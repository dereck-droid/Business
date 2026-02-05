# Intelligent Call Filtering

## Overview

This document describes the multi-layered validation system that filters out non-sales calls before processing them through the AI analysis pipeline. This prevents wasting AI credits on internal meetings, no-shows, test recordings, and other non-relevant calls.

**Created:** 2025-02-05
**Status:** Implemented in Fireflies webhook workflow
**Purpose:** Ensure only real sales calls are processed and saved to database

---

## Problem Statement

Without filtering, the workflow would process:
- ❌ Internal Retarget IQ-only meetings
- ❌ Calls where prospect was invited but never showed up (no-show)
- ❌ Calls where prospect joined briefly then dropped off (< 30 seconds)
- ❌ Test recordings or accidental captures
- ❌ Very short scheduling calls (< 2 minutes)
- ❌ Recordings where only host spoke

This wastes:
- AI processing costs (Claude Sonnet 4.5 is ~$3 per million tokens)
- Database storage
- Creates noise in contact records
- Sends false notifications to Slack

---

## Solution Architecture

### Data Source

Uses **Fireflies Analytics API** (`getTranscriptAnalytics` endpoint) which provides:
- Speaker-level metrics (duration, word count, questions asked)
- Speaking time percentages
- Monologue counts
- Filler word analysis

### Workflow Position

```
Fireflies Webhook
    ↓
Get Analytics of a Transcript (Fireflies API)
    ↓
Validate Real Sales Call (Code Node) ← FILTERING HAPPENS HERE
    ↓
Filter: is_real_call = true
    ├─ TRUE → Continue to transcript processing
    └─ FALSE → End (optionally log to monitoring)
```

---

## Validation Criteria

### Layer 1: Basic Structure

| Check | Threshold | Reasoning |
|-------|-----------|-----------|
| Has Retarget IQ speaker | >= 1 | Must have Nate, Cindy, Alex, or Calhoun |
| Has external speaker | >= 1 | Must have non-Retarget IQ speaker |
| Minimum speakers | >= 2 | Must be a conversation, not monologue |

### Layer 2: External Participation

| Check | Threshold | Reasoning |
|-------|-----------|-----------|
| External speaking time | >= 30 seconds (0.5 min) | No-show says "hi, can't hear you" (~10s) |
| External word count | >= 50 words | Quick "sorry I have to go" is ~20 words |
| External questions asked | >= 2 | Real prospects ask questions; no-shows don't |

### Layer 3: Conversation Quality

| Check | Threshold | Reasoning |
|-------|-----------|-----------|
| Total duration | >= 120 seconds (2 min) | Real sales calls are longer than quick check-ins |
| Total words | >= 200 | Meaningful conversation threshold |
| External participation % | >= 10% | Ensures external person wasn't mostly silent/muted |

### Layer 4: No-Show Pattern Detection

Combined check:
```javascript
externalSpeakingTime >= 30 seconds
AND externalWordCount >= 50 words
AND (externalQuestions >= 2 OR externalMonologues >= 1)
```

This catches scenarios where:
- Prospect joins, says "testing", leaves
- Connection issues cause choppy, incomplete participation
- Prospect is present but silent/muted entire call

---

## Implementation Code

**Node:** "Code in JavaScript1" (after "Get analytics of a transcript")

