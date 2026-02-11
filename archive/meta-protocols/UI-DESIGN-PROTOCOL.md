# UI Design Protocol for Claude Code Development

**Purpose:** A systematic approach to designing polished, professional, unique applications using Claude Code without requiring design expertise.

**Last Updated:** 2026-01-28

---

## Table of Contents

1. [Core Philosophy: When to Design What](#core-philosophy-when-to-design-what)
2. [The Three-Phase Design System](#the-three-phase-design-system)
3. [Phase 1: Foundation (Do Once)](#phase-1-foundation-do-once)
4. [Phase 2: MVP Build (Fast)](#phase-2-mvp-build-fast)
5. [Phase 3: Polish (Make it 10x Better)](#phase-3-polish-make-it-10x-better)
6. [Claude Code Prompting Templates](#claude-code-prompting-templates)
7. [Animation Framework](#animation-framework)
8. [Icon System](#icon-system)
9. [Quality Checklist](#quality-checklist)
10. [Resources & Tools](#resources--tools)

---

## Core Philosophy: When to Design What

### The Critical Rule

**Design happens in THREE distinct phases, not all at once:**

```
PHASE 1: Foundation    →  PHASE 2: MVP Build    →  PHASE 3: Polish
(Do once for all apps)    (Ship fast, ugly OK)      (Make it feel 10x better)
4-8 hours one-time        Hours to days             2-4 hours per app
```

### Why This Matters

**Common Mistake:** Trying to design everything perfectly before shipping
- Result: Analysis paralysis, never ship, wasted time on features users don't want

**The Right Approach:**
1. Build functional MVP with basic foundation → Get user feedback
2. Add polish to features users actually use → Iterate based on real data
3. Only invest design time where it matters

---

## The Three-Phase Design System

### Phase 1: Foundation (Do Once for All Apps)

**WHEN:** Before you build your first app (or right now if you haven't done this)

**TIME INVESTMENT:** 4-8 hours (one time)

**WHAT YOU'RE CREATING:**
- Your brand design tokens (colors, typography, spacing)
- Tech stack setup
- Base tooling configuration
- Claude Code prompting templates

**OUTPUT:**
- A design tokens file you can reuse across ALL apps
- Standard Claude Code instructions that ensure consistency

**YOU ONLY DO THIS ONCE.** Every future app inherits these foundations.

---

### Phase 2: MVP Build (Ship Fast)

**WHEN:** Starting a new app/feature

**TIME INVESTMENT:** Hours to days (depends on complexity)

**DESIGN DECISIONS AT THIS PHASE:**

✅ **DO worry about:**
- Basic layout that makes sense
- Using your foundation design tokens
- Functional navigation
- Readable text
- Working buttons/forms

❌ **DON'T worry about:**
- Custom animations
- Perfect icon selection
- Custom illustrations
- Micro-interactions
- Making it "feel amazing"

**GOAL:** Ship something that WORKS so you can validate the idea with real users

**THE RULE:** If you don't have users yet, you're in Phase 2. Ship the MVP.

---

### Phase 3: Polish (Make it 10x Better)

**WHEN:** After you have users/feedback OR before a launch/demo where first impressions matter critically

**TIME INVESTMENT:** 2-4 hours per app

**DESIGN DECISIONS AT THIS PHASE:**

This is where you apply the "10x better" techniques:
- Custom animations (broken into sub-components)
- Icon consistency and selection
- Custom illustrations for personality
- Haptic feedback (mobile)
- Micro-interactions
- Empty state design
- Loading states

**THE RULE:** Only polish features that:
1. Users actually use (validated by data/feedback)
2. Are customer-facing (internal tools can stay at MVP level)
3. Impact conversion/retention (polish the pricing page before the settings page)

---

## Phase 1: Foundation (Do Once)

### Design Tokens Setup

Your design tokens are the DNA of your brand. Define these ONCE and use them in EVERY project.

#### Step 1: Choose Your Color Palette

**Tool:** [Coolors.co](https://coolors.co)

**Process:**
1. Go to Coolors.co
2. Hit spacebar to generate random palettes
3. Lock colors you like (click the lock icon)
4. Keep generating until you find your palette
5. Export as CSS or save the hex codes

**What You Need:**

```javascript
// YOUR BRAND COLORS (define these now)

Primary Color:
- Used for: Primary buttons, links, active states
- Shades needed: 50, 100, 200, 300, 400, 500, 600, 700, 800, 900
- Example: Blue (#0066CC)

Greys:
- Used for: Text, borders, backgrounds
- Shades needed: 50, 100, 200, 300, 400, 500, 600, 700, 800, 900
- Example: Neutral greys

Semantic Colors:
- Success: Green (#10B981)
- Error: Red (#EF4444)
- Warning: Yellow (#F59E0B)
- Info: Blue (#3B82F6)

Optional Accent:
- Used for: Secondary actions, highlights
- Only if you need visual variety
```

**Why Shades Matter:**
- Light buttons use primary-500
- Hover states use primary-600
- Text on colored backgrounds uses primary-700
- Borders use primary-300
- Backgrounds use primary-50

You can't just pick one blue - you need a SCALE of blues.

**Tool for Generating Shades:** [UIColors.app](https://uicolors.app/create)
- Enter your main color (e.g., #0066CC)
- It generates all the shades (50-900)
- Export to Tailwind

#### Step 2: Typography System

**Recommendation:** Keep it simple

**Fonts:**
- Option 1: Use ONE font for everything (Inter, System UI, or similar)
- Option 2: One for headings, one for body (max 2 total)

**Where to Get Fonts:**
- Google Fonts (free)
- System fonts (already installed, fast)

**Font Sizes:** Use a scale

```javascript
xs: 12px   // Small labels
sm: 14px   // Secondary text
base: 16px // Body text (DEFAULT)
lg: 18px   // Large body
xl: 20px   // Subheadings
2xl: 24px  // Small headings
3xl: 30px  // Medium headings
4xl: 36px  // Large headings
```

**The Rule:** Don't create custom sizes. Use this scale consistently.

#### Step 3: Spacing System

**The 8px Rule:** All spacing should be multiples of 8

```javascript
1: 8px    // Tight spacing (between related items)
2: 16px   // Standard spacing (most common)
3: 24px   // Medium spacing (between sections)
4: 32px   // Large spacing (major sections)
6: 48px   // Extra large spacing
8: 64px   // Maximum spacing
```

**Why This Matters:**
- Creates visual rhythm
- Makes everything feel more organized
- Easy to remember and apply consistently

#### Step 4: Create Your Design Tokens File

**Save this somewhere you can reference for ALL projects:**

```javascript
// design-tokens.js
// Created: [DATE]
// Use this for ALL Dereck Droid projects

export const designTokens = {
  colors: {
    primary: {
      50: '#E6F2FF',
      100: '#B3D9FF',
      // ... all shades ...
      500: '#0066CC', // Main brand color
      // ... rest of shades ...
    },
    grey: {
      50: '#F8F9FA',
      // ... all shades ...
    },
    success: '#10B981',
    error: '#EF4444',
    warning: '#F59E0B',
    info: '#3B82F6',
  },

  typography: {
    fonts: {
      primary: 'Inter, system-ui, sans-serif',
    },
    sizes: {
      xs: '12px',
      sm: '14px',
      base: '16px',
      lg: '18px',
      xl: '20px',
      '2xl': '24px',
      '3xl': '30px',
      '4xl': '36px',
    },
  },

  spacing: {
    1: '8px',
    2: '16px',
    3: '24px',
    4: '32px',
    6: '48px',
    8: '64px',
  },
}
```

**Where to Save This:**
1. In a `/design-tokens/` folder in your Business repo
2. As a note in your note-taking app
3. Anywhere you can copy-paste it into Claude Code prompts

---

### Tech Stack Configuration

**Your Standard Stack (for all projects):**

#### Web Apps:
- **Framework:** Next.js (React framework)
- **Styling:** Tailwind CSS
- **Components:** shadcn/ui
- **Deployment:** Vercel

#### Mobile Apps (when needed):
- **Framework:** React Native with Expo
- **Styling:** NativeWind (Tailwind for React Native)
- **Components:** gluestack-ui
- **Testing:** Expo Go app

**Why This Stack:**
- Claude Code knows these tools VERY well
- High AI compatibility
- Consistent syntax across web and mobile
- Large community support
- Free/affordable tooling

---

### Standard Claude Code Prompt Template (Foundation)

**Use this prompt when starting ANY new project:**

```
I'm building [APP NAME] - a [ONE SENTENCE DESCRIPTION].

TECH STACK:
- Use Next.js with TypeScript
- Use Tailwind CSS for all styling
- Use shadcn/ui components where applicable
- Deploy-ready for Vercel

DESIGN TOKENS (use these exact values):
[Paste your design tokens here]

DESIGN RULES:
1. Use ONLY the color values from design tokens above
2. Use spacing in 8px increments: 8px, 16px, 24px, 32px, 48px, 64px
3. Use the typography scale provided (no custom font sizes)
4. Mobile-first responsive design
5. Clean, minimal aesthetic - no over-design

BUILD APPROACH:
- Start with functional MVP (basic layout, working features)
- We'll add polish/animations AFTER the MVP works
- Focus on clarity and usability over complexity

First, please:
1. Confirm you understand the design tokens
2. Ask me any clarifying questions about the app's functionality
3. Propose a simple 3-5 screen structure for the MVP

Let's build.
```

**What This Does:**
- Sets expectations (Claude Code knows to keep it simple)
- Provides the constraints (colors, spacing, typography)
- Establishes the workflow (MVP first, polish later)
- Makes Claude Code ASK questions before building

---

## Phase 2: MVP Build (Fast)

### The Goal

Ship a functional app that proves the concept. Design should be "good enough" not "perfect."

### Claude Code Prompts for MVP Phase

**Starting the Build:**

```
We're in MVP phase. Build the core functionality with clean, simple UI.

Use shadcn/ui components for:
- Buttons
- Forms
- Cards
- Navigation

Keep layout simple:
- Single column mobile
- Standard navigation patterns
- Clear hierarchy (headlines, subheadings, body text)

Don't add:
- Custom animations (yet)
- Complex interactions
- Custom illustrations
- Anything that takes more than 5 minutes per component

Focus on: Does it work? Is it usable? Can I demo this?
```

### Design Decisions During MVP

**Claude Code should ASK you:**

1. **"What are the 3-5 core screens/pages for this app?"**
   - Forces you to scope down
   - Prevents feature creep

2. **"What's the primary user action?"**
   - Ensures the main feature is prominent

3. **"Are there any specific screen layouts you've seen that you like?"**
   - You can reference Mobbin screenshots or other apps

4. **"Do you have any brand assets (logo, images)?"**
   - If yes, incorporate; if no, use placeholders

**You should NOT be asked:**
- Detailed color choices (you have design tokens)
- Specific spacing values (8px rule)
- Font selections (already defined)
- Animation preferences (not in MVP phase)

### MVP Quality Bar

**Your app is ready to ship from Phase 2 when:**

✅ All core features work
✅ It's usable on mobile and desktop
✅ Text is readable
✅ Buttons/links are clickable and obvious
✅ Navigation makes sense
✅ No broken layouts

**You DON'T need:**
❌ Beautiful animations
❌ Custom icons perfectly selected
❌ Empty states designed
❌ Loading states polished
❌ Perfect visual hierarchy

### When to Move to Phase 3

**Move to Phase 3 (Polish) when ONE of these is true:**

1. **You have users and feedback** - you know what features matter
2. **You're about to launch publicly** - first impressions matter
3. **You're demoing to investors/customers** - polish sells
4. **The app is generating revenue** - worth investing more time

**DON'T move to Phase 3:**
- Before you've validated the idea
- While still figuring out features
- When you're the only user

---

## Phase 3: Polish (Make it 10x Better)

This is where you apply the techniques from the video to make your app feel 10x better than generic.

### The Four Pillars of Polish

1. **Animations & Interactions**
2. **Icon Consistency**
3. **Custom Illustrations**
4. **Haptic Feedback** (mobile only)

---

## Animation Framework

### The Core Principle

**DON'T ask Claude Code:**
❌ "Make this look better"
❌ "Add some nice animations"
❌ "Make it feel more polished"

**DO ask Claude Code:**
✅ Break down animations into sub-components
✅ Specify each part of the interaction
✅ Build iteratively, one animation at a time

### The Animation Technique (From Video)

**Example: Recording Button Animation**

**Bad Prompt:**
```
Make the recording button have a cool animation when clicked
```

**Good Prompt:**
```
When the user taps the record button, I want this sequence:

1. The send icon rotates 90 degrees clockwise and transforms into a checkmark
2. Simultaneously, a circular background expands outward from the microphone icon
3. The "Recording..." text fades in with a spring animation (bounce effect)
4. All of this should complete in 0.3 seconds total

Build this step by step:
- First, just the icon rotation
- Then, add the background expansion
- Finally, add the text fade-in with spring

Show me each step so I can approve before moving to the next.
```

**Why This Works:**
- Claude Code can build each piece independently
- You can see progress and adjust
- Each sub-animation is simple enough for AI to handle
- Result is complex, professional animation

### Animation Checklist

**Where to Add Animations:**

✅ **High-value areas:**
- Primary user actions (submit forms, save data, record, etc.)
- State changes (tab switching, mode toggling)
- Success/error feedback
- Loading states

❌ **Don't animate:**
- Every single button
- Subtle hovers (keep those simple)
- Decorative elements
- Things that happen frequently (will get annoying)

### Standard Animation Patterns

**Use these as templates with Claude Code:**

#### 1. Button Click Feedback
```
When button is clicked:
1. Scale down to 0.95 (feels like it's being pressed)
2. Slight background color shift (darker)
3. Scale back to 1.0
Duration: 0.1 seconds
```

#### 2. Tab Switching
```
When switching tabs:
1. Current content fades out (opacity 1 → 0) over 0.15s
2. New content slides in from right and fades in (opacity 0 → 1) over 0.15s
3. Tab indicator (underline/highlight) smoothly transitions to new position over 0.2s
```

#### 3. Success Confirmation
```
When action succeeds:
1. Checkmark icon scales from 0 to 1.2 (overshoot)
2. Then settles back to 1.0 (spring animation)
3. Green background circle expands from behind the icon
4. Success text fades in below
Total duration: 0.4s
```

#### 4. Form Submission
```
When form is submitted:
1. Submit button shows loading spinner (replacing text)
2. Form fields fade to 50% opacity (disabled state)
3. On success: Form fades out, success message fades in
4. On error: Fields shake horizontally 3 times, error message appears in red
```

### Prompting Template for Animations

**Use this structure:**

```
I want to add animation to [COMPONENT NAME] for [USER ACTION].

The sequence should be:
1. [First thing that happens] over [duration]
2. [Second thing] over [duration]
3. [Third thing] over [duration]

Animation style:
- Type: [spring/ease/linear]
- Total duration: [X seconds]
- Should feel: [smooth/bouncy/snappy]

Reference: [Link to video/example if you have one]

Build this step-by-step. Show me just step 1 first.
```

---

## Icon System

### The Rules (From Video)

**Rule #1: Pick ONE style and stay consistent**

Icon styles:
- **Thin/Light:** Minimal, clean, modern (e.g., Hero Icons thin)
- **Heavy/Bold:** Strong, clear, attention-grabbing
- **Filled:** Solid shapes, high contrast

**Don't mix styles.** Mixing thin and heavy icons in the same interface looks unprofessional.

**Rule #2: Use weight variation for STATES, not variety**

✅ **Good use of multiple weights:**
- Unselected tab: Thin icon
- Selected tab: Filled/heavy version of SAME icon
- Creates visual hierarchy for state changes

❌ **Bad use of multiple weights:**
- Random mixing of thin and heavy icons across the interface
- Different styles for different features
- "This icon looks better heavy, this one looks better thin"

### Icon Selection Process

**For Each New App:**

**Step 1: Choose Your Icon Pack**

Recommended packs:
- **Hero Icons** (free) - Clean, professional, versatile
  - Thin version: Modern, minimal apps
  - Heavy version: Bold, clear apps
- **Lucide Icons** (free) - Similar to Hero Icons, slightly different aesthetic
- **SF Symbols** (iOS only) - Native iOS look

**How to choose:**
1. Go to [Mobbin.com](https://mobbin.com)
2. Search for apps similar to yours
3. Screenshot examples you like
4. Identify what icon style they're using
5. Pick ONE pack that matches that aesthetic

**Step 2: Define State Variations**

```
For this app, icons will use:

Default state: [Hero Icons - thin]
Selected/Active state: [Hero Icons - filled]
Disabled state: [Hero Icons - thin at 40% opacity]

This applies to:
- Navigation (bottom tabs, sidebar)
- Action buttons
- Status indicators
```

**Step 3: Prompt Claude Code**

```
For all icons in this app:
- Use Hero Icons (thin version)
- For selected/active states, use the filled version of the same icon
- Maintain consistent sizing: 24px for navigation, 20px for buttons, 16px for inline
- Color: Use grey-600 for inactive, primary-500 for active

Apply this consistently across all components.
```

### Icon Consistency Checklist

Before shipping Phase 3 polish:

✅ All icons are from the same pack
✅ Icon weights are consistent (thin vs heavy used purposefully)
✅ Active/inactive states use the same icon in different weights
✅ Icon sizes follow a consistent scale (16px, 20px, 24px, etc.)
✅ No mixing of icon styles (outlined + filled randomly)

---

## Custom Illustrations

### Purpose

Custom illustrations add **personality** and make each app feel unique.

**Use cases:**
- Empty states ("No data yet")
- Error pages (404, 500)
- Onboarding screens
- Success confirmations
- About/intro sections

### The Strategy

**Option 1: Commission a Base Mascot**

1. Hire an illustrator (Fiverr, Upwork) to create ONE base mascot/character
2. Budget: $100-300 for a simple character in 2-3 poses
3. Use that as the foundation

**Option 2: Use AI with Reference Images**

1. Use ChatGPT, Midjourney, or similar
2. Feed it reference images of styles you like
3. Generate variations for different states

### Using ChatGPT for Illustration Variations

**Prompt Template:**

```
I have a base mascot character for my app [APP NAME].

[Attach your base mascot image]

I need variations of this character for different app states:

1. Empty state: Character searching with a magnifying glass
2. Loading state: Character reading a book
3. Error state: Character looking confused
4. Success state: Character celebrating

Keep the same style, colors, and proportions. Generate these as simple, clean illustrations suitable for a modern app interface.
```

**The Key:** Start with ONE base illustration (commissioned or AI-generated), then create variations

### When to Use Custom Illustrations

**DO use for:**
✅ Empty states (high impact, users see this often)
✅ Onboarding (sets the tone)
✅ Error pages (turns frustration into delight)

**DON'T use for:**
❌ Every single screen (overwhelming)
❌ Decorative purposes only (unless it reinforces brand)
❌ Complex illustrations that don't fit the app aesthetic

### Implementation with Claude Code

```
I have custom illustrations for empty states.

[Attach or link to illustrations]

Implement these in the following screens:
- Dashboard empty state: Use "searching" illustration
- No results found: Use "confused" illustration
- Success confirmation: Use "celebrating" illustration

Ensure illustrations are:
- Centered on the page
- Max width 300px on mobile, 400px on desktop
- Accompanied by friendly text below
- Properly optimized (compressed, appropriate format)
```

---

## Haptic Feedback (Mobile Only)

### The Concept

Haptic feedback = phone vibrates slightly when user interacts with the app

**Why it matters:**
- Adds physicality to digital interactions
- Makes the app more satisfying to use
- Creates a premium feel

### Haptic Levels

iOS supports different haptic intensities:

- **Light:** Subtle, barely noticeable
- **Medium:** Noticeable but not strong
- **Heavy:** Strong, clear feedback

### When to Use Each Level

**Light Haptics:**
- Frequent interactions (typing, scrolling through lists)
- Minor state changes (highlighting a row)
- Subtle confirmations

**Medium Haptics:**
- Button clicks
- Toggle switches
- Tab changes
- Pull-to-refresh

**Heavy Haptics:**
- Major actions (submit form, complete purchase)
- Important state changes (mode switching)
- Error alerts
- Success confirmations

### Prompting Claude Code for Haptics

```
Add haptic feedback to this React Native app using Expo's Haptics API.

Haptic levels:
- Light: List item selections, minor interactions
- Medium: Button clicks, tab switches
- Heavy: Form submissions, important confirmations

Implement haptics for:
1. Bottom tab navigation (medium)
2. Primary action buttons (medium)
3. Form submission (heavy on success, heavy on error)
4. Pull-to-refresh (light when pulled, medium when released)

Ensure haptics only trigger on iOS devices (Android handles this differently).
```

### Haptic Guidelines

✅ **DO:**
- Use consistently (all buttons have haptics or none do)
- Match intensity to action importance
- Test on real device (haptics can't be felt in simulator)

❌ **DON'T:**
- Overuse (every tiny interaction doesn't need haptics)
- Mix random intensities (heavy for small actions, light for important ones)
- Add haptics without testing (can feel wrong if not calibrated)

---

## Claude Code Prompting Templates

### Template 1: Starting a New Project (Phase 1)

```
I'm building [APP NAME] - [ONE SENTENCE DESCRIPTION].

CONTEXT:
- Target users: [WHO]
- Main problem it solves: [WHAT]
- Key features: [LIST 3-5]

TECH STACK:
- Next.js + TypeScript
- Tailwind CSS + shadcn/ui
- Deployment: Vercel

DESIGN TOKENS:
[Paste your full design tokens]

PHASE: MVP (Phase 2)
- Focus on functionality first
- Clean, simple UI using shadcn/ui components
- No custom animations yet
- Mobile-responsive

Before you start building, please:
1. Confirm you understand the design constraints
2. Propose a simple page structure (3-5 main screens)
3. Ask any clarifying questions about functionality
4. Identify which shadcn/ui components we should use

Let's build this step by step.
```

### Template 2: Adding Animation (Phase 3)

```
I want to add animation to [SPECIFIC COMPONENT/INTERACTION].

CURRENT STATE:
[Describe what happens now]

DESIRED ANIMATION:
When [USER ACTION]:
1. [First animation] over [duration]
2. [Second animation] over [duration]
3. [Final state]

STYLE:
- Animation type: [spring/ease-in-out/linear]
- Should feel: [smooth/bouncy/snappy]
- Total duration: [X seconds]

APPROACH:
Build this incrementally:
1. Show me just the first animation
2. Once approved, add the second
3. Then combine and refine

Reference: [Link to example if you have one]
```

### Template 3: Icon Consistency Pass (Phase 3)

```
We need to ensure icon consistency across the app.

ICON SYSTEM:
- Pack: [Hero Icons / Lucide / SF Symbols]
- Default style: [thin/regular/bold]
- Active state style: [filled/bold version]
- Sizing: 24px navigation, 20px buttons, 16px inline

AUDIT:
1. List all icons currently in the app
2. Identify any inconsistencies (mixed packs, sizes, styles)
3. Propose replacements to achieve consistency

THEN:
Replace all icons with consistent versions following the system above.
```

### Template 4: Empty State Design (Phase 3)

```
Design empty states for the following screens:

SCREENS WITH NO DATA:
1. [Screen name] - When [condition]
2. [Screen name] - When [condition]

FOR EACH EMPTY STATE:
- Custom illustration: [Yes/No - if yes, describe or attach]
- Headline: [Friendly, helpful text]
- Subtext: [Explain what they can do]
- CTA button: [If applicable]

STYLE:
- Centered on page
- Illustration max-width: 300px mobile, 400px desktop
- Text below illustration
- Use grey-600 for text, primary color for CTA

Make these feel friendly and helpful, not like errors.
```

### Template 5: Polish Pass (Phase 3)

```
We're moving from MVP to polished product.

CURRENT STATE: Functional app, basic UI
TARGET STATE: 10x better feel

POLISH TASKS:
1. Animation pass:
   - [List specific interactions that should animate]
   - Use the animation framework we've established

2. Icon consistency:
   - Audit all icons
   - Ensure consistent pack and sizing

3. Empty states:
   - Add custom illustrations or friendly text
   - [List screens that need empty state design]

4. Micro-interactions:
   - Button hover/click feedback
   - Loading states
   - Success/error feedback

5. Visual hierarchy:
   - Ensure headlines/subheadings/body text are clearly differentiated
   - Use color sparingly for emphasis

Approach this systematically. Complete task 1, show me for review, then move to task 2.
```

---

## Quality Checklist

### Before Shipping (Any Phase)

**Functionality:**
✅ All features work as expected
✅ No console errors
✅ Forms validate properly
✅ Navigation works on all screen sizes

**Responsiveness:**
✅ Mobile layout (320px - 768px)
✅ Tablet layout (768px - 1024px)
✅ Desktop layout (1024px+)
✅ No horizontal scroll
✅ Touch targets minimum 44px (mobile)

**Design Tokens Applied:**
✅ Only using colors from design tokens
✅ Spacing follows 8px grid
✅ Typography uses defined scale
✅ Consistent button styles

### Before Shipping (Phase 3 - Polished App)

**Animations:**
✅ Key interactions have smooth animations
✅ No janky/broken animations
✅ Animations complete in reasonable time (<0.5s for most)
✅ Nothing animates that shouldn't

**Icons:**
✅ All from the same pack
✅ Consistent sizing
✅ Active/inactive states use weight variation
✅ No mixed styles

**Empty States:**
✅ All "no data" screens have friendly empty states
✅ Custom illustrations or helpful text
✅ Clear call-to-action where applicable

**Micro-interactions:**
✅ Buttons have click feedback
✅ Loading states are clear
✅ Success/error messages are obvious
✅ Haptics implemented (mobile only)

**Visual Hierarchy:**
✅ Headlines clearly stand out
✅ Important actions are prominent
✅ Supporting text is visually secondary
✅ Color used purposefully, not randomly

---

## Resources & Tools

### Design Tools

**Color Palettes:**
- [Coolors.co](https://coolors.co) - Generate color palettes (FREE)
- [UIColors.app](https://uicolors.app/create) - Generate shade scales from one color (FREE)
- [PaletteMaker.com](https://palettemaker.com) - Preview palettes on real UIs (FREE)

**Component Generation:**
- [v0.dev](https://v0.dev) - AI component generator from Vercel (200 free credits/month)

**Icon Packs:**
- [Hero Icons](https://heroicons.com) - Free, clean, professional
- [Lucide Icons](https://lucide.dev) - Free, similar to Hero Icons
- [SF Symbols](https://developer.apple.com/sf-symbols/) - Apple's icon set (iOS only)

**Inspiration:**
- [Mobbin.com](https://mobbin.com) - Library of real app designs (FREE tier available)
- [Dribbble.com](https://dribbble.com) - Design inspiration (study elements, don't copy)

**Fonts:**
- [Google Fonts](https://fonts.google.com) - Free fonts
- Recommendation: Inter, Work Sans, or use system fonts

**Illustrations:**
- [ChatGPT](https://chat.openai.com) - Generate custom illustrations with DALL-E
- [Midjourney](https://midjourney.com) - High-quality AI illustrations
- [Fiverr](https://fiverr.com) - Commission custom mascots ($100-300)

### Learning Resources

**Refactoring UI:**
- Book + video course on UI design for developers
- Cost: $99
- Highest ROI design resource for non-designers

**Tailwind CSS Docs:**
- [tailwindcss.com](https://tailwindcss.com)
- Excellent documentation and examples

**shadcn/ui:**
- [ui.shadcn.com](https://ui.shadcn.com)
- Browse components, see code, copy-paste

### Workflow Tools

**Development:**
- Claude Code - AI coding assistant
- GitHub - Version control
- Vercel - Hosting and deployment

**Mobile:**
- Expo Go app - Test React Native apps instantly
- TestFlight (iOS) - Beta testing
- Google Play Console (Android) - Beta testing

---

## Decision Framework: When to Use What

### MVP vs Polish Decision Tree

```
START: Do I have users using this feature?
│
├─ NO → Build MVP (Phase 2)
│   └─ Ship fast, gather feedback
│
└─ YES → Is this feature used frequently?
    │
    ├─ NO → Keep as MVP
    │   └─ Don't polish features no one uses
    │
    └─ YES → Does polish impact conversion/retention?
        │
        ├─ NO → Keep as MVP (internal tools, settings pages)
        │
        └─ YES → Apply Phase 3 polish
            └─ Animations, icons, illustrations, micro-interactions
```

### Animation Priority Decision

```
Should this interaction be animated?

1. Is it a primary user action? (YES → Animate)
2. Does it signal an important state change? (YES → Animate)
3. Would animation help user understanding? (YES → Animate)
4. Is it a rare, high-stakes action? (YES → Animate heavily)
5. Is it a frequent, low-stakes action? (YES → Animate subtly)

If all answers are NO → Don't animate
```

### Custom Illustration Priority

```
Should this screen have a custom illustration?

1. Is it an empty state users see often? (YES → Illustrate)
2. Is it an error that's frustrating? (YES → Illustrate to soften)
3. Is it onboarding/first impression? (YES → Illustrate)
4. Is it a success moment? (YES → Illustrate to celebrate)

If all answers are NO → Use text-only empty state
```

---

## Appendix: Example Workflows

### Example 1: Building a New App from Scratch

**Week 1: Foundation (if not done already)**
- [ ] Pick color palette (Coolors.co)
- [ ] Generate shade scales (UIColors.app)
- [ ] Save design tokens file
- [ ] Test tokens with Claude Code on a single page

**Week 2-3: MVP Build**
- [ ] Define 3-5 core screens
- [ ] Use Claude Code with MVP prompt template
- [ ] Build functionality with shadcn/ui components
- [ ] Test on mobile and desktop
- [ ] Ship to users or testers

**Week 4: Gather Feedback**
- [ ] Watch users interact
- [ ] Note pain points
- [ ] Identify most-used features

**Week 5: Polish (Phase 3)**
- [ ] Apply animation to top 3 user actions
- [ ] Icon consistency pass
- [ ] Design empty states for common scenarios
- [ ] Add haptics (mobile)
- [ ] Final visual hierarchy review

**Week 6: Ship Polished Version**

### Example 2: Polishing an Existing MVP

**Current State:** Working app, users are using it, but it feels generic

**Step 1: Audit (1 hour)**
- [ ] Screenshot every screen
- [ ] Identify which features are used most (analytics/feedback)
- [ ] List top 5 interactions that need animation
- [ ] Note all empty states
- [ ] Audit icon consistency

**Step 2: Prioritize (30 minutes)**
- [ ] Focus polish on most-used features
- [ ] Defer polish on rarely-used sections

**Step 3: Execute (4-8 hours)**
- [ ] Animation pass (2-3 hours)
  - Use animation prompting templates
  - Build iteratively, one animation at a time

- [ ] Icon consistency (1 hour)
  - Pick ONE icon pack
  - Replace all icons systematically

- [ ] Empty states (1-2 hours)
  - Design or generate illustrations
  - Implement with Claude Code

- [ ] Micro-interactions (1-2 hours)
  - Button feedback
  - Loading states
  - Success/error messages

**Step 4: Test & Ship**
- [ ] Test animations on real devices
- [ ] Get feedback from 2-3 users
- [ ] Iterate if needed
- [ ] Ship

---

## Notes & Updates

**Version History:**
- v1.0 (2026-01-28): Initial protocol created

**Future Additions:**
- Accessibility checklist
- Performance optimization
- A/B testing framework
- Design system evolution strategy

**Questions to Address:**
- When to hire a designer vs DIY
- Budget allocation for design resources
- Managing design across multiple products

---

**End of Protocol**
