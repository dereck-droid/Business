# Vegan Spots - App Concept Documentation

**Date:** 2026-01-28
**Last Updated:** 2026-01-28 (Major strategy update with GoHighLevel implementation details)
**Status:** Concept - RECOMMENDED TO BUILD FIRST (after Prayer Board completion)
**Purpose:** Comprehensive geo-located directory of restaurants with verified vegan options, populated by AI voice agent

---

## Related Documents
- [Backlog Entry](../../backlog.md#vegan-spots-app)
- Related Apps: [Good Bananas App](./good-bananas-app.md), [Elimination Diet App](./elimination-diet-app.md)

---

## 🎯 EXECUTIVE SUMMARY - KEY STRATEGIC DECISIONS

### What Changed (2026-01-28 Update)

This document was significantly enhanced with detailed implementation strategy including:

1. **GoHighLevel as Primary Platform** (vs. Bland.ai/Vapi)
   - More cost-effective: $0.018/min vs $0.12-0.15/min
   - Native integration with existing tech stack
   - Constraint: 100 calls/day per location (impacts timeline)
   - **Total cost for 3 cities (3,000 restaurants): $292**

2. **Two-Tier Data Collection Strategy**
   - **Tier 1 (1-5 vegan items):** Quick phone-only data collection, free basic listing
   - **Tier 2 (6+ vegan items):** Phone call + sales pitch + form submission, paid claimed listing
   - AI agent acts as both data collector AND salesperson

3. **The "Group Dining Insight" as Core Sales Pitch**
   - Revolutionary framing: "When one person is vegan, the ENTIRE group of 6-8 people chooses based on them"
   - Transforms from "vegan niche app" to "we send you group bookings"
   - Makes B2B subscription an obvious yes for restaurants

4. **Progressive Launch Strategy (CRITICAL)**
   - Launch Portland Week 3-4 (don't wait for all 3 cities)
   - Validate with real users before building Austin/SF
   - Revenue starts Week 4 instead of Week 6
   - Same cost, faster validation, lower risk

5. **Cross-Contamination Safety as Feature**
   - Not just compliance - it's competitive advantage
   - Enables "Group Dining" feature (accommodates allergies)
   - Builds trust with users
   - Positions app as comprehensive, not just vegan

6. **Complete Data Structure Defined**
   - Essential fields (phone collection)
   - Enhanced fields (form submission)
   - Safety disclaimers
   - Internal tracking
   - Restaurant tier system (Free/Claimed/Featured)

### Timeline & Economics

| Milestone | Timeline | Cost | Expected Outcome |
|-----------|----------|------|------------------|
| Build infrastructure | Week 1 | $0 | AI calling system ready |
| Portland database built | Weeks 2-3 | $81 | 550+ restaurants with vegan data |
| Soft launch Portland | Week 3-4 | $0 | 50-100 early users, 5-10 paying restaurants |
| Austin database built | Weeks 4-5 | $81 | Second city validated |
| Third city + full launch | Week 6+ | $81 | 3 cities, 500-1,000 users, $1.5-2.5K MRR |
| **TOTAL** | **6 weeks** | **$292** | **Validated SaaS product with revenue** |

### Why This Is Still #1 Priority (After Prayer Board)

1. ✅ **You ARE the customer** - personal pain point you experience daily
2. ✅ **AI agent moat** - genuinely hard to replicate, plays to your strengths
3. ✅ **B2B revenue from Week 4** - don't need massive user scale first
4. ✅ **Fast to validate** - 6 weeks vs 4-6 months (Elimination Diet)
5. ✅ **Group Dining feature** - markets itself, unique competitive advantage
6. ✅ **Proven market** - HappyCow exists but is beatable
7. ✅ **$292 total cost** - incredibly capital efficient validation
8. ✅ **Progressive launch** - revenue while building, not after

### Critical Success Factor: The Sales Script

The AI agent script is designed to:
- Lead with helpfulness ("help us represent YOU accurately")
- Collect comprehensive safety data (shared fryers, cross-contamination)
- Identify high-value prospects (6+ vegan items)
- Deliver "group dining insight" (transforms entire value prop)
- Soft-sell form submission (no pressure, plant seed)
- Maintain good relationship even if they decline

**This script is the business.** It determines:
- Data quality (completeness of menu items, safety info)
- Conversion rate (basic listing → claimed listing)
- Restaurant relationships (hostile vs partnership)

### Next Steps After This Documentation

1. ✅ **Complete Prayer Board** (2-3 weeks) - Prove you can ship SaaS
2. ✅ **Week 1: Build AI infrastructure** - GoHighLevel + n8n + Supabase
3. ✅ **Weeks 2-3: Let AI call Portland** while you build consumer app
4. ✅ **Week 4: Soft launch Portland** - First revenue, first validation
5. ✅ **Weeks 5-6: Expand to Austin + third city** - Prove scalability

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

### Technology Stack (UPDATED: GoHighLevel Implementation)

- **Primary Platform:** GoHighLevel Voice AI (native integration, cost-effective)
- **Voice Provider:** Twilio (via GoHighLevel LC Phone)
- **Orchestration:** GoHighLevel workflows + n8n for complex logic
- **Database:** PostgreSQL (Supabase) for logging all calls and responses
- **Tracking:** CRM-style tracking system for call status
- **Alternative (if speed needed):** Bland.ai or Vapi.ai (no daily limits, faster but 2X cost)

### GoHighLevel Constraints & Economics

**Daily Call Limits:**
- **100 calls per day maximum** per location/sub-account
- **1 call per minute** rate limit
- Only calls between 10 AM - 6 PM (contact's timezone)
- Each phone number can only be called **1x per day**, max **4x over 2 weeks**
- Must operate from inside a workflow
- Requires registration/approval before use

**Cost Breakdown:**
- Outbound call: $0.014/minute
- AI infrastructure (SIP): $0.004/minute
- **Total per minute: $0.018** (without transcription)
- With transcription: $0.042/min (adds $0.024) - **NOT RECOMMENDED**
- Phone number: $49/month per location
- GoHighLevel account: $97+ (Starter plan for single location)

**Economics for 3 Major Cities (3,000 Restaurants):**
- Average 4.5 minutes per restaurant (including retries)
- Total call time: ~13,500 minutes
- **Total calling cost: $243** (without transcription)
- Phone number: $49/month
- **Total investment: ~$292 for complete database**

**Timeline with Constraints:**
- Single location: 100 calls/day = 10 days per 1,000 restaurants
- 3 cities = 30 days of calling
- **Alternative:** 3 sub-accounts (3x parallel) = 10 days total (but $687 cost)

**Recommendation:** Single location, progressive city launches (launch with Portland after 10 days, don't wait 30 days for all 3)

### Two-Tier Data Collection Strategy

The AI agent uses different approaches based on restaurant vegan offerings:

#### **Tier 1: Phone-Only Quick Data Collection**

**For:** Restaurants with 1-5 vegan options, not vegan-focused

**What AI Collects Over Phone (3-5 minute call):**
- Restaurant name, address, phone, hours
- Number of vegan options by category (appetizers, entrees, sides, desserts)
- Brief description of each dish
- Price range ($, $$, $$$, $$$$)
- **Critical Safety Disclaimers:**
  - Shared fryer with animal products? (Y/N)
  - Shared grill/cooking surfaces? (Y/N)
  - Can accommodate modifications? (Y/N)
  - Dedicated vegan prep area? (Y/N)
  - Cross-contamination risk level: Low/Medium/High
- Allergen accommodations (gluten-free, nut-free, soy-free)

**Database Status:** "Basic Listing" (free tier)
**Follow-up:** None initially, quarterly re-verification

#### **Tier 2: Phone + Form Submission**

**For:** All-vegan restaurants OR 6+ vegan options

**AI Agent Process:**
1. Collects basic info over phone (name, address, contact, hours)
2. Begins asking about vegan options
3. **Identifies high-value prospect:** "Wow, it sounds like you have quite a few vegan options!"
4. **Transitions to sales pitch** (see script below)
5. **Sends form link via SMS immediately** after call ends
6. Schedules follow-up if form not submitted within 48 hours

**Form Submission Includes:**
- Full menu upload (PDF/photo)
- Detailed dish descriptions with ingredients
- Professional food photos (encouraged)
- Allergen information matrix
- Special dietary accommodations
- Preparation methods
- Online ordering/reservation links
- Social media handles

**Database Status:** "Premium Prospect" → "Claimed Listing" (paid tier)

### The Complete Sales Conversation Flow

This script collects data AND plants seeds for paid subscriptions:

#### **Opening (Non-Salesy, Helpful Framing)**

```
"Hi! This is Alex calling from Vegan Spots. We're building a comprehensive
directory to help people following a vegan diet find restaurants with
great options in [CITY]. We're calling restaurants across the city to
document what vegan options you currently offer.

Do you have a couple minutes to help us make sure your restaurant is
accurately represented?"
```

**Why This Works:**
- Positions as helpful, not pushy
- "Help us represent YOU accurately" = doing THEM a favor
- Establishes authority ("comprehensive directory")
- Low commitment ask (2 minutes)
- No mention of selling anything

#### **Data Collection Phase (All Restaurants)**

```
[If they say yes]

"Perfect! Let me ask you a few quick questions:

1. What vegan entrees do you currently offer?"
   [AI records each item]

2. "And what about vegan appetizers or sides?"
   [AI records]

3. "Do you have any vegan desserts?"
   [AI records]

4. "Can customers request modifications to make dishes vegan?
   For example, substitute vegan cheese?"
   [AI records: Yes/No/Limited]

5. "This is important for our users with allergies - do you use a
   shared fryer for vegan items and meat or seafood?"
   [AI records: Yes/No]

6. "Do you have a dedicated vegan prep area or use separate cooking surfaces?"
   [AI records: Yes/No/Sometimes]
```

#### **The Transition (When 6+ Options Identified)**

**AI Decision Point:** If restaurant mentions 6+ vegan items, trigger sales flow:

```
"Wow, it sounds like you have quite a few vegan options! That's fantastic.

You know, a lot of restaurants in [CITY] don't realize how much business
they're missing from group dining situations.

When a group of friends or family goes out to eat and even ONE person is
vegan, that ENTIRE group chooses the restaurant based on that person's needs.

If you're not showing up when they search 'vegan options near me,' they're
taking that whole group of 6-8 people somewhere else. You lose the entire
table, not just one customer.

Our app is launching in [CITY] next month, and we're giving restaurants
the opportunity to claim and enhance their listing with photos, full
menu details, and priority placement in search results.

Would you like me to text you a link where you can upload your menu and
see what a claimed listing looks like? There's no obligation - you can
explore it and decide if it makes sense for your restaurant."
```

**Why This Works:**
- Compliment first ("quite a few options!")
- **Group Dining Insight** = perspective they haven't considered
- Loss framing ("they're taking that whole group somewhere else")
- Quantifies loss ("6-8 people, entire table")
- Soft ask ("would you like me to TEXT you") - not "buy now"
- "No obligation" = low pressure
- "See what it looks like" = curiosity, not commitment

#### **If They Say Yes to Form Link**

```
"Perfect! I'm texting you the link right now to [PHONE NUMBER].

The form takes about 5 minutes to complete - you can upload your menu,
add some photos of your dishes, and see exactly how your listing will
appear to users searching for vegan options.

Just to be transparent: there's no charge to be listed in our basic
directory. You'll show up in searches regardless. But claimed listings
with enhanced details - photos, full menus, ability to update anytime -
those get priority placement when users are browsing.

The subscription for a claimed listing is $99 per month for vegan-friendly
restaurants, but you can explore everything first and decide if the
additional visibility makes sense for your business.

Is this the best number to reach you at if we have any follow-up questions?"

[Confirm contact info]

"Great! You should receive that text within the next minute. Thanks so
much for your time, and we're excited to help vegan diners discover
your restaurant!"
```

**Key Elements:**
- Immediate SMS (strike while iron is hot)
- Time expectation (5 minutes = doable)
- Transparency about costs builds trust
- "You'll show up regardless" = good faith
- "Decide if it makes sense" = low pressure
- Confirms contact for follow-up
- Ends enthusiastically

#### **If They Say "Not Interested Right Now"**

```
"No problem at all! We'll make sure your vegan options are listed
accurately in our directory regardless. You'll show up when people
search for vegan-friendly restaurants in [CITY], and we'll include
the menu items you mentioned.

If you ever want to enhance your listing with photos or priority
placement down the road, you can visit VeganSpots.com and claim
your restaurant listing anytime. It takes about 5 minutes.

Thanks so much for your time today - we really appreciate you helping
us build an accurate resource for the vegan community!"
```

**Why This Works:**
- Reassures they're still included (builds trust)
- Reinforces they'll get free value
- Plants seed for future ("claim anytime")
- Leaves door wide open
- Ends on genuinely positive note
- They'll remember you when they see traffic from the app

#### **If No Answer / Voicemail**

```
"Hi, this is Alex calling from Vegan Spots. We're building a directory
of restaurants with vegan options in [CITY], and we'd love to include
[RESTAURANT NAME]. I'll try you again another time. Thanks!"
```

**AI Workflow Action:**
- Mark: "No answer - Attempt 1"
- Schedule retry: Next day, different time (2-4 PM vs 10-11 AM)
- Max 3 attempts over 1 week
- After 3 failed attempts: Mark "Unable to reach" and move on

### Complete Data Structure

#### **Essential Fields (Collected via Phone or Form)**

**Basic Restaurant Info:**
- Restaurant name
- Full address (street, city, state, zip)
- Phone number
- Website URL
- Hours of operation (by day)
- Cuisine type (Italian, Mexican, Asian, American, etc.)
- Price range ($, $$, $$$, $$$$)

**Vegan Menu Data:**
- Vegan appetizers (array of items with descriptions)
- Vegan entrees (array of items with descriptions)
- Vegan sides (array of items with descriptions)
- Vegan desserts (array of items with descriptions)
- Vegan beverages/coffee options
- Modification options (can substitute vegan cheese, milk, etc.)

**Critical Safety/Allergen Information:**
- Shared fryer with animal products: Yes/No
- Shared grill/cooking surfaces: Yes/No
- Dedicated vegan prep area: Yes/No
- Cross-contamination risk level: Low/Medium/High
- Gluten-free options available: Yes/No
- Nut-free options available: Yes/No
- Soy-free options available: Yes/No

**Metadata:**
- Data source: AI Phone Call / Form Submission / Restaurant Dashboard
- Last verified date
- Last updated date
- Verification method
- Contact person name/title (if provided)

#### **Enhanced Fields (Form Submission / Claimed Listings Only)**

- Full menu PDF/image upload
- Individual dish photos (up to 10)
- Detailed dish descriptions with ingredients
- Chef's notes on preparation methods
- Online ordering link (DoorDash, Uber Eats, etc.)
- Reservation link (OpenTable, Resy, etc.)
- Social media handles (Instagram, Facebook)
- Special notes for vegans
- Parking information
- Accessibility information

#### **Internal Tracking Fields**

- Call status: Completed / No Answer / Needs Follow-up / Refused / Wrong Number / Disconnected
- Attempts made (1-3)
- Last call attempt date
- Next scheduled call date (quarterly re-verification)
- Sales status: Basic / Premium Prospect / Claimed / Featured / Churned / Not Interested
- Form sent: Yes/No
- Form submitted: Yes/No
- Follow-up needed: Yes/No
- Internal notes from calls
- Payment status (for claimed listings)
- Subscription tier
- Monthly recurring revenue (MRR) value

## RESTAURANT TIER SYSTEM & MONETIZATION

### Three-Tier Restaurant Listing Model

#### **Tier 1: Basic Listing (FREE)**

**What's Included:**
- Restaurant appears in all searches and map view
- Basic information from AI phone call:
  - Name, address, phone, hours
  - Vegan menu items documented by AI
  - Price range
  - Cross-contamination warnings
  - Allergen information
- User-generated content appears on listing:
  - User reviews and ratings
  - User-uploaded photos
  - Community comments
- "Last verified" date badge
- Standard search result placement

**Restaurant Requirements:** None - automatically included after AI call

**Value to Restaurant:** Free exposure to vegan diners, builds awareness

#### **Tier 2: Claimed Listing ($49/month - Vegan-Friendly | $99/month - All-Vegan)**

**Everything in Basic, PLUS:**
- ✅ Restaurant can claim and manage their own listing
- ✅ Update menu items anytime (no waiting for AI re-verification)
- ✅ Upload professional food photos (up to 10 images)
- ✅ Respond to customer reviews
- ✅ Post daily specials and seasonal menu changes
- ✅ Add detailed dish descriptions with ingredients
- ✅ "Verified by Restaurant" trust badge
- ✅ Analytics dashboard:
  - Monthly listing views
  - Click-through rate to website/phone
  - Number of reviews received
  - Search appearances
  - Traffic trends over time
- ✅ Priority placement in search results (top 30%)
- ✅ Customer insights report

**Restaurant Requirements:**
- Submit form with menu details
- Upload at least 3 professional photos
- Maintain current information

**Value to Restaurant:** Control narrative, professional presentation, analytics, more visibility

#### **Tier 3: Featured Listing ($149/month)**

**Everything in Claimed, PLUS:**
- 🌟 Featured placement at top of search results in their area
- 🌟 Highlighted throughout app with special badge
- 🌟 Promotional banner capability on listing page
- 🌟 Push notification capability to nearby users (limited to 1/month)
- 🌟 Inclusion in "Editor's Picks" and curated collections
- 🌟 Social media promotion from Vegan Spots official accounts
- 🌟 Monthly newsletter feature
- 🌟 Advanced analytics:
  - Competitor benchmarking
  - Customer demographics (if users opt-in)
  - Peak traffic times
  - Most popular menu items (based on user saves/shares)
- 🌟 Priority customer support

**Restaurant Requirements:**
- Must be claimed listing first
- Maintain high review ratings (4+ stars)
- Active engagement (respond to reviews within 7 days)
- Regular menu updates

**Value to Restaurant:** Maximum visibility, promotional reach, competitive advantage

### The "Group Dining Feature" - KILLER USER FEATURE

**The Problem:**
When groups go out to eat, ONE person's dietary restriction determines where EVERYONE goes.

**The Solution:**
```
"Planning Group Dinner?" feature in app:

User Input:
- Number of people: 6
- Dietary needs:
  - 2 vegans
  - 1 gluten-free
  - 1 nut allergy
  - 3 no restrictions

App Output:
- Shows ONLY restaurants that can accommodate ALL needs
- Highlights specific menu items for each person
- Ranks by "group satisfaction score"
- Shows: "This restaurant has 12 vegan options, 8 gluten-free options,
  and confirmed nut-free preparation available"
```

**Why This Is Brilliant:**
- ✅ **Solves real pain point** - no more "where can we all eat?" debates
- ✅ **Markets itself** - groups will share this feature organically
- ✅ **Drives restaurant value** - proves they're getting group bookings, not just solo vegans
- ✅ **Justifies B2B pricing** - "You're not paying for vegan app - you're paying for group tables"
- ✅ **Unique to Vegan Spots** - no competitor has this
- ✅ **Leverages safety data** - cross-contamination info becomes competitive advantage

**Implementation:**
- v1: Simple multi-filter (vegan + GF + nut-free)
- v2: Smart scoring algorithm (ranks by best fit)
- v3: Group sharing (send restaurant suggestions to whole group for voting)

This feature transforms the pitch to restaurants:
> "You're not just getting one vegan customer - you're getting the table of 8 people
> that comes WITH that vegan. Our Group Dining feature sends you entire parties,
> not individuals."

## LEGAL DISCLAIMERS & RISK MITIGATION

### User-Facing Disclaimers

**App-Wide Disclaimer (Settings/About):**
```
All restaurant information is verified through direct contact with restaurants
and user contributions. While we strive for accuracy, menu items and preparation
methods can change without notice.

For severe food allergies or medical dietary restrictions, ALWAYS confirm
ingredients and preparation methods directly with restaurant staff before ordering.

Vegan Spots is not liable for adverse reactions, cross-contamination, or menu
inaccuracies. Use this app as a guide, not medical advice.
```

**On Restaurant Listings with Cross-Contamination Warnings:**
```
⚠️ SHARED EQUIPMENT NOTICE
This restaurant uses shared fryers/grills for vegan and animal products.
Cross-contamination is possible. If you have severe allergies, please
speak with management before ordering.
```

**On All Menu Item Listings:**
```
Menu items and ingredients subject to change. Last verified: [DATE]
Always confirm with restaurant for current offerings and preparation methods.
```

**Group Dining Feature Disclaimer:**
```
Group Dining recommendations are based on documented menu options and
allergen information. For severe allergies, always verify with restaurant
directly. Vegan Spots does not guarantee complete safety for severe
allergen concerns.
```

### Restaurant Agreement (Terms for Claimed Listings)

**Key Terms:**
- Restaurant certifies information accuracy to best of knowledge
- Restaurant agrees to update listings within 7 days of menu changes
- Vegan Spots not liable for user dietary reactions
- Restaurant maintains right to refuse service as per standard business practice
- Cancellation: 30-day notice, no refunds for partial months
- Data usage: Vegan Spots may use aggregated data (non-identifiable) for trends/analytics

### Risk Mitigation Strategies

1. **Always show "Last Verified" dates** - user can see freshness
2. **Quarterly AI re-verification calls** - keep data current
3. **User reporting system** - "Is this info still accurate?" button
4. **Conservative cross-contamination warnings** - err on side of caution
5. **Never claim "allergen-free"** - only document "options available"
6. **Encourage user confirmation** - always remind to double-check with restaurant
7. **Restaurant liability** - terms make clear restaurants are responsible for accuracy

## WORKFLOW AUTOMATION (GoHighLevel + n8n)

### GoHighLevel Calling Workflow

**Daily Automated Process:**

1. **Morning (9 AM):** n8n triggers GoHighLevel workflow
   - Loads next 100 uncalled restaurants from database
   - Filters out any called in last 24 hours (prevent duplicates)
   - Queues 100 calls for the day

2. **Calling Window (10 AM - 6 PM):**
   - GoHighLevel AI agent makes 100 calls (1 per minute)
   - For each call:
     - Attempts connection
     - Executes appropriate script (data collection or data + sales)
     - Logs outcome in GoHighLevel
     - If 6+ vegan items mentioned → Sends SMS with form link
     - Updates call status

3. **Real-Time n8n Processing:**
   - Monitors GoHighLevel for completed calls
   - Parses AI transcription/structured data
   - Updates Supabase database with:
     - Restaurant vegan menu items
     - Safety/allergen info
     - Call outcome status
     - Sales tier (Basic vs Premium Prospect)
   - If form sent → Creates follow-up task for 48 hours later

4. **Evening (8 PM):** Daily summary report
   - Email to owner with stats:
     - Calls completed: X
     - Restaurants with vegan options: Y
     - Premium prospects identified: Z
     - Forms sent: A
     - Forms submitted: B
     - Need follow-up: C
     - Failed attempts: D

5. **Weekly (Sundays):**
   - Retry all "No Answer" restaurants (different time/day)
   - Follow up on premium prospects who haven't submitted forms
   - Generate weekly analytics report

6. **Quarterly (Automated):**
   - Re-verification calls to all restaurants
   - Update menu changes
   - Check if still in business
   - Refresh data freshness dates

### n8n Workflow Automation Tasks

**Beyond GoHighLevel Integration:**

1. **Form Submission Processing:**
   - Restaurant submits form → n8n receives webhook
   - Uploads menu PDF to Cloudinary
   - Processes and optimizes photos
   - Updates database with enhanced data
   - Changes status: Premium Prospect → Claimed Listing Candidate
   - Sends email to owner: "New restaurant form submitted - review needed"

2. **Follow-Up Sequences:**
   - Day 2 after form sent, not submitted: SMS reminder
   - Day 7: AI agent calls back with gentle follow-up
   - Day 30: Email with social proof ("Restaurants seeing X% more traffic")

3. **User Report Handling:**
   - User reports "outdated info" → Creates task for human review
   - If 3+ users report same issue → Triggers immediate AI re-verification call

4. **Restaurant Dashboard Activity:**
   - Claimed restaurant updates menu → Logs change, updates "Last Updated" date
   - Claimed restaurant responds to review → Notifies user who left review
   - Claimed restaurant views analytics → Logs engagement for health score

5. **Payment Processing:**
   - Stripe webhook on successful payment → Updates subscription status
   - Stripe webhook on failed payment → Triggers dunning sequence
   - Subscription cancelled → Downgrades to Basic after 30 days

6. **Data Quality Monitoring:**
   - Flags restaurants with no menu items (data collection error)
   - Flags duplicate restaurant entries (merge needed)
   - Flags restaurants not verified in 6+ months (priority re-call)

### Human Quality Control Checkpoints

**Not Everything Can Be Automated:**

1. **Manual Review Required:**
   - Premium prospect form submissions (review before activating claimed listing)
   - Restaurants claiming they're "all-vegan" (verify legitimacy)
   - User reports of serious safety issues (immediate attention)
   - Negative review disputes from restaurants

2. **Weekly Manual Tasks:**
   - Review 10 random call transcripts for AI quality
   - Personally call 3-5 "premium prospects" who didn't convert (get feedback)
   - Check user reviews for spam/abuse
   - Respond to restaurant questions about claiming

3. **Monthly Manual Tasks:**
   - Analyze conversion rates (calls → premium prospects → claimed listings)
   - Refine AI script based on successful vs unsuccessful calls
   - Update sales pitch based on restaurant feedback
   - Review and improve group dining feature based on usage data

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

## UPDATED TECHNICAL BUILD PLAN (Based on GoHighLevel Constraints)

### **Week 1: Build Calling Infrastructure + Start App Development**

**AI Calling System (Priority):**
- Set up GoHighLevel account and Voice AI
- Register for outbound calling (compliance approval)
- Acquire phone number ($49/month)
- Build AI agent with two-tier script:
  - Basic data collection flow (1-5 vegan items)
  - Data collection + sales pitch flow (6+ items)
- Create form submission page for premium prospects
- Set up n8n workflows:
  - Daily calling queue (100 restaurants/day)
  - Call outcome logging to Supabase
  - SMS form link sender
  - Follow-up scheduler
- Test with 10-20 test calls (local businesses or personal contacts)
- Refine scripts based on test results

**App Development (Parallel):**
- Set up React Native / Flutter project
- Design database schema in Supabase
- Create basic map interface (Google Maps / Mapbox)
- Design restaurant detail page UI

**Data Prep:**
- Scrape Portland restaurant list from Google Maps/Yelp (~1,000 restaurants)
- Clean and structure data (name, address, phone, cuisine type)
- Load into database with status: "Not Called"

**End of Week 1:**
- ✅ AI calling system ready to run
- ✅ App foundation built
- ✅ Portland restaurant database loaded
- ✅ Ready to start automated calling on Day 8

### **Weeks 2-3: Calling Sprint (Portland) + Continue App Build**

**Automated Calling (Runs Daily):**
- Day 8-17: AI makes 100 calls/day to Portland restaurants
- Total: 1,000 calls over 10 days
- Expected outcomes:
  - ~550 successful data collections (55% answer rate)
  - ~100-150 premium prospects identified (6+ vegan options)
  - ~50-75 form links sent
  - ~450 no answers (will retry Week 3-4)

**App Development (Parallel):**
- Build restaurant detail pages with all data fields
- Implement search and filter functionality
- Add map clustering and individual pins
- Build user authentication system
- Create photo upload capability
- Design and build review/rating system
- Implement cross-contamination warning displays
- Build "Last Verified" date badges
- Mobile responsiveness testing

**Daily Monitoring:**
- Review daily call summary reports
- Spot-check 5-10 call transcripts for quality
- Manually follow up with any flagged issues

**End of Week 3:**
- ✅ 550+ Portland restaurants with basic vegan data
- ✅ 100-150 premium prospects identified
- ✅ App 80% complete (core features working)
- ✅ Ready for soft launch

### **Week 4: Soft Launch Portland + Start Austin Calls**

**Launch Preparation:**
- Polish UI/UX based on internal testing
- Add legal disclaimers to app
- Create simple landing page explaining the app
- Write launch announcement for Portland vegan groups

**Soft Launch (Day 22-25):**
- Beta launch to Portland vegan Facebook groups
- Post in Portland vegan subreddit
- Share with 10-20 local vegan friends for feedback
- Target: 50-100 early adopter downloads

**Begin B2B Outreach:**
- Manually call top 20 premium prospects (all-vegan restaurants first)
- Pitch claimed listing subscriptions
- Offer "founding restaurant" discount (first 10 at $79/month instead of $99)
- Goal: 5-10 claimed listings by end of week

**Austin Calling Begins:**
- Load Austin restaurant database (~1,000 restaurants)
- Day 22-31: AI calls 100/day in Austin
- Same process as Portland

**User Feedback Loop:**
- Monitor user behavior in app
- Collect feedback from early users
- Fix critical bugs
- Make UI improvements

**End of Week 4:**
- ✅ Portland soft launched with 50-100 users
- ✅ 5-10 Portland restaurants signed up (claimed listings)
- ✅ Austin calling in progress (50% complete)
- ✅ App improved based on real user feedback

### **Week 5: Complete Austin + Build v2 Features**

**Austin Database Completion:**
- Days 1-3: Complete remaining Austin calls
- By Day 3: Austin database 80-90% complete
- Add Austin to live app on Day 4

**App v2 Features:**
- Build restaurant dashboard (for claimed listings):
  - Menu update interface
  - Photo upload
  - Review response capability
  - Basic analytics display
- Implement priority search placement for claimed listings
- Add "Verified by Restaurant" badges
- Build form submission processing workflow

**Portland Growth:**
- Continue organic growth in Portland
- Monitor restaurant subscription renewals
- Collect testimonials from early claimed restaurants
- Target: 100-200 total Portland users

**B2B Austin Outreach:**
- Begin outreach to Austin premium prospects
- Use Portland success stories as social proof

**End of Week 5:**
- ✅ Two cities live: Portland + Austin
- ✅ 150-250 total users
- ✅ 10-15 claimed restaurant subscriptions
- ✅ Restaurant dashboard functional
- ✅ Proven model working in two markets

### **Week 6: Third City (SF/Denver/NYC) + Full Launch**

**Third City Selection:**
Based on vegan population density, choose one:
- San Francisco (huge vegan scene, high concentration)
- Denver (growing vegan market, less competition)
- NYC (massive market, high complexity)

**Third City Calling:**
- Load third city database (1,000 restaurants)
- Begin calling (100/day)
- Will complete in Week 7-8

**Full Launch Marketing:**
- Press release: "New app maps vegan dining with AI-verified data"
- Reach out to vegan influencers in Portland/Austin
- Post in national vegan Facebook groups
- Submit to Product Hunt
- Post on Reddit r/vegan with success story
- Create TikTok/Instagram content highlighting app features

**Scale B2B:**
- Hire VA to help with restaurant outreach ($500/month)
- Create restaurant outreach email sequences
- Build case study from Portland success
- Target: 20-30 total claimed listings across all cities

**End of Week 6:**
- ✅ Three cities launched (one partially complete)
- ✅ 500-1,000 total users
- ✅ 20-30 claimed restaurant subscriptions ($1,500-2,500/month MRR)
- ✅ Proven scalable model
- ✅ Decision point: Continue expansion or refine?

### Progressive Launch Strategy (RECOMMENDED)

Instead of waiting 30 days to launch all 3 cities, launch incrementally:

**Advantages:**
- ✅ **Revenue starts Week 3-4** instead of Week 5-6
- ✅ **Validate with real users faster** - don't build for 6 weeks before learning
- ✅ **Refine pitch based on Portland** before tackling Austin/SF
- ✅ **Cash flow from Portland** funds Austin expansion
- ✅ **Lower risk** - if Portland flops, pivot before wasting 6 weeks
- ✅ **Psychological wins** - early traction builds momentum

**Timeline Comparison:**

| Strategy | First Launch | First Revenue | 3 Cities Live | Total Cost |
|----------|--------------|---------------|---------------|------------|
| Wait for All 3 | Week 6 | Week 6-7 | Week 6 | $292 |
| Progressive | Week 3 | Week 4 | Week 6 | $292 |

Progressive is objectively better - same cost, faster validation, earlier revenue.

### Alternative: Fast Track with Multiple Sub-Accounts

If you need to launch FASTER and have budget:

**Setup:**
- 3 GoHighLevel sub-accounts (3 parallel calling locations)
- 3 phone numbers ($147/month total)
- GoHighLevel Unlimited plan ($297/month)

**Timeline:**
- Week 1: Build infrastructure
- Week 2: Call all 3 cities simultaneously (100/day each = 300/day total)
- Days 8-17: Complete all 3 cities (3,000 restaurants in 10 days)
- Week 3: Polish app
- Week 4: Launch all 3 cities simultaneously

**Cost:** ~$687 vs $292 (2.3X more expensive)
**Time saved:** 2-3 weeks
**Recommendation:** Only if you're in a race or have urgent deadline

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
