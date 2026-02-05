# Retarget IQ - Sales & Support Automation

**Client:** Retarget IQ (Nate Calhoun & Alex Ciereszko)
**Budget:** $7,000 (upgraded from $4,500)
**Status:** Proposal Automation - Implementation Phase
**Priority:** HIGH - Proposal automation system (automated pricing emails)

---

## 🎯 Project Goals

### Primary: Automated Proposal System (Current Focus)
Detect when sales rep promises pricing → Analyze call history → Generate personalized proposal email → Auto-send or route for review based on confidence

**Impact:** 95% time reduction (15 min → 0 min per proposal), 100% accuracy in honoring promised pricing

### Secondary: Support Knowledge Base (Future Phase)
Build AI-powered support chat interface using 127 FAQs extracted from 299 emails + 30 call transcripts

**Impact:** 50% faster support response times, consistent answer quality

---

## 📁 Key Files

### 🟢 Current (Proposal Automation - Feb 5, 2025)

| File | Purpose |
|------|---------|
| **`START-HERE.md`** | 👈 **START HERE** - Master roadmap & file navigation |
| `proposal-automation-design.md` | Complete workflow design (900 lines) |
| `intelligent-call-filtering.md` | Call validation logic (filters no-shows) |
| `supabase-schema-complete.sql` | Database schema (deploy this) |
| `ai-prompts/proposal-prompts.md` | AI prompts for n8n LLM nodes |
| `SESSION-SUMMARY-2025-02-05.md` | Implementation roadmap |

### 🟡 Reference (Knowledge Base - Feb 2, 2025)

| File | Purpose |
|------|---------|
| `IMPLEMENTATION-GUIDE.md` | Original 4-phase plan (support chat) |
| `knowledge-base.json` | 127 FAQs ready for chat interface |
| `email-templates/` | 6 pricing templates + automation logic |

---

## 🚀 Quick Start

**New implementer?** Read **`START-HERE.md`** first - it explains:
- What we're building
- Implementation order (Step 1-7)
- Which files to use
- How documents relate to each other

### Implementation Steps (Summary)

1. **Database Setup** (30 min)
   - Deploy `supabase-schema-complete.sql`
   - Fixes existing workflow database error

2. **Call Filtering** (1 hour)
   - Add intelligent filtering to Fireflies workflow
   - Filters no-shows, internal meetings, test calls

3. **Proposal Detection** (2 hours)
   - Add AI check: Was proposal promised?
   - Route to proposal generation if YES

4. **Proposal Generation** (4-6 hours)
   - Query call history
   - AI generates personalized email
   - Validate and route by confidence

5. **Slack Integration** (2 hours)
   - Interactive buttons for review/approval

6. **Testing** (1-2 days)
   - Test all scenarios
   - Tune confidence thresholds

**Full details:** See `START-HERE.md` and `proposal-automation-design.md`

---

## ⏱️ Time Estimates

| Phase | Time | Status |
|-------|------|--------|
| Gmail Export Setup | 30-60 min | ⏳ Not Started |
| Supabase Database Setup | 30 min | ⏳ Not Started |
| n8n Workflow Build | 2-3 hours | ⏳ Not Started |
| Full Import & Testing | 1-2 hours | ⏳ Not Started |
| Client Review | 1-2 hours (their time) | ⏳ Not Started |
| **Total (Data Pipeline)** | **5-8 hours** | ⏳ Not Started |
| Chat Interface | 8-12 hours | ⏳ Next Phase |

---

## 📊 Current Status

### ✅ Completed (February 2025)
- [x] Knowledge base built (127 FAQs from 299 emails + 30 call transcripts)
- [x] Email templates created (6 pricing templates)
- [x] Proposal automation designed (complete workflow architecture)
- [x] Intelligent call filtering designed (filters no-shows)
- [x] AI prompts written (proposal detection + generation)
- [x] Database schema designed (call_recordings + proposal_emails)
- [x] Fireflies call recording workflow (working, needs DB fix)

### 🚧 In Progress
- [ ] Deploy database schema (`supabase-schema-complete.sql`)
- [ ] Implement intelligent call filtering (1 hour)
- [ ] Build proposal detection (2 hours)
- [ ] Build proposal generation workflow (4-6 hours)
- [ ] Set up Slack integration (2 hours)
- [ ] Testing & refinement (1-2 days)

