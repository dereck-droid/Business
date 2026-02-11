# File Versioning & Deprecation System

**Created:** 2026-01-30
**Purpose:** Track document versions, identify current/deprecated files, prevent conflicting information
**Status:** Active Protocol

---

## Problem Statement

As projects evolve, multiple versions of proposals, strategies, and documentation accumulate. Without a clear versioning system, we face:

- **Conflicting information** across documents
- **Unclear which version is current**
- **Risk of acting on outdated information**
- **Difficulty tracking decision evolution**

This system provides a method to mark files as current, deprecated, or superseded.

---

## File Status Categories

### 🟢 CURRENT
**Definition:** The active, authoritative version to be used for decisions and actions.

**Markers:**
- File name may include `-CURRENT` suffix (optional)
- Contains status header: `**Status:** CURRENT`
- Date stamped with last update
- Clear indication of what it supersedes

**Rules:**
- Only ONE file per topic can be CURRENT
- Must be dated within relevant timeframe
- Must reflect latest decisions/information

**Example:**
```markdown
# Ben/EquityPro CRM Proposal - CURRENT
**Status:** CURRENT
**Date:** 2026-01-30
**Supersedes:** ben-equitypro-ghl-crm-proposal-v1.md, ben-equitypro-crm-replacement-proposal.md
```

---

### 🟡 ARCHIVED
**Definition:** Superseded by a newer version but retained for historical context.

**Markers:**
- File name includes `-ARCHIVED-[date]` suffix
- Contains deprecation header at TOP of file
- Links to the file that supersedes it

**Rules:**
- Must link to current version
- Must state WHY it was superseded
- Must be dated

**Example:**
```markdown
# ⚠️ ARCHIVED - 2026-01-29
**This document has been superseded by:** [ben-equitypro-smartlead-ghl-proposal-CURRENT.md](./ben-equitypro-smartlead-ghl-proposal-CURRENT.md)
**Reason:** Scope changed from GHL-only to SmartLead+GHL two-platform architecture based on expert consultation
**Original Date:** 2026-01-29

---

# [Original content follows below]
```

---

### 🔴 DEPRECATED
**Definition:** No longer relevant, incorrect, or based on outdated assumptions. Should not be used.

**Markers:**
- File name includes `-DEPRECATED-[date]` suffix
- Contains deprecation warning at TOP of file
- Explains why it's no longer valid

**Rules:**
- Must state clearly why it's deprecated
- Should link to current approach (if one exists)
- Can be deleted after 90 days if no historical value

**Example:**
```markdown
# ❌ DEPRECATED - 2026-01-29
**DO NOT USE THIS DOCUMENT**
**Reason:** Based on incorrect assumption that GHL alone could handle cold email at scale. Expert consultation revealed this approach risks domain blacklisting.
**Current Approach:** See [ben-smartlead-ghl-architecture-addendum.md](./ben-smartlead-ghl-architecture-addendum.md)
**Deprecated Date:** 2026-01-29

---

# [Original content follows below]
```

---

### 📋 REFERENCE
**Definition:** Background information, research, or context that isn't actionable but provides valuable context.

**Markers:**
- File name may include `-REFERENCE` suffix
- Contains reference header
- Clearly states its purpose

**Rules:**
- Not superseded, just contextual
- Timeless or historical value
- Not decision-making documents

**Example:**
```markdown
# Ben/EquityPro Meeting Strategy - October 2024 Call Analysis
**Status:** REFERENCE
**Purpose:** Historical context from October 2024 discovery call
**Date:** 2024-10-15
**Use Case:** Background research when preparing for re-engagement
```

---

## File Naming Conventions

### Standard Format
```
[client-name]-[document-type]-[status]-[date].md
```

### Examples
```
ben-equitypro-crm-proposal-CURRENT-2026-01-30.md
ben-equitypro-crm-proposal-ARCHIVED-2026-01-29.md
ben-equitypro-meeting-notes-REFERENCE-2024-10-15.md
ben-equitypro-pricing-v1-DEPRECATED-2026-01-25.md
```

### Versioning Schemes

**Option 1: Date-based (Recommended for proposals/strategies)**
```
proposal-2026-01-30.md  (most recent = current)
proposal-2026-01-29.md  (archived)
proposal-2026-01-25.md  (archived)
```

**Option 2: Semantic versioning (For technical docs)**
```
architecture-v2.1.md (current)
architecture-v2.0.md (archived)
architecture-v1.0.md (archived)
```

