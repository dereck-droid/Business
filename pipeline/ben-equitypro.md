# Ben / EquityPro

**Company:** EquityPro Real Estate Investment
**Contact:** Ben Yonge (President) -- Orlando, FL
**Relationship:** Previous work relationship, reconnected after months

---

## Current Engagement: Lis Pendens Scraper

**Deal:** $2,500 build ($1,250 paid, $1,250 due end of Feb)
**Managed Service:** $200/mo (Ben likely choosing this -- "doesn't really have an option")
**Status:** Officially deployed Feb 10. Automation tweaked and finalized. System live for Orange County.

**What it does:** Monitors Orange County Comptroller for new Lis Pendens (pre-foreclosure) filings every 10 minutes during business hours. Automatically filters out banks/HOAs/corps, matches people to property addresses via FL state parcel records, skip traces for phone/email, delivers enriched leads to Google Sheet.

**Tech stack:** n8n workflows, custom headless browser scraper, FL statewide parcel API, skip trace API, CAPTCHA solver, AI name analysis, Google Sheets, email alerts.

**Known limitations (V1):**
- ~50% address match rate (could improve with Orange County Property Appraiser as secondary source)
- Skip trace doesn't find contacts for all matched addresses
- Ben's team has Forewarn (realtor skip trace tool) to fill gaps manually
- Timeshares auto-filtered out (confirmed no value)

**Expansion opportunities discussed on call:**
- More document types on same comptroller site: code enforcement liens, divorce filings, other recordable events
- More FL counties ($750 setup + $150-250/mo each)
- Better address matching via Orange County Property Appraiser (Ben showed it finds what state DB misses)
- Forewarn API integration if available

---

## Upcoming: CRM Decision

Ben is evaluating pre-built wholesale GHL platforms vs. custom build. Making decision this week. His words: "Either way, there's a lot of work for you that's about to come down the pipeline."

Previous proposals for this in `archive/opportunities/ben-equitypro-*.md`.

---

## Productization Potential

This system could be packaged as a SaaS for real estate wholesalers:
- Premium counties: $497/mo
- Mid-tier: $297/mo
- Smaller markets: $197/mo
- Target: 20+ county subscriptions
- Each county needs custom scraper build ($750 one-time) since each comptroller site is different

---

## Timeline

- **Jan 23:** Reconnected, scheduled meeting
- **Jan 30:** First meeting. Multiple proposals discussed (CRM, automations).
- **Feb 9:** Lis Pendens scraper demo call. V1 delivered. Ben impressed. Service options doc sent.
- **Feb 10:** Automation tweaked, system officially deployed. Need to ask Ben about Option A vs B.
- **This week:** Ben choosing service option (managed $200/mo vs ownership $800 one-time) + making CRM decision

---

## Related Files

- Ben proposal documents: `archive/opportunities/ben-equitypro-*.md`
- Follow-up messages: `communications/follow-ups/2026-01-23-ben-equitypro.md`
