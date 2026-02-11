# Ben / EquityPro

**Company:** EquityPro Real Estate Investment
**Contact:** Ben Yonge (President) -- Orlando, FL
**Relationship:** Previous work relationship, reconnected after months

---

## Current Engagement: Lis Pendens Scraper

**Deal:** $2,500 build ($1,250 paid, $1,250 due end of Feb)
**Managed Service:** Negotiating. Ben chose managed but pushed back on price. Dereck countered with Liens add-on ($300 one-time + $250/mo). Awaiting response.
**Status:** Lis Pendens live for Orange County. Liens feature proposed but not yet built.

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

**Liens add-on (proposed Feb 11):**
- 50-150 liens filed per day in Orange County (~1,500-2,200/mo vs 200-300 Lis Pendens)
- $300 one-time to add to existing scraper
- Monthly would be $250/mo for Orange County (up from $200 ask)
- Strategy: prove conversion on one county with massive volume, then expand

---

## Upcoming: CRM Decision

Ben is evaluating pre-built wholesale GHL platforms vs. custom build. Said he'd have a decision by Feb 11. His words: "Either way, there's a lot of work for you that's about to come down the pipeline."

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
- **Feb 10:** Automation tweaked, system officially deployed. Ben emailed at 4:46 PM: chose managed service but countered with $200/mo for up to 5 counties + $500 setup/county. Said he can't afford original pricing until leads start converting. CRM decision coming "tomorrow."
- **Feb 11:** Dereck replied with counter-proposal: add Liens scraping for $300 one-time, $250/mo for Orange County, ~10x lead volume increase. Waiting on Ben's response. Also waiting on CRM decision.
- **Pending:** Ben's reply on liens counter + CRM build decision

---

## Related Files

- Ben proposal documents: `archive/opportunities/ben-equitypro-*.md`
- Follow-up messages: `communications/follow-ups/2026-01-23-ben-equitypro.md`