```javascript
// Access the correct nested path from Fireflies analytics
const responseData = $input.item.json;
const analytics = responseData.data?.analytics || responseData.analytics || {};
const speakers = analytics.speakers || [];

// Retarget IQ team members (expand as needed)
const RETARGETIQ_NAMES = ['nate', 'cindy', 'alex', 'calhoun', 'retarget'];

const retargetiqSpeakers = speakers.filter(s => {
    const name = (s.name || '').toLowerCase();
    return RETARGETIQ_NAMES.some(keyword => name.includes(keyword));
});

const externalSpeakers = speakers.filter(s => {
    const name = (s.name || '').toLowerCase();
    return !RETARGETIQ_NAMES.some(keyword => name.includes(keyword));
});

// Calculate metrics
const externalSpeakingTime = externalSpeakers.reduce((sum, s) => sum + (s.duration || 0), 0);
const externalWordCount = externalSpeakers.reduce((sum, s) => sum + (s.word_count || 0), 0);
const externalQuestions = externalSpeakers.reduce((sum, s) => sum + (s.questions || 0), 0);
const externalMonologues = externalSpeakers.reduce((sum, s) => sum + (s.monologues_count || 0), 0);

const totalSpeakers = speakers.length;
const totalDuration = speakers.reduce((sum, s) => sum + (s.duration || 0), 0);
const totalWords = speakers.reduce((sum, s) => sum + (s.word_count || 0), 0);

const externalParticipationPct = totalDuration > 0 ? (externalSpeakingTime / totalDuration) * 100 : 0;

// NOTE: Fireflies duration is in MINUTES, not seconds
const externalSpeakingSeconds = externalSpeakingTime * 60;
const totalDurationSeconds = totalDuration * 60;

// Validation criteria
const hasRetargetiqSpeaker = retargetiqSpeakers.length >= 1;
const hasExternalSpeaker = externalSpeakers.length >= 1;
const hasMinSpeakers = totalSpeakers >= 2;
const externalSpokeEnough = externalSpeakingTime >= 0.5; // 30 seconds = 0.5 minutes
const externalSaidEnough = externalWordCount >= 50;
const meaningfulDuration = totalDuration >= 2; // 2 minutes
const meaningfulWords = totalWords >= 200;
const balancedConversation = externalParticipationPct >= 10;
const notANoShow =
    externalSpeakingTime >= 0.5 &&
    externalWordCount >= 50 &&
    (externalQuestions >= 2 || externalMonologues >= 1);

const isRealCall =
    hasRetargetiqSpeaker &&
    hasExternalSpeaker &&
    hasMinSpeakers &&
    externalSpokeEnough &&
    externalSaidEnough &&
    meaningfulDuration &&
    meaningfulWords &&
    balancedConversation &&
    notANoShow;

// Build detailed reason for filtering
let failedChecks = [];
if (!isRealCall) {
    if (!hasRetargetiqSpeaker) failedChecks.push('No Retarget IQ team member spoke');
    if (!hasExternalSpeaker) failedChecks.push('No external speakers detected');
    if (!hasMinSpeakers) failedChecks.push('Only 1 speaker detected');
    if (!externalSpokeEnough) failedChecks.push(`External spoke only ${Math.round(externalSpeakingSeconds)}s (need 30s+)`);
    if (!externalSaidEnough) failedChecks.push(`External said only ${externalWordCount} words (need 50+)`);
    if (!meaningfulDuration) failedChecks.push(`Call only ${Math.round(totalDurationSeconds)}s (need 120s+)`);
    if (!meaningfulWords) failedChecks.push(`Only ${totalWords} words total (need 200+)`);
    if (!balancedConversation) failedChecks.push(`External only spoke ${Math.round(externalParticipationPct)}% of time`);
}

return {
    json: {
        is_real_call: isRealCall,
        filter_reason: failedChecks.join(' | '),
        confidence_score: isRealCall ? 100 : 0,

        // Detailed metrics for monitoring
        metrics: {
            external_speakers: externalSpeakers.length,
            retargetiq_speakers: retargetiqSpeakers.length,
            external_speaking_minutes: Math.round(externalSpeakingTime * 100) / 100,
            external_speaking_seconds: Math.round(externalSpeakingSeconds),
            external_word_count: externalWordCount,
            external_questions_asked: externalQuestions,
            external_monologues: externalMonologues,
            external_participation_pct: Math.round(externalParticipationPct),
            total_duration_minutes: Math.round(totalDuration * 100) / 100,
            total_duration_seconds: Math.round(totalDurationSeconds),
            total_words: totalWords,
            total_speakers: totalSpeakers
        },

        // Speaker names for debugging
        speaker_breakdown: {
            retargetiq: retargetiqSpeakers.map(s => ({
                name: s.name,
                duration_minutes: Math.round(s.duration * 100) / 100,
                words: s.word_count,
                questions: s.questions
            })),
            external: externalSpeakers.map(s => ({
                name: s.name,
                duration_minutes: Math.round(s.duration * 100) / 100,
                words: s.word_count,
                questions: s.questions
            }))
        }
    }
};
```

---

## Example Scenarios

### ✅ PASSES (Real Sales Call)

**Scenario:** Full 20-minute sales demo
```
External: 2 speakers
External speaking: 5 minutes (25% participation)
External words: 800
External questions: 15
Total duration: 20 minutes
Total words: 3200
Result: ✅ All criteria met
```

**Scenario:** Short 5-minute discovery call
```
External: 1 speaker
External speaking: 2 minutes (40% participation)
External words: 320
External questions: 8
Total duration: 5 minutes
Total words: 800
Result: ✅ Meets all minimums
```

### ❌ FILTERED OUT (Not Real Call)

**Scenario:** No-show (host waited 15 minutes)
```
External: 0 speakers (invited but never joined)
External speaking: 0 minutes
External words: 0
Total duration: 15 minutes (just Nate talking to himself)
Result: ❌ No external speakers detected
```

**Scenario:** Prospect joined briefly, connection issues
```
External: 1 speaker
External speaking: 15 seconds
External words: 25 ("Hey, can you hear me? I have to go")
Total duration: 3 minutes
Result: ❌ External spoke only 15s (need 30s+)
```

**Scenario:** Internal Retarget IQ meeting
```
External: 0 speakers (only Nate and Cindy)
Total duration: 30 minutes
Total words: 5000
Result: ❌ No external speakers detected
```

