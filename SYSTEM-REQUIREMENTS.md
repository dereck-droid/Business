# 🔧 System Requirements & Maintenance

**Date Created:** January 24, 2026
**Purpose:** Define the dependencies, responsibilities, and maintenance protocols required for this business context management system to function accurately and efficiently.

**Status:** Active
**Owner:** Dereck Johnson + AI Agents

---

## Related Documents
- [Knowledge Management Protocol](./KNOWLEDGE-MANAGEMENT.md)
- [FOCUS Dashboard](./FOCUS.md)
- [Prospect Tracker](./opportunities/prospect-tracker.md)

---

## Table of Contents

1. [System Overview](#system-overview)
2. [User Responsibilities](#user-responsibilities-dereck)
3. [AI Agent Responsibilities](#ai-agent-responsibilities)
4. [File Structure Requirements](#file-structure-requirements)
5. [Formula & Calculation Dependencies](#formula--calculation-dependencies)
6. [Daily/Weekly Maintenance Protocols](#dailyweekly-maintenance-protocols)
7. [Session Start Protocol](#session-start-protocol-morning-kickoff)
8. [Context Logging Standards](#context-logging-standards)
9. [Critical Success Factors](#critical-success-factors)
10. [Failure Modes & Prevention](#failure-modes--prevention)

---

## System Overview

**What This System Does:**
- Provides accurate, up-to-date business context to AI agents
- Tracks prospects, opportunities, and priorities dynamically
- Adapts recommendations based on financial zone and urgency
- Prevents stale data from causing bad recommendations
- Maintains complete communication history for context

**What This System Requires:**
- Daily updates from user (60 seconds)
- Proper file organization and naming
- Accurate formulas and calculations
- Context logging after major events
- Agent verification and cross-checking

**Why This Matters:**
- AI agents make recommendations based on this data
- Stale data = bad priorities = missed opportunities
- Missing context = incorrect assessments = wrong advice
- Broken formulas = incorrect urgency rankings = wasted time

---

## User Responsibilities (Dereck)

### Daily (60 Seconds - Non-Negotiable)

**Update FOCUS.md Quick Daily Log EVERY DAY:**

```markdown
### [Today's Date] - [Day of Week]
**Cash Today:** $____
**Runway:** ___ weeks

**Prospect Updates:**
- [Name]: [What happened - or "no change"]
- [Name]: [What happened - or "no change"]

**Revenue In/Bills Paid:** $____
**Top Priority Tomorrow:** [One thing]
```

**Why This Matters:**
- Prevents 2-3 day old data (like Jan 21 data on Jan 24)
- Keeps AI agents informed of current reality
- Takes 60 seconds but prevents major errors

**How to Remember:**
- Do it first thing in morning with coffee
- OR do it end of day before closing laptop
- Set phone alarm if needed

---

### After Major Events (5 Minutes Each)

**Log These Immediately:**

1. **Quote Sent:**
   - Create file in `/communications/quotes/`
   - Update prospect-tracker.md with status
   - Update FOCUS.md daily log

2. **Prospect Response:**
   - Update prospect-tracker.md
   - Log in /communications/ if important
   - Update FOCUS.md daily log

3. **Meeting/Call:**
   - Save transcript in `/communications/transcripts/`
   - Update prospect-tracker.md with insights
   - Update FOCUS.md daily log

4. **Deal Closed/Lost:**
   - Update prospect-tracker.md (mark closed/lost)
   - Update financial-snapshot.md (if revenue)
   - Update FOCUS.md daily log

5. **Financial Change:**
   - Update financial-snapshot.md
   - Update FOCUS.md (cash, runway, bills)
   - Recalculate zone if runway changed

**Template Available:**
- Use `/communications/` templates for consistency
- Copy previous files and edit
- AI agents can help draft these quickly

---

### Weekly (15 Minutes - Every Sunday)

**Weekly Review Checklist:**

1. ✅ Review prospect-tracker.md
   - Are close probabilities still accurate?
   - Have any stages changed?
   - Any prospects to move to passive/closed?

2. ✅ Review FOCUS.md priorities
   - Do priority scores still make sense?
   - Any new opportunities to add?
   - Any completed milestones to check off?

3. ✅ Review financial-snapshot.md
   - Update cash position
   - Recalculate runway
   - Check if zone changed (Red → Yellow → Green)

4. ✅ Review backlog.md
   - Any conditions changed that affect urgency?
   - Any new ideas to add?
   - Any tasks to remove (no longer relevant)?

5. ✅ Clean up communications log
   - File any loose emails/messages
   - Update follow-up dates
   - Archive old conversations

---

### Monthly (30 Minutes - 1st of Month)

**Monthly Audit:**

1. ✅ Review all prospect statuses
   - Move stale prospects to passive/archived
   - Update close probabilities based on reality
   - Remove dead opportunities

2. ✅ Financial zone assessment
   - Calculate actual runway
   - Update zone if changed
   - Adjust priority formula weights if needed

3. ✅ Pipeline value accuracy check
   - Are revenue estimates still accurate?
   - Update based on new information
   - Remove wishful thinking

4. ✅ File structure audit
   - Are files in correct locations?
   - Is naming convention followed?
   - Any orphaned files to integrate?

5. ✅ Formula accuracy check
   - Test priority score calculations
   - Verify Days to Cash estimates
   - Check weighted pipeline math

---

## AI Agent Responsibilities

### Every Session Start (Mandatory)

**Before making recommendations, AI agents MUST:**

1. ✅ **Check file modification dates**
   ```bash
   ls -lah /home/user/Business/FOCUS.md
   ls -lah /home/user/Business/opportunities/prospect-tracker.md
   ```
   - If older than 48 hours: ASK for updates
   - Never trust data older than 3 days without verification

2. ✅ **Read FOCUS.md Quick Daily Log**
   - What's the latest entry?
   - Any prospect updates logged?
   - What was marked as top priority?

3. ✅ **Check financial zone**
   - What's current runway?
   - What zone are we in? (Red/Yellow/Green)
   - Apply correct priority formula weights

4. ✅ **Verify critical opportunities**
   - Read /communications/ for recent quotes/responses
   - Check if status matches what's in prospect-tracker
   - Flag any discrepancies

5. ✅ **Ask clarifying questions if needed**
   - "I see prospect-tracker was last updated Jan 21, but today is Jan 24. Any updates on Retarget IQ, Ben, or DC?"
   - Don't assume - verify current reality

---

### During Session (Continuous)

**AI Agents MUST:**

1. ✅ **Update files in real-time**
   - When user shares new info, immediately ask: "Should I update prospect-tracker.md?"
   - Don't let new context sit unlogged

2. ✅ **Cross-reference information**
   - If user mentions a quote, check /communications/quotes/
   - If discussing a prospect, read their full entry in prospect-tracker
   - If making priority recommendations, verify Days to Cash

3. ✅ **Flag inconsistencies**
   - "You said DC responded, but I don't see that in prospect-tracker. Want me to update it?"
   - "Priority score shows 8.0 but Days to Cash is 60 days and we're in RED ZONE - should that be lower?"

4. ✅ **Maintain context files**
   - Create /communications/ files for new quotes/transcripts
   - Update prospect details when new info emerges
   - Log important decisions in related files

---

### End of Session (Mandatory)

**Before ending, AI agents MUST:**

1. ✅ **Commit all updates**
   - Were any files updated during session?
   - Are all changes committed to git?
   - Is file structure still intact?

2. ✅ **Update FOCUS.md**
   - Add today's session to Quick Daily Log
   - Mark completed actions
   - Set tomorrow's priority

3. ✅ **Create any missing communication files**
   - If quote was discussed but not logged → create file
   - If meeting happened → create transcript file
   - If follow-up sent → create follow-up file

4. ✅ **Verify accuracy**
   - Do priority scores make sense?
   - Are Days to Cash estimates realistic?
   - Is anything obviously wrong?

5. ✅ **Provide session summary**
   - What was updated?
   - What's the top priority for tomorrow?
   - Any files that need user attention?

---

## File Structure Requirements

### Directory Structure (MUST MAINTAIN)

```
/Business/
├── FOCUS.md                           # Daily dashboard (update DAILY)
├── README.md                          # Business overview
├── KNOWLEDGE-MANAGEMENT.md            # Integration protocol
├── SYSTEM-REQUIREMENTS.md             # This file
├── backlog.md                         # Dynamic task list
│
├── /metrics/
│   ├── financial-snapshot.md          # Update when cash/runway changes
│   ├── revenue-tracking.md            # Update when deals close
│   └── campaign-performance.md        # Update weekly
│
├── /opportunities/
│   ├── prospect-tracker.md            # Update after EVERY prospect interaction
│   ├── pipeline-value.md              # Update when prospects/values change
│   └── [opportunity-specific-files]   # Research, notes, etc.
│
├── /communications/                   # NEW - Critical for context
│   ├── /quotes/                       # All quotes sent
│   ├── /emails/                       # Important email threads
│   ├── /transcripts/                  # Meeting recordings/notes
│   └── /follow-ups/                   # Follow-up messages
│
├── /company/
│   ├── identity.md                    # Rarely changes
│   ├── background.md                  # Rarely changes
│   └── personality-profile.md         # Rarely changes
│
├── /services/
│   ├── offerings.md                   # Update when services change
│   ├── pricing.md                     # Update when pricing changes
│   └── delivery.md                    # Update when process changes
│
├── /detailed-context/                 # Deep dives (create as needed)
└── /tools/                            # Scripts, utilities
```

### Naming Conventions (MUST FOLLOW)

**Communication Files:**
- Format: `YYYY-MM-DD-[prospect-name]-[type].md`
- Examples:
  - `2026-01-23-retarget-iq-quote.md`
  - `2026-01-19-dc-meeting-transcript.md`
  - `2026-01-23-ben-follow-up.md`

**Opportunity Files:**
- Format: `[opportunity-name]-[document-type].md`
- Examples:
  - `lead-supercharger-research.md`
  - `lead-supercharger-complexity-analysis.md`
  - `lead-supercharger-technical-notes.md`

**Why This Matters:**
- Searchable by date
- Alphabetically sorted
- Easy to find related files
- AI agents can parse names

---

## Formula & Calculation Dependencies

### Priority Score Formula

**Current Zone Determines Weights:**

**🔴 RED ZONE (<4 weeks runway):**
```
Priority Score =
  (Days to Cash Urgency × 0.40) +
  (Deal Amount × 0.30) +
  (Close Probability × 0.25) +
  (Execution Demand × 0.05)
```

**🟡 YELLOW ZONE (4-8 weeks runway):**
```
Priority Score =
  (Days to Cash Urgency × 0.25) +
  (Deal Amount × 0.20) +
  (Close Probability × 0.25) +
  (Strategic Value × 0.25) +
  (Execution Demand × 0.05)
```

**🟢 GREEN ZONE (8+ weeks runway):**
```
Priority Score =
  (Strategic Value × 0.50) +
  (Deal Amount × 0.20) +
  (Close Probability × 0.15) +
  (Days to Cash × 0.10) +
  (Execution Demand × 0.05)
```

**CRITICAL:** Zone must be recalculated whenever runway changes!

---

### Days to Cash Calculation

**Formula:**
```
Days to Cash =
  Days to Close +
  Days to Complete Project +
  Payment Terms
```

**Examples:**
- Quote accepted, just need invoice: 1-7 days
- Meeting scheduled, then project: 21-30 days
- Early pipeline, needs nurture: 45-60+ days

**Urgency Scoring (for Priority Formula):**
- 1-7 days = 10/10
- 8-14 days = 7/10
- 15-30 days = 4/10
- 30+ days = 1/10

**CRITICAL:** This is THE most important metric in RED ZONE!

---

### Runway Calculation

**Formula:**
```
Runway (weeks) =
  (Current Cash - Bills Due) /
  ((Monthly Burn - Monthly MRR) / 4.33)
```

**Example:**
- Cash: $3,000
- Bills due: $2,300
- After bills: $700
- Monthly burn: $4,900
- Monthly MRR: $2,094
- Monthly deficit: $2,806
- Weekly deficit: $648
- Runway: $700 / $648 = 1.08 weeks (CRISIS!)

**Zone Thresholds:**
- <4 weeks = RED ZONE
- 4-8 weeks = YELLOW ZONE
- 8+ weeks = GREEN ZONE

**CRITICAL:** Recalculate every time cash or MRR changes!

---

### Weighted Pipeline Value

**Formula:**
```
Weighted Value = Deal Amount × (Close Probability / 10)
```

**Example:**
- Ben: $10K × (7/10) = $7,000 weighted
- DC: $5K × (6/10) = $3,000 weighted
- Total: $10,000 weighted pipeline

**CRITICAL:** Use this for realistic planning, not wishful thinking!

---

## Daily/Weekly Maintenance Protocols

### Daily Protocol (60 Seconds - Morning or EOD)

**Checklist:**
1. ✅ Open FOCUS.md
2. ✅ Add today's date to Quick Daily Log
3. ✅ Update cash position (if changed)
4. ✅ List prospect updates (or write "no change")
5. ✅ Note revenue in / bills paid
6. ✅ Write tomorrow's top priority
7. ✅ Save & commit

**Time:** 60 seconds
**Frequency:** DAILY
**Consequence if skipped:** Stale data → bad AI recommendations

---

### Weekly Protocol (15 Minutes - Sunday Evening)

**Checklist:**
1. ✅ Review all active prospects in prospect-tracker.md
2. ✅ Update close probabilities based on latest interactions
3. ✅ Move stale prospects to passive/closed
4. ✅ Recalculate priority scores if anything changed
5. ✅ Review financial snapshot (cash, runway, zone)
6. ✅ Check backlog for condition changes
7. ✅ Clean up /communications/ (file loose items)
8. ✅ Plan next week's top 3 priorities

**Time:** 15 minutes
**Frequency:** WEEKLY (Sundays)
**Consequence if skipped:** Gradual drift, priorities become inaccurate

---

### Monthly Protocol (30 Minutes - 1st of Month)

**Checklist:**
1. ✅ Full audit of prospect-tracker.md (archive dead leads)
2. ✅ Verify all formulas still calculate correctly
3. ✅ Review file structure (everything in right place?)
4. ✅ Check for orphaned files (need integration?)
5. ✅ Verify Days to Cash estimates (still realistic?)
6. ✅ Review conversion metrics (what's working?)
7. ✅ Update any stale documentation
8. ✅ Backup repository to external location

**Time:** 30 minutes
**Frequency:** MONTHLY
**Consequence if skipped:** System decay, formula drift, lost context

---

## Session Start Protocol (Morning Kickoff)

### User Prompt (How to Start Each Session)

**Template for Morning Check-In:**

```
Good morning! Here's today's update:

**Cash:** $____
**Runway:** ___ weeks

**Prospect Updates:**
- [Name]: [What happened]
- [Name]: [No change]

**Today's Priority:** [What you want to focus on]

**Questions for you:**
- [Any specific questions or tasks]
```

**AI Agent Response Should Include:**
1. ✅ Acknowledgment of updates
2. ✅ Verification of priority formula (check zone)
3. ✅ Top 3 recommended actions for today
4. ✅ Any urgent items flagged
5. ✅ Offer to update files

---

### AI Agent Session Start Checklist

**BEFORE giving advice, AI agents MUST:**

1. ✅ **Check file dates**
   ```bash
   ls -lah FOCUS.md prospect-tracker.md
   ```

2. ✅ **Read Quick Daily Log**
   - What's the latest entry?
   - When was it updated?
   - If older than 48 hours: ASK for update

3. ✅ **Verify financial zone**
   - What's current runway?
   - Am I using the right priority formula?

4. ✅ **Check for new communications**
   ```bash
   ls -lah /communications/quotes/
   ls -lah /communications/follow-ups/
   ```

5. ✅ **Cross-reference prospect statuses**
   - Does prospect-tracker match recent communications?
   - Are there discrepancies?

6. ✅ **Ask clarifying questions if needed**
   - Don't assume
   - Verify current reality

**Then and only then:** Provide recommendations

---

## Context Logging Standards

### What MUST Be Logged

**Always Create Communication Files For:**

1. ✅ **Quotes Sent**
   - Location: `/communications/quotes/`
   - Include: Full quote, context, response, next steps
   - Link from: prospect-tracker.md

2. ✅ **Meeting Transcripts**
   - Location: `/communications/transcripts/`
   - Include: Full transcript or detailed notes, key insights, action items
   - Link from: prospect-tracker.md

3. ✅ **Important Email Threads**
   - Location: `/communications/emails/`
   - Include: Full thread, context, current status
   - Link from: prospect-tracker.md

4. ✅ **Follow-Ups**
   - Location: `/communications/follow-ups/`
   - Include: Message sent, context, expected response timeline
   - Link from: prospect-tracker.md

**Update Prospect Tracker For:**

1. ✅ Any stage change
2. ✅ Any close probability change
3. ✅ Any revenue estimate change
4. ✅ Any new information about prospect
5. ✅ Any new next action

**Update FOCUS.md For:**

1. ✅ Daily cash changes
2. ✅ Prospect updates
3. ✅ Completed actions
4. ✅ New priorities

---

### Logging Template (Quick Reference)

**Format for Logging Prospect Updates:**

```markdown
**[Date]:** [What happened]
- Quote sent: $____ for [service]
- Response: [Their response or "waiting"]
- Next action: [What's next]
- Days to cash: [Estimate]
- Updated priority score: [New score]
```

**Example:**
```markdown
**Jan 23, 2026:** Retarget IQ accepted $5K package quote
- Quote sent: $5,000 for proposal automation + support system
- Response: "perfect thanks" (accepted)
- Next action: Send SOW + invoice for $2,500 upfront
- Days to cash: 1-7 days
- Updated priority score: 9.80 (was 7.65)
```

---

## Critical Success Factors

### For This System to Work, We MUST:

1. ✅ **Update FOCUS.md daily** (60 seconds)
   - Prevents stale data
   - Keeps AI agents informed
   - Non-negotiable

2. ✅ **Log all major communications** (/communications/)
   - Prevents lost context
   - Enables accurate recommendations
   - Takes 5 minutes each

3. ✅ **Maintain file structure** (directory organization)
   - Keeps everything findable
   - Prevents orphaned files
   - Minimal ongoing effort

4. ✅ **Verify formulas match reality** (weekly/monthly)
   - Priority scores must reflect urgency
   - Days to Cash must be realistic
   - Zone must be current

5. ✅ **AI agents MUST verify before recommending**
   - Check file dates
   - Read latest updates
   - Ask clarifying questions
   - Cross-reference sources

---

## Failure Modes & Prevention

### Failure Mode #1: Stale Data

**Problem:**
- Files last updated Jan 21
- Today is Jan 24
- AI recommends Lead Supercharger (60-90 days to cash)
- Misses Retarget IQ ($5K, 1-7 days to cash)

**Root Cause:**
- User didn't update FOCUS.md daily
- AI didn't check file dates

**Prevention:**
- ✅ User: Update FOCUS.md EVERY DAY (60 seconds)
- ✅ AI: Check file dates EVERY SESSION START

**Early Warning Signs:**
- File modification date >48 hours old
- Prospect statuses don't match recent conversations
- Priority recommendations feel "off"

---

### Failure Mode #2: Missing Communications

**Problem:**
- User sent quote to prospect
- Didn't log in /communications/
- AI doesn't know quote was sent
- Recommends "send quote" (already done)

**Root Cause:**
- User didn't create communication file
- AI didn't ask for verification

**Prevention:**
- ✅ User: Create /communications/ file immediately after major events
- ✅ AI: Ask "Have you sent that quote? Should I log it?"

**Early Warning Signs:**
- User mentions quote but no file exists
- Prospect status says "needs quote" but user says "I sent it"
- Timeline doesn't match expected progression

---

### Failure Mode #3: Incorrect Priority Formula

**Problem:**
- Runway dropped from 4 weeks to 2 weeks (moved to RED ZONE)
- Priority formula still using YELLOW weights
- Strategic projects ranked higher than survival cash

**Root Cause:**
- Financial zone not recalculated
- Formula weights not updated

**Prevention:**
- ✅ User: Update financial snapshot when cash/runway changes
- ✅ AI: Recalculate zone EVERY SESSION, adjust formula weights

**Early Warning Signs:**
- Runway shows RED but strategic projects rank #1
- Days to Cash showing 60+ days as top priority in crisis
- Recommendations don't match urgency of situation

---

### Failure Mode #4: Lost Context Between Sessions

**Problem:**
- User had detailed conversation with AI yesterday
- Today, different AI agent has no context
- User has to re-explain everything

**Root Cause:**
- Yesterday's context not logged in files
- AI relied on session memory, not documentation

**Prevention:**
- ✅ AI: Create communication files DURING session, not after
- ✅ AI: Update prospect-tracker in real-time
- ✅ AI: End-of-session summary with files updated

**Early Warning Signs:**
- User says "I already told the other agent this"
- New AI agent asks questions that were answered yesterday
- Recommendations contradict previous session

---

### Failure Mode #5: Wishful Thinking in Estimates

**Problem:**
- Close probability marked 90%
- Days to Cash marked 7 days
- Reality: Prospect hasn't responded in 2 weeks

**Root Cause:**
- User optimistic, doesn't update when things cool
- AI doesn't challenge unrealistic estimates

**Prevention:**
- ✅ User: Weekly honest assessment of prospects
- ✅ AI: Flag obviously unrealistic numbers ("90% close prob but no response in 2 weeks?")

**Early Warning Signs:**
- High close probability + long silence
- Short days to cash + early pipeline stage
- Large revenue estimate + no detailed conversation yet

---

## System Health Check (Self-Audit)

**Run this check monthly or when something feels "off":**

### Data Freshness ✅
- [ ] FOCUS.md updated in last 24 hours?
- [ ] Prospect-tracker updated in last 48 hours?
- [ ] Financial snapshot reflects current cash?
- [ ] All communications from this week logged?

### File Structure ✅
- [ ] All directories exist and properly named?
- [ ] Communication files using correct naming convention?
- [ ] No orphaned files (everything linked)?
- [ ] Git repository up to date?

### Formula Accuracy ✅
- [ ] Current zone calculated correctly?
- [ ] Priority formula weights match current zone?
- [ ] Days to Cash estimates realistic?
- [ ] Weighted pipeline math correct?

### AI Agent Behavior ✅
- [ ] AI checks file dates before recommending?
- [ ] AI asks for updates when data is stale?
- [ ] AI creates communication files in real-time?
- [ ] AI flags inconsistencies?

### User Habits ✅
- [ ] Daily log being updated consistently?
- [ ] Major events being logged immediately?
- [ ] Weekly reviews happening?
- [ ] Monthly audits scheduled?

**Score:** ___/20

**If <15/20:** System needs attention
**If <10/20:** System is degrading, urgent fixes needed

---

## Emergency Recovery Protocol

**If system has degraded (stale data, missing files, broken formulas):**

### Step 1: Stop & Assess (15 minutes)
1. What's the current date?
2. When were critical files last updated?
3. What major events happened since last update?
4. What's current financial reality (cash, runway)?

### Step 2: Critical Updates (30 minutes)
1. Update FOCUS.md with current reality
2. Update financial-snapshot.md (cash, runway, zone)
3. Update prospect-tracker.md (all active prospects)
4. Create missing communication files from memory/email

### Step 3: Verify Accuracy (15 minutes)
1. Recalculate all priority scores
2. Verify Days to Cash estimates
3. Check formula weights match zone
4. Test that recommendations now make sense

### Step 4: Prevent Recurrence (10 minutes)
1. Set daily alarm for FOCUS.md update
2. Create checklist for major events
3. Schedule weekly review (Sunday evening)
4. Commit to system maintenance

**Total Recovery Time:** ~70 minutes
**Worth it to prevent bad decisions:** Absolutely

---

## Version History

**v1.0 (Jan 24, 2026):** Initial creation
- Established user/AI responsibilities
- Defined file structure requirements
- Created formula dependencies documentation
- Set up maintenance protocols
- Documented failure modes

**Future Versions:**
- Add automation scripts for file creation
- Create templates for common communication types
- Build health check automation
- Integrate with calendar reminders

---

## Quick Reference Card

**DAILY (60 sec):**
- [ ] Update FOCUS.md Quick Daily Log

**AFTER EVENTS (5 min each):**
- [ ] Quote sent → Create /communications/quotes/ file
- [ ] Meeting → Create /communications/transcripts/ file
- [ ] Response → Update prospect-tracker.md
- [ ] Financial change → Update financial-snapshot.md

**WEEKLY (15 min, Sunday):**
- [ ] Review prospect-tracker.md
- [ ] Verify priority scores
- [ ] Update close probabilities
- [ ] Clean up communications log

**MONTHLY (30 min, 1st):**
- [ ] Full audit of prospect-tracker
- [ ] Verify all formulas
- [ ] Archive dead leads
- [ ] File structure check

**AI EVERY SESSION:**
- [ ] Check file dates
- [ ] Read Quick Daily Log
- [ ] Verify financial zone
- [ ] Cross-reference communications
- [ ] Ask for updates if stale

---

**Remember:** This system only works if BOTH user and AI follow their responsibilities. Garbage in = garbage out. Accurate, timely updates = accurate, helpful recommendations.
