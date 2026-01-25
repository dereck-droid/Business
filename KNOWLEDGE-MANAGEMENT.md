# Knowledge Management Protocol

**Purpose:** Ensure all documents in this repository are discoverable, contextual, and properly integrated

**Audience:** Claude Code sessions, future team members, and any AI agents working in this repository

**Last Updated:** January 24, 2026

---

## Core Principle

> **Every new file must be integrated, not just created.**

When you create a new document, you're not just adding information—you're adding a node to a knowledge graph. That node must be connected, discoverable, and contextual.

---

## Protocol: Adding New Files to the Repository

### STEP 1: Determine if a New File is Needed

**Create a new file if:**
- ✅ The content serves a distinct purpose not covered by existing files
- ✅ The content will be referenced independently (not just part of another doc)
- ✅ The content is substantial enough to warrant separation (>50 lines typically)
- ✅ The content has its own lifecycle (will be updated independently)

**Update an existing file if:**
- ❌ The content is an extension of an existing topic
- ❌ The content is a minor addition or clarification
- ❌ Creating a new file would fragment related information
- ❌ The existing file is under 200 lines and not yet complex

---

### STEP 2: Choose the Correct Location

Follow the repository structure:

```
/Business/
├── ROOT LEVEL FILES
│   ├── README.md (Repository guide - update for major structural changes)
│   ├── FOCUS.md (Daily priorities - updated DAILY)
│   ├── SYSTEM-REQUIREMENTS.md (Dependencies & maintenance protocols - READ THIS)
│   ├── KNOWLEDGE-MANAGEMENT.md (This file - protocol for adding/managing docs)
│   └── backlog.md (Dynamic task list)
│
├── /metrics/ (Financial & Performance Data)
│   └── Use for: Cash flow, revenue tracking, KPIs, financial snapshots
│
├── /opportunities/ (Active Pipeline & Deals)
│   └── Use for: Prospect tracking, deal research, technical planning for opportunities
│
├── /communications/ (Communication Log - CRITICAL FOR CONTEXT)
│   ├── /quotes/ (All quotes sent to prospects)
│   ├── /emails/ (Important email threads)
│   ├── /transcripts/ (Meeting recordings/notes)
│   └── /follow-ups/ (Follow-up messages)
│   └── Use for: ALL client/prospect communications (prevents lost context)
│
├── /company/ (Business Identity)
│   └── Use for: Mission, values, personality, background, team info
│
├── /services/ (Service Catalog)
│   └── Use for: Offerings, pricing, delivery methods, case studies
│
├── /detailed-context/ (Deep Dives)
│   ├── /prospects/ (Individual prospect files)
│   ├── /projects/ (Active project documentation)
│   └── /clients/ (Client-specific context)
│
├── /tools/ (Scripts & Utilities)
│   └── Use for: Automation scripts, helper tools, templates
│
└── /archive/ (Completed/Inactive)
    └── Use for: Closed deals, completed projects, deprecated docs
```

**Naming conventions:**
- Use lowercase with hyphens: `lead-supercharger-research.md`
- Be descriptive: `financial-snapshot.md` not `finances.md`
- Include context when needed: `lead-supercharger-technical-notes.md` not `technical-notes.md`

**Special naming for /communications/:**
- Format: `YYYY-MM-DD-[prospect-name]-[type].md`
- Examples: `2026-01-23-retarget-iq-quote.md`, `2026-01-19-dc-meeting-transcript.md`
- Why: Chronological sorting, easy searchability, date-aware context

---

### STEP 3: Create File with Required Metadata

**Every new file must include:**

```markdown
# [Document Title]

**Date:** YYYY-MM-DD (creation date)
**Status:** [Draft | In Progress | Complete | Archived]
**Purpose:** One sentence explaining what this document is for
[Add other relevant metadata: Owner, Last Updated, Related Project, etc.]

---

## Related Documents

List all documents that are directly related to this one:
- **[Related Doc 1](./path/to/doc.md)** - Brief description of relationship
- **[Related Doc 2](./path/to/doc.md)** - Brief description of relationship

**This document:** [Brief statement of this document's unique role]

---

[Rest of content...]
```

---

### STEP 4: Integration Checklist

After creating a new file, **YOU MUST complete this checklist:**

#### ☐ **Cross-Reference Related Documents**
- Add "Related Documents" section to new file
- Update related files to reference the new file
- Ensure bi-directional linking (if A links to B, B should link to A)

#### ☐ **Update Index Files (if applicable)**
Update these files **only if the new document is significant enough to warrant top-level awareness:**

**README.md** - Update if:
- New document changes the repository structure
- New document represents a major category/section
- New document is critical for understanding the business

**FOCUS.md** - Update if:
- New document relates to active priorities
- New document affects current decision-making