### 📅 Future Phases
- [ ] Support chat interface (Phase 1 from original plan)
- [ ] VA email templates system (Phase 2)
- [ ] Onboarding automation (Phase 4)

### 🔗 External Repository: Chat Interface
The chat interface is maintained in a separate repository for Vercel deployment:
- **Local path:** `/home/user/retargetiq-chat/`
- **GitHub:** `dereck-droid/retargetiq-chat` (create this repo)
- **Stack:** React + Vite + Tailwind + reachat
- **Deployment:** Vercel

---

## 💡 Key Technical Decisions

### Why Google Apps Script?
- Free, no external tools needed
- Direct Gmail API access
- Handles threading automatically
- Easy for client to run updates themselves

### Why Supabase?
- Free tier sufficient
- Built-in auth and APIs
- Vector search support (pgvector)
- Real-time capabilities
- Easy client access for review

### Why n8n?
- Visual workflow (easier to debug)
- Built-in AI nodes (OpenAI, Claude)
- Error handling and retries
- Can be reused for ongoing imports

### AI Model Choice
- **OpenAI GPT-4 Turbo:** Better at structured output, faster
- **Claude 3.5 Sonnet:** Often more accurate for classification
- Recommend: Start with GPT-4, switch to Claude if accuracy issues

---

## 🎯 Success Criteria

### Data Pipeline
- [ ] >90% of support emails exported
- [ ] >85% AI categorization accuracy
- [ ] <5% duplicate threads
- [ ] Zero data loss

### Business Impact (Post-Chat Interface)
- [ ] Support response time reduced 50%
- [ ] Support team handles 2x volume
- [ ] Consistent answer quality
- [ ] Faster new hire ramp-up

---

## 📞 Client Context

### Why This Matters
- Recently acquired (cash flow no longer an issue)
- Rapid growth: 20 new clients, 10-15 sales calls/day
- 2 new support hires starting immediately
- Need knowledge base ASAP for support scaling

### Relationship
- Existing client (you're admin on their GHL)
- High trust (paid $7K immediately)
- Potential for larger Lead Supercharger partnership ($4-8K/month recurring)
- This project proves your capability for bigger deal

### Communication
- WhatsApp group (fast, casual)
- Responsive and engaged
- Open to iteration and feedback

---

## 🐛 Common Issues & Solutions

**Issue:** Apps Script times out
**Fix:** Reduce MAX_THREADS to 250, add date filters

**Issue:** AI classification inaccurate
**Fix:** Tune prompt, add examples, try Claude 3.5

**Issue:** Supabase duplicate key error
**Fix:** Add deduplication check in n8n (see workflow design)

**Issue:** OpenAI rate limits
**Fix:** Increase batch delay, reduce batch size

---

## 📚 Resources

### Documentation
- [Google Apps Script Docs](https://developers.google.com/apps-script)
- [Supabase Docs](https://supabase.com/docs)
- [n8n Docs](https://docs.n8n.io/)
- [OpenAI API](https://platform.openai.com/docs)

### Tools Used
- **Gmail API** - Email thread export
- **Google Apps Script** - Automation
- **Supabase** - PostgreSQL database + auth
- **n8n** - Workflow automation
- **OpenAI GPT-4** - AI classification
- **GoHighLevel** - Iframe embedding

---

## 🎉 Ready to Implement!

### For New Agents/Implementers:
**👉 Start with: `START-HERE.md`**

It provides:
- Clear project context
- Master roadmap with implementation order
- File navigation guide (which docs to use)
- Decision tree for what to build
- Step-by-step instructions

### For Quick Reference:
- **Workflow design:** `proposal-automation-design.md`
- **AI prompts:** `ai-prompts/proposal-prompts.md`
- **Database setup:** `supabase-schema-complete.sql`
- **Implementation roadmap:** `SESSION-SUMMARY-2025-02-05.md`

---

**Estimated completion:** 1-2 weeks (20-30 hours total)
**Current priority:** Proposal automation (automated pricing emails)
**Next milestone:** First automated proposal sent

---

*Last updated: February 5, 2025*
*Project files: `/home/user/Business/retarget-iq/`*
*Branch: `claude/study-proposal-automation-seDXF`*
