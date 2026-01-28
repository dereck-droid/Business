# Prayer Board App - Project Documentation

**Date:** 2026-01-28
**Status:** 85-90% Complete - Ready for Beta Testing
**Purpose:** Church prayer request management system replacing manual spreadsheet tracking

---

## Related Documents
- [Backlog Entry](../../backlog.md#complete-prayer-board-app)
- [FOCUS Dashboard](../../FOCUS.md)

---

## CURRENT STATUS

### Completion: 85-90%

**What's Complete:**
- Core prayer request submission system
- Database structure and RLS policies (mostly finalized)
- Basic admin dashboard
- Prayer request display and organization
- User authentication

**Remaining Work:**
- Final testing (audio/video uploads)
- RLS policy finalization
- Admin dashboard polish
- Mobile responsiveness testing
- Documentation for church admins
- Demo video and landing page
- Pricing page and signup flow

**Timeline to Launch:** 2-3 weeks development + 2-3 weeks marketing setup

---

## CORE CONCEPT

A SaaS application that replaces manual spreadsheet tracking of prayer requests for churches. Churches can collect, organize, and manage prayer requests from their congregation through a modern, user-friendly interface.

### The Problem Being Solved

**Current Reality:**
- Churches manually track prayer requests in spreadsheets
- Difficult to organize and share with prayer teams
- No easy way for congregation to submit requests
- Time-consuming for staff to manage
- Requests get lost or forgotten
- No privacy controls or sensitivity filters

**User Feedback from Pastors:**
- "Sensational" (direct quote from pastoral feedback)
- "Fantastic idea" (direct quote from pastoral feedback)
- Clear pain point validated by target users

---

## MARKET OPPORTUNITY

### Target Market

**Primary Target:**
- Churches with 150-500 members
- Mid-sized congregations with organized prayer ministries
- Churches already using digital tools (website, email, etc.)

**Market Size:**
- 40,000-50,000 churches in target size range (United States)
- Conservative capture rate: 0.5%-1% = 200-500 churches
- Optimistic capture rate: 2%-5% = 800-2,500 churches

### Revenue Model

**Pricing:** $99/month per church

**Revenue Projections:**

**Conservative (Year 1):**
- 50 churches × $99/month = $4,950/month = **$59,400/year**
- 100 churches × $99/month = $9,900/month = **$118,800/year**

**Moderate (Year 2-3):**
- 200 churches × $99/month = $19,800/month = **$237,600/year**

**Optimistic (At Scale):**
- 500 churches × $99/month = $49,500/month = **$594,000/year**
- 1,000 churches × $99/month = $99,000/month = **$1,188,000/year**

**Target from Backlog:** $60K-120K Year 1, $240K-300K at scale

---

## CORE FEATURES

### For Congregation Members

**Prayer Request Submission:**
- Simple web form accessible from church website
- Optional: Photo/video attachments
- Sensitivity levels (public, prayer team only, leadership only)
- Category selection (health, family, guidance, thanksgiving, etc.)
- Anonymous submission option
- Email confirmation when submitted

**Prayer Request Updates:**
- Submit updates on existing requests
- Mark as answered/resolved
- Share testimonies of answered prayers

### For Church Admin/Leadership

**Admin Dashboard:**
- View all prayer requests in one place
- Filter by category, date, sensitivity level
- Search functionality
- Approve/moderate requests before publishing
- Edit or remove inappropriate content
- Export to PDF or print for prayer meetings

**Organization Features:**
- Assign requests to specific prayer teams
- Set expiration dates for time-sensitive requests
- Archive old requests
- Track answered prayers
- Generate reports on prayer request trends

**Privacy Controls:**
- Role-based access (admin, prayer team leader, team member)
- Sensitivity filters ensure private requests stay private
- GDPR/privacy compliance for personal information

### For Prayer Teams

**Prayer Team View:**
- See requests assigned to their team
- Mark requests as "praying for this"
- Add private notes (visible to team only)
- Receive notifications of new urgent requests
- Weekly digest emails of current requests

---

## TECHNICAL SPECIFICATIONS

### Tech Stack (Based on Your Expertise)

**Frontend:**
- Modern web application (React or similar)
- Mobile-responsive design
- Progressive Web App capabilities

**Backend:**
- Supabase (PostgreSQL database)
- Row Level Security (RLS) policies for data protection
- Real-time subscriptions for live updates

**Storage:**
- Cloud storage for media uploads (audio/video)
- Cloudinary or AWS S3

**Authentication:**
- Church-specific subdomains or login portals
- Role-based access control
- Admin, team leader, team member, congregation roles

**Integrations (Future):**
- Church management systems (Planning Center, CCB, etc.)
- Email notifications
- SMS notifications (optional premium feature)
- Calendar integration for prayer meeting schedules

---

## COMPETITIVE LANDSCAPE

### Existing Solutions

**Prayer Request Features in ChMS:**
- Planning Center, Church Community Builder, etc. include prayer features
- **Weakness:** Part of expensive all-in-one systems ($50-200/month)
- **Weakness:** Clunky interfaces, not specialized for prayer ministry
- **Your Advantage:** Focused, purpose-built, affordable

**Standalone Prayer Apps:**
- Limited competition in SaaS church prayer space
- Most are consumer prayer apps (Echo Prayer, PrayerMate) not church-focused
- **Your Advantage:** B2B church-specific, admin controls, team organization

**Current "Solution" (Spreadsheets):**
- Free but manual, time-consuming, disorganized
- **Your Advantage:** Automation, organization, accessibility, mobile-friendly

---

## GO-TO-MARKET STRATEGY

### Phase 1: Beta Testing (Weeks 1-4)

**Goal:** Test with 5-10 churches, gather feedback, refine

**Approach:**
- Reach out to churches in personal network
- Offer free access during beta period
- Gather detailed feedback on UX
- Document testimonials and case studies
- Iterate based on real church needs

**Beta Recruitment:**
- Personal connections in church community
- Facebook groups for church leaders/pastors
- Local churches in Greenville/Simpsonville area
- Online church leadership forums

### Phase 2: Soft Launch (Months 2-3)

**Goal:** 20-50 paying churches, validate pricing

**Approach:**
- Launch pricing at $99/month
- Create demo video showing how it works
- Build simple landing page with benefits
- Testimonials from beta churches
- Case study: "How [Church Name] organized 200+ prayer requests in their first month"

**Marketing Channels:**
- Church leadership conferences (virtual presentations)
- Facebook ads targeting church admins
- Content marketing (blog posts on church prayer ministry)
- Referral program (existing customers refer others for 1 month free)

### Phase 3: Scale (Months 4-12)

**Goal:** 100-200 churches, establish as go-to solution

**Approach:**
- Partner with church consultants and coaches
- Exhibit at church conferences (if budget allows)
- Webinars: "Modernizing Your Church Prayer Ministry"
- SEO content targeting "church prayer request software"
- Case studies from diverse church sizes and denominations

**Partnership Opportunities:**
- Church consultants who recommend tools
- Worship/tech providers serving churches
- Church planting networks (new churches need tools)
- Denominational networks

---

## PRICING STRATEGY

### Base Tier: $99/month

**Includes:**
- Unlimited prayer requests
- Up to 500 active congregation members
- Basic admin dashboard
- Email notifications
- Standard support

### Premium Tier: $149-199/month (Future)

**Additional Features:**
- SMS notifications
- Advanced analytics and reporting
- API access for integrations
- Priority support
- Custom branding
- Multiple campuses/locations

### Enterprise: Custom Pricing

**For:**
- Mega churches (1,000+ members)
- Multi-site churches
- Denominational networks
- White-label opportunities

---

## CUSTOMER ACQUISITION COST (CAC) & LIFETIME VALUE (LTV)

### CAC Estimate

**Organic Channels:**
- Personal network: $0 (relationship-based)
- Beta referrals: $0-50/customer
- Content marketing: $100-200/customer (time investment)

**Paid Channels:**
- Facebook ads: $200-400/customer (estimated)
- Conference sponsorships: $500-800/customer
- Google ads: $300-500/customer

**Target CAC:** $100-300/customer

### LTV Estimate

**Average Customer Lifetime:**
- Assumption: 24-36 month retention (churches change tools slowly)
- Conservative: 24 months
- Optimistic: 48+ months (sticky product)

**LTV Calculation:**
- $99/month × 24 months = **$2,376 LTV**
- $99/month × 36 months = **$3,564 LTV**

**LTV:CAC Ratio:**
- Conservative: $2,376 / $300 = **7.9:1** (healthy SaaS metric)
- Target: 3:1 or higher is good, you're well above

---

## RETENTION & CHURN MITIGATION

### Why Churches Will Stay

**High Switching Costs:**
- Prayer request data locked in system
- Teams trained on platform
- Congregation familiar with submission process
- Historical prayer records valuable

**Network Effects:**
- More congregation uses it = more valuable
- Prayer team relies on it for coordination
- Becomes "how we do prayer" at church

**Continuous Value:**
- Ongoing prayer ministry needs
- New requests constantly coming in
- Not a "set and forget" tool

### Churn Risks

**Why Churches Might Leave:**
- Budget cuts (recession, giving declines)
- Switch to all-in-one ChMS
- Leadership change (new pastor doesn't value it)
- Church closes or merges

**Mitigation Strategies:**
- Annual billing discount (12 months for price of 10)
- Lock in early adopters at discounted rate
- Build integrations with major ChMS systems
- Demonstrate ROI through engagement metrics
- Provide excellent support and feature requests

---

## CRITICAL SUCCESS FACTORS

### Must-Haves for Product-Market Fit

1. **Simple for Congregation**
   - 30 seconds to submit a prayer request
   - Mobile-friendly (people submit on their phones)
   - No account required for congregation to submit

2. **Powerful for Admins**
   - Organize hundreds of requests easily
   - Filter and search quickly
   - Export for print/meetings

3. **Privacy First**
   - Sensitive requests stay private
   - Compliance with data protection laws
   - Churches trust us with personal information

4. **Reliable**
   - 99.9% uptime (churches rely on it)
   - Fast page loads
   - Data never lost

5. **Great Support**
   - Responsive to church admin questions
   - Training materials and videos
   - Onboarding assistance

---

## RISKS & MITIGATION

### Risk 1: Low Willingness to Pay

**Risk:** Churches won't pay $99/month

**Mitigation:**
- Beta testing validates pricing
- Show clear ROI (time saved, better organization)
- Offer annual discount
- Position as ministry investment, not expense
- Free trial (30 days)

### Risk 2: Competition from Free/Cheap Alternatives

**Risk:** Churches use Google Forms + Spreadsheets (free)

**Mitigation:**
- Emphasize time savings (staff time is expensive)
- Better organization = better prayer ministry = church growth
- Professional appearance vs. DIY solutions
- Privacy controls that spreadsheets don't offer

### Risk 3: Slow Church Decision Making

**Risk:** Churches take 3-6 months to decide on new software

**Mitigation:**
- Free trial removes barrier to testing
- Target early adopter churches (tech-forward)
- Build urgency with limited-time discounts
- Focus on smaller churches (faster decisions)

### Risk 4: Can't Reach Target Market

**Risk:** Marketing to churches is difficult

**Mitigation:**
- Personal network first (warm leads)
- Partner with church consultants (distribution)
- Facebook groups where church leaders hang out
- SEO for organic discovery
- Referral program (churches know other churches)

### Risk 5: Product Not Different Enough

**Risk:** Existing ChMS solutions "good enough"

**Mitigation:**
- Focus on churches NOT using full ChMS
- Specialize in prayer (not general church management)
- Better UX than legacy ChMS prayer modules
- Price point for smaller churches ($99 vs. $200+)

---

## WHY THIS PROJECT IS STRATEGIC

### 1. You're 85-90% Done

- **Sunk cost recovered:** Most dev work complete
- **Quick to revenue:** 2-3 weeks finishing touches
- **Low additional investment:** Mostly polish and testing

### 2. Recurring Revenue

- **MRR model:** Predictable monthly income
- **High retention:** Churches stick with tools they adopt
- **Scales without linear time:** 10 customers or 100, same effort

### 3. Validated Demand

- **Pastor feedback:** "Sensational," "Fantastic idea"
- **Clear pain point:** Spreadsheets are inadequate
- **Existing market:** 40-50K churches in target range

### 4. Plays to Your Strengths

- **Automation expertise:** You know how to build this
- **Understanding customer:** You understand church culture
- **Relationship-based sales:** Warm network for beta testing

### 5. Exit Potential

- **Acquirable by:**
  - Church management system companies (Planning Center, CCB, Breeze)
  - Church tech platforms (Subsplash, Pushpay)
  - Faith-based SaaS aggregators

- **Exit value:** $500K-2M depending on MRR and customer base

---

## NEXT STEPS (WHEN PRIORITIZED)

### Week 1-2: Finish Development

- [ ] Final testing of audio/video uploads
- [ ] Finalize RLS policies
- [ ] Polish admin dashboard UI
- [ ] Mobile responsiveness testing
- [ ] Bug fixes from testing

### Week 3-4: Marketing Prep

- [ ] Write church admin documentation
- [ ] Create demo video (5-10 minutes)
- [ ] Build landing page
- [ ] Create pricing page
- [ ] Set up payment processing (Stripe)
- [ ] Design email templates for notifications

### Week 5-6: Beta Launch

- [ ] Recruit 5-10 beta churches
- [ ] Onboard and train church admins
- [ ] Gather feedback weekly
- [ ] Iterate based on usage
- [ ] Document testimonials

### Month 3-4: Public Launch

- [ ] Incorporate beta feedback
- [ ] Launch pricing at $99/month
- [ ] Activate marketing channels
- [ ] Target 20 paying churches

### Month 5-12: Scale

- [ ] Iterate on features based on customer requests
- [ ] Build integrations (ChMS, email platforms)
- [ ] Expand marketing efforts
- [ ] Target 100 churches

---

## COMPARISON WITH OTHER APP IDEAS

### Prayer Board vs. Vegan Spots

**Prayer Board Advantages:**
- 85-90% complete (closer to revenue)
- Validated demand (pastor feedback)
- B2B SaaS (easier to monetize)
- Your understanding of church culture

**Vegan Spots Advantages:**
- Personal pain point (you're the user)
- AI agent moat (harder to copy)
- Larger market (20M vegans vs. churches)
- Higher revenue ceiling ($975K vs. $600K)

### Prayer Board vs. Elimination Diet

**Prayer Board Advantages:**
- Nearly complete (weeks vs. months to launch)
- Validated with users already
- Simpler tech stack (no voice AI complexity)
- Faster to cash

**Elimination Diet Advantages:**
- Personal pain point (you're doing elimination diet NOW)
- Voice AI moat (unique competitive advantage)
- Larger market (32M food allergies + autoimmune)
- Higher revenue ceiling ($3M vs. $600K)
- Solving active medical need (higher retention)

### Prayer Board vs. Good Bananas

**Prayer Board Advantages:**
- 85-90% complete (weeks vs. months)
- B2B revenue model (churches pay for tools)
- Validated demand
- Recurring SaaS (vs. ad-supported)

**Good Bananas Advantages:**
- Unique/novel concept
- Viral potential (inherent shareability)
- Fast to MVP (1-2 weeks from scratch)
- Portfolio diversification

---

## STRATEGIC RECOMMENDATION

### When to Prioritize Prayer Board

**NOW if:**
- ✅ You want fastest path to new recurring revenue
- ✅ You want to validate your ability to ship and monetize SaaS
- ✅ Church contacts or referrals expressing interest
- ✅ You need MRR growth without 4-6 month dev cycle

**WAIT if:**
- ❌ Elimination Diet app is more urgent (personal health need)
- ❌ Vegan Spots offers better strategic positioning
- ❌ You want to pursue higher revenue ceiling opportunities first

### Execution Timeline

**If Prioritized:**
- Week 1-3: Finish development (2-3 weeks)
- Week 4-6: Beta testing (3-4 weeks)
- Month 3: First paying customers
- Month 6: $5-10K MRR target (50-100 churches)

**Effort vs. Return:**
- **Remaining effort:** 2-3 weeks focused development
- **Return:** $60-120K annual recurring revenue
- **ROI:** High (most work already done)

---

## FINANCIAL PROJECTIONS

### Conservative Scenario (12 months)

**Customers:**
- Month 3: 5 churches (beta converts)
- Month 6: 20 churches
- Month 9: 40 churches
- Month 12: 60 churches

**Revenue:**
- Month 3: $495 MRR
- Month 6: $1,980 MRR = **$23,760 ARR**
- Month 12: $5,940 MRR = **$71,280 ARR**

**Costs:**
- Development (remaining): $0 (your time)
- Hosting: $50-100/month
- Payment processing: 3% ($1,782 annually at month 12)
- Marketing: $500-1,000/month
- **Net:** $60K+ annual profit

### Moderate Scenario (24 months)

**Customers:**
- Month 18: 150 churches
- Month 24: 250 churches

**Revenue:**
- Month 18: $14,850 MRR = **$178,200 ARR**
- Month 24: $24,750 MRR = **$297,000 ARR**

**With this MRR:**
- Can hire support (VA, customer success)
- Can invest in marketing
- Can afford feature development
- Strong exit positioning

### Optimistic Scenario (36 months)

**Customers:**
- 500-1,000 churches
- $49,500-99,000 MRR
- **$594K-1.2M ARR**

**Exit value:** $3-7M (5-7x ARR SaaS multiples)

---

## KEY LEARNINGS FROM BACKLOG

### From Your Working Genius Profile

**Strengths:**
- ✅ Wonder (visionary) - You saw the prayer board opportunity
- ✅ Discernment (pattern recognition) - You validated with pastors

**Watch Out:**
- ⚠️ Tenacity (finishing) - You're at 85-90% (classic Wonder profile)
- ⚠️ Need to push through final 10-15% to launch

**Solution:**
- Hire VA for testing and documentation
- Use systematic checklist to finish
- Set hard deadline for beta launch
- Accountability partner to ensure completion

---

## QUESTIONS TO ANSWER

### Before Final Push

1. **Market Validation:**
   - How many churches in your network could beta test?
   - What specific feedback did pastors give?
   - Any churches ready to pay on day one?

2. **Technical Decisions:**
   - What's blocking the final 10-15%?
   - Are there specific bugs or features holding you back?
   - Can you ruthlessly cut scope to get to MVP faster?

3. **Go-to-Market:**
   - Who's your ideal first customer?
   - How will you find 5 beta churches?
   - What's your pricing confidence level?

4. **Competitive:**
   - Have you researched Planning Center's prayer features?
   - What do current prayer apps NOT do well?
   - Why won't churches just use Google Forms forever?

---

**Last Updated:** 2026-01-28

**Status:** Ready for final push when prioritized. Closest to revenue of all product ideas.
