# Claude Code Quick Reference Card
**Copy-paste these prompts into Claude Code sessions**

---

## 🚀 Starting a New Project (Phase 2: MVP)

```
I'm building [APP NAME] - [ONE SENTENCE DESCRIPTION].

TECH STACK:
- Next.js + TypeScript
- Tailwind CSS + shadcn/ui
- Vercel deployment

DESIGN TOKENS - Use these EXACT values:
Colors:
  Primary: [Your main color]
  Grey scale: [Your greys]
  Success: #10B981
  Error: #EF4444
  Warning: #F59E0B

Spacing: Only use 8px increments (8, 16, 24, 32, 48, 64)
Typography: [Your font] with sizes: 12, 14, 16, 18, 20, 24, 30, 36px

PHASE: MVP - Build fast
- Use shadcn/ui components
- Clean, simple layouts
- Mobile-responsive
- NO custom animations yet
- Focus on functionality

Before building:
1. Confirm you understand the design constraints
2. Propose a 3-5 screen structure
3. Ask clarifying questions about functionality
4. Tell me which shadcn/ui components you'll use

Let's build step by step.
```

---

## ✨ Adding Animation (Phase 3: Polish)

```
Add animation to [COMPONENT NAME] when [USER ACTION].

SEQUENCE:
1. [First animation] - [duration] - [effect]
2. [Second animation] - [duration] - [effect]
3. [Third animation] - [duration] - [effect]

STYLE:
- Animation type: [spring/ease-in-out/linear]
- Should feel: [smooth/bouncy/snappy]
- Total duration: [X seconds]

BUILD INCREMENTALLY:
- Show me step 1 first
- After I approve, add step 2
- Then combine and refine

Example: "When user clicks submit:
1. Button scales down to 0.95 - 0.1s - feels pressed
2. Background color darkens slightly - 0.1s - visual feedback
3. Spinner appears, button text fades out - 0.2s - loading state"
```

---

## 🎨 Icon Consistency Check (Phase 3)

```
Audit icons for consistency.

ICON SYSTEM:
- Pack: [Hero Icons / Lucide / SF Symbols]
- Default: [thin/regular/bold] version
- Active state: [filled/bold] version
- Sizes: 24px nav, 20px buttons, 16px inline

TASKS:
1. List ALL icons currently in the app
2. Identify inconsistencies (mixed packs, wrong sizes)
3. Replace with consistent versions

Apply uniformly across entire app.
```

---

## 🖼️ Empty State Design (Phase 3)

```
Design empty states for:

SCREENS:
- [Screen name]: When [no data condition]
- [Screen name]: When [no data condition]

FOR EACH:
- Custom illustration: [Yes - describe / No - text only]
- Headline: [Friendly text explaining state]
- Subtext: [What user can do]
- CTA: [Button if applicable]

STYLE:
- Centered layout
- Illustration max-width: 300px mobile, 400px desktop
- grey-600 text color
- Primary color for CTA buttons
- Friendly tone, not error-like
```

---

## 🔍 Phase 3 Polish Pass (Full)

```
Moving from MVP to polished product.

POLISH CHECKLIST:

1. ANIMATIONS:
   - [List top 5 interactions to animate]
   - Use spring animations for satisfying feel
   - Build each animation incrementally

2. ICON CONSISTENCY:
   - All icons from [Pack name]
   - [Style] for default, [Style] for active
   - Consistent sizing throughout

3. EMPTY STATES:
   - [List screens needing empty state design]
   - Use custom illustrations or friendly text
   - Include clear CTAs

4. MICRO-INTERACTIONS:
   - Button hover/click feedback (scale + color shift)
   - Loading spinners for async actions
   - Success/error toasts with icons
   - Smooth transitions between states

5. VISUAL HIERARCHY:
   - Headlines clearly differentiated (size + weight)
   - Body text readable (grey-700)
   - Color used sparingly for emphasis
   - Consistent spacing (8px grid)

Complete systematically. Show me each task for review before next.
```

---

## 🔧 Design Tokens Template

**Save this and reference in every project:**