**Option 3: Status suffix (For mixed documents)**
```
proposal-CURRENT.md
proposal-ARCHIVED-2026-01-29.md
proposal-DEPRECATED-2026-01-25.md
```

---

## Implementation Protocol

### When Creating New Document

1. **Check for existing files** on same topic
2. **Determine relationship** to existing files
3. **Mark status clearly** at top of file
4. **Link to related documents** if applicable

### When Updating Existing Document

#### Minor Updates (same scope/approach)
1. Update the date in the file
2. Note what changed in a changelog section
3. Keep same file name

#### Major Updates (scope/pricing/approach changes)
1. Rename old file with `-ARCHIVED-[date]` suffix
2. Add deprecation header to old file
3. Create new file with `-CURRENT` suffix
4. Link old file to new file
5. Explain what changed in new file header

#### Complete Pivot (old approach invalid)
1. Rename old file with `-DEPRECATED-[date]` suffix
2. Add deprecation warning to old file
3. Create new file with current approach
4. Explain in both files why approach changed

### Monthly Review Process

**First Monday of each month:**
1. Review all files in critical directories (`/opportunities`, `/communications`, `/strategic-pivot-*`)
2. Identify files without status markers
3. Mark files as CURRENT, ARCHIVED, DEPRECATED, or REFERENCE
4. Rename files according to conventions
5. Add supersession links where applicable
6. Delete DEPRECATED files older than 90 days (if no historical value)

---

## Directory-Specific Rules

### `/opportunities/` Directory

**Rule:** Each client should have ONE CURRENT proposal/strategy file.

**Structure:**
```
opportunities/
├── [client-name]-proposal-CURRENT.md          ← Active proposal
├── [client-name]-strategy-CURRENT.md          ← Active strategy
├── [client-name]-proposal-ARCHIVED-[date].md  ← Previous versions
├── [client-name]-meeting-notes-REFERENCE.md   ← Historical context
└── [client-name]-analysis-REFERENCE.md        ← Research/analysis
```

**Application Example:**
```
opportunities/
├── ben-equitypro-proposal-CURRENT-2026-01-30.md
├── ben-equitypro-strategy-CURRENT-2026-01-30.md
├── ben-equitypro-proposal-ARCHIVED-2026-01-29.md
├── ben-equitypro-proposal-ARCHIVED-2026-01-25.md
├── ben-equitypro-meeting-notes-REFERENCE-2024-10-15.md
└── ben-equitypro-architecture-analysis-REFERENCE-2026-01-29.md
```

### `/communications/` Directory

**Rule:** Time-stamped communications are inherently versioned by date. Status markers less critical.

**Structure:**
```
communications/
├── follow-ups/
│   └── YYYY-MM-DD-[client-name].md
├── transcripts/
│   └── YYYY-MM-DD-[meeting-name].md
└── sessions/
    └── YYYY-MM-DD-[session-name].md
```

**Note:** Date in filename serves as version. Most recent = current.

### Root Directory Strategy Files

**Rule:** High-level strategy files should be marked clearly.

**Examples:**
- `FOCUS.md` - Always current, updated in place
- `STATUS-DASHBOARD.md` - Always current, updated in place
- `strategic-pivot-[topic].md` - Date in content shows currency

---

## Conflict Resolution

### When Multiple "Current" Files Exist

**Diagnostic Questions:**
1. Which has the most recent date?
2. Which reflects the latest decision/information?
3. Which is referenced by other current documents?
4. Which has been acted upon (contracts sent, work started)?

**Resolution:**
1. Determine the TRUE current version
2. Mark it as CURRENT
3. Mark others as ARCHIVED or DEPRECATED
4. Add supersession links
5. Document the decision

### When Scope Has Changed Across Versions

**Example:** Proposal started as $5K advisory, evolved to $19.5K implementation, now considering $30K comprehensive.

**Approach:**
1. Each scope is a DIFFERENT proposal
2. Don't archive old scopes unless explicitly rejected
3. Use descriptive names:
   - `ben-equitypro-proposal-advisory-CURRENT.md` ($5K option)
   - `ben-equitypro-proposal-implementation-CURRENT.md` ($19.5K option)
   - `ben-equitypro-proposal-comprehensive-CURRENT.md` ($30K option)
4. Have a master strategy file that explains relationships

---

## Special Cases

### Proposals with Multiple Options

**Scenario:** Single proposal with Tier 1, Tier 2, Tier 3 pricing.

**Approach:**
- One CURRENT proposal file
- Contains all tiers
- Clear about which tier is recommended
- No need to split into separate files

