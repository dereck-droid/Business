# Vegan Spots - App Concept Documentation

**Date:** 2026-01-28
**Status:** Concept - RECOMMENDED TO BUILD FIRST
**Purpose:** Comprehensive geo-located directory of restaurants with verified vegan options, populated by AI voice agent

---

## Related Documents
- [Backlog Entry](../../backlog.md#vegan-spots-app)
- Related Apps: [Good Bananas App](./good-bananas-app.md)

---

## CORE CONCEPT

A comprehensive, geo-located directory of restaurants with verified vegan options. Unlike existing solutions, this app will be populated proactively using an AI voice agent that systematically calls restaurants to gather detailed information about their vegan offerings, creating the most complete and accurate vegan restaurant database available.

---

## THE PROBLEM BEING SOLVED

### Personal Pain Point (Primary User)

- Constantly looks up "vegan spots near me"
- Existing resources have little to no comments from actual vegans
- Information about vegan options and quality is sparse or unreliable
- Facebook groups have unorganized information that's not actionable
- No systematic, comprehensive source of verified vegan restaurant data

### Market Size

- ~6% of Americans are vegan (approximately 20 million people)
- Another 5% vegetarian who would use the app
- Concentrated in urban areas (easier to market and higher density)
- Passionate, vocal community with strong word-of-mouth potential
- Growing market - veganism has increased significantly in past decade

### Existing Solution Failures

#### HappyCow (Primary Competitor)

- Been around since 1999 (legacy platform, showing age)
- Relies entirely on user submissions (slow, incomplete data collection)
- Outdated listings (restaurants close, menus change, data goes stale)
- Charges users $3.99 for the app (significant barrier to adoption)
- Ancient UI/UX (not optimized for modern mobile users)
- Global coverage but thin - wide but not deep

#### Yelp/Google Maps

- Not vegan-specific filtering
- Unreliable vegan option identification
- Mixed reviews from non-vegans (not useful for vegans)
- No verification of what's actually vegan
- Can't filter by useful criteria (all-vegan vs. vegan-friendly)

#### Facebook Groups

- Completely disorganized information
- Hard to search and find specific info
- Not geo-searchable or map-based
- Information gets buried quickly
- No structured data or tags
- Not mobile-optimized for on-the-go use

**There is a genuine gap in the market for a modern, comprehensive, mobile-first vegan restaurant app with verified data.**

---

## UNIQUE VALUE PROPOSITION & COMPETITIVE MOAT

### The AI Voice Agent is the Killer Differentiator

This is what makes Vegan Spots genuinely different and hard to copy:

#### What It Does

1. AI agent systematically calls every restaurant in a geographic area
2. Follows a strategic script to maximize participation
3. Positions call as an opportunity: "We're building a vegan directory - would you like to be included?"
4. Conducts structured interview with manager to document vegan options
5. Asks standardized questions:
   - "Do you have vegan options on your menu?"
   - "Can you list your vegan entrees?"
   - "Are they clearly marked on the menu?"
   - "Do you have vegan appetizers/desserts/sides?"
   - "Can menu items be modified to be vegan?"
   - "Do you use separate cooking surfaces to avoid cross-contamination?"
   - "Do you have vegan cheese/milk alternatives?"
6. Logs all responses in structured database
7. Keeps log of: successful completion, needs follow-up, refused to participate, disconnected, etc.
8. Flags incomplete data for human follow-up if needed
9. Schedules quarterly re-calls to update menu changes

#### Why This is a Moat

- **Nobody else is doing this** - all competitors rely on passive user submissions
- Could populate an entire city (200+ restaurants) in DAYS instead of months/years
- Creates comprehensive data from day one of launch
- Keeps data fresh with automated quarterly updates
- Requires specific AI/automation expertise that most competitors don't have
- Plays directly to your core skillset (automation, AI agents, n8n workflows)
- Makes you 10x faster than any competitor at market entry in new cities

**You can launch in a city with COMPLETE data** instead of launching empty and hoping for user submissions.

---

## CORE FEATURE SET

### User-Facing Features

#### Map Interface

- Interactive map showing all restaurants with vegan options
- Pin colors indicate: all-vegan (green), vegan-friendly (yellow), limited options (orange)
- Cluster view when zoomed out, individual pins when zoomed in
- Current location tracking
- Distance indicators

#### Restaurant Detail Pages

- Name, address, phone, hours, website
- List of verified vegan menu items (from AI agent calls)
- User-uploaded photos of dishes
- User reviews and ratings (vegan-specific)
- Helpful tags:
  - "All Vegan" (100% vegan restaurant)
  - "Extensive Options" (5+ vegan entrees)
  - "Limited Options" (1-2 vegan items)
  - "Can Modify" (willing to modify dishes)
  - "Vegan Desserts"
  - "Vegan Alcohol" (vegan wine/beer selection)
  - "Separate Prep" (avoids cross-contamination)
  - Cuisine type: "Italian," "Mexican," "Asian," "American," etc.
- Price range indicator ($, $$, $$$, $$$$)
- Last verified date (when AI agent last called)
- Link to make reservations (OpenTable, Resy integration)

#### Search & Filter

- Search by: location, cuisine type, price range, specific tags
- Filter by: distance, rating, "all-vegan only," "open now"
- Sort by: distance, rating, recently verified, number of vegan options

#### User Contribution Features

- Upload photos of vegan dishes
- Write reviews (text + star rating)
- Add/suggest menu items not in database
- Report outdated information
- Upvote/downvote existing reviews for helpfulness

#### Social Features

- Create favorite lists
- Share restaurants with friends
- "Tried this" check-in feature
- Follow other vegan users
- Comment on reviews

#### Offline Capability

- Download city data for offline access
- Useful for travelers without data

---

## THE AI CALLING AGENT - TECHNICAL DETAILS

### Technology Stack

- **Voice AI platform:** Bland.ai, Vapi.ai, or Retell.ai (specialized in restaurant/business calls)
- **Alternative:** Build custom with OpenAI Realtime API + Twilio
- **Orchestration:** n8n workflow orchestration
- **Database:** PostgreSQL (Supabase) for logging all calls and responses
- **Tracking:** CRM-style tracking system for call status

### The Script Structure

#### Opening (Getting Past Gatekeeper)

"Hi, my name is [Agent Name] calling from Vegan Spots. We're building a comprehensive directory of restaurants with vegan options in [City Name]. We'd love to include [Restaurant Name]. May I speak with a manager about your vegan menu offerings? This will only take 2-3 minutes."

#### Manager Interview Questions

1. "Great! First, do you currently offer any vegan options on your menu?"
   - If NO: "Would you be interested in being listed anyway in case you add vegan options in the future?" (still capture basic info)
   - If YES: Continue

2. "Wonderful. Can you tell me what vegan entrees you offer?"
   - [Record each item]

3. "Are these items clearly marked as vegan on your menu?"

4. "Do you have any vegan appetizers or sides?"
   - [Record]

5. "What about vegan desserts?"
   - [Record]

6. "Can customers request modifications to make non-vegan items vegan?"
   - "For example, can they substitute dairy cheese for vegan cheese?"

7. "Do you use separate cooking surfaces or utensils to avoid cross-contamination for vegan dishes?"

8. "Do you offer any vegan milk alternatives for coffee or tea?"

9. "Is there anything else about your vegan offerings you'd like vegans to know?"

#### Closing

"Thank you so much! We'll include [Restaurant Name] in our directory with this information. Our app will help vegan diners in [City] discover your restaurant. If your menu changes, you can always update your listing on our platform at [website]. Have a great day!"

### Data Logging

- Restaurant name, address, phone (from initial database)
- Contact person name and title
- Date/time of call
- Call status: Completed, Refused, No Answer, Needs Follow-up, Wrong Number
- If completed:
  - All vegan items listed (categorized: entrees, appetizers, desserts, sides)
  - Menu modification policy
  - Cross-contamination prevention (yes/no)
  - Additional notes
- Next action: Schedule for quarterly re-verification call

### Workflow Automation (n8n)

1. Load restaurant list for city from database
2. For each restaurant:
   - Trigger AI agent call
   - Log call outcome
   - Parse and structure response
   - Update restaurant record in database
3. Flag incomplete/failed calls for human review
4. Send daily summary report: X successful, Y need follow-up, Z refused
5. Schedule quarterly re-verification for all restaurants

### Human Quality Control

- Review 10% of calls randomly for quality
- Follow up on any flagged incomplete calls personally
- Verify accuracy of AI transcription
- Call restaurants that refused to participate after 30 days

### Call Volume Capacity

- AI agents can make calls 24/7 (though limit to business hours for restaurants)
- Can handle 100+ calls per day easily
- Average call duration: 3-5 minutes
- Could completely populate a medium city (200 restaurants) in 2-3 days
- Large city (500+ restaurants) in 1 week

---

## TECHNICAL BUILD PLAN

### Week 1: MVP Core App

- Map interface with restaurant pins
- Restaurant detail pages showing:
  - Basic info (name, address, hours, phone)
  - Vegan menu items (from AI agent data)
  - Tags (all-vegan, extensive options, etc.)
- Basic search functionality
- Filter by distance, cuisine type

### Week 2: AI Voice Agent

- Build or integrate AI calling agent
- Create structured interview script
- Set up n8n workflows for:
  - Call orchestration
  - Data logging
  - Follow-up scheduling
- Test with 10-20 local restaurants
- Refine script based on results

### Week 3: Data Collection Sprint

- Load Greenville/Spartanburg restaurant database (scrape from Google Maps/Yelp)
- Run AI agent on 200+ area restaurants
- Human verification of results
- Clean and structure data
- Add to database

### Week 4: User Features & Launch

- Add photo upload capability
- User accounts and authentication
- Review/rating system
- Share features
- Polish UI/UX
- Beta launch to local vegan community

### Week 5-6: Iteration & Expansion

- Fix bugs based on user feedback
- Add requested features
- Prepare for next city expansion

### Tech Stack

- **Frontend:** React Native (cross-platform mobile) or Flutter
- **Backend:** Supabase (PostgreSQL + Auth + Storage)
- **Maps:** Google Maps API or Mapbox
- **Photos:** Cloudinary for image hosting
- **AI Voice:** Bland.ai, Vapi.ai, Retell.ai, or custom (OpenAI + Twilio)
- **Automation:** n8n for all workflows
- **Analytics:** Mixpanel or Amplitude
- **Payment processing:** Stripe (for restaurant subscriptions)

---

## GO-TO-MARKET STRATEGY

### Phase 1: Greenville/Spartanburg Launch (Month 1)

#### Pre-Launch
- AI agent calls 200+ local restaurants
- Build database with verified vegan options
- Launch with COMPLETE local data (this is the key advantage)

#### Launch Day
- Post in local vegan Facebook groups: "Finally - a complete guide to vegan dining in Greenville"
- Share in personal networks
- Local media outreach: "Local entrepreneur builds comprehensive vegan dining app"
- Instagram/TikTok content highlighting local spots

**Success Metric:** 200+ app downloads, 20+ user-contributed reviews in first month

### Phase 2: Organic Growth (Months 2-3)

- Users start adding photos and reviews
- Word of mouth in vegan community
- Engage with users, respond to feedback
- Add requested features
- Build community around the app

**Target:** 500+ active users in Greenville area

### Phase 3: Charleston Expansion (Month 4)

- Charleston is tourist destination (good test market)
- Large vegan population
- AI agent calls all Charleston restaurants
- Launch with complete data
- Partner with local vegan influencers
- Food bloggers and Instagram accounts

**Target:** 300+ Charleston users in first month

### Phase 4: Major City Expansion (Months 5-6)

- Charlotte, NC (large nearby market)
- Atlanta, GA (huge vegan scene)
- AI agent systematically calls restaurants
- Launch in each city with complete data
- Paid influencer partnerships
- Local vegan event sponsorships

**Target:** 5,000+ total users across 4 cities

### Phase 5: National Scale (Months 7-12)

Expand to top 20 US vegan cities:
- Portland, Seattle, San Francisco, Los Angeles
- New York, Boston, Philadelphia
- Austin, Denver, Minneapolis
- Chicago, Nashville, etc.

- Consider limited paid advertising targeting vegans
- Partner with national vegan organizations
- PR push: "Most comprehensive vegan restaurant app"

**Target:** 50,000+ users nationally

### Phase 6: Revenue & B2B (Months 12+)

- Begin offering restaurant claimed listings
- Sell data insights to vegan brands
- Explore acquisition opportunities

---

## REVENUE MODEL

### Consumer Side (Free to Use)

#### Free Tier

- Full access to all restaurant data
- Unlimited search and filtering
- Ability to add reviews and photos
- Supported by minimal ads (vegan brands only)

#### Premium Tier ($2.99/month or $24.99/year)

- Ad-free experience
- Offline city data downloads
- Advanced filters (dietary restrictions beyond vegan)
- Priority customer support
- Early access to new features
- "Tried This" tracking and stats

**Conservative estimate:** 2% conversion to premium
- 50,000 users × 2% = 1,000 premium
- 1,000 × $2.99/month = $2,990/month = **$35,880/year**

### Restaurant Side (B2B Revenue)

#### Free Basic Listing

- Restaurant appears in directory
- Basic info from AI agent call
- User reviews and photos appear
- Last verified date shown

#### Verified/Claimed Listing ($49/month)

- Restaurant can claim and manage their listing
- Update menu anytime
- Upload professional photos
- Respond to reviews
- Post daily specials or new menu items
- View analytics: views, clicks, reviews, traffic trends
- Badge: "Verified by Restaurant"
- Higher trust with users

#### Premium Restaurant Listing ($99/month)

- Everything in Verified tier
- Featured placement in search results within their area
- Promotional banner capability
- Push notification to nearby users when offering specials
- Priority placement in "Editor's Picks"
- Monthly report: customer insights, competitor analysis

#### All-Vegan Restaurant Package ($149/month)

- Everything in Premium tier
- Highlighted throughout app with special badge
- Featured in "100% Vegan" category
- Social media promotion from Vegan Spots
- Newsletter features

#### Revenue Projections

- **Start conservative:** 10 restaurants at $49/month = $490/month
- **Growth:** 100 restaurants at average $60/month = $6,000/month = **$72K/year**
- **Scale:** 500 restaurants at average $70/month = $35,000/month = **$420K/year**
- **All-vegan restaurants:** 50 at $149/month = $7,450/month = **$89,400/year**

### Additional B2B Revenue Streams

#### Affiliate Revenue

- Integration with OpenTable, Resy for reservations (commission per booking)
- Delivery app partnerships (DoorDash, Uber Eats) - commission on orders
- **Potential:** $5-20K/year depending on volume

#### Data Licensing

Sell aggregated trend data to:
- Vegan food brands (which cities/restaurants are growing)
- Restaurant consulting firms (vegan dining trends)
- Food industry market research

**Potential:** $10-50K/year

#### Advertising

- Vegan brands (food products, supplements, clothing, cosmetics)
- Small banner ads or sponsored content
- Keep minimal and tasteful

**Potential:** $10-30K/year

### Total Revenue Potential

#### Conservative 24-Month Projection
- Premium users: $35K
- Restaurant subscriptions: $150K
- Affiliates: $10K
- Data/Ads: $20K
- **Total: ~$215K/year**

#### Optimistic 36-Month Projection
- Premium users (3% of 100K users): $100K
- Restaurant subscriptions (1,000 restaurants): $750K
- Affiliates: $50K
- Data/Ads: $75K
- **Total: ~$975K/year**

---

## WHY VEGAN SPOTS IS THE STRONGEST APP IDEA

### Unique Advantages Over Other App Ideas

1. **You ARE the customer**
   - Personal, lived experience with the problem
   - Intimate understanding of user needs
   - Can build exactly what you wish existed
   - Best product validation possible

2. **AI Agent is Genuinely Innovative**
   - Nobody else doing systematic automated restaurant outreach
   - Creates comprehensive data from day one (competitive advantage)
   - Hard for competitors to replicate (requires specific AI/automation skills)
   - Plays directly to your unique expertise
   - Makes you 10x faster at new market entry

3. **Clear Gap in Existing Solutions**
   - HappyCow is old, slow, incomplete, charges users
   - Yelp/Google not vegan-specific
   - Facebook groups are disorganized
   - Real opportunity to be the modern solution

4. **B2B Revenue from Day One**
   - Don't have to wait for massive user scale
   - Restaurants will pay for claimed listings
   - Multiple revenue streams
   - Path to profitability faster than pure consumer apps

5. **Network Effects**
   - More users = more reviews = more valuable
   - More restaurants = more valuable to users
   - Virtuous cycle once it starts

6. **Launch with Real Data**
   - AI agent pre-populates database
   - Don't launch empty hoping for submissions
   - Immediate utility for users on day one

7. **Niche But Big Enough**
   - 20M+ vegans in US
   - Concentrated in urban areas (easier marketing)
   - Passionate community (word of mouth)
   - Growing market

8. **Clear Monetization**
   - Multiple proven revenue streams
   - Not dependent on single model
   - B2B + B2C diversification

9. **Acquisition Potential**
   - Attractive to delivery apps (DoorDash, Uber Eats)
   - Attractive to review platforms (Yelp)
   - Attractive to vegan brands
   - Exit opportunity in 3-5 years

10. **Your Unfair Advantages**
    - Personal experience as user
    - AI/automation expertise for the calling agent
    - Speed with Claude Code (ship in weeks)
    - Understanding of vegan community

---

## COMPETITIVE ANALYSIS

### HappyCow (Primary Competitor)

#### Their Strengths
- 25 years of data accumulation
- Global coverage
- Established brand in vegan community
- Large existing user base

#### Their Weaknesses
- Ancient UI/UX (not optimized for modern mobile)
- Relies only on user submissions (slow, incomplete)
- Outdated listings (no systematic verification)
- Charges users $3.99 (barrier to adoption)
- Global but thin (wide coverage, not deep)
- No restaurant engagement/management tools
- No systematic data updates

#### How You Win
- Modern, beautiful mobile-first UI
- AI-powered comprehensive data collection
- Fresh, verified data with regular updates
- Free for users
- Deep coverage in key cities (vs thin global)
- Restaurant tools for engagement
- Faster iteration and feature development

### Yelp/Google Maps

#### Their Strengths
- Massive user base
- Comprehensive restaurant coverage
- Strong SEO and brand recognition

#### Their Weaknesses
- Not vegan-specific
- Unreliable vegan filtering
- Mixed reviews from non-vegans
- Can't filter by meaningful vegan criteria

#### How You Win
- Vegan-specific focus (not general restaurant reviews)
- Verified vegan options
- Vegan-specific tags and filters
- Community of vegan reviewers
- Curated for vegan needs

### Your Unique Positioning

**"The only comprehensive, verified vegan restaurant guide with complete coverage in your city, built by vegans for vegans."**

---

## CRITICAL SUCCESS FACTORS

### Must-Haves for Success

1. **Data Quality from Launch**
   - AI agent must work flawlessly
   - Complete city coverage before launch
   - Accurate menu information

2. **User Trust**
   - Verification system must be credible
   - Restaurant data must be current
   - Reviews must be authentic (from real vegans)

3. **Beautiful UX**
   - Must be easier/better than HappyCow
   - Fast, intuitive, mobile-optimized
   - Photo-first (Instagram generation)

4. **Community Building**
   - Engage early users deeply
   - Create sense of belonging
   - Encourage contributions (photos, reviews)

5. **City-by-City Domination**
   - Better to fully own 5 cities than be thin in 50
   - Launch in each city with complete data
   - Build local vegan influencer partnerships

6. **Restaurant Relationships**
   - Make restaurants WANT to be listed
   - Frame as opportunity, not obligation
   - Provide real value (free marketing, customer insights)

---

## RISKS & MITIGATION STRATEGIES

### Risk 1: AI Agent Doesn't Work Well
**Mitigation:** Test extensively before launch; have human backup; iterate script based on results; use proven AI calling platforms

### Risk 2: Restaurants Refuse to Participate
**Mitigation:** Frame as opportunity ("free marketing"); keep calls brief and professional; follow up gently; accept some non-participation

### Risk 3: HappyCow Copies Your Approach
**Mitigation:** Move fast; build brand loyalty; focus on superior UX; deepen restaurant relationships; your automation expertise is hard to copy

### Risk 4: Can't Get to Critical Mass in Cities
**Mitigation:** AI agent solves this - you launch WITH complete data; don't rely on user submissions for initial data

### Risk 5: Restaurant Data Goes Stale
**Mitigation:** Quarterly automated re-verification calls; user reporting of outdated info; incentivize restaurants to update their own listings

### Risk 6: Not Enough Users to Attract Paying Restaurants
**Mitigation:** Start with data licensing revenue; offer restaurants free trials; show value through analytics; focus on all-vegan restaurants first (most motivated)

### Risk 7: Vegan Market Too Small
**Mitigation:** Target 6% vegan + 5% vegetarian = 11% potential market; focus on high-density urban areas; could expand to vegetarian if needed

---

## THE 3-WEEK TEST

### Week 1
- Build basic MVP (map + restaurant listings + detail pages)
- Build AI calling agent
- Test agent on 20 restaurants

### Week 2
- Refine agent based on test results
- Call 100+ Greenville restaurants
- Build out complete local database
- Add photo upload and review features

### Week 3
- Polish UI/UX
- Beta launch to 20-50 local vegans
- Gather feedback
- Iterate

**Success = 200+ users in Greenville in first month with 50+ reviews posted**

If this happens, you have proof of concept and can:
- Expand to Charleston
- Raise small angel round ($50-100K)
- Find growth partner
- Continue bootstrapping

---

## COMPARED TO GOOD BANANAS

### Why Vegan Spots is Stronger

1. **Clearer path to revenue** - B2B from day one vs waiting for scale
2. **You're the customer** - deep personal understanding vs hypothetical users
3. **AI agent moat** - genuinely hard to replicate vs easier to copy
4. **Higher engagement frequency** - vegans eat out regularly vs occasional banana shopping
5. **Bigger ticket B2B** - restaurants pay more than grocery stores likely would
6. **Better existing competitors to beat** - HappyCow is beatable vs Yelp/Google are not
7. **Less seasonal** - consistent year-round vs banana quality varies seasonally

Good Bananas is still a viable concept, but Vegan Spots has:
- More certain product-market fit (solving your own pain)
- Clearer monetization
- Your unique technical advantage (AI calling agent)
- Better competitive positioning

---

## NEXT STEPS FOR FINDING A GROWTH PARTNER

### What You Need

- Someone to handle organic marketing (content, social, SEO, community)
- Build initial user base without paid spend
- Scale with paid ads once revenue proves PMF
- Focus on distribution while you build

### Where to Find

- GrowthHackers.com community
- Demand Curve Slack
- CoFoundersLab (filter for marketing co-founders)
- FounderDating / Founders Network
- Reddit r/cofounder
- LinkedIn: "Growth Marketing" + "looking for opportunities"
- Failed startup founders (have skills, need product)
- Agency refugees (tired of client work)

### Partnership Structure Options

#### Option A: App-by-App
- Each app is separate LLC
- 50/50 split per app
- Focus on one at a time
- Proven model before next one

#### Option B: Portfolio Company
- One LLC owns all apps
- 60/40 or 50/50 split
- They handle all growth across portfolio
- You build all products

#### Option C: Revenue Share First, Then Equity
- Start with 50/50 revenue split
- If hits $5K/month, formalize equity
- Lower commitment to test chemistry

### The Offer to Partners

- Apps already built (most co-founder situations = waiting for dev)
- Multiple shots on goal (portfolio)
- Builder who ships fast (you + Claude Code)
- Clear role separation (growth/marketing vs building)

### Trial Before Equity

**Don't give equity immediately. Test first:**
1. Pick one app (Vegan Spots recommended)
2. You build MVP in 1-2 weeks
3. Give them 30 days to get to 100 users organically
4. Pay $2K for the trial (de-risks both sides)
5. If it works, formalize equity partnership

### Red Flags to Avoid in Partners

**Don't partner with:**
- "Idea people" with no growth track record
- People who want to "strategize" not execute
- Anyone without proof of growing something before
- People wanting majority equity for "sweat equity"

**Do partner with:**
- Someone who's hit 10K+ users on something
- Real examples of organic growth campaigns
- Understands paid ads (FB, Google, TikTok)
- Gets excited about YOUR ideas (not pushing their own)

---

## RECOMMENDATION: BUILD THIS FIRST

### Reasons

1. You'll use it yourself immediately (instant validation)
2. AI agent gives you unfair advantage
3. B2B revenue potential from month 1
4. Your automation expertise is the moat
5. Clearer path to $100K+ annual revenue
6. Better acquisition potential

### Then Consider Good Bananas As

- Second app in portfolio
- Learning from Vegan Spots launch
- Proof you can build and scale apps
- Potential portfolio company

### Timeline to Test

- **Week 1-2:** Build MVP
- **Week 3-4:** Launch locally, get first 100 users
- **Week 5-8:** Iterate, add features, expand
- **Month 3:** Decide to scale, pivot, or move to next app

### Success Metrics

- **Month 1:** 100-200 active users
- **Month 3:** 500-1000 users
- **Month 6:** 5,000 users OR first B2B customer OR acquisition discussions

---

**Last Updated:** 2026-01-28
