# RAMP Manufacturing - Impromptu Google Meet

**Date:** February 2, 2026 (Sunday)
**Duration:** 37 minutes
**Attendees:** Dereck Johnson, Saj Patel, Dave Briggs, Joe Kreidler, Joe Brennan
**Recording:** https://fathom.video/share/rpRc9QkyZEY7g1gotJysskE8RL6DsFDV

---

## Related Documents
- [RAMP Opportunity Analysis](../../opportunity-analysis-ramp-manufacturing.md)
- [RAMP Action Items](../../ACTION-ITEMS-RAMP-MANUFACTURING.md)
- [Joe Follow-up Call](./2026-02-02-joe-brennan-ramp-debrief.md)
- [Initial Joe Discovery Call](./2026-01-27-joe-ramp-manufacturing-call.md)

---

## Meeting Summary

**Purpose:** Technical scoping call to understand RAMP's work instruction automation needs

**Key Outcomes:**
1. **Clear Problem Defined:** Engineers spend 2-6 weeks creating 50-200 page work instructions per product
2. **Realistic Expectations:** They want 50-70% automation, not 100% replacement
3. **Phased Approach Agreed:** Start with interview-based AI, evolve toward more automation
4. **Security Critical:** Customer IP concerns require enterprise AI contracts and encryption
5. **Knowledge Base Ownership:** They want to own the training data as their IP
6. **Proposal Due:** Friday, February 6th with architecture, security, licensing details

**Next Steps:**
- Dereck to send proposal by Friday Feb 6 to Saj, Joe K, Joe B, Dave
- Proposal must include: Phase 0 discovery scope, architecture, security approach, licensing, hosting, IP ownership

---

## The Problem (Crystal Clear Definition)

### Current State: Manual Work Instruction Creation

**What Are Work Instructions?**
- Step-by-step assembly guides for factory floor workers (like IKEA instructions but for manufacturing)
- Include: Component breakdowns, assembly steps, quality checkpoints, test procedures
- Format: 50-200 pages with photos, CAD snapshots, annotations, arrows, detailed text

**Example Shown:** Matthews Assembly (compound bow device)
- Go-no-go gauge testing
- Keypad installation with specific placement
- Rubber grommet assembly
- PCB and antenna integration
- Quality inspection checkpoints
- Electronics testing at multiple stages

**Time Investment:**
- **2-6 weeks per product** (sometimes more)
- Engineer-level work required
- Highly iterative (station assignments change, rework needed)
- Tedious documentation burden

**The Engineers' Process:**
1. Receive 3D CAD data for device
2. Receive physical prototype
3. Decide optimal assembly line breakdown (how many stations)
4. Create work instructions for each station
5. Coordinate with Dave/manufacturing team on station strategy
6. Rework when assembly strategy changes (choke points discovered)

### The Pain Points

**Dave's Perspective:**
- Different skill levels on factory floor (some high school education, some technical)
- Instructions must be very specific and clear
- Sometimes use CAD drawings, sometimes photos (photos often clearer)
- Workers have varying capabilities (soldering, complex assembly, basic assembly)
- Need to expand workforce quickly sometimes

