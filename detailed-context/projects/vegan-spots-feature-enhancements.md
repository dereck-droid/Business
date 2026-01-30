# Vegan Spots - Feature Enhancement Specification

**Date:** 2026-01-30
**Status:** Planning - Feature Specification
**Purpose:** Enhanced filtering, restaurant engagement, menu management, and quality validation features
**Priority:** HIGH - User-requested features that significantly improve app value proposition

---

## Related Documents
- [Vegan Spots Core Documentation](./vegan-spots-app.md)
- [Backlog Entry](../../backlog.md#vegan-spots-app)

---

## EXECUTIVE SUMMARY

This document specifies four critical feature enhancements to the Vegan Spots application based on user feedback and market analysis:

1. **Advanced Restaurant Tagging System** - Comprehensive tags for filtering (cuisine types, features, vegan levels)
2. **Push Notification System for New Dishes** - Restaurant-to-user alerts when new vegan items are added
3. **Enhanced Menu Management** - Rich media menu functionality with images, titles, descriptions
4. **Restaurant Validation Questionnaire** - Quality assurance system to verify restaurants understand vegan standards

These features collectively address:
- ✅ User discovery friction (finding specific food types quickly)
- ✅ Restaurant engagement (giving restaurants tools to attract customers)
- ✅ Data quality (ensuring listings meet vegan community standards)
- ✅ User retention (push notifications drive app re-engagement)
- ✅ Competitive differentiation (features HappyCow doesn't have)

---

## FEATURE 1: ADVANCED RESTAURANT TAGGING SYSTEM

### The Problem

Current restaurant discovery relies on basic search and limited filters. Users can't quickly answer questions like:
- "Where can I get vegan pizza near me?"
- "Which restaurants are 100% vegan vs vegan-friendly?"
- "Where can I take my non-vegan friends that has good options for everyone?"
- "I'm craving Mexican food - which places have the most vegan options?"

### The Solution

Implement a comprehensive, multi-category tagging system that allows:
- **Quick filtering** for specific cuisine types or food categories
- **Vegan level identification** (all-vegan vs vegan+non-vegan)
- **Feature-based filtering** (outdoor seating, delivery, etc)
- **Cuisine type filtering** (Mexican, Italian, Asian, etc)
- **Popular item filtering** (burgers, pizza, tacos, etc)

### Tag Categories & Examples

#### Category 1: Vegan Level
```
- All Vegan (100% vegan restaurant)
- Extensive Options (6+ vegan entrees)
- Vegan-Friendly (3-5 vegan entrees)
- Limited Options (1-2 vegan items)
- Vegan+Non (mixed menu, good for groups with non-vegans)
```

#### Category 2: Cuisine Type
```
- Mexican
- Italian
- Asian (with sub-tags: Thai, Chinese, Japanese, Korean, Vietnamese)
- American
- Mediterranean
- Indian
- Ethiopian
- Middle Eastern
- Caribbean
- French
- Soul Food
```

#### Category 3: Popular Food Items (THIS IS THE GAME CHANGER)
```
- Pizza
- Burgers
- Tacos
- Sushi
- Ramen
- Pasta
- Salads
- Sandwiches
- Bowls (poke, grain, buddha)
- Smoothies
- Desserts
- Ice Cream
- Coffee/Cafe
- Bakery
- Wings
- BBQ
```

#### Category 4: Dietary Accommodations
```
- Gluten-Free Options
- Nut-Free Options
- Soy-Free Options
- Oil-Free Options
- Raw Options
- Organic
```

#### Category 5: Features
```
- Outdoor Seating
- Delivery Available
- Takeout
- Dine-in
- Reservations Available
- Kid-Friendly
- Dog-Friendly
- LGBTQ+ Friendly
- Fast Casual
- Fine Dining
- Late Night (open past 10pm)
- Breakfast/Brunch
```

#### Category 6: Special Attributes
```
- Black-Owned
- Woman-Owned
- Locally-Owned
- Chain Restaurant
- Food Truck
- Pop-up
- Ghost Kitchen
```

### Database Schema

```sql
-- Tags master table (predefined tags only)
CREATE TABLE tags (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL, -- 'vegan_level', 'cuisine', 'food_item', 'dietary', 'features', 'attributes'
  description TEXT,
  icon_name VARCHAR(50), -- For UI display
  search_weight INTEGER DEFAULT 1, -- For search ranking
  created_at TIMESTAMP DEFAULT NOW()
);

-- Restaurant-Tag junction table (many-to-many)
CREATE TABLE restaurant_tags (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  restaurant_id UUID NOT NULL REFERENCES restaurants(id) ON DELETE CASCADE,
  tag_id UUID NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  source VARCHAR(50), -- 'ai_call', 'form_submission', 'restaurant_claimed', 'user_suggested', 'admin'
  confidence_score DECIMAL(3,2), -- 0.00-1.00 for AI-assigned tags
  verified BOOLEAN DEFAULT FALSE, -- Manual verification flag
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(restaurant_id, tag_id)
);

-- User-suggested tags (for moderation before approval)
CREATE TABLE tag_suggestions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  restaurant_id UUID NOT NULL REFERENCES restaurants(id),
  tag_id UUID NOT NULL REFERENCES tags(id),
  user_id UUID NOT NULL REFERENCES users(id),
  status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'approved', 'rejected'
  created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX idx_restaurant_tags_restaurant ON restaurant_tags(restaurant_id);
CREATE INDEX idx_restaurant_tags_tag ON restaurant_tags(tag_id);
CREATE INDEX idx_tags_category ON tags(category);
CREATE INDEX idx_tag_suggestions_status ON tag_suggestions(status);
```

### AI Agent Tag Assignment

During phone calls, the AI agent will automatically assign tags based on conversation:

**Script Addition:**
```
[After collecting vegan menu items]

AI: "Great! Just a few more questions to help people find your restaurant:

What type of cuisine would you say you serve?"
[AI records: Maps to cuisine tags]

"Do you have vegan pizza/burgers/tacos on the menu?"
[AI records: Maps to popular item tags]

"Do you also serve non-vegan food, or is your restaurant entirely vegan?"
[AI records: Maps to vegan level tags]

"Do you offer delivery or takeout?"
[AI records: Maps to feature tags]
```

**Auto-Tagging Rules:**
```javascript
// Example auto-tagging logic
if (restaurant.veganItemCount === restaurant.totalItemCount) {
  assignTag('All Vegan', confidence: 1.0);
} else if (restaurant.veganEntrees >= 6) {
  assignTag('Extensive Options', confidence: 1.0);
  assignTag('Vegan+Non', confidence: 1.0);
} else if (restaurant.veganEntrees >= 3) {
  assignTag('Vegan-Friendly', confidence: 1.0);
  assignTag('Vegan+Non', confidence: 1.0);
}

// Parse menu items for popular foods
if (menuItems.some(item => item.toLowerCase().includes('pizza'))) {
  assignTag('Pizza', confidence: 0.9);
}

if (menuItems.some(item => /burger|beyond.*burger|impossible.*burger/i.test(item))) {
  assignTag('Burgers', confidence: 0.9);
}
```

### User Interface Implementation

#### Filter Panel (Mobile App)
```
┌─────────────────────────────┐
│  Filters                [X] │
├─────────────────────────────┤
│                             │
│ 🌱 Vegan Level              │
│  ☑ All Vegan               │
│  ☐ Extensive Options        │
│  ☑ Vegan+Non (Good for      │
│     non-vegan friends)      │
│                             │
│ 🍕 Looking for...           │
│  ☑ Pizza                   │
│  ☑ Burgers                 │
│  ☐ Tacos                    │
│  ☐ Sushi                    │
│  [+ Show more]              │
│                             │
│ 🌮 Cuisine Type             │
│  ☑ Mexican                 │
│  ☐ Italian                  │
│  ☐ Asian                    │
│  [+ Show more]              │
│                             │
│ ⚡ Features                 │
│  ☐ Delivery                 │
│  ☐ Outdoor Seating          │
│  ☐ Late Night               │
│                             │
│ [Clear All]  [Apply (23)]   │
└─────────────────────────────┘
```

#### Restaurant Card Display
```
┌─────────────────────────────────┐
│ 📍 Veggie Grill                 │
│ ⭐⭐⭐⭐½ (124 reviews)           │
│                                 │
│ 🌱 All Vegan  🍔 Burgers        │
│ 🌮 American   🚚 Delivery       │
│                                 │
│ 0.3 miles • $$ • Open Now       │
└─────────────────────────────────┘
```

#### Quick Filter Chips (Above Map)
```
┌───────────────────────────────────────┐
│ [🍕 Pizza] [🍔 Burgers] [🌮 Mexican]  │
│ [🌱 All Vegan] [+ More Filters]       │
└───────────────────────────────────────┘
```

### API Endpoints

```
GET /api/tags
  - Returns all available tags grouped by category
  - Response: { vegan_level: [...], cuisine: [...], food_item: [...] }

GET /api/restaurants?tags=pizza,burgers,all-vegan&location=lat,lng
  - Search restaurants by multiple tags
  - Boolean AND logic (must have ALL selected tags)
  - Response: Restaurants matching all criteria

POST /api/restaurants/:id/tags
  - Add tag to restaurant (claimed listings only)
  - Body: { tag_id: UUID, source: 'restaurant_claimed' }
  - Auth required

DELETE /api/restaurants/:id/tags/:tagId
  - Remove tag from restaurant (claimed listings only)
  - Auth required

POST /api/tag-suggestions
  - Users suggest tags for restaurants
  - Body: { restaurant_id: UUID, tag_id: UUID }
  - Auth required
  - Goes to moderation queue

GET /api/restaurants/:id/tags
  - Get all tags for specific restaurant
  - Response: { tags: [...], last_updated: timestamp }
```

### Implementation Priority

**Phase 1 (MVP):**
- ✅ Core tag categories: Vegan Level, Cuisine Type, Popular Food Items
- ✅ Database schema and migrations
- ✅ AI agent auto-tagging logic
- ✅ Basic filter UI (checkbox filters)
- ✅ Tag display on restaurant cards

**Phase 2 (Enhanced):**
- ✅ Dietary accommodations tags
- ✅ Feature tags
- ✅ User tag suggestions
- ✅ Quick filter chips
- ✅ Advanced search with tag combinations

**Phase 3 (Advanced):**
- ✅ Special attribute tags
- ✅ Smart tag recommendations ("Based on what you search for...")
- ✅ Tag-based push notifications ("New pizza place added near you!")
- ✅ Analytics on most-searched tags

### Business Value

**For Users:**
- ⚡ 10x faster restaurant discovery
- 🎯 Find exactly what they're craving
- 👥 Easily find "vegan+non" spots for group dining
- 📍 Discover new options based on preferences

**For Restaurants:**
- 📈 Increased visibility in relevant searches
- 🎯 Attract customers looking for specific items
- 🏆 Stand out with unique tags
- 💼 Justify claimed listing (manage own tags)

**For Vegan Spots:**
- 🚀 Major competitive advantage over HappyCow
- 📊 Valuable data on user preferences (what tags are most searched)
- 💰 Selling point for B2B subscriptions ("Get tagged for 'pizza' and appear when people search!")
- 🔄 Increased user engagement and retention

---

## FEATURE 2: PUSH NOTIFICATION SYSTEM FOR NEW DISHES

### The Problem

Restaurants add new vegan items to their menus, but have no way to alert the vegan community. This means:
- ❌ Restaurants miss out on immediate customer interest
- ❌ Users discover new options late (or never)
- ❌ No incentive for restaurants to expand vegan offerings
- ❌ App becomes stale if users don't check regularly

### The Solution

**Restaurant-to-User Push Notification System:**

When a claimed restaurant adds a new vegan dish to their menu, they can send a **push notification** to users within a certain radius who have favorited or visited that restaurant.

### Key Features

#### 1. New Dish Announcement Flow

**Restaurant Dashboard:**
```
┌──────────────────────────────────┐
│ Add New Menu Item                │
├──────────────────────────────────┤
│ Item Name:                       │
│ [Impossible Cheesesteak        ] │
│                                  │
│ Category:                        │
│ [Entrees ▼]                      │
│                                  │
│ Description:                     │
│ [Philly-style sandwich with...] │
│                                  │
│ Price: [$14.99]                  │
│                                  │
│ Upload Photo: [Choose File]      │
│                                  │
│ ☑ Notify followers about this    │
│   new item (23 users nearby)     │
│                                  │
│ Notification Message:            │
│ [Try our NEW Impossible          │
│  Cheesesteak! Available now.]    │
│                                  │
│ [Cancel]  [Add Item & Notify]    │
└──────────────────────────────────┘
```

**User Notification:**
```
┌──────────────────────────────────┐
│ 🌱 Veggie Grill                  │
│ NEW: Impossible Cheesesteak      │
│                                  │
│ Try our NEW Impossible           │
│ Cheesesteak! Available now.      │
│                                  │
│ 📍 0.8 miles from you            │
│                                  │
│ [View Menu]    [Dismiss]         │
└──────────────────────────────────┘
```

#### 2. Notification Targeting Rules

**Who Receives Notifications:**
- Users within X mile radius (configurable per subscription tier)
- Users who have:
  - ✅ Favorited the restaurant
  - ✅ Checked in at the restaurant before
  - ✅ Rated/reviewed the restaurant
  - ✅ Enabled location services + push notifications
  - ✅ Opted into "new dish alerts" in settings

**Subscription Tier Limits:**

| Tier | Notifications/Month | Radius | Users Reached |
|------|---------------------|--------|---------------|
| Claimed Listing ($49/mo) | 1 | 5 miles | ~50-200 |
| Premium Listing ($99/mo) | 4 | 10 miles | ~200-500 |
| Featured Listing ($149/mo) | Unlimited | 15 miles | ~500-2000 |

#### 3. Anti-Spam Protection

**Rate Limiting:**
- Max 1 notification per restaurant per user per week
- Max 1 notification per user per day (across all restaurants)
- Cooldown period: 7 days between notifications from same restaurant

**User Controls:**
```
Settings > Notifications
┌──────────────────────────────────┐
│ Push Notifications               │
├──────────────────────────────────┤
│ New Vegan Dishes                 │
│ ☑ Notify me when favorited       │
│   restaurants add new items      │
│                                  │
│ Notification Radius              │
│ ○ 5 miles                        │
│ ● 10 miles                       │
│ ○ 15 miles                       │
│                                  │
│ Frequency                        │
│ ● Max 1 per day                  │
│ ○ Max 3 per week                 │
│ ○ Max 1 per week                 │
│                                  │
│ ☑ Special offers and promotions  │
│ ☐ App updates and features       │
└──────────────────────────────────┘
```

### Database Schema

```sql
-- Push notification tokens
CREATE TABLE push_tokens (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  token TEXT NOT NULL,
  device_type VARCHAR(20), -- 'ios', 'android', 'web'
  created_at TIMESTAMP DEFAULT NOW(),
  last_used_at TIMESTAMP DEFAULT NOW()
);

-- Notification history
CREATE TABLE notifications (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  restaurant_id UUID NOT NULL REFERENCES restaurants(id),
  menu_item_id UUID REFERENCES menu_items(id),
  notification_type VARCHAR(50), -- 'new_dish', 'special_offer', 'menu_update'
  title VARCHAR(200) NOT NULL,
  message TEXT NOT NULL,
  radius_miles INTEGER,
  users_targeted INTEGER,
  users_reached INTEGER,
  clicks INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW(),
  created_by UUID REFERENCES users(id) -- Restaurant owner
);

-- User notification receipts (track who received what)
CREATE TABLE notification_receipts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  notification_id UUID NOT NULL REFERENCES notifications(id),
  user_id UUID NOT NULL REFERENCES users(id),
  delivered BOOLEAN DEFAULT FALSE,
  opened BOOLEAN DEFAULT FALSE,
  clicked BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW(),
  opened_at TIMESTAMP,
  clicked_at TIMESTAMP
);

-- User notification preferences
CREATE TABLE notification_preferences (
  user_id UUID PRIMARY KEY REFERENCES users(id),
  new_dishes BOOLEAN DEFAULT TRUE,
  special_offers BOOLEAN DEFAULT TRUE,
  radius_miles INTEGER DEFAULT 10,
  max_per_day INTEGER DEFAULT 1,
  enabled BOOLEAN DEFAULT TRUE,
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### Analytics Dashboard for Restaurants

```
Restaurant Dashboard > Notifications
┌──────────────────────────────────────┐
│ New Dish Notification Performance    │
├──────────────────────────────────────┤
│ Impossible Cheesesteak               │
│ Sent: Jan 28, 2026 at 2:15 PM        │
│                                      │
│ 📊 Targeted: 127 users               │
│ ✉️ Delivered: 114 users (90%)        │
│ 👀 Opened: 87 users (76%)            │
│ 🔗 Clicked: 62 users (54%)           │
│                                      │
│ 📈 Estimated reach value: $186       │
│    (62 clicks × $3 avg order value)  │
│                                      │
│ [View Details]                       │
└──────────────────────────────────────┘
```

### Implementation with Firebase Cloud Messaging (FCM)

**Tech Stack:**
- Firebase Cloud Messaging (iOS + Android + Web)
- Node.js backend with FCM Admin SDK
- n8n workflow for notification scheduling
- Supabase for notification tracking

**Notification Workflow:**
```
1. Restaurant adds new menu item via dashboard
2. Checks notification tier limits (has quota?)
3. Query users matching criteria:
   - Within radius
   - Has favorited/reviewed restaurant
   - Push notifications enabled
   - Not exceeded daily/weekly limits
4. Send notifications via FCM batch API
5. Log delivery status to notification_receipts
6. Track opens/clicks for analytics
7. Update restaurant dashboard with stats
```

### Business Value

**For Restaurants:**
- 🚀 Direct channel to engaged customers
- 💰 Drive immediate traffic for new items
- 📈 Prove ROI of claimed listing subscription
- 🎯 Reach customers actively looking for vegan options
- 📊 Analytics on customer engagement

**For Users:**
- 🔔 Never miss new vegan options at favorite spots
- 🎉 Discover new dishes immediately
- 📍 Relevant, location-based updates
- 🚫 Anti-spam controls (user-configurable)

**For Vegan Spots:**
- 💼 Major selling point for B2B subscriptions
- 📈 Increase restaurant engagement with platform
- 🔄 Drive user re-engagement (combat app abandonment)
- 📊 Valuable engagement data
- 🏆 Feature HappyCow doesn't have

### Sales Pitch to Restaurants

> "When you add a new vegan item to your menu, we'll instantly notify up to 500 vegans within 10 miles who have favorited your restaurant. That's targeted, immediate reach to people actively looking for new vegan spots. On average, restaurants see 50-70% open rates and drive $150-300 in orders from a single notification. It's like having a direct line to your most engaged customers."

---

## FEATURE 3: ENHANCED MENU MANAGEMENT WITH RICH MEDIA

### The Problem

Current menu listings are text-only (item name + description). This creates:
- ❌ Less engaging listings (no visual appeal)
- ❌ Harder for users to decide what looks good
- ❌ Less differentiation between restaurants
- ❌ Missed opportunity for restaurants to showcase food quality

### The Solution

**Rich Media Menu System** with:
- 📸 High-quality food photos for each menu item
- 📝 Detailed descriptions with ingredients
- 🏷️ Item-level tags (gluten-free, nut-free, spicy, etc)
- 💰 Pricing display
- 🔥 Popularity indicators ("Most Ordered")
- ⭐ Item-specific ratings

### Menu Item Data Structure

```javascript
// Enhanced menu_items table
{
  id: UUID,
  restaurant_id: UUID,
  name: "Beyond Burger",
  category: "Entrees", // Appetizers, Entrees, Sides, Desserts, Beverages
  description: "Plant-based burger with lettuce, tomato, pickles, vegan mayo on brioche bun",
  ingredients: ["Beyond Burger patty", "lettuce", "tomato", "pickles", "vegan mayo", "brioche bun"],
  price: 14.99,
  photo_url: "https://cdn.veganspots.com/123/beyond-burger.jpg",
  photo_thumbnail_url: "https://cdn.veganspots.com/123/beyond-burger-thumb.jpg",
  allergen_warnings: ["gluten", "soy"],
  dietary_flags: ["vegan", "can-be-gluten-free"], // If can modify
  spice_level: 0, // 0-5
  calories: 550, // Optional
  prep_notes: "Ask for gluten-free bun to make this gluten-free",
  available: true,
  seasonal: false,
  popular: true, // Top 20% of orders
  created_at: timestamp,
  updated_at: timestamp,
  created_by: UUID, // Restaurant owner or AI agent
  source: "restaurant_claimed" // or "ai_call", "user_submitted"
}
```

### Menu Item Photo Management

**Photo Requirements:**
- Minimum resolution: 800x600px
- Aspect ratio: 4:3 or 1:1 (square)
- Max file size: 5MB
- Formats: JPG, PNG, WebP
- Auto-optimization: Convert to WebP, generate thumbnails

**Photo Sources:**
1. **Restaurant uploads** (claimed listings)
2. **User-contributed photos** (all listings)
3. **AI-sourced** (scrape from restaurant Instagram/website with permission)

**Storage: Cloudinary or Supabase Storage**
- Automatic thumbnail generation
- CDN distribution
- Image optimization (lazy loading, responsive sizing)

### Restaurant Dashboard - Menu Management

```
┌─────────────────────────────────────────┐
│ Menu Management                         │
├─────────────────────────────────────────┤
│                                         │
│ [+ Add Menu Item]  [Import from PDF]    │
│                                         │
│ Entrees (8 items)                       │
│ ┌───────────────────────────────────┐  │
│ │ 🍔 Beyond Burger         $14.99   │  │
│ │ [Photo]                            │  │
│ │ 👁️ 1,234 views  ⭐ 4.8 (23)       │  │
│ │ [Edit] [Delete] [Reorder ↕]       │  │
│ └───────────────────────────────────┘  │
│                                         │
│ ┌───────────────────────────────────┐  │
│ │ 🌮 Jackfruit Tacos      $12.99    │  │
│ │ ⚠️ No photo - Add one!            │  │
│ │ 👁️ 892 views  ⭐ 4.6 (15)         │  │
│ │ [Edit] [Delete] [Reorder ↕]       │  │
│ └───────────────────────────────────┘  │
│                                         │
│ Desserts (4 items)                      │
│ ...                                     │
└─────────────────────────────────────────┘
```

**Add/Edit Menu Item Form:**
```
┌─────────────────────────────────────┐
│ Add Menu Item                       │
├─────────────────────────────────────┤
│ Item Name *                         │
│ [Beyond Burger                    ] │
│                                     │
│ Category *                          │
│ [Entrees ▼]                         │
│                                     │
│ Description *                       │
│ [Plant-based burger with lettuce, │
│  tomato, pickles, vegan mayo on   │
│  brioche bun                      ] │
│                                     │
│ Ingredients (comma separated)       │
│ [Beyond patty, lettuce, tomato... ] │
│                                     │
│ Price * [$14.99]                    │
│                                     │
│ Photo *                             │
│ [Upload Photo] or [Choose Existing] │
│ ┌─────────────┐                     │
│ │   Preview   │                     │
│ │   [Image]   │                     │
│ └─────────────┘                     │
│                                     │
│ Dietary Flags                       │
│ ☑ Vegan (required)                  │
│ ☑ Can be Gluten-Free                │
│ ☐ Gluten-Free                       │
│ ☐ Nut-Free                          │
│ ☐ Soy-Free                          │
│ ☐ Oil-Free                          │
│                                     │
│ Allergen Warnings                   │
│ ☑ Contains Gluten                   │
│ ☑ Contains Soy                      │
│ ☐ May contain nuts                  │
│                                     │
│ Preparation Notes                   │
│ [Ask for gluten-free bun to make  │
│  this gluten-free                 ] │
│                                     │
│ ☑ Mark as "Popular" item            │
│ ☐ Seasonal/Limited time             │
│                                     │
│ [Cancel]  [Save Item]               │
└─────────────────────────────────────┘
```

### User-Facing Menu Display

**Restaurant Detail Page - Menu Section:**
```
┌───────────────────────────────────────┐
│ Menu                                  │
├───────────────────────────────────────┤
│ [All] [Entrees] [Apps] [Desserts]    │
│                                       │
│ ┌─────────────────────────────────┐  │
│ │ 🍔 Beyond Burger      $14.99 🔥 │  │
│ │ ┌─────────┐                      │  │
│ │ │ [Photo] │ Plant-based burger   │  │
│ │ │         │ with lettuce, tomato,│  │
│ │ └─────────┘ pickles, vegan mayo  │  │
│ │             on brioche bun       │  │
│ │                                  │  │
│ │ ⭐ 4.8 (23 ratings)               │  │
│ │ 🏷️ Can be GF • Contains Soy      │  │
│ │                                  │  │
│ │ [❤️ Save] [📷 Upload Photo]      │  │
│ └─────────────────────────────────┘  │
│                                       │
│ ┌─────────────────────────────────┐  │
│ │ 🌮 Jackfruit Tacos    $12.99    │  │
│ │ ┌─────────┐                      │  │
│ │ │ [Photo] │ Slow-cooked jackfruit│  │
│ │ │         │ with corn tortillas, │  │
│ │ └─────────┘ pico de gallo, lime  │  │
│ │                                  │  │
│ │ ⭐ 4.6 (15 ratings)               │  │
│ │ 🏷️ Gluten-Free • Nut-Free        │  │
│ │                                  │  │
│ │ [❤️ Save] [📷 Upload Photo]      │  │
│ └─────────────────────────────────┘  │
│                                       │
│ [View Full Menu PDF]                  │
└───────────────────────────────────────┘
```

### Item-Level Ratings & Reviews

Users can rate and review individual menu items:

```
┌───────────────────────────────────────┐
│ Beyond Burger Reviews                 │
├───────────────────────────────────────┤
│ ⭐⭐⭐⭐⭐ Sarah K. - Jan 15, 2026      │
│ "Best vegan burger in Portland! The   │
│ patty is juicy and the vegan mayo is  │
│ chef's kiss."                         │
│ [📷 Photo]                            │
│ 👍 24  💬 3                           │
│                                       │
│ ⭐⭐⭐⭐ Mike R. - Jan 10, 2026        │
│ "Really good! Would be 5 stars if the │
│ bun was softer."                      │
│ 👍 15  💬 1                           │
│                                       │
│ [Load More Reviews]                   │
└───────────────────────────────────────┘
```

### Database Schema

```sql
-- Enhanced menu items table
CREATE TABLE menu_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  restaurant_id UUID NOT NULL REFERENCES restaurants(id) ON DELETE CASCADE,
  name VARCHAR(200) NOT NULL,
  category VARCHAR(50), -- Appetizers, Entrees, Sides, Desserts, Beverages
  description TEXT,
  ingredients TEXT[], -- Array of ingredient strings
  price DECIMAL(10,2),
  photo_url TEXT,
  photo_thumbnail_url TEXT,
  allergen_warnings TEXT[], -- gluten, soy, nuts, etc
  dietary_flags TEXT[], -- vegan, gluten-free, nut-free, etc
  spice_level INTEGER DEFAULT 0, -- 0-5
  calories INTEGER,
  prep_notes TEXT,
  available BOOLEAN DEFAULT TRUE,
  seasonal BOOLEAN DEFAULT FALSE,
  popular BOOLEAN DEFAULT FALSE,
  display_order INTEGER,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  created_by UUID REFERENCES users(id),
  source VARCHAR(50) -- ai_call, restaurant_claimed, user_submitted
);

-- Menu item ratings (separate from restaurant ratings)
CREATE TABLE menu_item_ratings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  menu_item_id UUID NOT NULL REFERENCES menu_items(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id),
  restaurant_id UUID NOT NULL REFERENCES restaurants(id),
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  review_text TEXT,
  photo_url TEXT,
  helpful_count INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(menu_item_id, user_id)
);

