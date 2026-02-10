# 📋 Post-Event Update Protocol
**Purpose:** Ensure all status updates propagate correctly after events
**Created:** January 28, 2026 (Response to diagnostic findings)

---

## 🎯 The Problem This Solves

**Before:** Events happen (meetings, payments, status changes) but only SOME files get updated.
- Transcript gets created ✅
- But FOCUS.md shows meeting as upcoming ❌
- STATUS-DASHBOARD.md doesn't exist ❌
- Prep file never marked complete ❌
- AI agents ask "did that meeting happen?" ❌

**After:** Systematic protocol ensures ALL relevant files updated.
- Complete checklist every time
- AI agents always know current status
- No redundant questions
- No conflicting information

---

## 📅 After Any Meeting Completes

**Immediate Actions (Within 30 minutes):**

1. **[ ] Create meeting transcript**
   - Location: `/communications/transcripts/YYYY-MM-DD-[prospect-name]-[meeting-type].md`
   - Include: Date, duration, attendees, recording link, summary, key outcomes, next steps
   - Link to related documents

2. **[ ] Update STATUS-DASHBOARD.md**
   - Change meeting status from 🔜 UPCOMING to ✅ COMPLETE
   - Add transcript link
   - Add key outcome summary (1 sentence)
   - Update "Last Updated" timestamp

3. **[ ] Update FOCUS.md**
   - Mark meeting section as "COMPLETED"
   - Add transcript link
   - Add 3-5 bullet points of key outcomes
   - Update "Last Updated" field at top

4. **[ ] Update meeting prep file**
   - Change "Status: PREP COMPLETE" to "Status: ✅ MEETING COMPLETED"
   - Add "Transcript:" link
   - Add "Outcome:" summary
   - Add "Next Steps:" if applicable

5. **[ ] Update prospect status (if relevant)**
   - Update `/opportunities/prospect-tracker.md`
   - Update STATUS-DASHBOARD.md prospects table
   - Change status if deal advanced/closed/lost
   - Update "Last Contact" date
   - Update "Next Action" field

6. **[ ] Commit changes**
   - Commit message: "Complete [Meeting Name] - [Key Outcome in 3-5 words]"
   - Example: "Complete Joe/RAMP meeting - Intelligence gathered"

**Time Investment:** 5-10 minutes per meeting

---

## 💰 After Financial Update

**When cash position changes (payment received, expense paid, etc.):**

