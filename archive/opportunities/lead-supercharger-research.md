# Lead Supercharger - Technical Research Summary

**Date:** January 21, 2026
**Status:** Research Complete, Ready for Proposal
**Partnership:** Retarget IQ (Alex & Nate)

---

## Related Documents

This is the **primary research document** covering CRM integration strategy and platform viability analysis.

**Companion documents:**
- **[Call Brief](./lead-supercharger-call-brief.md)** - Talking points and questions for Nate/Alex call (trigger logic, API details, validation)
- **[Technical Notes](./lead-supercharger-technical-notes.md)** - Ongoing build considerations (database design, architecture decisions, infrastructure planning)
- **[Complexity Analysis](./lead-supercharger-complexity-analysis.md)** - Build scope breakdown for partner communication (security, scalability, why this is sophisticated)

**Purpose of each:**
- **This file (Research):** Strategic decisions on CRM platforms, V1 scope, partnership terms
- **Call Brief:** Prepare for client calls, align on approach, validate assumptions
- **Technical Notes:** Living document for implementation details, architectural decisions, and technical considerations
- **Complexity Analysis:** Explain technical scope to non-technical partners, justify equity stake

---

## Executive Summary

Completed comprehensive technical research for Lead Supercharger partnership. **Recommendation: Launch V1 with GoHighLevel only**, then expand based on validated customer demand.

---

## Research Questions Addressed

### 1. Lead Capture Methods Evaluated

| Method | Convenience | Effectiveness | Verdict |
|--------|------------|---------------|---------|
| **GHL Marketplace App** | 10/10 | 9/10 | ✅ **V1 Choice** |
| **Webhook URL** | 6/10 | 9/10 | ✅ Backup option |
| **CSV Email Delivery** | 8/10 | 5/10 | ✅ Universal fallback |
| WordPress Plugin | 7/10 | 8/10 | ⏳ V2 candidate |
| Email Forwarding | 8/10 | 5/10 | ❌ Unreliable |
| JavaScript Snippet | 4/10 | 6/10 | ❌ Scares users |

---

## CRM Marketplace App Viability Analysis

Validated whether native "one-click" integrations are possible across major CRMs:

| CRM | Create Fields | Auto-Webhook | OAuth Send-Back | Verdict |
|-----|--------------|--------------|-----------------|---------|
| **GoHighLevel** | ✅ Yes | ✅ Yes | ✅ Yes | ✅ **Fully Automated** |
| **Pipedrive** | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Fully Automated |
| **Zoho CRM** | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Fully Automated |
| **HubSpot** | ⚠️ Enterprise only | ❌ No (manual) | ✅ Yes | ⚠️ Partial - Operations Hub required |
| **Salesforce** | ✅ Yes | ❓ Unclear | ✅ Yes | ❓ Needs deeper research |

---

## V1 Technical Architecture

### Platform: GoHighLevel Marketplace App Only

**Why GHL First:**
- Primary market for Alex & Nate (marketing agencies)
- Truly one-click installation
- You have prior GHL marketplace app experience
- Fastest path to revenue (2-3 weeks build time)
- Validates business model before expanding

**Installation Flow:**
1. Customer clicks "Install" in GHL marketplace
2. OAuth authorization (standard screen)
3. Backend automatically:
   - Creates 40+ custom fields in branded folder
   - Creates workflow with webhook pointing to enrichment endpoint
   - Stores OAuth tokens for write-back capability
4. Customer is done - zero additional configuration

**Technical Stack:**
- **Logic Layer:** n8n (all automation workflows)
- **Database:** Supabase (OAuth tokens, customer data)
- **Billing:** Stripe (subscription management)
- **Landing Page:** Simple static page with marketplace install link

**Data Flow:**
```
New Contact Created in GHL
    ↓
GHL Workflow fires webhook → n8n
    ↓
n8n receives: contact data + Location ID
    ↓
n8n enriches via Retarget IQ API
    ↓
n8n writes back to GHL (using stored OAuth tokens)
    ↓
Enriched fields populate in contact record
```

---

## Delivery Options (All Tiers)

### Free/Included:
1. **GHL Marketplace App** - One-click install
2. **Webhook URL** - For platforms supporting webhooks
3. **CSV Email Delivery** - Universal fallback for any platform

### Paid White Glove Setup ($149-199):
- WordPress integration
- HubSpot integration
- Salesforce/custom CRM
- Any platform not auto-supported
- **Delivery:** VA handles setup (costs you $7-15, profit $134-192 per setup)