-- User-uploaded menu item photos
CREATE TABLE menu_item_photos (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  menu_item_id UUID NOT NULL REFERENCES menu_items(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id),
  restaurant_id UUID NOT NULL REFERENCES restaurants(id),
  photo_url TEXT NOT NULL,
  thumbnail_url TEXT,
  caption TEXT,
  approved BOOLEAN DEFAULT FALSE, -- Moderation
  helpful_count INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_menu_items_restaurant ON menu_items(restaurant_id);
CREATE INDEX idx_menu_items_category ON menu_items(category);
CREATE INDEX idx_menu_item_ratings_item ON menu_item_ratings(menu_item_id);
CREATE INDEX idx_menu_item_ratings_user ON menu_item_ratings(user_id);
```

### API Endpoints

```
GET /api/restaurants/:id/menu
  - Get full menu for restaurant
  - Optional query params: ?category=Entrees

GET /api/menu-items/:id
  - Get single menu item with ratings

POST /api/restaurants/:id/menu-items
  - Add menu item (claimed restaurants only)
  - Auth required

PUT /api/menu-items/:id
  - Update menu item (claimed restaurants only)
  - Auth required

DELETE /api/menu-items/:id
  - Delete menu item (claimed restaurants only)
  - Auth required

POST /api/menu-items/:id/ratings
  - Rate menu item
  - Auth required
  - Body: { rating: 1-5, review_text: "...", photo_url: "..." }

POST /api/menu-items/:id/photos
  - Upload user photo of menu item
  - Auth required
  - Multipart form with image file

GET /api/menu-items/:id/ratings
  - Get ratings for menu item
  - Pagination support
```

### Business Value

**For Restaurants:**
- 🎨 Showcase food quality with photos
- 📈 Increase order conversions (photos drive purchases)
- 🎯 Highlight popular items
- 📊 Track which items are most viewed/rated
- 💼 Professional presentation = more subscriptions

**For Users:**
- 👀 Visual menu browsing (see food before ordering)
- ⭐ Item-level ratings (not just restaurant-level)
- 🔍 Find specific dishes across restaurants
- 📸 Contribute photos and help others
- 💬 Read reviews about specific items

**For Vegan Spots:**
- 🏆 Major UX advantage over HappyCow (text-only menus)
- 💰 Justifies higher subscription prices
- 📊 Valuable menu trend data
- 🚀 Increased user engagement (rate items, upload photos)

---

## FEATURE 4: RESTAURANT VALIDATION QUESTIONNAIRE

### The Problem

Not all restaurants understand what "vegan" means. Common issues:
- ❌ "Vegan" dish cooked in butter
- ❌ "Vegan" pasta with parmesan sprinkled on top
- ❌ Shared fryers with chicken (not disclosed)
- ❌ "Vegan" salad with honey mustard dressing
- ❌ Cross-contamination not taken seriously

**This is a TRUST issue.** If users get burned by incorrect listings, they'll abandon the app.

### The Solution

**Two-Stage Validation System:**

1. **AI Phone Call Validation** - Initial screening during data collection
2. **Form Submission Questionnaire** - Detailed validation for claimed listings

### Stage 1: AI Phone Call Validation

During the AI agent call, ask specific validation questions:

**Script Addition:**
```
AI: "I need to ask a few quick questions to make sure we accurately represent your vegan options:

1. When you prepare vegan dishes, do you use any animal-derived ingredients like butter, milk, eggs, or honey?"

   [If YES] → "Those items would not be considered vegan. Let me clarify what vegan means..."
   [If NO] → Continue

2. "Do your vegan dishes share cooking surfaces, grills, or fryers with meat or seafood?"

   [If YES] → Flag as "Shared Equipment" - not disqualifying, just disclosed
   [If NO] → Excellent, note as "Separate Prep"

3. "Are your vegan menu items clearly marked on the menu so customers can easily identify them?"

   [Record answer - helps users know what to expect]

4. "Do you use separate utensils when preparing vegan dishes?"

   [Record answer - important for strict vegans]

5. "If a customer has questions about ingredients, does your staff know which items are vegan?"

   [Record answer - indicates restaurant knowledge level]
```

**Validation Scoring:**
```javascript
let validationScore = 0;
let flags = [];

// Question 1: Understanding of vegan (CRITICAL)
if (usesAnimalIngredients === true) {
  flags.push('misunderstands_vegan');
  validationScore -= 50; // Major red flag
} else {
  validationScore += 20;
}

// Question 2: Shared equipment (DISCLOSURE, not disqualifying)
if (sharedEquipment === true) {
  flags.push('shared_equipment');
  // Not a penalty, just disclosure
} else {
  validationScore += 15;
  flags.push('separate_prep');
}

// Question 3: Menu labeling
if (clearlyMarked === true) {
  validationScore += 10;
}

// Question 4: Separate utensils
if (separateUtensils === true) {
  validationScore += 10;
}

// Question 5: Staff knowledge
if (staffKnowledge === 'yes') {
  validationScore += 15;
} else if (staffKnowledge === 'no') {
  flags.push('staff_training_needed');
  validationScore -= 10;
}

// Scoring outcomes
if (validationScore >= 50) {
  status = 'APPROVED';
} else if (validationScore >= 20) {
  status = 'APPROVED_WITH_WARNINGS';
} else {
  status = 'NEEDS_REVIEW'; // Human follow-up required
}
```

### Stage 2: Form Submission Questionnaire (Claimed Listings)

When restaurants submit the form to claim their listing, they must complete a **Vegan Standards Questionnaire**:

```
┌────────────────────────────────────────┐
│ Vegan Standards Verification           │
├────────────────────────────────────────┤
│ Before claiming your listing, please   │
│ answer these questions to ensure we    │
│ maintain accurate information for our  │
│ community.                             │
│                                        │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                        │
│ 1. Does your restaurant understand     │
│    that vegan means:                   │
│    ☑ No meat, poultry, seafood         │
│    ☑ No dairy (milk, cheese, butter)   │
│    ☑ No eggs                            │
│    ☑ No honey                           │
│    ☑ No animal-derived ingredients      │
│                                        │
│    [YES - We understand] [NO - Tell    │
│     me more]                           │
│                                        │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                        │
│ 2. Do your vegan dishes share fryers   │
│    with animal products? *             │
│    ○ Yes - Shared fryers               │
│    ○ No - Separate fryers for vegan    │
│    ○ No fryers used                    │
│                                        │
│ ⚠️ Shared fryers will be disclosed on  │
│    your listing but will NOT            │
│    disqualify you.                     │
│                                        │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                        │
│ 3. Do vegan items share grills or      │
│    cooking surfaces with meat? *       │
│    ○ Yes - Shared surfaces             │
│    ○ No - Separate surfaces            │
│    ○ We clean surfaces between uses    │
│    ○ N/A - No grilled items            │
│                                        │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                        │
│ 4. Are vegan and non-vegan foods       │
│    prepared with separate utensils? *  │
│    ○ Yes - Always separate             │
│    ○ No - Same utensils, cleaned       │
│    ○ Sometimes - Depends on dish       │
│                                        │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                        │
│ 5. Do any of your "vegan" dishes       │
│    contain: *                          │
│    ☐ Butter or ghee                    │
│    ☐ Cheese or dairy                   │
│    ☐ Eggs                               │
│    ☐ Honey                              │
│    ☐ Fish sauce or oyster sauce        │
│    ☐ None of the above ✓               │
│                                        │
│ 🚨 If any boxes are checked, we cannot │
│    list these as vegan items.          │
│                                        │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                        │
│ 6. Is your kitchen staff trained to    │
│    understand and prepare vegan         │
│    dishes correctly? *                 │
│    ○ Yes - Staff is trained            │
│    ○ Partially - Some staff trained    │
│    ○ No - We need training resources   │
│                                        │
│ 💡 We can provide free training        │
│    materials if needed.                │
│                                        │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                        │
│ 7. Are vegan items clearly labeled on  │
│    your menu? *                        │
│    ○ Yes - Marked with (V) or "vegan"  │
│    ○ No - Customers must ask           │
│    ○ Partially - Some items marked     │
│                                        │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                        │
│ 8. Can customers request modifications │
│    to make dishes vegan? *             │
│    ○ Yes - We accommodate modifications│
│    ○ Limited - Some dishes only        │
│    ○ No - Menu items as-is             │
│                                        │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                        │
│ 9. Risk Assessment:                    │
│    Based on your answers, we've        │
│    assessed your cross-contamination   │
│    risk as:                            │
│                                        │
│    🟡 MEDIUM RISK                      │
│                                        │
│    - Shared fryers (disclosed)         │
│    - Separate prep surfaces ✓          │
│    - Staff partially trained           │
│                                        │
│    This information will be displayed  │
│    on your listing to help customers   │
│    make informed decisions.            │
│                                        │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ │
│                                        │
│ ☑ I certify that the information       │
│   provided is accurate to the best     │
│   of my knowledge.                     │
│                                        │
│ [Back]  [Submit for Review]            │
└────────────────────────────────────────┘
```

### Disqualifiers vs Disclosures

**DISQUALIFIERS (Cannot be listed as vegan):**
- ❌ Uses butter, milk, eggs, honey in "vegan" dishes
- ❌ Fundamental misunderstanding of what vegan means
- ❌ Refuses to answer validation questions

**DISCLOSURES (Listed with warnings):**
- ⚠️ Shared fryers with animal products
- ⚠️ Shared cooking surfaces (disclosed, not disqualified)
- ⚠️ Same utensils used (cleaned between uses)
- ⚠️ Staff not fully trained on vegan prep
- ⚠️ Cross-contamination risk (Medium/High)

### User-Facing Disclosure Badges

Restaurants with disclosed issues show warning badges:

```
┌─────────────────────────────────────┐
│ 📍 Joe's Pizza & Pasta              │
│ ⭐⭐⭐⭐ (87 reviews)                │
│                                     │
│ ⚠️ PREPARATION NOTICES              │
│ • Shared fryers with non-vegan items│
│ • Shared cooking surfaces           │
│ • Cross-contamination possible      │
│                                     │
│ ℹ️ This restaurant accommodates     │
│    vegans but also serves animal    │
│    products. Some cross-contact may │
│    occur.                           │
│                                     │
│ [View Menu]  [Get Directions]       │
└─────────────────────────────────────┘
```

**vs Clean Listing:**

```
┌─────────────────────────────────────┐
│ 📍 Plant Power Cafe                 │
│ ⭐⭐⭐⭐⭐ (342 reviews)             │
│                                     │
│ ✅ 100% Vegan Restaurant            │
│ ✅ Dedicated vegan kitchen          │
│ ✅ No cross-contamination risk      │
│                                     │
│ ℹ️ Fully vegan establishment with   │
│    trained staff and separate prep. │
│                                     │
│ [View Menu]  [Get Directions]       │
└─────────────────────────────────────┘
```

### Database Schema

```sql
-- Restaurant validation responses
CREATE TABLE restaurant_validation (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  restaurant_id UUID NOT NULL REFERENCES restaurants(id) ON DELETE CASCADE,
  validation_date TIMESTAMP DEFAULT NOW(),
  validation_source VARCHAR(50), -- 'ai_call', 'form_submission', 'manual_review'

  -- Core understanding
  understands_vegan BOOLEAN,

  -- Cross-contamination
  shared_fryers BOOLEAN,
  shared_grills BOOLEAN,
  shared_utensils BOOLEAN,
  separate_prep_area BOOLEAN,

  -- Animal ingredients check
  uses_butter BOOLEAN DEFAULT FALSE,
  uses_dairy BOOLEAN DEFAULT FALSE,
  uses_eggs BOOLEAN DEFAULT FALSE,
  uses_honey BOOLEAN DEFAULT FALSE,
  uses_fish_sauce BOOLEAN DEFAULT FALSE,

  -- Staff & operations
  staff_trained BOOLEAN,
  menu_labeled BOOLEAN,
  allows_modifications BOOLEAN,

  -- Risk assessment
  contamination_risk VARCHAR(20), -- 'low', 'medium', 'high'
  validation_score INTEGER, -- 0-100

  -- Flags
  disqualified BOOLEAN DEFAULT FALSE,
  disqualification_reason TEXT,
  warnings TEXT[], -- Array of warning messages

  -- Metadata
  validated_by UUID REFERENCES users(id), -- AI or admin
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Validation history (track changes over time)
CREATE TABLE validation_history (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  restaurant_id UUID NOT NULL REFERENCES restaurants(id),
  validation_data JSONB, -- Snapshot of validation data
  changed_by UUID REFERENCES users(id),
  change_type VARCHAR(50), -- 'ai_initial', 'form_update', 'admin_override'
  created_at TIMESTAMP DEFAULT NOW()
);
```

### Admin Review Queue

For restaurants flagged as "NEEDS_REVIEW":

```
┌────────────────────────────────────────┐
│ Validation Review Queue (12 pending)   │
├────────────────────────────────────────┤
│                                        │
│ 🔴 Joe's Pizza                         │
│ Portland, OR                           │
│ Flagged: Uses honey in "vegan" items   │
│ Validation Score: 15/100               │
│                                        │
│ AI Call Transcript:                    │
│ "We have a vegan honey mustard         │
│  dressing... wait, honey isn't vegan?" │
│                                        │
│ [❌ Disqualify] [✏️ Contact Restaurant]│
│                                        │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                        │
│ 🟡 Thai Basil                          │
│ Austin, TX                             │
│ Flagged: Shared fryers, no separate    │
│          prep area                     │
│ Validation Score: 42/100               │
│                                        │
│ [✅ Approve with Warnings]             │
│ [✏️ Request More Info]                 │
│                                        │
│ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                        │
│ [Load More]                            │
└────────────────────────────────────────┘
```

### Business Value

**For Users:**
- 🛡️ Trust and safety (know what to expect)
- 📋 Informed decisions (see cross-contamination risks)
- ⚠️ No surprises (clear warnings displayed)
- 🌱 Vegan integrity maintained
- 🔍 Transparency builds community trust

**For Restaurants:**
- 📚 Education (learn what vegan actually means)
- 🤝 Clear expectations (know what's required)
- ✅ Credibility (validation badge = trust)
- 🎯 Attract right customers (vegans who appreciate transparency)
- 💼 Differentiation (strict vegans see you're thoughtful)

**For Vegan Spots:**
- 🏆 Community trust (preventing "fake vegan" listings)
- 🛡️ Liability protection (disclaimers + warnings)
- 📊 Quality control (maintain high standards)
- 💪 Competitive advantage (more thorough than HappyCow)
- 🚀 Brand reputation (known for accuracy)

---

## IMPLEMENTATION ROADMAP

### Phase 1: Foundation (Weeks 1-2)
**Restaurant Tagging System**
- ✅ Database schema for tags
- ✅ Seed predefined tags (50+ tags across all categories)
- ✅ AI agent tag assignment logic
- ✅ Basic tag display on restaurant cards
- ✅ Tag filter UI (checkboxes)

**Validation Questionnaire**
- ✅ Add validation questions to AI call script
- ✅ Database schema for validation responses
- ✅ Validation scoring algorithm
- ✅ Admin review queue

### Phase 2: Enhanced Features (Weeks 3-4)
**Menu Management**
- ✅ Menu items database schema
- ✅ Photo upload functionality (Cloudinary integration)
- ✅ Restaurant dashboard menu management UI
- ✅ User-facing menu display with photos
- ✅ Item-level ratings

**Tag System Enhancement**
- ✅ Advanced tag combinations
- ✅ Popular filter chips
- ✅ Tag-based search ranking

### Phase 3: Engagement (Weeks 5-6)
**Push Notifications**
- ✅ Firebase Cloud Messaging setup
- ✅ Push token collection from users
- ✅ Notification targeting logic
- ✅ Restaurant notification dashboard
- ✅ User notification preferences
- ✅ Analytics tracking (open rates, clicks)

**Menu Features**
- ✅ User photo contributions
- ✅ Item-level reviews
- ✅ "Popular" badge algorithm
- ✅ Menu PDF upload

### Phase 4: Polish & Analytics (Week 7+)
- ✅ Validation disclosure badges
- ✅ Tag analytics (most searched)
- ✅ Notification performance analytics
- ✅ A/B testing on features
- ✅ User onboarding improvements

---

## SUCCESS METRICS

### Restaurant Tagging System
- **User Engagement:** 60%+ of searches use at least one tag filter
- **Discovery:** Users find restaurants 3x faster with tags vs text search
- **Retention:** Tagged restaurants get 2x more profile views

### Push Notifications
- **Delivery Rate:** 85%+ notifications delivered
- **Open Rate:** 40%+ notifications opened
- **Click Rate:** 25%+ users click through to restaurant
- **Restaurant Value:** Average $150-300 in orders per notification

### Menu Management
- **Photo Coverage:** 70%+ of menu items have photos (claimed listings)
- **User Engagement:** 50% increase in time spent on restaurant pages
- **Conversion:** 30% increase in "Get Directions" clicks with photos

### Validation System
- **Accuracy:** <5% user reports of incorrect vegan listings
- **Trust:** 80%+ of users trust validation badges
- **Disqualification Rate:** <10% of restaurants disqualified

---

## COMPETITIVE ANALYSIS

| Feature | Vegan Spots | HappyCow | Yelp/Google |
|---------|-------------|----------|-------------|
| Restaurant Tags | ✅ Comprehensive | ⚠️ Basic | ❌ None |
| Push Notifications | ✅ Restaurant→User | ❌ None | ⚠️ Limited |
| Menu Photos | ✅ Item-level | ⚠️ Restaurant-level | ⚠️ Mixed quality |
| Validation | ✅ AI + Form | ❌ User-reported | ❌ None |
| Cuisine Filtering | ✅ Detailed tags | ⚠️ Basic | ⚠️ General |
| Cross-Contamination | ✅ Disclosed clearly | ⚠️ Sometimes mentioned | ❌ None |
| Item Ratings | ✅ Individual items | ❌ Restaurant only | ⚠️ Mixed |

**Vegan Spots Advantage:** Only app with ALL these features combined.

---

## SALES PITCH INTEGRATION

### Updated Restaurant Pitch

> "We're building the most comprehensive vegan restaurant directory in [CITY]. Here's what makes us different:
>
> **For Discovery:**
> - We tag restaurants with 50+ specific filters - cuisine types, popular items like pizza and burgers, dietary accommodations, and features. When someone searches 'vegan pizza near me,' you'll show up.
>
> **For Engagement:**
> - When you add a new vegan dish, we'll instantly notify up to 500 vegans within 10 miles who have favorited your restaurant. Direct reach to engaged customers.
>
> **For Trust:**
> - We verify vegan standards and clearly disclose cross-contamination risks. This builds trust with our community and shows you take vegan prep seriously.
>
> **For Presentation:**
> - Upload photos of every dish, not just your restaurant. Users browse by photos - restaurants with menu images get 50% more clicks.
>
> Would you like me to text you a link to claim your listing and access these features?"

---

## FINAL THOUGHTS & RECOMMENDATIONS

### Why These Features Work Together

1. **Tags solve discovery** → Users find restaurants faster
2. **Push notifications solve engagement** → Restaurants can re-engage customers
3. **Menu photos solve conversion** → Users order more when they see food
4. **Validation solves trust** → Community trusts the app long-term

These aren't isolated features - they're a **cohesive system** that addresses user needs, restaurant needs, and platform credibility simultaneously.

### Priority Recommendation

**Build in this order:**
1. **Validation System** (FIRST) - Foundation of trust, prevents bad listings
2. **Restaurant Tags** (SECOND) - Core discovery feature, high user value
3. **Menu Management** (THIRD) - Differentiation from HappyCow
4. **Push Notifications** (FOURTH) - Engagement and retention

### Integration with Existing Plan

These features integrate seamlessly with the existing Vegan Spots architecture:

- **AI Agent** → Auto-assigns tags during calls + validates restaurants
- **GoHighLevel** → Can trigger push notifications via workflow
- **Supabase** → Handles all new database tables
- **n8n** → Orchestrates notification delivery
- **B2B Monetization** → Features justify higher subscription tiers

### Estimated Development Time

- **Phase 1 (Tags + Validation):** 2 weeks
- **Phase 2 (Menu Management):** 2 weeks
- **Phase 3 (Push Notifications):** 2 weeks
- **Total:** 6 weeks for all features

This aligns perfectly with the existing 6-week launch timeline in the core documentation.

---

**Last Updated:** 2026-01-30
**Next Review:** After Phase 1 implementation (2 weeks)
**Status:** Ready for Development
