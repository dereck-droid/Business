# Proposal Email Automation - Implementation Guide

## Overview

This guide documents the phased approach to implementing automated proposal email generation with human-in-the-loop quality control, as agreed with Jonathan Kluger (Head of Sales).

**Philosophy:** Start with 100% human review, build confidence through feedback loops, gradually increase automation as the system proves reliable.

**Created:** 2026-02-06
**Status:** Phase 1 Ready for Implementation
**Primary Contacts:** Dereck Johnson (implementation), Jonathan Kluger (sales), Nate Calhoun (product)

---

## Table of Contents

1. [Current State](#current-state)
2. [Phase 1: Human-in-the-Loop (100% Review)](#phase-1-human-in-the-loop-100-review)
3. [Phase 2: Graduated Automation](#phase-2-graduated-automation)
4. [Implementation Steps](#implementation-steps)
5. [Slack Approval Interface](#slack-approval-interface)
6. [Testing Protocol](#testing-protocol)
7. [Success Criteria](#success-criteria)

---

## Current State

### What's Working Now ✅

The existing workflow (`proposal-automation-workflow.json`) successfully:

1. ✅ Receives Fireflies webhook when call transcription completes
2. ✅ Validates call is real (filters no-shows, internal meetings)
3. ✅ Extracts transcript and attendee emails
4. ✅ **Detects if proposal was promised** using AI
5. ✅ Routes to two paths:
   - **"Send Proposal"** path (if promised)
   - **"No Proposal"** path (normal call summary)
6. ✅ Generates call summary and updates GHL
7. ✅ Saves to Supabase database
8. ✅ Sends Slack notification

### What's Missing ⚠️

The **"Send Proposal" path** currently only adds a field to the call summary but doesn't actually generate or send the email. We need to add:

- [ ] Query Supabase for all previous calls with this contact
- [ ] AI email generation with full call history context
- [ ] Email validation and confidence scoring
- [ ] **Slack approval interface with draft preview**
- [ ] Email sending (via Gmail API or SMTP)
- [ ] Database logging of proposal emails
- [ ] GHL updates (tags, custom fields, notes)

---

## Phase 1: Human-in-the-Loop (100% Review)

### Objective

**All AI-generated proposal emails must be reviewed and approved by a human before sending.**

This achieves:
- ✅ Quality control against hallucinations
- ✅ Ability to add personal touches
- ✅ Team builds confidence in the system
- ✅ Feedback loop for improving prompts
- ✅ Zero risk of incorrect pricing sent to prospects

### Confidence Score Behavior (Phase 1)

In Phase 1, **confidence score is calculated but ignored for routing**. All emails go to Slack for review regardless of score.

```
Email Generated → Calculate Confidence (0-100%)
                 ↓
              [Display confidence in Slack for monitoring]
                 ↓
           ALL emails → Slack Review (human approval required)
```

**Why?** This lets us:
1. See what confidence scores the system generates
2. Determine if the confidence score correlates with actual quality
3. Set appropriate thresholds for Phase 2 based on real data

### User Experience (Sales Rep Perspective)

**Before (Manual):**
1. Finish call
2. Review notes
3. Select template
4. Customize email
5. Send via Gmail
6. Update GHL
7. ⏱️ **Time: 10-15 minutes**

**After (Phase 1 - Human Review):**
1. Finish call
2. Receive Slack notification with draft email
3. Review draft (usually perfect, occasionally add personal touch)
4. Click "Approve & Send" or "Edit First"
5. ⏱️ **Time: 1-2 minutes**

**Time Saved:** 85-90% reduction

---

## Phase 2: Graduated Automation

### Objective

After 2-4 weeks of Phase 1 data collection, transition high-confidence emails to auto-send.

### Confidence-Based Routing

```
Email Generated → Calculate Confidence
                 ↓
    ┌────────────┴────────────┐
    ↓                         ↓
≥ 95% Confidence         < 95% Confidence
    ↓                         ↓
AUTO-SEND                 SLACK REVIEW
(no human needed)         (human approval)
```

### Two Standard Deviations Threshold

Jonathan's suggestion: Use statistical validation for confidence thresholds.

**Approach:**
1. Collect confidence scores from Phase 1
2. Calculate mean (μ) and standard deviation (σ)
3. Set auto-send threshold at μ + 2σ
4. Only top ~5% of emails auto-send initially
5. Gradually relax threshold as system proves reliable

**Example:**
- Phase 1 data: mean = 82%, σ = 8%
- μ + 2σ = 82% + 16% = 98%
- Only emails with 98%+ confidence auto-send
- Rest still get human review

### Transition Criteria

Don't move to Phase 2 until:
- [ ] 50+ emails generated in Phase 1
- [ ] 95%+ human approval rate (very few rejections)
- [ ] Zero incidents of incorrect pricing
- [ ] Jonathan approves transition
- [ ] Confidence score shows strong correlation with quality

---

## Implementation Steps

### Step 1: Extend "Send Proposal" Path in n8n

**Current:** "Send Proposal" output → Edit Fields1 → Aggregate → Parse/Sum

**Add After "Edit Fields1":**

```
Edit Fields1
    ↓
[NEW] Query Supabase: Get Previous Calls
    ↓
[NEW] AI: Generate Proposal Email
    ↓
[NEW] Code: Validate & Score Email
    ↓
[NEW] Save to Supabase (proposal_emails table)
    ↓
[NEW] Slack: Draft Email for Approval
    ↓
[Workflow Ends - Button Handler workflow takes over]
```

### Step 2: Add Supabase Query Node

**Node Type:** Supabase (Query)
**Operation:** Run SQL Query
**Purpose:** Get all previous calls for this contact to give AI full context

**SQL Query:**
```sql
SELECT
  recording_id,
  recording_url,
  created_at,
  summary,
  transcript,
  tool_interests,
  call_outcome
FROM call_recordings
WHERE ghl_contact_id = '{{ $('Lookup Contact').item.json.contact.id }}'
ORDER BY created_at DESC
```

**Output:** Array of all calls this prospect has had with Retarget IQ

### Step 3: Add AI Email Generation Node

**Node Type:** LLM Chain (OpenRouter)
**Model:** `anthropic/claude-sonnet-4.5` (most capable)
**Temperature:** 0.2 (slightly creative for personalization)
**Response Format:** `json_object`

**Prompt:** (See full prompt in `PROPOSAL-EMAIL-PROMPT.md` - to be created)

**Key Inputs:**
- All call transcripts and summaries
- Contact name and email
- Tools discussed (from call_recordings)
- Pricing options and Stripe links
- Email templates (from `/retarget-iq/email-templates/`)

**Output JSON:**
```json
{
  "analysis": {
    "white_label_discussed": true/false,
    "pricing_mentioned": {
      "monthly": 797,
      "quarterly": 500,
      "white_label": null
    },
    "customer_profile": "A|B|C|D|E",
    "use_case": "Brief description",
    "team_member_on_call": "nate@retargetiq.com"
  },
  "email_generation": {
    "template_used": "Template 1",
    "template_reasoning": "Why chosen",
    "subject": "Pricing for Retarget IQ",
    "body": "[Complete email with all variables filled]",
    "stripe_link": "https://buy.stripe.com/..."
  },
  "confidence": {
    "score": 92.0,
    "reasoning": "Why this confidence",
    "validation_flags": []
  }
}
```

### Step 4: Add Validation & Scoring Node

**Node Type:** Code (JavaScript)
**Purpose:** Quality checks before presenting to human

**Validation Checks:**
1. ✅ No `[BRACKETS]` remain in email
2. ✅ All `[VARIABLES]` replaced with actual values
3. ✅ Stripe link matches plan type discussed
4. ✅ Email has proper greeting and closing
5. ✅ Signature matches team member on call
6. ✅ Email length reasonable (not too short/long)
7. ✅ No obvious AI artifacts ("As an AI..." etc.)

**Confidence Adjustment:**
- Start with AI's confidence score
- Deduct 10% for each validation failure
- Add flags for human reviewer to check

**Code Example:**
```javascript
const aiOutput = $input.item.json;
let confidence = aiOutput.confidence.score;
const issues = [];

// Check for unfilled variables
if (aiOutput.email_generation.body.includes('[')) {
  issues.push('Unfilled variables detected');
  confidence -= 10;
}

// Check for proper Stripe link
const emailBody = aiOutput.email_generation.body;
const stripeLink = aiOutput.email_generation.stripe_link;
if (!emailBody.includes(stripeLink)) {
  issues.push('Stripe link not included in email');
  confidence -= 15;
}

// Check for AI artifacts
const artifacts = ['As an AI', 'I am an', 'I cannot', 'I apologize'];
if (artifacts.some(phrase => emailBody.includes(phrase))) {
  issues.push('AI artifact language detected');
  confidence -= 20;
}

// Minimum confidence floor
confidence = Math.max(0, Math.min(100, confidence));

return {
  json: {
    ...aiOutput,
    validation: {
      passed: issues.length === 0,
      issues: issues,
      final_confidence: confidence
    }
  }
};
```

### Step 5: Save to Supabase (proposal_emails)

**Node Type:** Supabase (Insert)
**Table:** `proposal_emails`

**Fields to Insert:**
```javascript
{
  ghl_contact_id: $('Lookup Contact').item.json.contact.id,
  contact_email: $('Code in JavaScript').item.json.email,
  contact_name: $('Lookup Contact').item.json.contact.fullNameLowerCase,
  email_subject: $json.email_generation.subject,
  email_body: $json.email_generation.body,
  template_used: $json.email_generation.template_used,
  confidence_score: $json.validation.final_confidence,
  ai_reasoning: $json.confidence.reasoning,
  validation_issues: $json.validation.issues,
  status: 'pending_review',  // Always pending in Phase 1
  created_by: 'automation',
  metadata: JSON.stringify($json.analysis)
}
```

**Why Save Before Approval?**
- Preserves draft even if Slack message fails
- Allows analytics on what was generated
- Button handler can query database to get full email

### Step 6: Send to Slack for Approval

**Node Type:** Slack (Send Message)
**Channel:** `#sales-proposals` (or dedicated channel)
**Message Type:** Blocks with interactive buttons

**See:** [Slack Approval Interface](#slack-approval-interface) below for full message format

**Key Data to Display:**
- Contact name and email
- Confidence score (with visual indicator)
- Email template used
- First 300 chars of email (preview)
- Link to view full email
- AI reasoning
- Any validation warnings

**Buttons:**
1. ✅ **Approve & Send** (primary, green)
2. ✏️ **Edit in GHL** (opens GHL contact, rep sends manually)
3. ❌ **Reject** (danger, red) - flags for review

---

## Slack Approval Interface

### Message Format (Blocks API)

```json
{
  "channel": "C0A8FF70QJC",
  "text": "📧 Pricing email needs review",
  "blocks": [
    {
      "type": "header",
      "text": {
        "type": "plain_text",
        "text": "📧 Pricing Email Ready for Review"
      }
    },
    {
      "type": "section",
      "fields": [
        {
          "type": "mrkdwn",
          "text": "*Contact:*\nJohn Smith"
        },
        {
          "type": "mrkdwn",
          "text": "*Email:*\njohn@example.com"
        },
        {
          "type": "mrkdwn",
          "text": "*Template:*\nTemplate 1 - Initial Pricing"
        },
        {
          "type": "mrkdwn",
          "text": "*Confidence:*\n92% 🟢"
        }
      ]
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*AI Reasoning:*\nCustomer profile A (Quick Buyer). Discussed quarterly plan on call. No white label mentioned. High confidence in template selection and pricing accuracy."
      }
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*Email Preview:*\n```Hi John,\n\nGreat speaking with you today! As discussed, here's the pricing for Retarget IQ...\n\n[Click View Full Email below to see complete draft]```"
      }
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "<https://supabase.com/dashboard/project/xxx/editor/12345|📄 View Full Email>"
      }
    },
    {
      "type": "context",
      "elements": [
        {
          "type": "mrkdwn",
          "text": "⚠️ *Validation Warnings:* None"
        }
      ]
    },
    {
      "type": "divider"
    },
    {
      "type": "actions",
      "elements": [
        {
          "type": "button",
          "text": {
            "type": "plain_text",
            "text": "✅ Approve & Send",
            "emoji": true
          },
          "style": "primary",
          "action_id": "approve_proposal",
          "value": "uuid-from-database"
        },
        {
          "type": "button",
          "text": {
            "type": "plain_text",
            "text": "✏️ Edit in GHL",
            "emoji": true
          },
          "action_id": "edit_proposal_ghl",
          "value": "uuid-from-database",
          "url": "https://app.gohighlevel.com/location/NsVY7d3y1lM4chVbXzwk/contacts/detail/CONTACT_ID"
        },
        {
          "type": "button",
          "text": {
            "type": "plain_text",
            "text": "❌ Reject",
            "emoji": true
          },
          "style": "danger",
          "action_id": "reject_proposal",
          "value": "uuid-from-database"
        }
      ]
    }
  ]
}
```

### Confidence Score Visual Indicators

```javascript
function getConfidenceEmoji(score) {
  if (score >= 95) return '🟢'; // Green - excellent
  if (score >= 85) return '🟡'; // Yellow - good
  if (score >= 70) return '🟠'; // Orange - review carefully
  return '🔴'; // Red - likely needs manual
}
```

### Button Handler Workflow (Separate)

**Webhook Path:** `/webhook/proposal-email-approval`
**Trigger:** Slack button click
**Purpose:** Handle approve/reject actions

**Flow:**
```
Slack Button Click
    ↓
Extract proposal_id from button value
    ↓
Query Supabase: SELECT * FROM proposal_emails WHERE id = proposal_id
    ↓
Switch: Which button?
    ├─ APPROVE → Send Email Path
    │   ↓
    │   Send via Gmail API
    │   ↓
    │   Update Supabase (status='sent', sent_by=slack_user, sent_at=now)
    │   ↓
    │   Update GHL (add tag "Pricing Sent", create note)
    │   ↓
    │   Update Slack message: ✅ "Email sent by @user at 2:15pm"
    │
    ├─ EDIT → Manual Path
    │   ↓
    │   Update Supabase (status='manual_edit', reviewed_by=slack_user)
    │   ↓
    │   Update Slack message: ✏️ "Sent to GHL for manual editing by @user"
    │
    └─ REJECT → Escalation Path
        ↓
        Update Supabase (status='rejected', reviewed_by=slack_user)
        ↓
        Slack: "@dereck @nate - Proposal rejected, needs review"
        ↓
        Update Slack message: ❌ "Rejected by @user - flagged for review"
```

---

## Testing Protocol

### Phase 1 Testing Checklist

Before rolling out to production:

#### 1. Database Validation
- [ ] `proposal_emails` table exists in Supabase
- [ ] Test query: Get all calls for a contact works
- [ ] Test insert: Can save proposal email
- [ ] Indexes perform well (< 100ms queries)

#### 2. AI Email Generation
- [ ] Test with real call transcript (Aaron Wilson call)
- [ ] Verify all `[VARIABLES]` replaced
- [ ] Check Stripe link accuracy
- [ ] Validate template selection logic
- [ ] Review email tone and formatting

#### 3. Validation Logic
- [ ] Catches unfilled variables
- [ ] Detects wrong Stripe links
- [ ] Flags AI artifacts
- [ ] Confidence score reasonable (70-95% range)

#### 4. Slack Integration
- [ ] Message sends to correct channel
- [ ] All fields display correctly
- [ ] Buttons render and contain proposal_id
- [ ] "View Full Email" link works
- [ ] Confidence emoji displays correctly

#### 5. Button Handler
- [ ] Approve button sends email successfully
- [ ] Email arrives in prospect's inbox
- [ ] GHL updates correctly (tag, note, custom field)
- [ ] Supabase updates status to 'sent'
- [ ] Slack message updates with confirmation
- [ ] Edit button opens GHL contact
- [ ] Reject button flags for review

#### 6. End-to-End Test Scenarios

| Scenario | Expected Behavior | Status |
|----------|-------------------|--------|
| Call with clear quarterly pricing | Generate email, 90%+ confidence, Template 1 | ⏳ |
| Call with white label discussion | Generate email, 85%+ confidence, Template 3 | ⏳ |
| Multiple calls, unclear pricing | Generate email, 60-70% confidence, flags | ⏳ |
| "Just send me the link" | Generate email, 95%+ confidence, Template 4 | ⏳ |
| No pricing discussed at all | Should not trigger proposal path | ⏳ |

---

## Success Criteria

### Phase 1 Goals (First 2-4 Weeks)

**Quantitative:**
- [ ] 50+ proposal emails generated
- [ ] 95%+ approval rate (human clicks "Approve")
- [ ] < 5% rejection rate
- [ ] Zero incorrect pricing sent
- [ ] Average review time < 2 minutes
- [ ] 85%+ reduction in time vs manual process

**Qualitative:**
- [ ] Sales team trusts the system
- [ ] Jonathan approves of quality
- [ ] Minimal edits needed after approval
- [ ] Confidence score correlates with actual quality
- [ ] No customer complaints about emails

### Phase 2 Transition Criteria

Don't move to graduated automation until:
- [ ] All Phase 1 goals met
- [ ] Statistical analysis shows confidence score reliability
- [ ] μ + 2σ threshold identified (likely 95-98%)
- [ ] Team comfortable with auto-send concept
- [ ] Jonathan and Nate give explicit approval
- [ ] Monitoring dashboard in place

### Long-Term Success (6 Months)

- [ ] 60%+ emails auto-send (high confidence)
- [ ] 30% human review (medium confidence)
- [ ] < 10% manual escalation (low confidence)
- [ ] 100% pricing accuracy maintained
- [ ] Sales team loves the system
- [ ] Measurable increase in proposal response rate

---

## Risk Mitigation

### What Could Go Wrong?

| Risk | Impact | Mitigation |
|------|--------|------------|
| AI hallucinates wrong pricing | HIGH | Phase 1: 100% human review<br>Validation checks for Stripe links<br>Confidence score deduction |
| Email sounds too robotic | MEDIUM | Temperature 0.2 allows personalization<br>Reference specific call details<br>Human can add rapport before sending |
| Stripe link doesn't match plan | HIGH | Validation checks link against plan type<br>Confidence deduction if mismatch<br>Human reviews before send |
| System sends to wrong contact | HIGH | Email domain validation<br>GHL lookup confirmation<br>Display contact clearly in Slack |
| Slack button doesn't work | MEDIUM | Save to DB first (draft preserved)<br>Manual send option always available<br>Fallback to GHL |
| Database query slow/fails | LOW | Indexes on ghl_contact_id<br>Error handling continues workflow<br>Generate without history if needed |

### Rollback Plan

If Phase 1 shows problems:
1. Disable "Send Proposal" path in n8n
2. Fall back to normal call summary only
3. Sales team sends proposals manually (as before)
4. Review issues and improve prompts
5. Re-test in staging environment
6. Re-enable when issues resolved

**No harm done** - we're just enhancing existing process, not replacing mission-critical system.

---

## Monitoring & Analytics

### Dashboards to Build

**Supabase SQL Queries:**

```sql
-- Daily proposal stats
SELECT
  DATE(created_at) as date,
  status,
  COUNT(*) as count,
  AVG(confidence_score) as avg_confidence,
  MIN(confidence_score) as min_confidence,
  MAX(confidence_score) as max_confidence
FROM proposal_emails
WHERE created_at >= NOW() - INTERVAL '30 days'
GROUP BY DATE(created_at), status
ORDER BY date DESC;

-- Approval rate by confidence range
SELECT
  CASE
    WHEN confidence_score >= 95 THEN '95-100%'
    WHEN confidence_score >= 85 THEN '85-94%'
    WHEN confidence_score >= 70 THEN '70-84%'
    ELSE 'Below 70%'
  END as confidence_range,
  COUNT(*) as total,
  COUNT(*) FILTER (WHERE status = 'sent') as approved,
  COUNT(*) FILTER (WHERE status = 'rejected') as rejected,
  ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'sent') / COUNT(*), 1) as approval_pct
FROM proposal_emails
GROUP BY confidence_range
ORDER BY confidence_range DESC;

-- Template usage and performance
SELECT
  template_used,
  COUNT(*) as times_used,
  AVG(confidence_score) as avg_confidence,
  COUNT(*) FILTER (WHERE status = 'sent') as approved,
  COUNT(*) FILTER (WHERE status = 'rejected') as rejected
FROM proposal_emails
GROUP BY template_used
ORDER BY times_used DESC;

-- Average review time (how long until human approves)
SELECT
  AVG(EXTRACT(EPOCH FROM (sent_at - created_at))/60) as avg_minutes,
  MIN(EXTRACT(EPOCH FROM (sent_at - created_at))/60) as min_minutes,
  MAX(EXTRACT(EPOCH FROM (sent_at - created_at))/60) as max_minutes
FROM proposal_emails
WHERE status = 'sent' AND sent_at IS NOT NULL;
```

### Weekly Review Meeting

**Every Monday:**
1. Review stats from previous week
2. Look at rejected emails - why were they rejected?
3. Adjust prompts if patterns emerge
4. Celebrate wins (fast approvals, great emails)
5. Decide if ready for Phase 2

---

## Next Steps

### Immediate (This Week)
1. [ ] Create `PROPOSAL-EMAIL-PROMPT.md` with full AI prompt
2. [ ] Set up Slack app with interactivity enabled
3. [ ] Create button handler webhook in n8n
4. [ ] Verify Supabase `proposal_emails` table exists
5. [ ] Build nodes in n8n per Step 1-6 above

### Week 2
1. [ ] End-to-end testing with test calls
2. [ ] Fix any issues found
3. [ ] Demo to Jonathan and Nate
4. [ ] Get approval to enable for real calls

### Week 3-4
1. [ ] Enable for production
2. [ ] Monitor closely (daily check-ins)
3. [ ] Collect feedback from sales team
4. [ ] Iterate on prompts based on feedback

### Month 2
1. [ ] Analyze Phase 1 data
2. [ ] Determine Phase 2 thresholds
3. [ ] Present to Jonathan for approval
4. [ ] Plan Phase 2 transition

---

## Related Documentation

- `proposal-automation-workflow.json` - Current n8n workflow (baseline)
- `proposal-automation-design.md` - Original design document
- `email-templates/pricing-email-templates.md` - Email templates
- `email-templates/automation-logic.md` - Template selection decision tree
- `supabase-schema-complete.sql` - Database schema
- `PROPOSAL-EMAIL-PROMPT.md` - AI prompt (to be created)

---

## Communication Log

**2026-02-03 - Initial Discussion**
- Jonathan: Prefers human-in-the-loop approach
- Jonathan: Two standard deviation threshold for confidence
- Jonathan: Seen enough variance and hallucinations over 8 years with AI
- Dereck: 100% agree, starting with drafts and direct feedback loop
- Agreement: Phase 1 (100% review) → Phase 2 (graduated automation)

**2026-02-06 - Implementation Planning**
- Documented phased approach in this guide
- Saved current workflow as baseline
- Identified missing components to build
- Created testing protocol
- Established success criteria

---

## Appendix: Technical References

### Stripe Payment Links

```javascript
const STRIPE_LINKS = {
  monthly_core: 'https://buy.stripe.com/7sY9AUc6U65w1uM36F4gg0l',
  quarterly_core: 'https://buy.stripe.com/bJe14oef2fG6ehy6iR4gg0f',
  api_addon_monthly: 'https://buy.stripe.com/9B64gA2wk2Tk5L25eN4gg0j',
  api_addon_quarterly: '[Need link]',
  api_addon_annual: '[Need link]',
  white_label: '[Contact for custom link]'
};
```

### GHL API Endpoints

```javascript
// Lookup contact by email
GET https://services.leadconnectorhq.com/contacts/search/duplicate
  ?email=john@example.com
  &locationId=NsVY7d3y1lM4chVbXzwk

// Add note to contact
POST https://services.leadconnectorhq.com/contacts/{contactId}/notes
  body: { "body": "Pricing email sent at 2:15pm" }

// Update custom fields
PUT https://services.leadconnectorhq.com/contacts/{contactId}
  body: { "customFields": [...] }

// Add tag
POST https://services.leadconnectorhq.com/contacts/{contactId}/tags
  body: { "tags": ["Pricing Sent"] }
```

### Slack Webhook URLs

```
Main Workflow Webhook:
https://server.advancedleadsolutions.com/webhook/cde306b0-97d3-4b81-bab4-be9333ead391

Button Handler Webhook:
https://server.advancedleadsolutions.com/webhook/proposal-email-approval
(Set this in Slack App Interactivity settings)
```

---

**End of Implementation Guide**

*This is a living document. Update as implementation progresses and new insights emerge.*
