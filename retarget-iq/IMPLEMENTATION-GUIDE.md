# Retarget IQ: Email Knowledge Base Implementation Guide

**Project:** AI Support System + Pricing Database
**Client:** Retarget IQ (Nate Calhoun & Alex Ciereszko)
**Budget:** $7,000
**Deadline:** Extended (TBD)

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [Prerequisites](#prerequisites)
4. [Step-by-Step Implementation](#step-by-step-implementation)
5. [Testing & Validation](#testing--validation)
6. [Client Deliverables](#client-deliverables)
7. [Troubleshooting](#troubleshooting)

---

## 🎯 Project Overview

### Objective
Build an AI-powered support knowledge base by:
1. Extracting all support and pricing email threads from their Gmail
2. Categorizing threads using AI (support vs pricing)
3. Storing in Supabase database
4. Building a chat interface for support team to query the knowledge base

### Current Status
- ✅ Client paid $7,000 (upgraded from $4,500)
- ✅ Timeline extended (no immediate deadline pressure)
- ✅ Scope refined: No Slack bot initially, just chat interface
- ⏳ Support team needs this urgently (2 new hires onboarding)

### Why This Approach
- **Real data:** Using actual support emails = better training than theoretical FAQs
- **Scalable:** Automated categorization handles hundreds of threads
- **Maintainable:** Structured database allows easy updates and searches
- **Client-friendly:** Simple review interface for them to approve/edit

---

## 🏗️ Architecture

```
Gmail Inbox
    ↓
[Google Apps Script] ← Export complete threads
    ↓
CSV File (one row = one thread)
    ↓
[n8n Workflow] ← AI classification
    ↓
[Supabase Database]
    ├─ support_threads table
    └─ pricing_threads table
    ↓
[Chat Interface] ← RAG system queries database
    ↓
[GHL Embedded iframe] ← Support team access
```

---

## ✅ Prerequisites

### Accounts & Access Needed
- [x] Gmail access to Retarget IQ support inbox
- [ ] Supabase account (free tier works)
- [ ] n8n instance (self-hosted or cloud)
- [ ] OpenAI API key OR Anthropic API key
- [ ] GoHighLevel admin access (for iframe embedding)

### Tools Required
- Google Sheets (for Apps Script)
- Web browser
- Text editor (for reviewing/editing CSV if needed)

### Estimated Time
- **Setup:** 2-3 hours
- **Email export:** 30 minutes - 1 hour
- **n8n workflow:** 2-3 hours
- **Testing:** 1-2 hours
- **Total:** ~8 hours for data pipeline

---

## 🚀 Step-by-Step Implementation

### Phase 1: Export Gmail Threads to CSV

#### Step 1.1: Set Up Google Apps Script

1. **Open Google Sheets**
   - Go to [sheets.google.com](https://sheets.google.com)
   - Create a new blank spreadsheet
   - Name it: "Retarget IQ Email Export"

2. **Open Apps Script Editor**
   - Click: `Extensions` → `Apps Script`
   - Delete any default code
   - Copy the entire contents of `gmail-thread-export-script.js`
   - Paste into the editor
   - Name the project: "Gmail Thread Exporter"

3. **Configure Search Query**
   - Find the `SEARCH_QUERY` constant at the top of the script
   - Update with Retarget IQ's support email:
     ```javascript
     const SEARCH_QUERY = 'to:support@retargetiq.com OR from:support@retargetiq.com';
     ```
   - Optional: Add date filter to limit scope:
     ```javascript
     const SEARCH_QUERY = '(to:support@retargetiq.com OR from:support@retargetiq.com) after:2024/01/01';
     ```

4. **Adjust Batch Size (if needed)**
   - Find `MAX_THREADS` constant
   - Default is 500 (to avoid timeout)
   - For large exports, run multiple times with date filters

#### Step 1.2: Run the Export

1. **First Run - Authorization**
   - Click the "Run" button (▶️) or select `exportGmailThreadsToSheet` from dropdown
   - You'll see: "Authorization required"
   - Click "Review Permissions"
   - Select your Google account
   - Click "Advanced" → "Go to Gmail Thread Exporter (unsafe)"
   - Click "Allow"

2. **Monitor Progress**
   - Check "Execution log" tab in Apps Script editor
   - You'll see progress updates every 50 threads
   - Wait for "Export complete!" message

3. **Review Results in Sheet**
   - Go back to your Google Sheet
   - You should see columns:
     - Thread ID
     - Subject
     - First Message Date
     - Last Message Date
     - Number of Messages
     - Participants
     - Complete Thread Content
     - Preview

#### Step 1.3: Download as CSV

1. **Download the File**
   - In Google Sheets: `File` → `Download` → `Comma Separated Values (.csv)`
   - Save as: `retarget-iq-emails.csv`

2. **Quick Quality Check**
   - Open CSV in text editor or Excel
   - Verify:
     - Each row is a complete thread (not individual emails)
     - "Complete Thread Content" column has full conversations
     - No obvious errors or corrupted data

---

### Phase 2: Set Up Supabase Database

#### Step 2.1: Create Supabase Project

1. **Sign Up / Log In**
   - Go to [supabase.com](https://supabase.com)
   - Create account or log in
   - Click "New Project"

2. **Configure Project**
   - Organization: (select or create)
   - Name: `retarget-iq-kb`
   - Database Password: (generate strong password - save this!)
   - Region: Choose closest to your location
   - Pricing Plan: Free tier is fine for now
   - Click "Create new project"

3. **Wait for Setup**
   - Takes 1-2 minutes to provision database
   - You'll see a loading screen

#### Step 2.2: Create Database Schema

1. **Open SQL Editor**
   - In Supabase dashboard, click "SQL Editor" in left sidebar
   - Click "New Query"

2. **Run Schema Script**
   - Open `supabase-schema.sql` from the project files
   - Copy the entire contents
   - Paste into SQL Editor
   - Click "Run" (or press Ctrl/Cmd + Enter)

3. **Verify Creation**
   - You should see success messages in the Results panel
   - Check "Table Editor" in left sidebar
   - You should see:
     - `support_threads` table
     - `pricing_threads` table

4. **Save API Credentials**
   - Go to "Settings" → "API"
   - Copy and save securely:
     - `Project URL` (e.g., https://xxxxx.supabase.co)
     - `anon/public` key (for frontend)
     - `service_role` key (for n8n - keep secret!)

---

### Phase 3: Build n8n Workflow

#### Step 3.1: Set Up n8n

**Option A: Cloud (Recommended for speed)**
- Go to [n8n.io](https://n8n.io)
- Sign up for free trial
- Create new workflow

**Option B: Self-Hosted**
- Install n8n: `npx n8n`
- Open: http://localhost:5678
- Create new workflow

#### Step 3.2: Add Credentials

1. **Supabase Credential**
   - In n8n: Click your profile → "Credentials"
   - Click "Add Credential"
   - Search for "Supabase"
   - Fill in:
     - Host: Your Supabase Project URL
     - Service Role Secret: Your service_role key
   - Save

2. **OpenAI Credential** (or Anthropic)
   - Add Credential → "OpenAI"
   - Enter your OpenAI API key
   - Save

#### Step 3.3: Build the Workflow

Follow the detailed workflow design in `n8n-workflow-design.md`. Here's the quick version:

**Node 1: Manual Trigger**
- Add "Manual Trigger" node to start

**Node 2: Read Binary File**
- Add "Read Binary File" node
- File Path: Path to your CSV file
- Binary Property: `data`

**Node 3: Convert to JSON**
- Add "Spreadsheet File" node
- Operation: "Read from File"
- Format: CSV
- Options: "Header Row" = true

**Node 4: Split in Batches**
- Add "Split in Batches" node
- Batch Size: 10
- This prevents rate limiting

**Node 5: OpenAI (AI Classification)**
- Add "OpenAI" node
- Resource: "Message a Model"
- Model: `gpt-4-turbo-preview`
- System Message: Copy from `n8n-workflow-design.md` → AI Classification Prompt
- User Message: `{{ $json['Complete Thread Content'] }}`
- Response Format: JSON Object
- Temperature: 0.1

**Node 6: Code (Parse AI Response)**
- Add "Code" node
- Mode: "Run Once for Each Item"
- Language: JavaScript
- Code: Copy from `n8n-workflow-design.md` → AI Response Parsing section

**Node 7: Switch (Route by Category)**
- Add "Switch" node
- Mode: "Rules"
- Rule 0: `{{ $json.category }}` equals "SUPPORT" → Output 0
- Rule 1: `{{ $json.category }}` equals "PRICING" → Output 1
- Rule 2: Otherwise → Output 2

**Node 8: Supabase (Support Threads)**
- Add "Supabase" node (connect to Output 0)
- Operation: "Insert"
- Table: `support_threads`
- Data: `{{ $json.data }}`

**Node 9: Supabase (Pricing Threads)**
- Add "Supabase" node (connect to Output 1)
- Operation: "Insert"
- Table: `pricing_threads`
- Data: `{{ $json.data }}`

**Node 10: Merge (Optional - for logging)**
- Add "Merge" node to combine outputs
- Shows final statistics

#### Step 3.4: Test Workflow

1. **Create Test CSV**
   - Take first 3 rows from your full CSV
   - Save as `test-emails.csv`

2. **Run Test**
   - Update Read Binary File node path to test CSV
   - Click "Execute Workflow"
   - Watch execution flow

3. **Verify Results**
   - Check execution logs
   - Go to Supabase → Table Editor
   - Query `support_threads` and `pricing_threads`
   - Verify data inserted correctly

---

### Phase 4: Full Import

#### Step 4.1: Prepare for Large Import

1. **Check API Limits**
   - OpenAI: 3,500 requests/minute (Tier 2)
   - Adjust batch size if needed

2. **Update File Path**
   - Point "Read Binary File" node to full CSV
   - Save workflow

#### Step 4.2: Run Full Import

1. **Execute Workflow**
   - Click "Execute Workflow"
   - This may take 10-30 minutes depending on thread count

2. **Monitor Progress**
   - Watch execution panel
   - Check for errors
   - Note: Some threads may fail (API timeouts, etc.) - that's okay

3. **Handle Errors**
   - If workflow fails partway through, note which batch
   - You can restart from that point by modifying CSV

#### Step 4.3: Verify Data

1. **Check Counts**
   ```sql
   SELECT COUNT(*) FROM support_threads;
   SELECT COUNT(*) FROM pricing_threads;
   ```

2. **Spot Check Quality**
   ```sql
   SELECT subject, ai_category, ai_confidence_score
   FROM support_threads
   ORDER BY ai_confidence_score ASC
   LIMIT 10;
   ```

3. **Review Low Confidence Threads**
   - Look for confidence < 0.7
   - These may need manual review

---

### Phase 5: Client Review & Approval

#### Step 5.1: Create Review Interface (Simple)

**Option A: Supabase Table Editor (Quick & Dirty)**
- Give Nate/Alex access to Supabase project
- Show them Table Editor
- They can mark `approved_for_kb = true` directly

**Option B: Simple Web Interface** (Better UX)
- Build basic CRUD interface
- Show threads with approve/reject buttons
- Filter by category, confidence score
- Add notes field for edits

**For now, recommend Option A** to save time.

#### Step 5.2: Client Review Process

1. **Send Instructions**
   - Email Nate/Alex with Supabase login
   - Provide quick video walkthrough (Loom)
   - Ask them to review and approve threads

2. **What to Review**
   - Check AI categorization accuracy
   - Mark obviously wrong categories
   - Add notes for missing information
   - Approve high-quality, accurate threads

3. **Timeline**
   - Give them deadline: "Please review by [date]"
   - Expect 1-2 hours of their time
   - Offer to hop on call if they have questions

---

### Phase 6: Build Chat Interface (Next Stage)

**Note:** This is the next phase after data pipeline is complete. Documented separately.

**Quick Overview:**
1. Build RAG system using Supabase + OpenAI embeddings
2. Create simple chat UI (React/Vue/HTML)
3. Brand with Retarget IQ colors/logo
4. Embed in GHL via iframe
5. Test with support team
6. Iterate based on feedback

**Estimated Time:** 8-12 hours

---

## 🧪 Testing & Validation

### Automated Tests

#### Test 1: Email Export Accuracy
```
✓ Each CSV row = one complete thread
✓ All messages in thread included in "Complete Thread Content"
✓ Participants list is accurate
✓ Dates are correct
```

#### Test 2: AI Classification Accuracy
```
✓ Sample 20 random threads
✓ Manually categorize each (support vs pricing)
✓ Compare with AI categorization
✓ Target: 90%+ accuracy
```

#### Test 3: Database Integrity
```sql
-- Check for duplicates
SELECT gmail_thread_id, COUNT(*)
FROM support_threads
GROUP BY gmail_thread_id
HAVING COUNT(*) > 1;

-- Check for missing required fields
SELECT * FROM support_threads
WHERE complete_thread_content IS NULL
   OR subject IS NULL
   OR gmail_thread_id IS NULL;
```

### Manual Review Checklist

- [ ] Export includes all relevant support emails
- [ ] No customer data leaked to wrong category
- [ ] AI summaries are accurate
- [ ] Confidence scores make sense
- [ ] Database schema matches requirements
- [ ] No sensitive data exposed in logs

---

## 📦 Client Deliverables

### Deliverable 1: Knowledge Base Database
- ✅ Supabase project with populated tables
- ✅ Admin access for Nate/Alex
- ✅ Documentation on querying data

### Deliverable 2: Data Pipeline Documentation
- ✅ Apps Script for future email exports
- ✅ n8n workflow for AI categorization
- ✅ Instructions for running updates

### Deliverable 3: Chat Interface (Next Phase)
- ⏳ Branded chat UI
- ⏳ RAG-powered AI responses
- ⏳ GHL integration
- ⏳ Support team training

### Deliverable 4: Documentation
- ✅ This implementation guide
- ✅ n8n workflow design docs
- ✅ Database schema documentation
- ⏳ End-user guide for support team

---

## 🐛 Troubleshooting

### Problem: Apps Script Times Out

**Cause:** Too many threads to process at once
**Solution:**
- Reduce `MAX_THREADS` to 250
- Add date filters to search query
- Run multiple exports and combine CSVs

### Problem: AI Classification is Inaccurate

**Cause:** Prompt needs tuning or examples unclear
**Solution:**
- Review low-confidence threads
- Update AI prompt with more specific rules
- Add few-shot examples to prompt
- Consider using Claude 3.5 Sonnet (often better at classification)

### Problem: Supabase Insert Fails - Duplicate Key

**Cause:** Thread already exists in database
**Solution:**
- Add deduplication check in n8n workflow (see advanced features in workflow design)
- Or use `ON CONFLICT` in SQL:
  ```sql
  INSERT INTO support_threads (...)
  VALUES (...)
  ON CONFLICT (gmail_thread_id) DO NOTHING;
  ```

### Problem: OpenAI Rate Limit Errors

**Cause:** Sending requests too fast
**Solution:**
- Increase batch delay in Split in Batches node
- Reduce batch size
- Upgrade OpenAI tier (if possible)

### Problem: CSV Has Special Characters That Break Import

**Cause:** Email content has quotes, commas, newlines
**Solution:**
- Apps Script handles escaping automatically
- If issues persist, try exporting to Google Sheets first, then download as CSV
- Use UTF-8 encoding

---

## 📊 Success Metrics

### Data Pipeline Success
- ✅ >90% of support emails successfully exported
- ✅ >85% AI classification accuracy
- ✅ <5% duplicate threads in database
- ✅ Zero data loss during import

### Business Impact (Post-Chat Interface)
- Support response time reduced by 50%
- Support team can handle 2x more tickets
- Consistency in answers improved
- New support hires ramp up 3x faster

---

## 🎯 Next Steps After Data Pipeline

1. **Review with Client**
   - Schedule call with Nate/Alex
   - Walk through database
   - Get approval on data quality
   - Gather feedback for chat interface

2. **Plan Chat Interface**
   - Gather branding assets (logo, colors)
   - Define UX flow with support team
   - Choose tech stack (recommend: Next.js + Tailwind + Supabase)
   - Estimate timeline: 1-2 weeks

3. **Build & Test**
   - Develop RAG system
   - Create chat UI
   - Test with sample support queries
   - Iterate based on feedback

4. **Deploy & Train**
   - Embed in GHL
   - Train support team (1-hour session)
   - Monitor usage first week
   - Fix bugs and optimize

5. **Maintain & Improve**
   - Set up monthly email exports to keep KB updated
   - Collect feedback from support team
   - Tune AI prompts based on usage
   - Expand KB with FAQ content from website

---

## 📞 Client Communication Points

### Initial Update (Send Now)
```
Hey Nate & Alex,

Quick update on the support KB project:

1. ✅ Built data pipeline to extract all support emails
2. ✅ AI categorization system ready
3. ⏳ Running import this weekend
4. ⏳ Will need ~1-2 hours of your time next week to review

I'll send database access early next week for review.

Timeline looking good - chat interface will be ready 1-2 weeks after data review.

- Dereck
```

### Mid-Project Update (After Import)
```
Nate & Alex,

Data import complete! Here's what we have:

📊 Statistics:
- X support threads imported
- Y pricing threads imported
- AI categorization: Z% confidence avg

Next: Need your review (link to Supabase below)
- Check AI categories are accurate
- Mark threads to include in KB
- Should take 1-2 hours

[Supabase Login Link]
[Loom Walkthrough Video]

Let me know when you're done and we'll move to chat interface.
```

### Final Delivery Update
```
Chat interface is live! 🎉

Access: [GHL Link]

Features:
✅ AI-powered support responses
✅ Trained on all your support history
✅ Copy/paste email threads → get AI response
✅ Branded for Retarget IQ

Next: Support team training (schedule 1-hour call?)

This should dramatically speed up your support workflow.
```

---

## 📁 Project Files

All files for this implementation:

```
/Business/retarget-iq/
├── IMPLEMENTATION-GUIDE.md        (this file)
├── gmail-thread-export-script.js  (Google Apps Script)
├── supabase-schema.sql            (Database schema)
├── n8n-workflow-design.md         (n8n workflow details)
└── README.md                      (Quick reference)
```

---

## 🎉 You're Ready!

You now have everything needed to:
1. ✅ Export Gmail threads to CSV
2. ✅ Set up Supabase database
3. ✅ Build n8n AI categorization workflow
4. ✅ Process all support emails into structured database
5. ✅ Deliver to client for review

**Estimated Total Time:** 8-10 hours
**Client Value:** $7,000
**Effective Hourly Rate:** $700-875/hr

Go build it! 🚀
