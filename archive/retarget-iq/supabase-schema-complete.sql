-- =====================================================
-- RETARGET IQ - COMPLETE DATABASE SCHEMA
-- =====================================================
-- Purpose: Complete schema for call recording automation
--          and proposal email generation
--
-- Tables:
--   1. call_recordings - Fireflies transcripts & analysis
--   2. proposal_emails - Generated pricing proposals
--
-- Created: 2025-02-05
-- Last Updated: 2025-02-05
-- =====================================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "vector"; -- For future semantic search

-- =====================================================
-- TABLE 1: call_recordings
-- =====================================================
-- Purpose: Store Fireflies call transcripts and AI analysis
-- Populated by: Fireflies webhook → n8n workflow
-- Used by: Proposal automation to query call history
-- =====================================================

CREATE TABLE IF NOT EXISTS call_recordings (
    -- Primary Key
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    -- Fireflies Data
    recording_id TEXT UNIQUE NOT NULL,
    recording_url TEXT,

    -- Contact Information
    contact_email TEXT NOT NULL,
    contact_name TEXT,
    ghl_contact_id TEXT NOT NULL,

    -- AI Analysis Results (from Claude Sonnet 4.5)
    summary TEXT,                    -- Formatted summary with business context
    transcript TEXT,                 -- Condensed transcript (speaker: text format)
    tool_interests TEXT[],           -- Array: ["Website Identification", "Intent Data", etc.]
    call_outcome TEXT,               -- "Send invoice", "Thinking about it", etc.

    -- Raw Data (for extracting team members, re-processing, etc.)
    raw_payload JSONB,               -- Complete Fireflies webhook payload

    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for Performance
CREATE INDEX IF NOT EXISTS idx_call_recordings_ghl_contact
    ON call_recordings(ghl_contact_id);
CREATE INDEX IF NOT EXISTS idx_call_recordings_email
    ON call_recordings(contact_email);
CREATE INDEX IF NOT EXISTS idx_call_recordings_date
    ON call_recordings(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_call_recordings_recording_id
    ON call_recordings(recording_id);

-- Full-text search on transcript (for future search features)
CREATE INDEX IF NOT EXISTS idx_call_recordings_transcript_search
    ON call_recordings USING gin(to_tsvector('english', transcript));

-- =====================================================
-- TABLE 2: proposal_emails
-- =====================================================
-- Purpose: Store generated proposal emails and workflow status
-- Populated by: Proposal automation workflow
-- Used by: Slack button handler, reporting, analytics
-- =====================================================

CREATE TABLE IF NOT EXISTS proposal_emails (
    -- Primary Key
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    -- Contact Information
    ghl_contact_id TEXT NOT NULL,
    contact_email TEXT NOT NULL,
    contact_name TEXT,

    -- Generated Email Content
    generated_email TEXT NOT NULL,
    email_subject TEXT DEFAULT 'Pricing for Retarget IQ',
    template_used TEXT,              -- "Template 1", "Template 3 - White Label", etc.

    -- AI Analysis from Call Transcripts
    white_label_discussed BOOLEAN DEFAULT FALSE,
    pricing_mentioned JSONB,         -- {monthly: 797, quarterly: 500, white_label: 2999, custom_terms: "..."}
    customer_profile TEXT,           -- "A" (Quick Buyer), "B" (Detail-Oriented), "C" (Agency), etc.
    use_case TEXT,                   -- Extracted use case from calls
    variables_extracted JSONB,       -- {first_name: "John", plan_type: "quarterly", stripe_link: "..."}

    -- Quality & Confidence Metrics
    confidence_score DECIMAL(5,2),   -- 0.00 to 100.00
    ai_reasoning TEXT,               -- Why AI chose this template/confidence level
    validation_issues TEXT[],        -- Any warnings or flags from validation

    -- Source Data Tracking
    call_recording_ids TEXT[],       -- Array of recording IDs used for generation
    retargetiq_team_member TEXT,     -- Email of team member from the call (for Slack @mentions)

    -- Status Workflow
    status TEXT DEFAULT 'pending_review',
    /*
    Status values:
      - pending_review: Waiting for human approval in Slack
      - sent: Email sent successfully
      - rejected: Human rejected the draft
      - manual: Flagged for manual creation (low confidence)
    */
    sent_at TIMESTAMPTZ,
    sent_by TEXT,                    -- "automation" or Slack username who approved
    reviewed_by TEXT,                -- Slack username who clicked approve/reject

    -- Slack Integration
    slack_message_ts TEXT,           -- Slack message timestamp (for updating message)
    slack_channel TEXT,              -- Channel ID where review was posted

    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for Performance
CREATE INDEX IF NOT EXISTS idx_proposal_emails_ghl_contact
    ON proposal_emails(ghl_contact_id);
CREATE INDEX IF NOT EXISTS idx_proposal_emails_status
    ON proposal_emails(status);
CREATE INDEX IF NOT EXISTS idx_proposal_emails_created
    ON proposal_emails(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_proposal_emails_email
    ON proposal_emails(contact_email);

-- Index for finding proposals by team member (useful for metrics)
CREATE INDEX IF NOT EXISTS idx_proposal_emails_team_member
    ON proposal_emails(retargetiq_team_member);

-- =====================================================
-- TRIGGERS - Auto-update timestamps
-- =====================================================

-- Function to update updated_at column
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for call_recordings
DROP TRIGGER IF EXISTS update_call_recordings_updated_at ON call_recordings;
CREATE TRIGGER update_call_recordings_updated_at
    BEFORE UPDATE ON call_recordings
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Trigger for proposal_emails
DROP TRIGGER IF EXISTS update_proposal_emails_updated_at ON proposal_emails;
CREATE TRIGGER update_proposal_emails_updated_at
    BEFORE UPDATE ON proposal_emails
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- =====================================================
-- HELPER VIEWS
-- =====================================================

-- View: Pending proposal reviews (for dashboard)
CREATE OR REPLACE VIEW pending_proposal_reviews AS
SELECT
    id,
    contact_name,
    contact_email,
    template_used,
    confidence_score,
    retargetiq_team_member,
    created_at,
    EXTRACT(EPOCH FROM (NOW() - created_at))/3600 AS hours_pending
FROM proposal_emails
WHERE status = 'pending_review'
ORDER BY created_at ASC;

-- View: Contact call history (useful for debugging and context)
CREATE OR REPLACE VIEW contact_call_history AS
SELECT
    ghl_contact_id,
    contact_name,
    contact_email,
    COUNT(*) AS total_calls,
    array_agg(DISTINCT tool_interests) AS all_tool_interests_discussed,
    array_agg(call_outcome) AS all_call_outcomes,
    MAX(created_at) AS last_call_date,
    MIN(created_at) AS first_call_date
FROM call_recordings
GROUP BY ghl_contact_id, contact_name, contact_email;

-- View: Proposal email metrics (for reporting)
CREATE OR REPLACE VIEW proposal_email_metrics AS
SELECT
    status,
    COUNT(*) AS count,
    AVG(confidence_score) AS avg_confidence,
    COUNT(*) FILTER (WHERE white_label_discussed = true) AS white_label_count,
    COUNT(*) FILTER (WHERE sent_by = 'automation') AS auto_sent_count,
    COUNT(*) FILTER (WHERE sent_by != 'automation' AND sent_by IS NOT NULL) AS human_approved_count
FROM proposal_emails
GROUP BY status;

-- =====================================================
-- UTILITY FUNCTIONS
-- =====================================================

-- Function: Get all call data for a contact (used by n8n workflow)
CREATE OR REPLACE FUNCTION get_contact_calls(contact_id TEXT)
RETURNS TABLE (
    recording_id TEXT,
    recording_url TEXT,
    summary TEXT,
    transcript TEXT,
    tool_interests TEXT[],
    call_outcome TEXT,
    retargetiq_team_member TEXT,
    created_at TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        cr.recording_id,
        cr.recording_url,
        cr.summary,
        cr.transcript,
        cr.tool_interests,
        cr.call_outcome,
        (
            SELECT email::TEXT
            FROM jsonb_array_elements(cr.raw_payload->'data'->'meeting_attendees') AS attendee
            WHERE (attendee->>'email')::TEXT ILIKE '%@retargetiq.com'
            LIMIT 1
        ) AS retargetiq_team_member,
        cr.created_at
    FROM call_recordings cr
    WHERE cr.ghl_contact_id = contact_id
    ORDER BY cr.created_at DESC;
END;
$$ LANGUAGE plpgsql;

-- Function: Get proposal email statistics
CREATE OR REPLACE FUNCTION get_proposal_stats()
RETURNS TABLE (
    total_proposals BIGINT,
    pending_review BIGINT,
    sent BIGINT,
    rejected BIGINT,
    avg_confidence DECIMAL,
    avg_review_time_hours DECIMAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        COUNT(*)::BIGINT AS total_proposals,
        COUNT(*) FILTER (WHERE status = 'pending_review')::BIGINT AS pending_review,
        COUNT(*) FILTER (WHERE status = 'sent')::BIGINT AS sent,
        COUNT(*) FILTER (WHERE status = 'rejected')::BIGINT AS rejected,
        AVG(confidence_score) AS avg_confidence,
        AVG(
            CASE
                WHEN sent_at IS NOT NULL
                THEN EXTRACT(EPOCH FROM (sent_at - created_at))/3600
                ELSE NULL
            END
        ) AS avg_review_time_hours
    FROM proposal_emails;
END;
$$ LANGUAGE plpgsql;

-- =====================================================
-- ROW LEVEL SECURITY (RLS) - Optional
-- =====================================================
-- Uncomment if you want to enable RLS for additional security

-- ALTER TABLE call_recordings ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE proposal_emails ENABLE ROW LEVEL SECURITY;

-- CREATE POLICY "Enable all access for service role" ON call_recordings
--     FOR ALL
--     TO service_role
--     USING (true)
--     WITH CHECK (true);

-- CREATE POLICY "Enable all access for service role" ON proposal_emails
--     FOR ALL
--     TO service_role
--     USING (true)
--     WITH CHECK (true);

-- =====================================================
-- TEST QUERIES (uncomment to verify setup)
-- =====================================================

-- Check tables were created
-- SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' ORDER BY table_name;

-- Check call_recordings structure
-- SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'call_recordings' ORDER BY ordinal_position;

-- Check proposal_emails structure
-- SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'proposal_emails' ORDER BY ordinal_position;

-- Test get_contact_calls function
-- SELECT * FROM get_contact_calls('test-contact-id-123');

-- Test get_proposal_stats function
-- SELECT * FROM get_proposal_stats();

-- View pending reviews
-- SELECT * FROM pending_proposal_reviews;

-- View proposal metrics
-- SELECT * FROM proposal_email_metrics;

-- =====================================================
-- SUCCESS MESSAGE
-- =====================================================

DO $$
BEGIN
    RAISE NOTICE '';
    RAISE NOTICE '✅ Retarget IQ Database Schema Created Successfully!';
    RAISE NOTICE '';
    RAISE NOTICE '📊 Tables Created:';
    RAISE NOTICE '   - call_recordings (stores Fireflies transcripts)';
    RAISE NOTICE '   - proposal_emails (stores generated proposals)';
    RAISE NOTICE '';
    RAISE NOTICE '📈 Views Created:';
    RAISE NOTICE '   - pending_proposal_reviews';
    RAISE NOTICE '   - contact_call_history';
    RAISE NOTICE '   - proposal_email_metrics';
    RAISE NOTICE '';
    RAISE NOTICE '⚡ Functions Created:';
    RAISE NOTICE '   - get_contact_calls(contact_id)';
    RAISE NOTICE '   - get_proposal_stats()';
    RAISE NOTICE '';
    RAISE NOTICE '🔄 Next Steps:';
    RAISE NOTICE '   1. Update Fireflies workflow to save to call_recordings';
    RAISE NOTICE '   2. Build proposal automation workflow';
    RAISE NOTICE '   3. Set up Slack app for interactive buttons';
    RAISE NOTICE '   4. Test with real call data';
    RAISE NOTICE '';
END $$;