**Example:**
```markdown
# Ben/EquityPro AI Integration Proposal - CURRENT
**Status:** CURRENT
**Date:** 2026-01-30
**Recommended:** Tier 2 ($10-15K)

## Option 1: Advisory ($5K)
...

## Option 2: Quick Wins ($10-15K) ⭐ RECOMMENDED
...

## Option 3: Comprehensive ($20-30K)
...
```

### Strategy Files with Multiple Scenarios

**Scenario:** Meeting strategy file with multiple conversation paths.

**Approach:**
- One CURRENT strategy file
- Contains all scenarios/paths
- Clear about which to prioritize
- Update in place (don't create versions unless major pivot)

---

## Status Header Template

### For Documents at Top of File

```markdown
---
**Document Type:** [Proposal / Strategy / Analysis / Reference]
**Status:** [CURRENT / ARCHIVED / DEPRECATED / REFERENCE]
**Date:** YYYY-MM-DD
**Client/Topic:** [Name]
**Supersedes:** [Link to previous version, if applicable]
**Superseded By:** [Link to newer version, if applicable]
**Reason for Change:** [Why this version exists / why previous deprecated]
---
```

### Minimal Version (for less critical docs)

```markdown
**Status:** CURRENT
**Date:** 2026-01-30
```

---

## Changelog Best Practice

For documents that evolve over time, maintain a changelog:

```markdown
## Changelog

### 2026-01-30 - Major Update
- Changed from GHL-only to SmartLead+GHL architecture
- Updated pricing from $15-17K to $18-22K
- Added comprehensive copywriting option
- **Reason:** Expert consultation revealed GHL not suitable for cold email at scale

### 2026-01-29 - Initial Version
- Created proposal for GHL-only CRM implementation
- Pricing: $15-17K for 30-day rush
```

---

## Automation Opportunities

### Potential Scripts/Tools (Future Enhancement)

1. **Status Checker**
   - Scans directories for files without status markers
   - Reports files older than 30 days without CURRENT/ARCHIVED/DEPRECATED markers

2. **Supersession Linker**
   - When creating new version, automatically updates old version with "Superseded by" link
   - Prompts for reason for change

3. **Monthly Audit Report**
   - Lists all CURRENT files by directory
   - Flags files with conflicting dates/status
   - Suggests files for archival/deprecation

4. **Deprecated File Cleaner**
   - Identifies DEPRECATED files older than 90 days
   - Prompts for deletion or REFERENCE conversion

---

## Quick Reference Guide

### Creating New Document
```markdown
# Title - CURRENT
**Status:** CURRENT
**Date:** 2026-01-30

[Content]
```

### Archiving Old Version
1. Rename: `old-file.md` → `old-file-ARCHIVED-2026-01-29.md`
2. Add header:
```markdown
# ⚠️ ARCHIVED - 2026-01-29
**Superseded by:** [new-file-CURRENT.md](./new-file-CURRENT.md)
**Reason:** [Why superseded]

---

[Original content]
```

### Deprecating Invalid Document
1. Rename: `old-file.md` → `old-file-DEPRECATED-2026-01-29.md`
2. Add header:
```markdown
# ❌ DEPRECATED - 2026-01-29
**DO NOT USE**
**Reason:** [Why no longer valid]
**Current Approach:** [Link if applicable]

---

[Original content]
```

### Marking Reference Material
```markdown
# Title
**Status:** REFERENCE
**Purpose:** [Why this exists]
**Date:** 2026-01-30

[Content]
```

---

## Success Metrics

This system is successful when:

- ✅ Any team member can identify the current version of a document within 30 seconds
- ✅ No conflicting information across CURRENT documents
- ✅ Clear audit trail of how decisions evolved
- ✅ DEPRECATED files have clear reasons stated
- ✅ Monthly review takes < 30 minutes
- ✅ Zero instances of acting on outdated information

---

## Related Documents

- [POST-EVENT-UPDATE-PROTOCOL.md](./POST-EVENT-UPDATE-PROTOCOL.md) - Protocol for updating docs after events
- [SYSTEM-REQUIREMENTS.md](./SYSTEM-REQUIREMENTS.md) - Overall system requirements
- [FOCUS.md](./FOCUS.md) - Current focus and priorities (always CURRENT)

---

**Next Steps:**
1. Apply this system to all Ben/Equiypro files immediately
2. Audit `/opportunities/` directory and mark all files
3. Set calendar reminder for first Monday of each month for review
4. Update this document as system evolves

**Questions or Suggestions:** Update this document with improvements as we discover what works.