**Scenario:** Quick 90-second scheduling call
```
External: 1 speaker
External speaking: 45 seconds
External words: 75
Total duration: 90 seconds
Result: ❌ Call only 90s (need 120s+)
```

---

## Tuning Thresholds

If you're getting **false positives** (bad calls passing through):

| Increase This | From | To | Effect |
|---------------|------|-----|--------|
| External speaking time | 30s | 60s | Requires longer participation |
| External word count | 50 | 100 | Requires more conversation |
| Total duration | 120s | 180s | Only processes longer calls |
| Total words | 200 | 400 | Requires more substantial conversation |

If you're getting **false negatives** (good calls filtered out):

| Decrease This | From | To | Effect |
|---------------|------|-----|--------|
| External speaking time | 30s | 20s | Allows briefer participation |
| External word count | 50 | 30 | Allows fewer words |
| External questions | 2 | 1 | Less strict on questions asked |

---

## Monitoring & Debugging

### Add Slack Notification for Filtered Calls

Add this after the Filter node on the FALSE path:

```javascript
// Slack node on FALSE path
{
  "channel": "#dev-logs",
  "text": "🚫 Call filtered out",
  "blocks": [
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "*Call Filtered*\n\n*Reason:* {{ $json.filter_reason }}\n\n*Metrics:*\n- External spoke: {{ $json.metrics.external_speaking_seconds }}s\n- External words: {{ $json.metrics.external_word_count }}\n- Total duration: {{ $json.metrics.total_duration_seconds }}s\n- Questions asked: {{ $json.metrics.external_questions_asked }}\n\n*Recording:* {{ $('Get a transcript').item.json.data.transcript_url }}"
      }
    }
  ]
}
```

This lets you:
- See what's being filtered in real-time
- Spot false positives (good calls incorrectly filtered)
- Adjust thresholds based on actual data

### Query Filtered Calls

You can optionally save filtered calls to a separate table for analysis:

```sql
CREATE TABLE filtered_calls (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    meeting_id TEXT,
    filter_reason TEXT,
    metrics JSONB,
    filtered_at TIMESTAMPTZ DEFAULT NOW()
);
```

Then query to see patterns:

```sql
SELECT
    filter_reason,
    COUNT(*) as count
FROM filtered_calls
GROUP BY filter_reason
ORDER BY count DESC;
```

---

## Cost Savings

### Before Filtering
- 100 Fireflies recordings/month
- 40 are internal meetings, no-shows, tests
- AI processing: 100 calls × $0.15 = **$15/month**
- Database storage: 100 records

### After Filtering
- 100 Fireflies recordings/month
- 40 filtered out before processing
- AI processing: 60 calls × $0.15 = **$9/month**
- Database storage: 60 records
- **Savings: 40% reduction in costs + cleaner data**

---

## Maintenance

### Adding New Team Members

Update the `RETARGETIQ_NAMES` array:

```javascript
const RETARGETIQ_NAMES = [
    'nate',
    'cindy',
    'alex',
    'calhoun',
    'retarget',
    'newperson'  // Add new team member
];
```

### Seasonal Adjustments

During busy seasons, you might want to be more lenient:

```javascript
// BUSY SEASON (more calls, be lenient)
const externalSpokeEnough = externalSpeakingTime >= 0.33; // 20 seconds
const meaningfulDuration = totalDuration >= 1.5; // 90 seconds

// QUIET SEASON (fewer calls, be strict)
const externalSpokeEnough = externalSpeakingTime >= 1.0; // 60 seconds
const meaningfulDuration = totalDuration >= 3; // 3 minutes
```

---

## Testing

### Test Cases

Create test recordings for:
1. ✅ Normal 15-minute sales call
2. ❌ No-show (host only)
3. ❌ Brief connection test (< 30 seconds)
4. ✅ Short but real 3-minute call
5. ❌ Internal team meeting
6. ❌ Silent participant (external joined but didn't speak)

### Validation Script

Run this after implementing:

```javascript
// Test with known recording IDs
const testCases = [
    { id: "01KENF6A97RFX9K8SRR7CMB1GB", expected: true, name: "Aaron Wilson call" },
    { id: "no-show-recording-id", expected: false, name: "No-show test" }
];

// Run each through workflow and verify results match expected
```

---

## Future Enhancements

1. **Machine Learning**: Train model on filtered vs passed calls to improve accuracy
2. **Sentiment Analysis**: Filter out calls with very negative sentiment (angry customers)
3. **Language Detection**: Filter out non-English calls if not supported
4. **Custom Rules per Team Member**: Different thresholds for different sales reps
5. **Time-of-Day Filtering**: Internal meetings often happen at specific times

---

## References

- Fireflies API Documentation: https://docs.fireflies.ai/
- n8n Filter Node: https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.filter/
- Related Files:
  - `/retarget-iq/supabase-schema-complete.sql`
  - `/retarget-iq/proposal-automation-design.md`