1. **[ ] Update metrics/financial-snapshot.md**
   - Change "Total Available Cash" to new amount
   - Update "Last Updated" date
   - Add entry to "Recent Changes" section (if doesn't exist, create it)
   - Update runway calculation

2. **[ ] Update STATUS-DASHBOARD.md**
   - Change "Current Cash Position" to new amount
   - Update "Last Updated" timestamp
   - Update "Zone" if changed (RED/YELLOW/GREEN)
   - Update runway estimate

3. **[ ] Update FOCUS.md (if significant change)**
   - Update "Cash Today" field
   - Update "Runway" field
   - Update "Financial Status" if zone changed

4. **[ ] Verify consistency**
   - Run: `grep -r "Current Cash" . | grep -v ".git"`
   - Verify all show same number
   - If any don't match, update them

5. **[ ] Commit changes**
   - Commit message: "Update financial snapshot to $X,XXX (from $Y,YYY)"
   - Example: "Update financial snapshot to $9,234 (from $7,500)"

**Time Investment:** 10-15 minutes per financial update

---

## 📊 After Prospect Status Change

**When prospect moves in pipeline (new lead, advanced stage, closed, lost):**

1. **[ ] Update STATUS-DASHBOARD.md**
   - Update prospects table with new status
   - Update "Last Contact" date
   - Update "Next Action"
   - Update "Last Updated" timestamp

2. **[ ] Update opportunities/prospect-tracker.md**
   - Update detailed prospect information
   - Update priority score if needed
   - Add notes on status change

3. **[ ] Update opportunity-specific files**
   - If meeting prep file exists, add status update
   - If quote sent, update quote status
   - If closed, mark as CLOSED and add won/lost reason

4. **[ ] Update metrics (if closed)**
   - If WON: Update revenue-tracking.md with closed deal
   - If LOST: Add to "Prospects Lost" section with reason
   - Update pipeline value

5. **[ ] Commit changes**
   - Commit message: "[Prospect Name] status: [change]"
   - Example: "Ben/EquityPro status: Closed Won - $12K"

**Time Investment:** 5-10 minutes per prospect update

---

## 🚀 Start of Each Day

**Morning Routine (5 minutes):**

1. **[ ] Read STATUS-DASHBOARD.md**
   - Verify financial data is current
   - Check today's meetings
   - Review top priorities

2. **[ ] Update if needed**
   - Any overnight payments?
   - Any emails changing meeting status?
   - Any urgent priority shifts?

3. **[ ] Update FOCUS.md "Cash Today" if changed**
   - Quick bank balance check
   - Update if different from STATUS-DASHBOARD.md

4. **[ ] Commit if changes made**
   - Commit message: "Morning update - [date]"

---

## ✅ End of Each Day

**Evening Routine (10 minutes):**

1. **[ ] Review what happened today**
   - Any meetings completed? → Run meeting protocol
   - Any payments in/out? → Run financial protocol
   - Any prospect changes? → Run prospect protocol

2. **[ ] Verify all events logged**
   - Check calendar vs. STATUS-DASHBOARD.md
   - Check bank vs. financial-snapshot.md
   - Check email vs. prospect-tracker.md

3. **[ ] Update FOCUS.md for tomorrow**
   - What's tomorrow's top priority?
   - Any prep needed tonight?

4. **[ ] Commit all updates**
   - Commit message: "End of day update - [date]"

---

## 🤖 For AI Sessions

**At START of session:**

1. **[ ] Read STATUS-DASHBOARD.md FIRST**
   - This is source of truth for current status
   - Check "Last Updated" timestamp
   - If >2 days old, ask user for current status

2. **[ ] Check for stale data**
   - If data looks old, verify with user before proceeding
   - Never assume stale data is current

**At END of session:**

3. **[ ] Run appropriate protocol(s)**
   - If meeting happened → Meeting protocol
   - If financial change → Financial protocol
   - If prospect change → Prospect protocol

4. **[ ] Verify updates propagated**
   - Check STATUS-DASHBOARD.md updated
   - Check related files updated
   - Check "Last Updated" timestamps current

5. **[ ] Commit all changes**
   - Clear commit message describing what updated
   - Include session ID for reference

---

## 📝 Checklist Template

**Copy this for each meeting:**

```markdown
## Meeting Update Checklist: [Meeting Name]

- [ ] Transcript created in communications/transcripts/
- [ ] STATUS-DASHBOARD.md meeting table updated (status → COMPLETE)
- [ ] STATUS-DASHBOARD.md transcript link added
- [ ] FOCUS.md meeting section marked complete
- [ ] FOCUS.md key outcomes added
- [ ] Meeting prep file status updated
- [ ] Prospect status updated (if applicable)
- [ ] All "Last Updated" timestamps current
- [ ] Changes committed to git
```

---

## 🚨 Red Flags

**Signs protocol wasn't followed:**

- ❌ Meeting happened but STATUS-DASHBOARD.md shows "UPCOMING"
- ❌ Transcript exists but FOCUS.md doesn't reference it
- ❌ Financial change but multiple files show different amounts
- ❌ "Last Updated" dates more than 2 days old
- ❌ AI agents asking "did that meeting happen?"
- ❌ User saying "we already discussed this"

**If you see these:**
1. Stop what you're doing
2. Run the appropriate protocol NOW
3. Update all relevant files
4. Verify consistency
5. Commit updates

---

## 💡 Why This Matters

**Without This Protocol:**
- Information exists but scattered
- Status unclear or contradictory
- AI agents can't trust data
- Redundant questions
- Wasted time

**With This Protocol:**
- Single source of truth
- All files consistent
- AI agents have current status
- No redundant questions
- Efficient collaboration

---

## 🔗 Related Documents

- [STATUS-DASHBOARD.md](./STATUS-DASHBOARD.md) - The single source of truth
- [KNOWLEDGE-MANAGEMENT.md](./KNOWLEDGE-MANAGEMENT.md) - Overall repository management
- [SYSTEM-REQUIREMENTS.md](./SYSTEM-REQUIREMENTS.md) - AI agent guidelines
- [DIAGNOSTIC-REPORT-2026-01-28.md](./DIAGNOSTIC-REPORT-2026-01-28.md) - Why this protocol was created
- [COMPREHENSIVE-ORGANIZATIONAL-AUDIT.md](./COMPREHENSIVE-ORGANIZATIONAL-AUDIT.md) - Full organizational analysis

---

**Remember:** 10 minutes of systematic updates saves hours of confusion later.

**End of Protocol**
