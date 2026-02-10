# Advanced Lead Solutions - Claude Code Entry Point

**Owner:** Dereck Johnson | **Location:** South Carolina | **Business:** AI automation consultancy

## How to Start Every Session

1. Read `dashboard.md` -- this is the single source of truth for finances, pipeline, and priorities
2. Ask Dereck: "What's on your mind today?" or "Any updates since last session?"
3. Update `dashboard.md` with anything that changed
4. Work on whatever matters most today

## Repository Structure

```
/Business/
├── CLAUDE.md          ← You are here (session entry point)
├── README.md          ← Repo overview
├── dashboard.md       ← SINGLE SOURCE OF TRUTH (finances, pipeline, priorities)
├── backlog.md         ← Product ideas & deferred tasks
│
├── company/           ← Evergreen business identity
│   ├── identity.md
│   ├── personality-profile.md
│   └── background.md
│
├── services/          ← What we sell and how
│   ├── offerings.md
│   ├── pricing.md
│   └── delivery.md
│
├── pipeline/          ← One file per active opportunity
│   ├── 365-digital.md
│   ├── ramp-manufacturing.md
│   ├── lead-supercharger.md
│   ├── ben-equitypro.md
│   ├── fraser-roofing.md
│   └── dc-australia.md
│
├── projects/          ← Product and app documentation
│   ├── prayer-board-app.md
│   ├── elimination-diet-app.md
│   ├── vegan-spots-app.md
│   └── good-bananas-app.md
│
├── communications/    ← Meeting transcripts, quotes, follow-ups
│   ├── transcripts/
│   ├── quotes/
│   └── follow-ups/
│
└── archive/           ← Historical reference (don't read unless asked)
```

## Key Rules

1. **One source of truth.** Financial data, pipeline status, and priorities live ONLY in `dashboard.md`. Do not duplicate this information into other files.
2. **Update, don't append.** When something changes, update the existing entry in `dashboard.md`. Don't create new files for status updates.
3. **Pipeline files are context, not status.** Each file in `pipeline/` has history, analysis, and context for a deal. The *current status* of that deal is in `dashboard.md`.
4. **No temporal files at root.** Don't create action-item lists, weekend plans, session summaries, or dated files at the repo root. If it has a date in the name, it belongs in `archive/` or `communications/`.
5. **Keep it lean.** Before creating a new file, ask: does this information already have a home?

## Working With Dereck

**Personality:** ENFP + Wonder/Discernment genius + Tenacity frustration

- He thrives on vision, strategy, and relationships -- keep him there
- He struggles with execution and follow-through -- provide structure
- He generates many ideas -- capture them in `backlog.md`, don't let them derail today's priority
- He responds well to clear, ranked priorities -- give him a top 3, not a list of 15
- Trust his gut on deals -- his Discernment is rarely wrong
- Don't over-systematize -- the system should be simple enough that it actually gets used

## Updating the Dashboard

When Dereck reports a change (cash received, deal closed, meeting happened, etc.):

1. Update the relevant section in `dashboard.md`
2. Update the corresponding `pipeline/` file if it's a deal change
3. Update the `Last Updated` timestamp
4. That's it. Don't cascade updates to other files.
