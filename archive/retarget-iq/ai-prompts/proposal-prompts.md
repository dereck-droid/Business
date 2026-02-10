# AI Prompts for Proposal Automation

This document contains all AI prompts used in the proposal automation workflow.

**Created:** 2025-02-05
**Models Used:** Claude 3.5 Haiku (fast check), Claude 3.5 Sonnet (generation)
**Related:** `/retarget-iq/proposal-automation-design.md`

---

## Table of Contents

1. [Proposal Promise Detection](#prompt-1-proposal-promise-detection)
2. [Proposal Email Generation](#prompt-2-proposal-email-generation)
3. [Template Selection Logic](#template-selection-logic)
4. [Variable Extraction Rules](#variable-extraction-rules)

---

## Prompt 1: Proposal Promise Detection

**Purpose:** Quickly detect if sales rep promised to send pricing
**Model:** Claude 3.5 Haiku (`anthropic/claude-3-5-haiku`)
**Temperature:** 0.1
**Response Format:** JSON
**Cost:** ~$0.001 per call
**Node Name:** "Check Proposal Promised"

### Prompt Text

```
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

### Expected Output

```json
{
  "proposal_promised": true,
  "confidence": 0.98,
  "evidence": "Nate Calhoun: 'Perfect, let me send over the pricing breakdown to your email right after this call.'"
}
```

### Edge Cases

| Scenario | Expected Result |
|----------|-----------------|
| "I'll send the pricing" | `proposal_promised: true` |
| "You can find pricing on our website" | `proposal_promised: false` |
| "Would you like me to send pricing?" (no response) | `proposal_promised: false` |
| "I'll follow up next week" (no pricing mentioned) | `proposal_promised: false` |
| Prospect asks "can you send that?" → Nate: "Absolutely" | `proposal_promised: true` |

---

## Prompt 2: Proposal Email Generation

**Purpose:** Analyze call history and generate personalized proposal
**Model:** Claude 3.5 Sonnet (`anthropic/claude-sonnet-4.5`)
**Temperature:** 0.2
**Response Format:** JSON
**Cost:** ~$0.15 per call
**Node Name:** "Generate Proposal Email"

### Prompt Text

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
{% for call in calls %}
---
Call {{ loop.index }} - {{ call.created_at }}
Recording: {{ call.recording_url }}

Summary:
{{ call.summary }}

Transcript:
{{ call.transcript }}

Tool Interests: {{ call.tool_interests | join(", ") }}
Call Outcome: {{ call.call_outcome }}

{% endfor %}

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
    "team_member_on_call": "nate@retargetiq.com"
  },
  "email_generation": {
    "template_used": "Template 1",
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

### Example Input (n8n format)

```javascript
// In n8n, this comes from Supabase query
{
  "calls": [
    {
      "recording_id": "01KENF6A97RFX9K8SRR7CMB1GB",
      "recording_url": "https://app.fireflies.ai/view/01KENF6A97RFX9K8SRR7CMB1GB",
      "created_at": "2025-01-15T10:30:00Z",
      "summary": "Summary: Aaron runs a real estate lead generation business...",
      "transcript": "Nate Calhoun: Hey Aaron, thanks for joining...",
      "tool_interests": ["Website Identification", "Intent Data"],
      "call_outcome": "Thinking about it"
    }
  ]
}
```

### Example Output

```json
{
  "analysis": {
    "white_label_discussed": false,
    "white_label_evidence": null,
    "pricing_mentioned": {
      "monthly": 797,
      "quarterly": 500,
      "white_label": null,
      "custom_terms": null
    },
    "customer_profile": "B",
    "use_case": "Identify website visitors for real estate lead generation",
    "questions_concerns": [
      "How accurate is the visitor identification?",
      "Can it integrate with GoHighLevel?",
      "What's the match rate for real estate traffic?"
    ],
    "team_member_on_call": "nate@retargetiq.com"
  },
  "email_generation": {
    "template_used": "Template 2",
    "template_reasoning": "Customer asked detailed questions about features, integrations, and match rates. Profile B (Detail-Oriented) fits best. Needs full pricing breakdown including add-ons.",
    "generated_email_subject": "Pricing for Retarget IQ",
    "generated_email_body": "Hi Aaron!\n\nGreat chatting with you earlier about using Retarget IQ for your real estate lead gen business...\n\n[Full email body here]",
    "stripe_link_used": "https://buy.stripe.com/bJe14oef2fG6ehy6iR4gg0f"
  },
  "confidence": {
    "score": 92.0,
    "reasoning": "High confidence. Customer profile clear (detail-oriented), pricing discussed explicitly (quarterly preferred), use case well-defined (real estate leads), GoHighLevel integration confirmed. Only minor uncertainty around whether to include API add-on pricing.",
    "validation_flags": [
      "Customer asked about GoHighLevel integration - confirmed it's available but didn't explicitly ask for API add-on pricing. Included in email for completeness."
    ]
  }
}
```

---

## Template Selection Logic

### Decision Tree (Implemented in AI Prompt)

```
START
  ↓
Was white label discussed?
  ├─ YES → Template 3 (White Label Pricing)
  └─ NO → Continue
      ↓
  Does customer just need the payment link?
    ├─ YES → Template 4 (Payment Link Follow-Up)
    └─ NO → Continue
        ↓
    Is customer detail-oriented OR asking about add-ons?
      ├─ YES → Template 2 (Full Pricing Breakdown)
      └─ NO → Continue
          ↓
      Is customer ready to buy (Quick Buyer)?
        ├─ YES → Template 1 (Initial Pricing - Brief)
        └─ NO → Continue
            ↓
        Is customer on the fence (comparing competitors)?
          ├─ YES → Template 1 + Template 6 (Add urgency)
          └─ NO → Template 2 (Safe default)
```

### Customer Profile Definitions

| Profile | Indicators | Template |
|---------|-----------|----------|
| A - Quick Buyer | "Let's do it", minimal questions, decisive | Template 1 |
| B - Detail-Oriented | Multiple questions, wants full breakdown | Template 2 |
| C - Agency/White Label | Mentions clients, reselling, seats | Template 3 |
| D - Just Needs Link | "Just send me the link", already decided | Template 4 |
| E - On the Fence | Mentions competitors, comparing options | Template 1 + 6 |

---

## Variable Extraction Rules

### Variables to Extract

| Variable | Source | Fallback | Example |
|----------|--------|----------|---------|
| `[FIRST_NAME]` | Contact name | "there" | "John" |
| `[PLAN_TYPE]` | Call discussion | "quarterly" | "quarterly" |
| `[STRIPE_LINK]` | Plan type → link map | Monthly link | "https://buy.stripe.com/..." |
| `[USE_CASE]` | Call summary | "your business" | "real estate lead generation" |
| `[TEAM_MEMBER]` | raw_payload attendees | "Nate" | "Nate" |

### Stripe Link Mapping

```javascript
const STRIPE_LINKS = {
  "monthly": "https://buy.stripe.com/7sY9AUc6U65w1uM36F4gg0l",
  "quarterly": "https://buy.stripe.com/bJe14oef2fG6ehy6iR4gg0f",
  "api_addon_m2m": "https://buy.stripe.com/9B64gA2wk2Tk5L25eN4gg0j",
  "white_label": "Contact for custom link"
};

// Logic
if (white_label_discussed) {
  link = "Contact for custom link";
} else if (plan_type === "quarterly") {
  link = STRIPE_LINKS.quarterly;
} else {
  link = STRIPE_LINKS.monthly; // default
}
```

---

## Confidence Scoring Guidelines

### Confidence Ranges

| Range | Meaning | Action |
|-------|---------|--------|
| 95-100% | Perfect clarity | Auto-send |
| 85-94% | Very high confidence | Auto-send |
| 70-84% | Good but minor gaps | Human review |
| 50-69% | Significant uncertainty | Human review |
| < 50% | Too much missing | Manual escalation |

### Confidence Factors

**Increase Confidence (+):**
- Pricing explicitly discussed
- Plan type clearly stated
- Use case well-defined
- Single call with complete discussion
- No contradictions in call history

**Decrease Confidence (-):**
- No pricing mentioned
- Multiple conflicting statements
- Unclear customer profile
- Many unanswered questions
- Competitor comparison without clear preference

### Example Confidence Calculations

**High Confidence (96%):**
```
✓ Pricing discussed explicitly ("I'd like the quarterly plan")
✓ Use case clear ("tracking website visitors for my agency")
✓ No white label confusion
✓ Template selection obvious (Template 1)
✓ All variables easily extracted
→ Confidence: 96%
```

**Medium Confidence (78%):**
```
✓ Pricing discussed
✓ Use case mentioned
⚠ Unclear if quarterly or monthly preferred
⚠ Asked about white label but didn't commit
⚠ Some questions left unanswered
→ Confidence: 78% (human review)
```

**Low Confidence (55%):**
```
✗ No pricing discussed
✗ Use case vague
✗ Multiple unresolved questions
✗ Customer "still thinking about it"
⚠ Mentioned competitors
→ Confidence: 55% (manual escalation)
```

---

## Validation Rules (Post-AI Generation)

After AI generates the email, run these checks:

### Critical Validations

```javascript
// Check 1: No [BRACKETS] remain
const hasBrackets = /\[.*?\]/.test(generated_email);
if (hasBrackets) {
  validation_issues.push("Email contains unfilled [VARIABLES]");
  confidence -= 20;
}

// Check 2: Stripe link is valid
const validLinks = [
  "https://buy.stripe.com/7sY9AUc6U65w1uM36F4gg0l",
  "https://buy.stripe.com/bJe14oef2fG6ehy6iR4gg0f",
  "https://buy.stripe.com/9B64gA2wk2Tk5L25eN4gg0j"
];
if (!validLinks.some(link => generated_email.includes(link))) {
  validation_issues.push("No valid Stripe link found");
  confidence -= 15;
}

// Check 3: Has proper structure
const hasGreeting = /^Hi |^Hey |^Hello /.test(generated_email);
const hasClosing = /Best,|Thanks,|Regards,/.test(generated_email);
if (!hasGreeting || !hasClosing) {
  validation_issues.push("Missing greeting or closing");
  confidence -= 5;
}

// Check 4: Not too short
if (generated_email.length < 300) {
  validation_issues.push("Email seems too brief");
  confidence -= 10;
}
```

---

## Testing Prompts

### Test Prompt 1: Simple Case

**Input:**
```
Call 1 - 2025-02-05
Summary: Quick call with Sarah about using Retarget IQ for her marketing agency.
Transcript:
Nate: "So what brings you to Retarget IQ today?"
Sarah: "I want to identify my website visitors. I have about 3,000 visitors a month."
Nate: "Perfect, we can definitely help with that. The quarterly plan at $500/month would be great for you."
Sarah: "That sounds good. Can you send me the pricing?"
Nate: "Absolutely, I'll send it right over after this call."
```

**Expected Output:**
- `proposal_promised`: true
- `customer_profile`: "A" (Quick Buyer)
- `template_used`: "Template 1"
- `confidence`: 95%+
- Email includes $500/month quarterly pricing
- Quarterly Stripe link included

### Test Prompt 2: White Label Case

**Input:**
```
Call 1 - 2025-02-05
Summary: Agency owner asking about white label for multiple clients.
Transcript:
Alex: "Tell me about your white label options."
Client: "I have about 15 clients I'd want to set this up for."
Alex: "Our white label is $2,999/month and includes 10 client seats. Additional seats are $100 each."
Client: "Ok, send me the details."
```

**Expected Output:**
- `white_label_discussed`: true
- `customer_profile`: "C" (Agency)
- `template_used`: "Template 3"
- `confidence`: 92%+
- Email includes white label pricing
- Mentions 15 clients, 10 included + 5 additional

---

## Prompt Maintenance

### When to Update Prompts

1. **New pricing added** → Update PRICING OPTIONS section
2. **New team member** → Add to team member detection
3. **New template created** → Add to decision tree
4. **Customer feedback** → Adjust tone/style guidelines
5. **Stripe links change** → Update STRIPE PAYMENT LINKS section

### Version History

| Date | Change | Reason |
|------|--------|--------|
| 2025-02-05 | Initial prompts created | New proposal automation |

---

## Related Files

- `/retarget-iq/proposal-automation-design.md` - Complete workflow design
- `/retarget-iq/email-templates/pricing-email-templates.md` - Template library
- `/retarget-iq/email-templates/automation-logic.md` - Decision tree details