**Saj's Perspective:**
- "His business is document sensitive and document burdensome" (Joe's words from previous call)
- Reduces engineer time for strategy and critical thinking
- Tediousness takes focus away from planning
- Wish-list: "Show Gemini the assembly, tell it station count and worker skills, get optimized instructions"

**Reality Check:**
- They've tried ChatGPT and Gemini
- Get "decent results" but not "engineering level results"
- Understand AI won't replace engineers completely

---

## What They Want (Phased Goals)

### Phase 1: Interview-Based Document Generation
**Engineer interviews AI → AI generates draft instructions → Engineer refines**

- Quick interview process (faster than building from scratch)
- AI asks clarifying questions about components, assembly methods, adhesives, placement logic
- Output: Editable Google Slides-style document
- Success: 50-70% there, engineers manually complete rest

### Phase 2: Knowledge Base Learning
**AI remembers patterns and applies to future projects**

- Database grows over time with reusable knowledge
- Example: "Plastic parts need to be handled this way" - remembered for program #2
- Component-level patterns (adhesives, assembly techniques, quality checks)
- Assembly-level patterns (station strategies, worker skill matching)

### Dream State (Long-term): Visual + Logic Automation
**"Have cake and eat it too" scenario**

- Show AI a device assembly via Gemini Live
- Provide: 8 stations, worker skill matrix, output goals (1,000 units/day)
- AI generates optimized station-by-station instructions
- Worker skill matching, workflow optimization

**Realistic Timeline:** Not Phase 1, maybe future exploration

---

## Technical Requirements & Constraints

### Input Data Available

**They Provide:**
1. **3D CAD Data** (Creo software)
   - Complete device models
   - Component-level detail
   - Can explode views, slice through, show flexes/connectors
   - Very powerful but unclear if AI can use directly (exploration needed)

2. **Component Drawings** (Two Types)
   - **Component-level:** How manufacturer makes the part (dimensions, adhesive placement, etc.)
   - **Assembly-level:** Exploded views showing what parts go where (loosely)
   - Not sufficient alone to create work instructions

3. **Physical Prototype**
   - Actual device engineers can photograph
   - Engineers manually take all photos currently

4. **Assembly Strategy Knowledge**
   - Station count decisions
   - Worker skill assignments (future phase)
   - Quality checkpoint placement
   - Test procedure sequencing

### What AI Must Generate

**Document Structure:**
- Component breakdown (all parts laid out)
- Step-by-step assembly instructions
- Photos with annotations (red arrows, callouts, placement indicators)
- Quality checkpoints ("Stop, do inspection #1")
- Test procedures ("Run electronics test at this point")
- Go-no-go gauge instructions
- Specific placement guidance with visual aids

**Visual Requirements:**
- Photos of components and assemblies
- Red arrows and callout boxes
- Annotations for specific placement/techniques
- Clear enough for high school education workers

**Format:**
- Editable output (Google Slides or similar)
- Print-ready for factory floor stations
- 4-10 pages per station (50-200 pages total per product)

### Security & IP Requirements (CRITICAL)

**Customer IP Protection:**
- Devices they manufacture are often "new to the world"
- Detailed assembly information is customer IP
- Cannot have data going into public cloud models for training
- Cannot risk exposure to competitors

**RAMP IP Ownership:**
- Knowledge base they build should be "ring-fenced" as their IP
- If they train on 100 work instructions over 6 months, that's theirs
- Not just using ChatGPT where knowledge leaks into general model

**Dereck's Security Solution:**
- Enterprise contracts with AI providers (Claude, ChatGPT, Grok, Gemini)
- Models not trained on customer data
- Encrypted input/output
- Secure private database (hosted locally or private cloud server)

**Dereck's Model Strategy:**
- Don't use local on-device models (too inflexible)
- Use multiple AI models for different strengths:
  - Claude: Business logic, coding, complex reasoning
  - ChatGPT: Design and visual work
  - Grok: Certain specialized tasks
  - Gemini: Potential for visual assembly understanding
- Enterprise contracts ensure privacy across all

---

## The Process Discussion (How It Would Work)

### Phase 1 Approach: Interview + Document Generation

**Dereck's Proposed Process:**

1. **Engineer Interview System**
   - AI asks structured questions about each component
   - "What component is this?"
   - "How is it attached? (Adhesive, snap-fit, screws, etc.)"
   - "Any special handling requirements?"
   - "Placement logic and criteria?"
   - Quick information relay vs. building entire doc manually

2. **Document Extraction from Existing Data**
   - Pull information from CAD files (if accessible)
   - Extract from component/assembly drawings
   - Gap-fill with interview for missing context

3. **Image Upload System**
   - Create user interface to secure database
   - Someone (potentially entry-level worker) takes photos
   - Upload with metadata: "What component? What angle? What step?"
   - Doesn't require high skill level - clear process with guidance

4. **Document Generation**
   - AI assembles text instructions based on interview data
   - Places images in appropriate locations
   - *Unknown feasibility:* Can AI generate red arrows/annotations effectively?
   - Output editable format for engineer review

5. **Knowledge Base Growth**
   - System learns patterns: adhesive techniques, plastic handling, quality checks
   - Stores valuable information for reuse
   - Logic: Determine what's new/reusable knowledge vs. one-off specifics
   - Automate storage of valuable patterns

### What Can't Be Automated Yet (Phase 1)

**Dereck's Honest Unknowns:**
- ❓ Visual annotation generation (red arrows, callout boxes) - need to experiment
- ❓ CAD integration feasibility - depends on Creo APIs/access
- ❓ How much assembly logic can be automated vs. engineer input required
- ❓ Quality checkpoint placement logic
- ❓ Station assignment optimization

**Joe K's Question:** "What needs to be done to supercharge engineers?"
**Dereck's Answer:** Don't require engineer to figure out all info needed - that's same as writing instructions. Instead:
- Quick interview (faster than manual build)
- Extract from existing documents where possible
- Phase 2: Remove engineer from more of the process

---

## Scope Definition & Expectations

### Joe K's Input/Process/Output Framework

**INPUT:**
- Component drawings
- Component pictures
- CAD information
- Physical prototype

**PROCESS:**
- Take inputs and generate output (what we're proposing to build)

**OUTPUT:**
- Assembly instructions (50-200 pages)
- Instructions per station

**Expectation Setting:**
- "My experience with AI is you don't get 100% accuracy"
- "If we can get it 50-70% there, we'll manually do the rest"
- "Then figure out how to improve the process so human interaction reduces going forward"

**Goal:** Speeding up and fast-tracking engineers, not replacing them

### Station Assignment Context

**Dave's Explanation:**
- One person doesn't do all 50-200 pages
- Maybe 10 people on assembly line
- Pages 6-8 belong at station 1 (adhesive for display)
- Pages 9-12 at station 2 (different assembly)
- Physically print and post relevant pages at each station
- Different skill sets per station (soldering, complex assembly, basic assembly)

**Scope Simplification:**
- Joe K: "Ignore skill levels of staff at first, just generate instructions"
- "Pretty simple task for us to assign who goes on what station"
- Saj agreed: "Yeah, that would be 'have cake and eat it too' - that's down the road"

### Dereck's Positioning

**On Domain Knowledge:**
> "I'm going to have to learn your process. I'm going to need you guys to teach me manufacturing specifics, and I'll apply AI expertise to solve the workflow problem."

**On Starting Simple:**
> "We want to start with as simple of a process as we can, then start chipping away at deeper logic and deeper logic, more complex processes."

**On Phase Definition:**
> "Let's define what our main goal is, then backtrack: In order to do that, we need to start here."

**On Unknowns:**
> "There's a lot here that I don't see yet. I'm going to discover through the process."

---

## Proposal Requirements (From Joe K)

### What Joe K Wants to See

**Architectural Approach:**
- How the solution would actually work
- What components would be needed
- What's off-the-shelf vs. custom build
- What needs to be licensed and purchased
- Where does it need to run (cloud, local, hybrid)

**Structure:**
- Not just "here's what we'll do"
- Want to understand "how it's built and deployed"

**Dereck's Response:**
> "I can tell you what database I'd recommend, hosted on either a local server in-house accessible remotely, or a private server in the cloud that's trusted. That stuff will be detailed in the proposal."

### Proposal Contents (Confirmed)

**Must Include:**
1. Phase 0: Paid Discovery scope and pricing
2. Phase 1: MVP implementation overview
3. Architecture approach (databases, hosting, APIs)
4. Security approach (enterprise contracts, encryption)
5. Licensing requirements (AI model subscriptions)
6. IP ownership structure
7. Timeline for delivery

**Recipients:**
- Saj Patel
- Joe Kreidler
- Joe Brennan
- Dave Briggs

**Deadline:** End of this week (Friday, February 6, 2026)

---

## Key Insights & Observations

### They've Done Their Homework
- Tried ChatGPT and other AI tools themselves
- Realistic about limitations ("decent results but not engineering-level")
- Understand AI won't be 100% accurate
- Open to 50-70% automation with manual refinement

### Security Is Non-Negotiable
- Customer IP at stake (new-to-world devices)
- RAMP's competitive advantage (knowledge base ownership)
- Enterprise contracts and encryption required
- This will affect pricing and architecture

### Phased Mindset Is Native
- Joe B confirmed: "Very common in their industry to approach projects this way"
- They call it "Phase Zero" (discovery)
- Regroup and re-quote between phases
- Comfortable with unknowns and iterative refinement

### Engineering Rigor Expected
- Dave wanted to know about CAD integration immediately
- Joe K pushed for architectural detail in proposal
- They're technical people who want to understand how it works
- Not just "trust us, AI magic happens"

### Joe B's Strategic Intervention
- Saved Dereck from having to define full scope prematurely
- Asked Joe K to define proposal structure he wanted
- "I always wait... don't want to interfere" but jumped in perfectly
- Industry knowledge helped set realistic expectations

---

## What Success Looks Like (Defined)

### Phase 1 (Interview-Based)
✅ Engineer spends 30-60 minutes in AI interview vs. 2-6 weeks manual build
✅ AI generates 50-70% complete work instructions
✅ Output is editable (Google Slides or similar)
✅ Engineer refines/completes remaining 30-50%
✅ Total time reduced from 2-6 weeks to maybe 3-7 days

### Phase 2 (Knowledge Base)
✅ System remembers component handling patterns
✅ Assembly technique library builds over time
✅ Each new project gets faster as knowledge grows
✅ Engineers spend less time on each successive project

### Long-term Vision
✅ Show AI the assembly, get optimized instructions
✅ Worker skill matching automation
✅ Station optimization for throughput goals
✅ Quality checkpoint auto-placement
✅ Minimal engineer time required

---

## Questions Still Outstanding

### Technical Unknowns
- Can AI generate effective visual annotations (red arrows, callouts)?
- Is Creo CAD data accessible via API or export?
- How to determine what knowledge is reusable vs. one-off?
- What assembly logic can be extracted from drawings vs. requires interview?

### Business Unknowns
- What's their budget for Phase 0 discovery?
- Timeline expectations for implementation?
- How many products do they ramp per year? (ROI calculation)
- Are they building this for internal use or to offer clients as a service?

### Process Unknowns
- Who would take the photos? (Engineer, tech, entry-level worker?)
- Who reviews and approves final work instructions?
- How do they currently store/version control work instructions?
- What's their current tech stack beyond Creo?

---

## Action Items

### For Dereck (This Week)
- ✅ Debrief with Joe B (completed same day)
- [ ] Research Creo CAD software capabilities and APIs
- [ ] Draft Phase 0 discovery proposal ($5-7K range)
- [ ] Define architecture (database, hosting, AI model access)
- [ ] Document security approach (enterprise contracts, encryption)
- [ ] Outline IP ownership structure
- [ ] Send proposal by Friday Feb 6 to all four recipients

### For Joe B
- [ ] Provide manufacturing proposal templates
- [ ] Review Dereck's draft for industry terminology
- [ ] Help format proposal in their expected style
- [ ] Advise on pricing based on industry norms

### For RAMP Team
- Waiting for proposal
- No immediate actions requested

---

## Quotes Worth Remembering

**Saj on the problem:**
> "It usually takes anywhere between two to six weeks for an engineer to do. It's a lot of effort. And sometimes you have to redo it."

**Saj on dream state:**
> "If I had my cake and eat it too, I would have Gemini Live looking at me, I could literally put together a device, and then say 'lay me out work instructions according to capabilities of workers and number of stations.'"

**Joe K on expectations:**
> "My experience with AI is that you don't get 100% accuracy, right? And that's accepted. But if we can get it 50-70% there, we'll manually do the rest."

**Joe K on goal:**
> "Replacing the engineer isn't really the goal. It's speeding them up, fast-tracking them."

**Dereck on process:**
> "We want to start with as simple of a process as we can, and then just start chipping away at deeper logic and deeper logic and all that stuff."

**Dave on skill levels:**
> "We got people with high school education sometimes. Nothing wrong with that. But they're not all trained technically. Instructions need to be very clear and detailed."

**Joe B on proposal approach:**
> "Very common in their industry to approach a project this way. Phase zero is come together, let's start this out. As we move from phase to phase, we're going to re-quote, re-imagine."

---

## Meeting Tone & Energy

**Overall Vibe:** Professional, collaborative, realistic

**Saj:** Visionary, excited about AI potential, sets the vision
**Dave:** Practical, operations-focused, asks technical questions
**Joe K:** Analytical, wants architectural detail, holds feet to fire
**Joe B:** Strategic advisor, intervenes at key moments, calming presence
**Dereck:** Honest about unknowns, focused on phased value delivery

**Chemistry:** Good. They're technical enough to appreciate complexity, realistic enough to accept limitations, and excited enough to invest in exploration.

---

**Transcript Prepared by:** Claude Code
**Date:** February 3, 2026
**Status:** ✅ Complete
**Next:** Joe B debrief call, then proposal creation
