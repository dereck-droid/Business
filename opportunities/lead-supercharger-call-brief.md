# Lead Supercharger Call Brief
**Date:** January 22, 2026
**Call With:** Nate & Alex (Retarget IQ)
**Purpose:** Align on trigger logic, validate approach, confirm next steps

---

## Related Documents
- **[Research Summary](./lead-supercharger-research.md)** - Primary research on CRM platforms, V1 strategy, partnership terms
- **[Technical Notes](./lead-supercharger-technical-notes.md)** - Implementation details, architecture decisions, infrastructure planning
- **[Complexity Analysis](./lead-supercharger-complexity-analysis.md)** - Build scope breakdown for partner communication

**This document:** Talking points and validation questions for client calls

---

## What I've Already Researched

✅ **CRM Integration Options** - Validated that GoHighLevel marketplace app is fully automated (auto-creates fields, auto-configures webhooks, OAuth write-back)

✅ **V1 Strategy** - Recommendation: Launch with GHL only, expand based on validated demand

✅ **Technical Architecture** - n8n (logic) + Supabase (database) + Stripe (billing)

✅ **Data Flow** - Contact created → GHL workflow fires webhook → n8n → Enrichment API → Write back to GHL

✅ **Timeline** - 2-3 weeks to launch V1

**Full research doc:** `/opportunities/lead-supercharger-research.md`

---

## Key Decision for This Call: Trigger Logic

### The Question:
**What triggers the enrichment process?**

### Options We've Discussed:

**Option A: Form Fills Only**
- ❌ Requires identifying specific form(s) in setup process
- ❌ Extra configuration step (not turnkey)
- ❌ Some forms don't have webhook capability
- ✅ More targeted (only "hot" leads from forms)

**Option B: All New Contacts Meeting Basic Criteria**
- ✅ Fully turnkey (no form selection needed)
- ✅ Works with any contact source (forms, manual entry, imports, integrations)
- ✅ Simpler setup = more scalable
- ⚠️ May enrich contacts that don't need it (but low marginal cost)

**Basic Criteria:** Full name is not empty AND (Email is not empty OR Phone is not empty)

---

## My Recommended Approach

### **Recommendation: Option B (All New Contacts)**

**Why this aligns with our turnkey goal:**

1. **Zero configuration** - Customer installs marketplace app, we auto-create workflow that triggers on "New Contact Created" with basic criteria filters. Done.

2. **Platform agnostic** - Works regardless of how contacts enter the system (forms, Zapier, API, manual entry, CSV imports, etc.)

3. **Scalable** - No need for customer support calls to "configure which forms to use"

4. **Sellable** - Simple value proposition: "Install app, every new real lead gets enriched automatically"

5. **Future-proof** - If they add new forms or lead sources later, it just works

**Trade-off we're making:**
- We enrich ALL qualifying contacts, not just form fills
- This means slightly higher API costs for enrichment
- BUT: Eliminates setup friction, support burden, and increases perceived value

**Why this is the right trade-off:**
- Enrichment cost is probably $0.10-0.50 per lead
- Support call to troubleshoot "why isn't this form working?" costs way more
- Customer sees MORE value (all leads enriched, not just some)

---

## Enrichment Process (For Clarity)

**What I understand:**
1. Our n8n workflow sends webhook to your white-label enrichment service
2. We receive HTTP response with enriched data
3. We write that data back to GHL custom fields

**What I need to confirm with you:**
- What data do we send in the webhook? (Name, email, phone, company?)
- What's the response format? (JSON with specific fields?)
- What's the typical response time? (Sync vs async?)
- How do we handle errors/no data found?
- Are there rate limits I need to design around?

---

## Questions to Validate My Assumptions

### Business Model:
1. **Pricing model** - Are we charging per-seat, per-enrichment, or flat monthly fee?
2. **API cost passthrough** - Are enrichment costs included in the price, or charged separately?
3. **Target customer** - Marketing agencies using GHL, or direct to SMBs?

### Technical:
4. **Enrichment API details** - Endpoint, authentication, request/response format, rate limits?
5. **Field mapping** - Do you have a defined list of 40+ fields we're populating?
6. **Error handling** - What happens if enrichment fails or returns no data?

### Launch:
7. **MVP scope** - Are we aligned on GHL-only for V1, or do you need multiple platforms at launch?
8. **Timeline pressure** - Is 2-3 weeks acceptable, or do you need it faster?
9. **Beta customers** - Do you have GHL customers ready to test?

---

## My Positioning for This Call

**Opening statement:**
"I'm excited to learn more about your enrichment service and align on the best approach. I'm the expert in automation and building turnkey solutions, not lead enrichment or your industry, so I'm going to ask a lot of questions to make sure I understand the business model and technical requirements. My goal is to design something that's truly hands-off and scalable, which means making smart decisions now about what we automate vs. what we leave configurable."

**Core thesis:**
Every decision we make should optimize for **turnkey + scalable + sellable**. This means:
- Heavy upfront build complexity = good (we do it once)
- Ongoing configuration/support complexity = bad (we do it forever)
- Customer setup steps = bad (friction kills conversions)

---

## What Success Looks Like

**After this call, I should have:**
1. ✅ Alignment on trigger logic (all contacts vs. form fills)
2. ✅ Enrichment API technical details
3. ✅ Field mapping and data structure
4. ✅ Pricing/business model clarity
5. ✅ Confirmed timeline and V1 scope

**Next step after this call:**
- Write formal proposal (due Friday, Jan 24) with:
  - Technical architecture
  - Timeline and milestones
  - Partnership terms (25% equity)
  - V1 scope and V2 expansion strategy

---

## Notes / Open Items

(Space for notes during the call)

**Action Items:**
- [ ] Get enrichment API documentation from Nate/Alex
- [ ] Confirm field list (40+ fields)
- [ ] Finalize trigger logic decision
- [ ] Draft proposal by Friday

---

**Bottom Line:** I've done the hard research on CRM integration viability. This call is about aligning on the enrichment process, trigger logic, and business model so I can finalize the proposal. My recommendation is to go with "all new contacts" trigger because it's the most turnkey approach and aligns with our goal of building something scalable and sellable.