**Prospect Tracker** (`opportunities/prospect-tracker.md`) - Update if:
- New document is about an active opportunity

**Backlog** (`backlog.md`) - Update if:
- New document creates or closes tasks

#### ☐ **Verify Discoverability**
Ask: "If someone were looking for this information, would they find it?"
- Is it linked from at least one high-traffic document?
- Is it in the right folder?
- Is the filename descriptive enough?

#### ☐ **Test Mental Model**
Imagine you're a new Claude session. Read the new file. Can you answer:
- What is this document for?
- Why was it created?
- How does it relate to other documents?
- When should it be updated?

If you can't answer these clearly, add more context.

---

## Document Lifecycle Management

### When to Update Existing Files

**Update immediately when:**
- Status changes (e.g., "In Progress" → "Complete")
- Decisions are made that invalidate previous content
- New information makes previous sections obsolete
- Cross-references break (linked files are moved/renamed)

**Review periodically:**
- Financial data: Weekly
- Active opportunities: As status changes
- Strategic documents: Monthly
- Background/identity: Quarterly or as needed

### When to Archive Files

**Move to `/archive/` when:**
- Project is completed
- Opportunity is closed (won or lost)
- Document is no longer relevant to active work
- Information is historical but worth keeping

**Archive process:**
1. Move file to `/archive/[category]/`
2. Update cross-references to reflect archived status
3. Remove from active index files (README, FOCUS, etc.)
4. Add "Archived" status and archive date to metadata

---

## Common Document Types & Templates

### Communication Logs (CRITICAL - Added Jan 24, 2026)

**Use for:** ALL quotes, meeting transcripts, email threads, and follow-ups

**Why This Matters:**
- Prevents "What did I quote them?" confusion
- Keeps AI agents informed of current status
- Eliminates stale data causing bad recommendations
- Creates paper trail for all prospect interactions

**Template for Quotes:**
```markdown
# [Prospect Name] - [Project] Quote

**Date:** YYYY-MM-DD
**Prospect:** [Name/Company]
**Type:** [Quote/Proposal]
**Status:** [Pending/Accepted/Declined]
**Amount:** $X,XXX
**Payment Terms:** [Terms]

---

## Related Documents
- [Prospect Details](../../opportunities/prospect-tracker.md)
- [Meeting Transcript](../transcripts/YYYY-MM-DD-[name]-meeting.md) (if applicable)

---

## Quote Details
[Full quote or summary]

## Their Response
[What they said, or "Waiting for response"]

## Next Steps
[What happens next]

## Days to Cash
[Estimate]
```

**Template for Meeting Transcripts:**
```markdown
# [Prospect Name] Meeting Transcript

**Date:** YYYY-MM-DD
**Duration:** X minutes
**Attendees:** [Names]
**Recording:** [Link if available]

---

## Related Documents
- [Quote Sent](../quotes/YYYY-MM-DD-[name]-quote.md) (if applicable)
- [Prospect Details](../../opportunities/prospect-tracker.md)

---

## Meeting Summary
[Key outcomes, next steps]

## Full Transcript/Notes
[Detailed notes or full transcript]

## Key Insights
[What you learned]

## Action Items
- [ ] Item 1
- [ ] Item 2
```

**When to Create Communication Files:**
- ✅ ALWAYS: When you send a quote
- ✅ ALWAYS: When you have a sales call/meeting
- ✅ ALWAYS: When you get an important response (acceptance, rejection, questions)
- ✅ USUALLY: For follow-up messages on major opportunities
- ⏸️ OPTIONAL: For casual check-ins or scheduling coordination

**See:** [SYSTEM-REQUIREMENTS.md](./SYSTEM-REQUIREMENTS.md) for full logging protocols

---

### Opportunity/Deal Research

**Use for:** Technical research, business analysis, partnership planning

**Template:**
```markdown
# [Opportunity Name] - [Document Type]

**Date:** YYYY-MM-DD
**Status:** [Research | Ready for Proposal | In Negotiation | Closed]
**Opportunity:** [Prospect/Partner Name]

---

## Related Documents
- List related docs here

---

## Executive Summary
High-level overview in 2-3 sentences

## [Research Sections]
...

## Open Questions
- Questions that need answering

## Next Steps
- [ ] Action items

## Decision Log
| Date | Decision | Rationale | Status |
```

### Technical Planning

**Use for:** Architecture decisions, implementation notes, build considerations

**Template:**
```markdown
# [Project Name] - Technical Considerations

**Purpose:** Capture technical decisions, open questions, and implementation details

**Status:** [Planning | In Development | Deployed]

---

## Related Documents
- List related docs here

---

## [Technical Sections]
- Database Design
- Architecture
- Infrastructure
- Security
- Monitoring

## Decision Log
Track major technical decisions with date and rationale

## Next Steps
Action items for implementation
```

### Client/Prospect Deep Dive