```javascript
// Design Tokens - [Your Brand Name]
// Use for ALL projects

colors: {
  primary: {
    500: '#[YOUR COLOR]',  // Main brand color
    // Add other shades: 50, 100, 200...900
  },
  grey: {
    50: '#F8F9FA',
    600: '#6B7280',
    700: '#374151',
    900: '#111827',
    // Add full scale
  },
  success: '#10B981',
  error: '#EF4444',
  warning: '#F59E0B',
  info: '#3B82F6',
}

spacing: {
  1: '8px',
  2: '16px',
  3: '24px',
  4: '32px',
  6: '48px',
  8: '64px',
}

typography: {
  font: '[Your Font], system-ui, sans-serif',
  sizes: {
    xs: '12px',
    sm: '14px',
    base: '16px',
    lg: '18px',
    xl: '20px',
    '2xl': '24px',
    '3xl': '30px',
    '4xl': '36px',
  }
}
```

---

## 📱 Haptic Feedback (Mobile Only)

```
Add haptic feedback using Expo Haptics API.

LEVELS:
- Light: Frequent interactions (list selections)
- Medium: Button clicks, tab changes
- Heavy: Important actions (form submit, confirmations)

IMPLEMENT FOR:
- Bottom tabs: Medium
- Primary buttons: Medium
- Form submission: Heavy (success), Heavy (error)
- Toggle switches: Light

iOS only - check platform before triggering.
```

---

## ❓ Smart Questions Claude Code Should Ask

**When you start a project, Claude Code should ask:**

1. "What are the 3-5 core screens/pages?"
   - Forces scope definition

2. "What's the primary user action?"
   - Ensures main feature is prominent

3. "Are there similar apps you like the design of?"
   - Reference for layout/patterns

4. "Do you have brand assets (logo, colors)?"
   - Use existing brand or create new

5. "Are we building MVP (fast) or polished (animations, custom design)?"
   - Sets expectations for detail level

**If Claude Code doesn't ask these, prompt it:**
"Before you build, ask me the key questions from the UI Design Protocol."

---

## 🎯 Phase Decision Framework

**Use this to decide MVP vs Polish:**

```
Do you have users using this feature?
│
├─ NO → Build MVP (Phase 2)
│   └─ Ship fast, no animations, basic design
│
└─ YES → Is this feature used frequently?
    │
    ├─ NO → Keep as MVP
    │
    └─ YES → Does polish impact conversion/retention?
        │
        ├─ NO → Keep as MVP
        │
        └─ YES → Apply Phase 3 polish
            └─ Animations + icons + illustrations
```

**Translation:**
- No users yet? → MVP
- Internal tools? → MVP
- Public-facing, revenue-impacting? → Polish
- User-tested, high-usage? → Polish

---

## 🛠️ Resources Quick Links

**Colors:**
- Coolors.co - Generate palettes
- UIColors.app - Generate shades from one color

**Components:**
- v0.dev - AI component generator
- ui.shadcn.com - Browse shadcn/ui components

**Icons:**
- heroicons.com - Free, professional icons
- lucide.dev - Alternative icon pack

**Inspiration:**
- mobbin.com - Real app designs
- dribbble.com - Design examples (study, don't copy)

**Fonts:**
- fonts.google.com - Free web fonts
- Recommendation: Inter or system fonts

**Illustrations:**
- ChatGPT (DALL-E) - Generate custom illustrations
- Fiverr - Commission mascots ($100-300)

---

## 📋 Pre-Ship Checklist

**Before deploying ANY version:**

✅ **Functionality**
- All features work
- Forms validate
- Navigation works
- No console errors

✅ **Responsive**
- Mobile (320-768px)
- Tablet (768-1024px)
- Desktop (1024px+)
- No horizontal scroll
- Touch targets 44px+ (mobile)

✅ **Design Tokens Applied**
- Only using token colors
- 8px spacing grid
- Typography scale followed
- Consistent button styles

**Additional for Phase 3 (Polished):**

✅ **Animations** - Smooth, complete in <0.5s
✅ **Icons** - All same pack, consistent sizing
✅ **Empty States** - Friendly text/illustrations
✅ **Micro-interactions** - Click feedback, loading states
✅ **Hierarchy** - Headlines stand out, color used purposefully

---

**Full protocol:** See `/Business/UI-DESIGN-PROTOCOL.md`