---

## V2+ Expansion Strategy

**Decision Criteria:** Build based on validated customer demand, not assumptions

**Top Candidates (in priority order):**
1. **HubSpot** - Large SMB market, but requires:
   - Operations Hub Professional/Enterprise ($800+/month customer requirement)
   - Manual workflow setup by customer (not fully automated)
   - OAuth can auto-create fields, but webhook setup is manual

2. **Pipedrive** - Clean API, fully automated potential, sales-focused users

3. **Zoho CRM** - Budget market, international appeal, fully automated potential

4. **WordPress Plugin** - Massive market (43% of websites), medium complexity

**Recommendation:** Wait until GHL V1 launches, then analyze:
- Which CRMs are customers requesting?
- What's the conversion rate for white glove setups?
- Is demand concentrated in one platform?

---

## Partnership Terms (For Proposal)

**Equity Split:**
- Alex & Nate: 75%
- Dereck: 25%

**Scope Included in Equity:**
- V1 GHL marketplace app build
- Ongoing maintenance and bug fixes
- Platform expansion (2-3 additional platforms as demand warrants)

**Scope NOT Included (Requires Separate Compensation):**
- Building full SaaS platform with user auth, dashboards, admin portal
- Major architectural changes post-launch

**Their Responsibilities:**
- Marketing, sales, customer acquisition
- Customer support
- API costs (Retarget IQ enrichment)
- Ad spend (repaid from first revenues before profit splits)

**Your Responsibilities:**
- Technical build and architecture
- Platform integrations and maintenance
- Technical support for integration issues

---

## Build Timeline

**V1 (GHL Only):**
- Week 1-2: GHL marketplace app development
- Week 2-3: Testing, OAuth flow, field creation automation
- Week 3: Submission to GHL marketplace for approval
- **Total: 2-3 weeks to launch**

**V2 (If Demand Warrants):**
- Each additional native integration: 2-3 weeks
- Priority based on customer requests

---

## Key Insights & Decisions

### What We Learned:
1. **"Build to sell" = minimize operational complexity** - Native integrations with auto-setup are more valuable than flexible but complex webhook-only approaches

2. **HubSpot is NOT as turnkey as assumed** - No snapshot equivalent, requires Operations Hub for webhooks, manual workflow setup required

3. **Most HubSpot users use HubSpot native forms** - Not WordPress forms, which simplifies their trigger setup

4. **Field creation is critical** - Cannot rely on customers to manually create 40+ custom fields; must be programmatic

5. **Zapier is a trap** - Adds cost, complexity, and support burden without reducing your build effort

### Strategic Decisions:
- ✅ Focus V1 exclusively on GoHighLevel
- ✅ Offer CSV email delivery as universal fallback
- ✅ Monetize complexity via white glove setup fees
- ✅ Expand to V2 platforms only after validated demand
- ❌ Do NOT build multiple platforms before launch
- ❌ Do NOT rely on Zapier for core integrations

---

## Risks & Mitigations

| Risk | Mitigation |
|------|-----------|
| GHL API changes break integration | Build robust error handling, monitor API changelog |
| Customers want HubSpot immediately | Offer white glove setup option, explain V2 timeline |
| Enrichment API rate limits | Implement queuing system, batch processing |
| Marketplace approval delays | Submit early, have backup direct-install option |
| Support burden higher than expected | Document common issues, build self-service troubleshooting |

---

## Next Steps

1. **Draft proposal to Alex & Nate** (by Friday, Jan 24)
   - V1 technical architecture (GHL only)
   - Rationale for platform prioritization
   - Partnership terms (25% equity)
   - Timeline (2-3 weeks to launch)
   - V2 expansion strategy

2. **Get alignment on:**
   - Equity split
   - Scope boundaries
   - Timeline expectations
   - Launch vs. multi-platform debate

3. **Once approved:**
   - Begin GHL marketplace app development
   - Set up n8n + Supabase + Stripe infrastructure
   - Create landing page and onboarding flow

---

## Open Questions for Alex & Nate

- Are they comfortable launching with GHL only, or do they need multiple platforms at launch?
- What's their risk tolerance for 2-3 weeks build time vs. 3-4 months for multi-platform?
- Do they have existing GHL customers who would be early adopters?
- What's their expected timeline to exit? (Influences build-for-sale decisions)

---

**Research Status:** ✅ Complete
**Confidence Level:** High - Ready to propose
**Recommendation:** Proceed with V1 GHL-only build
