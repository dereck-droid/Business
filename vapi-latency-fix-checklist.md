# VAPI Latency Fix - Action Checklist

## Problem Identified
**Endpointing latency: 2,293ms average** (should be 400-600ms max)
- This is the delay waiting to detect when you stop speaking
- Accounts for 63% of total turn latency
- Target: Reduce total latency from 3,630ms to 750-900ms

## Immediate Actions (Do These In Order)

### ✅ Step 1: Switch Transcriber Provider
**Current:** (Check your VAPI dashboard)
**Change to:** Deepgram Flux OR LiveKit

**How:**
1. Open VAPI dashboard → Your "Alex" assistant
2. Find "Transcriber" or "Speech Configuration" section
3. Provider dropdown → Select "Deepgram"
4. Model dropdown → Select "Flux" (or "Nova-2" if Flux not available)
5. **Alternative:** Select "LiveKit" as provider
6. Save changes

**Expected improvement:** Reduces endpointing by ~1000ms

---

### ✅ Step 2: Adjust Endpointing Sensitivity
**Current setting:** Likely 1000ms (default)
**Change to:** 400ms

**How:**
1. In same "Speech Configuration" or "Transcriber Settings" section
2. Look for one of these labels:
   - "Endpointing Threshold"
   - "Silence Duration"
   - "End of Speech Detection"
   - "Turn Detection Timeout"
3. Change value from 1000ms → **400ms**
4. Save changes

**Expected improvement:** Reduces endpointing by ~600ms

---

### ✅ Step 3: Optimize Start Speaking Plan
**What this controls:** How long to wait after different types of speech

**Option A: Via Dashboard (if available)**
Look for "Start Speaking Plan" or "Turn Detection Settings":
- On Punctuation: **0.3 seconds** (300ms)
- On No Punctuation: **0.5 seconds** (500ms)
- On Numbers: **0.4 seconds** (400ms)

**Option B: Via API (if dashboard doesn't have these settings)**
Use VAPI API to update assistant with:
```json
{
  "transcriber": {
    "provider": "deepgram",
    "model": "nova-2",
    "endpointing": 400
  },
  "startSpeakingPlan": {
    "onPunctuationSeconds": 0.3,
    "onNoPunctuationSeconds": 0.5,
    "onNumberSeconds": 0.4
  }
}
```

**Expected improvement:** Reduces endpointing by additional ~300-500ms

---

### ✅ Step 4: Optimize Voice Provider (Optional)
**Current:** Likely ElevenLabs standard model
**Consider switching to:**

**Option A: ElevenLabs Turbo v2.5**
- Faster latency than standard models
- Still high quality
- Best balance of speed + naturalness

**Option B: PlayHT 3.0**
- Often faster for real-time
- Test quality vs. ElevenLabs

**How:**
1. VAPI dashboard → Voice settings
2. If using ElevenLabs: Select "Turbo v2.5" model
3. OR switch provider to PlayHT and select "3.0" model
4. Test voice quality (make sure it still sounds professional)
5. Save if quality is acceptable

**Expected improvement:** Reduces voice latency by ~100-150ms

---

### ✅ Step 5: Reduce Max Tokens (Small Optimization)
**Current:** Likely 150-200
**Change to:** 100

**Why:** Forces even more concise responses, reduces LLM processing time slightly

**How:**
1. VAPI dashboard → Model Configuration
2. Find "Max Tokens" or "Max Completion Tokens"
3. Change to **100**
4. Save changes

**Expected improvement:** Reduces LLM latency by ~50-100ms

---

## Testing After Changes

### Run 3 Test Calls
After making changes above, call your VAPI number 3 times and test:

**Test Scenarios:**
1. Short responses: "Hi, I'm testing the AI"
2. Medium responses: "I run a roofing company with about 5,000 old leads"
3. Longer responses: "I'm interested in automation but I'm not sure what I need. Can you tell me more about what you offer?"

### Check New Analytics
After 3 calls, check VAPI analytics for:

**Target Metrics:**
- Total Turn Latency: **750-900ms** (acceptable range)
- Endpointing: **400-600ms** (down from 2,293ms!)
- Voice: **300-450ms** (depends on provider)
- LLM: **400-550ms** (depends on prompt complexity)
- Transcriber: **250-350ms** (should stay similar)

**If still above 1,500ms total:** Something is wrong
- Check that changes actually saved
- Try switching transcriber providers again
- Contact VAPI support with analytics screenshot

**If below 600ms total:** Might be too fast
- Increase endpointing to 500-600ms
- Watch for assistant interrupting callers mid-sentence

---

## Optimal Settings Summary

| Setting | Recommended Value | Why |
|---------|------------------|-----|
| Transcriber Provider | Deepgram Flux or LiveKit | Best endpointing detection |
| Endpointing Threshold | 400ms | Balance speed + accuracy |
| On Punctuation Wait | 300ms | Quick but not interruptive |
| On No Punctuation Wait | 500ms | Allows natural pauses |
| Voice Provider | ElevenLabs Turbo v2.5 | Fast + quality |
| LLM Model | GPT-4o | Good speed/intelligence balance |
| Max Tokens | 100 | Forces conciseness for voice |
| Temperature | 0.7 | Natural variation |

---

## Troubleshooting

### "I can't find endpointing settings in dashboard"
- Look under different names: "Turn Detection", "Speech Configuration", "Silence Detection"
- May need to use VAPI API to set these (check API docs)
- Some settings only available via API, not dashboard

### "Assistant is interrupting me now"
- Endpointing is too aggressive
- Increase threshold from 400ms → 500ms or 600ms
- Increase "onNoPunctuationSeconds" to 0.7 or 0.8

### "Latency is still high after changes"
- Verify changes actually saved (refresh dashboard)
- Check that new transcriber provider is active
- Try completely different transcriber (switch from Deepgram to LiveKit or vice versa)
- Check if your prompt is too long (though 4,500 words should be fine)

### "Voice quality decreased after switching providers"
- Try different voice within same provider
- Test multiple voices from ElevenLabs, PlayHT, Azure
- Sometimes need to sacrifice slight quality for speed
- Find the best balance for your use case

---

## Expected Results

**Before optimization:**
- Total latency: 3,630ms
- Feels sluggish and awkward
- Long pauses between caller finishing and Alex responding

**After optimization:**
- Total latency: 750-900ms
- Feels natural and conversational
- Responsive without being interruptive
- Professional impression

---

## If This Doesn't Fix It

Contact VAPI support with:
- Your assistant ID
- Screenshot of latency analytics (before and after)
- Settings you've tried
- Request help optimizing endpointing specifically

They can sometimes adjust backend settings not available in dashboard.

---

## Research Sources

Based on VAPI documentation and community best practices:
- Endpointing latency is most common cause of sluggish responses
- Default ASR timeouts often wait full 1 second (too long)
- 300-500ms endpointing works for most use cases
- Deepgram Flux and LiveKit have best turn detection
- Sub-750ms can cause interruptions; 750-900ms is sweet spot

This is a known, solvable issue - you should see dramatic improvement after Step 1 & 2 alone!