**Use for:** Detailed context on specific clients or prospects

**Template:**
```markdown
# [Company Name] - Context

**Date:** YYYY-MM-DD
**Status:** [Prospect | Client | Closed]
**Primary Contact:** [Name, Title]
**Opportunity Value:** $X,XXX

---

## Related Documents
- List related docs here

---

## Company Overview
Who they are, what they do

## Current Situation
Their pain points and context

## Our Proposed Solution
What we're offering

## History
Timeline of interactions

## Next Steps
```

---

## Special Cases

### Multi-Document Projects (like Lead Supercharger)

When a single project requires multiple documents:

1. **Create a naming convention:** `[project-name]-[document-type].md`
   - Example: `lead-supercharger-research.md`, `lead-supercharger-call-brief.md`

2. **Establish document hierarchy:**
   - **Primary document:** Strategic overview (research, plan)
   - **Supporting documents:** Tactical details (call briefs, technical notes)

3. **Cross-reference heavily:**
   - Each document should have "Related Documents" section
   - Explain each document's unique purpose

4. **Update together:**
   - When one document changes significantly, review related docs
   - Keep them in sync

---

## Quick Reference: Integration Checklist

**Copy this checklist when creating new files:**

```markdown
New File Integration Checklist:
- [ ] File has required metadata (date, status, purpose)
- [ ] File has "Related Documents" section
- [ ] Related documents updated to reference new file
- [ ] Index files updated (if applicable: README, FOCUS, prospect tracker)
- [ ] File is in correct folder per repository structure
- [ ] Filename follows naming conventions
- [ ] Document purpose is clear to cold reader
- [ ] Cross-references are bi-directional
- [ ] Verified discoverability (can someone find this?)
```

---

## For AI Agents: Automatic Protocol Execution

**🚨 CRITICAL: Read [SYSTEM-REQUIREMENTS.md](./SYSTEM-REQUIREMENTS.md) for full AI agent responsibilities**

### File Creation Protocol

**When you create a new file in this repository, you MUST:**

1. ✅ **Before creating:**
   - Check if existing file can be updated instead
   - Verify correct folder location
   - Confirm filename follows conventions
   - For /communications/ files: Use `YYYY-MM-DD-[name]-[type].md` format

2. ✅ **While creating:**
   - Include required metadata header
   - Add "Related Documents" section
   - Write clear purpose statement

3. ✅ **After creating:**
   - Update related documents with cross-references
   - Update index files if warranted (FOCUS.md, prospect-tracker.md)
   - Verify discoverability
   - Commit with descriptive message

**Do not wait for user to prompt you.** This protocol is automatic.

**If uncertain about integration:**
- Ask user: "I've created [filename]. Should I also update [README/FOCUS/other file]?"
- Better to over-communicate than under-integrate

---

### Session Start Protocol (CRITICAL)

**Before making ANY recommendations, you MUST:**

1. ✅ **Check file modification dates**
   ```bash
   ls -lah FOCUS.md prospect-tracker.md
   ```
   - If older than 48 hours: ASK for updates
   - NEVER trust stale data

2. ✅ **Read FOCUS.md Quick Daily Log**
   - What's the latest entry date?
   - Any prospect updates logged?
   - What's current financial zone?

3. ✅ **Cross-check /communications/ directory**
   - Any recent quotes sent?
   - Any recent responses logged?
   - Does prospect status match communications log?

4. ✅ **Verify priorities make sense**
   - Are Days to Cash estimates realistic?
   - Does priority formula match current zone?
   - Are recommendations aligned with urgency?

**See [SYSTEM-REQUIREMENTS.md](./SYSTEM-REQUIREMENTS.md) for complete session protocols and failure mode prevention.**

---

### Real-Time Context Logging

**During the session, proactively ask:**

- User mentions sending quote → "Should I create a file in /communications/quotes/?"
- User mentions meeting → "Should I log that transcript in /communications/transcripts/?"
- User shares prospect update → "Should I update prospect-tracker.md?"
- User mentions financial change → "Should I update financial-snapshot.md and recalculate zone?"

**Don't wait for permission.** Offer to create/update files immediately.

---

## Maintenance & Evolution

**This protocol itself should evolve:**
- Add new document templates as patterns emerge
- Update folder structure as business grows
- Refine integration checklist based on experience

**When updating this protocol:**
1. Update "Last Updated" date
2. Document what changed in commit message
3. Notify regular users if major changes

---

## Why This Matters

**Without this protocol:**
- Documents become isolated
- Information gets lost
- Future sessions waste time searching
- Knowledge graph fragments

**With this protocol:**
- Every document is discoverable
- Context is preserved
- Future sessions are efficient
- Repository scales with business

---

**Bottom line:** Integration is not optional. If you're creating a new file, you're committing to making it part of the system, not just adding to the pile.
