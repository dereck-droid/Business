# Proposal Automation - Complete Design Document

## Executive Summary

Automated system that detects when a sales rep promises to send pricing, analyzes call history, generates personalized proposal emails using AI, validates quality, and routes for approval or auto-sends based on confidence.

**Status:** Design Complete, Implementation Pending
**Created:** 2025-02-05
**Target Launch:** TBD
**Expected Impact:** 95% time reduction in proposal creation, 100% accuracy in honoring promised pricing

---

## Table of Contents

1. [Problem Statement](#problem-statement)
2. [Solution Overview](#solution-overview)
3. [Workflow Architecture](#workflow-architecture)
4. [AI Prompts](#ai-prompts)
5. [Database Schema](#database-schema)
6. [Slack Integration](#slack-integration)
7. [Email Templates](#email-templates)
8. [Testing Strategy](#testing-strategy)
9. [Implementation Plan](#implementation-plan)
10. [Success Metrics](#success-metrics)

---

## Problem Statement

### Current Manual Process

1. Sales rep finishes call and promises to send pricing
2. Rep manually reviews call notes
3. Rep tries to remember what pricing was discussed
4. Rep selects email template and customizes it
5. Rep manually fills in variables (name, plan type, links)
6. Rep sends email
7. Rep updates GHL with "pricing sent" status

**Time:** 10-15 minutes per proposal
**Errors:** Occasional wrong pricing, missing details, inconsistent formatting
**Bottleneck:** Requires sales rep time immediately after call

### Desired Automated Process

1. Sales rep finishes call (Fireflies records automatically)
2. Automation detects proposal was promised
3. AI analyzes all call history for contact
4. AI generates personalized proposal email
5. High-confidence emails sent automatically
6. Medium-confidence emails routed to Slack for quick approval
7. GHL automatically updated

**Time:** 0 minutes for sales rep (happens in background)
**Errors:** AI validation catches issues before sending
**Bottleneck:** None - happens automatically

---

## Solution Overview

### High-Level Flow

```
Fireflies Webhook (transcription complete)
    ↓
Intelligent Call Filtering (filters no-shows, internal meetings)
    ↓
Get Full Transcript
    ↓
Quick AI Check: Was proposal promised?
    ├─ YES → PROPOSAL PATH (new automation)
    │   ↓
    │   [Complete proposal generation workflow]
    │
    └─ NO → NORMAL PATH (existing workflow)
        ↓
        [Existing call summary + GHL update]
```

### Key Components

1. **Proposal Promise Detection** - Fast AI check (Claude Haiku)
2. **Call History Analysis** - Query Supabase for all previous calls
3. **Proposal Generation** - Advanced AI (Claude Sonnet 4.5) with full context
4. **Validation Engine** - Multi-check validation before sending
5. **Confidence Routing** - Auto-send vs human review based on confidence
6. **Slack Review Interface** - Interactive buttons for approval/rejection
7. **Email Sending** - Gmail API or SMTP
8. **Database Logging** - Track all proposals for analytics

---

## Workflow Architecture

### Detailed Proposal Path

```
Switch: Proposal Promised? [YES output]
    ↓
Merge with Parse1 Data (need transcript & emails)
    ↓
Code: Split by Email (one item per attendee)
    ↓
Lookup Contact in GHL
    ↓
Filter: Contact Exists?
    ↓
Query Supabase: Get All Calls for This Contact
    ↓
AI: Generate Proposal Email (Claude Sonnet 4.5)
    ├─ Input: All call transcripts, summaries, outcomes
    ├─ Analyze: White label? Pricing discussed? Customer profile?
    ├─ Select: Template (1-6 from email-templates/)
    ├─ Generate: Personalized email
    └─ Output: Email + confidence score + reasoning
    ↓
Code: Validate Email
    ├─ Check: All [VARIABLES] replaced?
    ├─ Check: Correct Stripe links?
    ├─ Check: No [BRACKETS] remain?
    ├─ Check: Proper greeting/closing?
    └─ Output: Validation pass/fail + final confidence
    ↓
Save to Supabase (proposal_emails table, status=pending_review)
    ↓
Switch: Route by Confidence
    ├─ >= 95% → AUTO-SEND PATH
    │   ↓
    │   Send Email (Gmail API)
    │   ↓
    │   Update Supabase (status=sent, sent_by=automation)
    │   ↓
    │   Update GHL (add tag "Pricing Sent", update custom fields)
    │   ↓
    │   Slack: "✅ Pricing auto-sent to [Name]"
    │
    └─ 70-94% → REVIEW PATH
        ↓
        Slack: Interactive Message with Buttons
        ├─ [Approve & Send]
        ├─ [Edit in GHL]
        └─ [Reject]
        ↓
        [Button Handler Workflow - separate]

    └─ < 70% → MANUAL ESCALATION
        ↓
        Update Supabase (status=manual)
        ↓
        Slack: "🚨 Manual proposal needed for [Name]"
        ↓
        Create GHL Task (assigned to sales rep)
```

### Node Breakdown

| Node | Type | Purpose | Input | Output |
|------|------|---------|-------|--------|
| Check Proposal Promised | LLM Chain (Haiku) | Detect if pricing was promised | Transcript | {proposal_promised, confidence, evidence} |
| Route: Proposal Path? | Switch | Route to correct workflow | proposal_promised | 2 outputs (proposal/normal) |
| Get Previous Calls | Supabase Query | Fetch call history | ghl_contact_id | Array of all calls |
| Generate Proposal | LLM Chain (Sonnet 4.5) | Create personalized email | All call data | {email, template, confidence, reasoning} |
| Validate Email | Code (JS) | Quality checks | Generated email | {validated, issues, final_confidence} |
| Route by Confidence | Switch | Auto-send vs review | final_confidence | 3 outputs (auto/review/manual) |
| Send Email | HTTP/Gmail | Send the email | Email content | Success/failure |
| Slack Review | Slack Message | Interactive approval UI | Draft email | Slack message TS |

---

## AI Prompts

### 1. Proposal Promise Detection (Fast Check)

**Model:** Claude 3.5 Haiku (fast & cheap)
**Purpose:** Quickly determine if proposal was promised
**Temperature:** 0.1 (consistent)
**Response Format:** JSON

```markdown
You are analyzing a sales call transcript to determine if the Retarget IQ team member promised to send a pricing proposal/email after the call.

TRANSCRIPT:
{{ $json.transcript }}

Analyze the conversation and determine:
1. Did the Retarget IQ host (Nate, Cindy, or Alex) promise to send pricing information via email?
2. Look for phrases like:
   - "I'll send you the pricing"
   - "Let me email you the details"
   - "I'll shoot over the proposal"
   - "I'll get that pricing to you"
   - "I'll send the payment link"
   - Any commitment to follow up with pricing via email

Respond with ONLY this JSON structure:
{
  "proposal_promised": true/false,
  "confidence": 0.95,
  "evidence": "Quote from transcript showing the promise, or 'None' if not found"
}
```

### 2. Proposal Email Generation (Full Analysis)

**Model:** Claude 3.5 Sonnet (most capable)
**Purpose:** Analyze call history and generate personalized proposal
**Temperature:** 0.2 (slightly creative for personalization)
**Response Format:** JSON

```markdown
You are generating a personalized pricing proposal email for Retarget IQ based on all sales call history with this prospect.

CONTEXT:
You have access to ALL previous calls with this contact. Use them to understand:
- What they discussed across multiple conversations
- Any pricing that was mentioned or promised
- Whether white label was discussed
- Their use case and business needs
- Their buying stage and urgency

PRICING OPTIONS:
- Monthly: $797/month (month-to-month)
- Quarterly: $1,500/3 months (effectively $500/month)
- API Add-on: $297/month (month-to-month), $249/month (quarterly), $200/month (annual)
- VIP Support: $297/month
- White Label: $2,999.99/month (includes 10 client seats + API for all)

STRIPE PAYMENT LINKS:
- Monthly Core: https://buy.stripe.com/7sY9AUc6U65w1uM36F4gg0l
- Quarterly Core: https://buy.stripe.com/bJe14oef2fG6ehy6iR4gg0f
- API Add-on (m2m): https://buy.stripe.com/9B64gA2wk2Tk5L25eN4gg0j
- White Label: Contact for custom link

CALL HISTORY:
{{ range $call := $json.calls }}
---
Call {{ add $index 1 }} - {{ $call.created_at }}
Recording: {{ $call.recording_url }}

Summary:
{{ $call.summary }}

Transcript:
{{ $call.transcript }}

Tool Interests: {{ join $call.tool_interests ", " }}
Call Outcome: {{ $call.call_outcome }}

{{ end }}

YOUR TASK:
1. Analyze all calls to extract:
   - Was white label discussed? (Yes/No with evidence)
   - What pricing was mentioned? (Exact quotes if any)
   - Customer profile:
     * A = Quick Buyer (ready to go, minimal questions)
     * B = Detail-Oriented (wants full breakdown)
     * C = Agency/White Label (needs multi-client solution)
     * D = Just Needs Link (already discussed everything, just wants link)
     * E = On the Fence (comparing competitors, needs urgency)
   - Use case (what they want to accomplish)
   - Questions/concerns raised

2. Select appropriate template using this decision tree:
   - IF white_label_discussed → Template 3 (White Label Pricing)
   - ELSE IF just_needs_link → Template 4 (Payment Link Follow-Up)
   - ELSE IF detail_oriented OR asking_about_add_ons → Template 2 (Full Breakdown)
   - ELSE IF quick_buyer → Template 1 (Initial Pricing - Brief)
   - ELSE IF on_the_fence → Template 1 + Template 6 (add grandfathering urgency)

3. Generate personalized email:
   - Replace ALL [VARIABLES] with actual values:
     * [FIRST_NAME] - from contact name
     * [PLAN_TYPE] - monthly/quarterly based on discussion
     * [STRIPE_LINK] - correct link for plan type
     * [USE_CASE] - their specific use case
   - Reference specific details from calls naturally
   - Match Retarget IQ's casual, helpful tone
   - From: info@retargetiq.com (standard sender)
   - Sign as: "Best, Nate" or whoever was on the call

4. Calculate confidence score:
   - 95-100%: All data clear, template obvious, pricing explicitly discussed
   - 85-94%: Minor uncertainty but reasonable assumptions
   - 70-84%: Significant assumptions, needs human review
   - Below 70%: Too much missing/unclear data

RESPOND WITH JSON:
{
  "analysis": {
    "white_label_discussed": true/false,
    "white_label_evidence": "Quote from calls or null",
    "pricing_mentioned": {
      "monthly": 797 or null,
      "quarterly": 500 or null,
      "white_label": 2999 or null,
      "custom_terms": "Any special pricing discussed" or null
    },
    "customer_profile": "A" / "B" / "C" / "D" / "E",
    "use_case": "Brief description of what they want to accomplish",
    "questions_concerns": ["Array of key questions they asked"],
    "team_member_on_call": "nate@retargetiq.com" // extracted from call data
  },
  "email_generation": {
    "template_used": "Template 1" / "Template 2" / "Template 3" / "Template 4" / "Template 1 + 6",
    "template_reasoning": "Why this template was chosen",
    "generated_email_subject": "Pricing for Retarget IQ",
    "generated_email_body": "[Complete email with NO [BRACKETS] remaining]",
    "stripe_link_used": "https://buy.stripe.com/..."
  },
  "confidence": {
    "score": 95.0,
    "reasoning": "Why this confidence level",
    "validation_flags": ["Any concerns or warnings"]
  }
}

CRITICAL RULES:
- NEVER leave [VARIABLES] unfilled - if you don't know, use best guess or flag for review
- NEVER include [BRACKETS] in final email
- ALWAYS use exact Stripe links provided above
- ALWAYS reference specific details from calls (shows you read their history)
- Keep tone casual and helpful, not salesy or corporate
```

---

## Database Schema

See: `/retarget-iq/supabase-schema-complete.sql`

### Key Tables

**call_recordings:**
- Stores Fireflies transcripts, summaries, outcomes
- Indexed by `ghl_contact_id` for fast lookups
- Used as input for proposal generation

**proposal_emails:**
- Stores generated proposals and their status
- Tracks confidence scores and review workflow
- Indexed by `status` for monitoring pending reviews

### Key Queries

```sql
-- Get all calls for a contact (used by n8n)
SELECT * FROM get_contact_calls('ghl-contact-id-123');

-- Get pending proposal reviews
SELECT * FROM pending_proposal_reviews;

-- Get proposal statistics
SELECT * FROM get_proposal_stats();
```

---

## Slack Integration

### Interactive Buttons Architecture

**Two Workflows:**
1. **Main Workflow** - Generates proposal, sends Slack message with buttons
2. **Button Handler Workflow** - Separate webhook that handles button clicks

### How It Works

```
Main Workflow:
  Generates proposal → Saves to DB with unique ID
      ↓
  Sends Slack message with buttons
      ↓
  Buttons contain proposal_id in value field
      ↓
  Workflow ends (doesn't wait)

[User clicks button in Slack]
      ↓
Button Handler Workflow:
  Receives button click event
      ↓
  Extracts proposal_id from button value
      ↓
  Queries DB: SELECT * FROM proposal_emails WHERE id = proposal_id
      ↓
  IF "Approve" → Send email + update status
  IF "Reject" → Update status + notify
```

### Slack Message Format

```json
{
  "channel": "C0A8FF70QJC",
  "text": "📋 Pricing email needs review",
  "blocks": [
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*Pricing Email Review Needed*\n\n*Contact:* John Smith (john@example.com)\n*Template Used:* Template 1 - Initial Pricing\n*Confidence:* 92%\n*Call with:* <@nate@retargetiq.com>\n\n*AI Reasoning:* Customer profile A (Quick Buyer). Discussed quarterly plan during call. No white label mentioned. High confidence in template selection."
      }
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*Email Preview:*\n```Hi John...[first 500 chars]```\n\n[View Full Email](link-to-supabase-or-ghl)"
      }
    },
    {
      "type": "actions",
      "elements": [
        {
          "type": "button",
          "text": {"type": "plain_text", "text": "✅ Approve & Send"},
          "style": "primary",
          "action_id": "approve_proposal",
          "value": "uuid-from-database"
        },
        {
          "type": "button",
          "text": {"type": "plain_text", "text": "❌ Reject"},
          "style": "danger",
          "action_id": "reject_proposal",
          "value": "uuid-from-database"
        },
        {
          "type": "button",
          "text": {"type": "plain_text", "text": "✏️ Edit Manually"},
          "action_id": "edit_proposal",
          "value": "uuid-from-database"
        }
      ]
    }
  ]
}
```

### Slack App Setup

1. Go to https://api.slack.com/apps
2. Create new app for workspace
3. Enable **Interactivity**
4. Set Request URL: `https://server.advancedleadsolutions.com/webhook/slack-proposal-buttons`
5. Add Bot Token Scopes: `chat:write`, `chat:write.public`
6. Install app to workspace
7. Copy Bot Token to n8n credentials

---

## Email Templates

Located: `/retarget-iq/email-templates/pricing-email-templates.md`

### Available Templates

1. **Template 1** - Initial Pricing Presentation (Brief)
2. **Template 2** - Full Pricing Breakdown (All Options)
3. **Template 3** - White Label Pricing
4. **Template 4** - Payment Link Follow-Up
5. **Template 5** - Access Timeline After Payment
6. **Template 6** - Grandfathering Urgency Language

### Email Sender

**From:** `info@retargetiq.com` (standard for all proposals)
**Signature:** "Best, Nate" (or whoever was on the call)

---

## Testing Strategy

### Test Scenarios

| Scenario | Expected Behavior |
|----------|-------------------|
| Call with clear quarterly pricing discussed | Auto-send (95%+ confidence), Template 1 |
| Call with white label discussion | Review (85% confidence), Template 3 |
| Multiple calls, unclear pricing | Manual (60% confidence), escalate |
| "Just send me the link" | Auto-send (98% confidence), Template 4 |
| Competitor comparison mentioned | Template 1 + 6 (urgency), 90% confidence |

### Test Data

Use these known recordings:
- `01KENF6A97RFX9K8SRR7CMB1GB` - Aaron Wilson call (real sales call)
- Create test recordings for edge cases

### Validation Checklist

- [ ] All [VARIABLES] replaced
- [ ] Correct Stripe links for plan type
- [ ] No [BRACKETS] remain in email
- [ ] Proper greeting and closing
- [ ] References specific call details
- [ ] Matches Retarget IQ tone
- [ ] From correct sender
- [ ] Subject line appropriate

---

## Implementation Plan

### Phase 1: Database Setup (Day 1)
- [ ] Run `supabase-schema-complete.sql` in Supabase
- [ ] Verify tables created correctly
- [ ] Test `get_contact_calls()` function

### Phase 2: Update Existing Workflow (Day 1-2)
- [ ] Add "Check Proposal Promised" node
- [ ] Add Switch node for routing
- [ ] Test proposal detection with sample calls

### Phase 3: Build Proposal Generation (Day 2-3)
- [ ] Add Supabase query for call history
- [ ] Build proposal generation AI prompt
- [ ] Add validation code node
- [ ] Test with multiple call histories

### Phase 4: Confidence Routing (Day 3-4)
- [ ] Add confidence-based switch
- [ ] Build auto-send path (Gmail API)
- [ ] Build review path (Slack message)
- [ ] Build manual escalation path

### Phase 5: Slack Integration (Day 4-5)
- [ ] Set up Slack app with interactivity
- [ ] Build button handler workflow
- [ ] Test approve/reject functionality
- [ ] Add Slack notifications

### Phase 6: GHL Integration (Day 5)
- [ ] Update custom fields
- [ ] Add "Pricing Sent" tag
- [ ] Create notes with proposal details
- [ ] Test GHL updates

### Phase 7: Testing & Refinement (Day 6-7)
- [ ] Test all 8 scenarios from automation-logic.md
- [ ] Tune confidence thresholds
- [ ] Verify email formatting
- [ ] Check database logging

### Phase 8: Launch (Day 8)
- [ ] Enable for real calls
- [ ] Monitor first 10 proposals closely
- [ ] Adjust thresholds based on results
- [ ] Document any issues

---

## Success Metrics

### Primary KPIs

| Metric | Target | How to Measure |
|--------|--------|----------------|
| Time saved per proposal | 95%+ | Manual: 10-15 min → Automated: 0 min |
| Pricing accuracy | 100% | No incorrect pricing sent |
| Auto-send rate | 60%+ | % with confidence >= 95% |
| Review rate | 30% | % with confidence 70-94% |
| Manual escalation rate | <10% | % with confidence < 70% |
| Human approval rate | >95% | % of reviews approved (not rejected) |

### Secondary KPIs

| Metric | Target |
|--------|--------|
| Average confidence score | 88%+ |
| Time to send (auto) | <2 minutes from call end |
| Time to send (review) | <30 minutes from call end |
| Template selection accuracy | 95%+ |
| Variable replacement errors | 0 |

### Monitoring Queries

```sql
-- Daily proposal stats
SELECT
    DATE(created_at) as date,
    status,
    COUNT(*) as count,
    AVG(confidence_score) as avg_confidence
FROM proposal_emails
WHERE created_at >= NOW() - INTERVAL '7 days'
GROUP BY DATE(created_at), status
ORDER BY date DESC;

-- Average review time
SELECT
    AVG(EXTRACT(EPOCH FROM (sent_at - created_at))/60) as avg_minutes
FROM proposal_emails
WHERE status = 'sent' AND sent_by != 'automation';

-- Auto-send rate
SELECT
    COUNT(*) FILTER (WHERE sent_by = 'automation')::FLOAT / COUNT(*) * 100 as auto_send_pct
FROM proposal_emails
WHERE status = 'sent';
```

---

## Future Enhancements

1. **Multi-language support** - Detect language, send in prospect's language
2. **Calendar integration** - Include meeting scheduler link in proposals
3. **Video proposals** - Generate personalized Loom video with pricing walkthrough
4. **A/B testing** - Test different email templates, track open/reply rates
5. **Follow-up automation** - Auto-send follow-up if no response in 3 days
6. **Learning system** - Track which proposals convert, improve AI over time

---

## Related Documentation

- `/retarget-iq/supabase-schema-complete.sql` - Database schema
- `/retarget-iq/intelligent-call-filtering.md` - Call validation logic
- `/retarget-iq/email-templates/pricing-email-templates.md` - Email templates
- `/retarget-iq/email-templates/automation-logic.md` - Decision tree
- `/retarget-iq/IMPLEMENTATION-GUIDE.md` - Overall implementation phases

---

## Support & Maintenance

**Primary Contact:** Dereck (implementation)
**Client Contact:** Nate (Retarget IQ)
**Documentation Updates:** Update this file when making changes
**Version Control:** Commit all changes to GitHub with clear messages
