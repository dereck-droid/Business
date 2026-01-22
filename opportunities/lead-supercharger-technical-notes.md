# Lead Supercharger - Technical Considerations & Build Notes

**Purpose:** Capture technical decisions, open questions, and implementation details as we design the system

**Status:** Pre-build planning phase

---

## Database Design

### Requirements to Define:
- [ ] **What data needs to be stored?**
  - OAuth tokens (GHL access tokens, refresh tokens)
  - Customer/location mappings (GHL Location ID → customer account)
  - Custom field ID mappings (per location)
  - Billing/subscription data
  - Usage metrics (enrichments per customer)
  - Error logs and monitoring data
  - Webhook delivery status

- [ ] **Schema considerations**
  - Multi-tenancy approach (one DB for all customers)
  - Indexing strategy for performance
  - Data retention policies
  - Backup and recovery plan

- [ ] **Security requirements**
  - Encryption at rest (OAuth tokens, API keys)
  - Row-level security (Supabase RLS)
  - Audit logging for compliance

### Initial Database Tables (Draft):

```
customers
- id (uuid)
- ghl_location_id (text, unique)
- company_name (text)
- oauth_access_token (encrypted)
- oauth_refresh_token (encrypted)
- stripe_customer_id (text)
- subscription_status (enum)
- created_at (timestamp)
- updated_at (timestamp)

custom_field_mappings
- id (uuid)
- customer_id (uuid, foreign key)
- field_name (text)
- ghl_field_id (text)
- created_at (timestamp)

enrichment_logs
- id (uuid)
- customer_id (uuid, foreign key)
- contact_id (text)
- enrichment_status (enum: success, failed, partial)
- api_response (jsonb)
- error_message (text, nullable)
- processed_at (timestamp)

billing_events
- id (uuid)
- customer_id (uuid, foreign key)
- event_type (enum)
- amount (numeric)
- stripe_event_id (text)
- created_at (timestamp)
```

---

## GHL API Integration

### Custom Field ID Retrieval Strategy

**Problem:** When using HTTP requests (not native n8n GHL nodes), we need custom field IDs instead of names

**Solution Approach:**
1. On marketplace app installation, make API call: `GET /locations/{locationId}/customFields`
2. Use Code node to filter and map fields by name
3. Store mappings in database: `field_name → ghl_field_id`
4. Use stored IDs in subsequent HTTP requests

**Implementation Steps:**
- [ ] Create function to fetch all custom fields for a location
- [ ] Create Code node to parse and map: `{field_name: "CV Name", field_id: "abc123"}`
- [ ] Store mappings in `custom_field_mappings` table
- [ ] Create helper function to retrieve field IDs by name from database
- [ ] Handle field ID changes (if customer deletes/recreates fields)

**Example Code Node Logic:**
```javascript
// Input: GHL API response with all custom fields
// Output: Array of {name, id} objects for our specific fields

const ourFields = [
  'Lead Score',
  'Company Size',
  'Industry',
  // ... all 40+ fields we create
];

const fieldMappings = items[0].json.customFields
  .filter(field => ourFields.includes(field.name))
  .map(field => ({
    name: field.name,
    id: field.id
  }));

return fieldMappings;
```

**Error Handling:**
- What if custom fields are deleted by user?
- Should we auto-recreate them or notify customer?
- Cache invalidation strategy

---

## Infrastructure & Architecture

### Hosting Decision: n8n Cloud vs Self-Hosted

| Factor | n8n Cloud | Self-Hosted (Railway/Render) |
|--------|-----------|------------------------------|
| **Cost at scale** | $20-50/mo + execution fees | $20-50/mo flat |
| **Maintenance** | Zero | Manual updates, monitoring |
| **Reliability** | High (managed SLA) | Depends on hosting provider |
| **Customization** | Limited | Full control |
| **Scalability** | Auto-scaling | Manual scaling config |
| **Data residency** | n8n servers | Your chosen region |

**Decision needed:** Which hosting approach aligns with our goals?

**Considerations:**
- Do Alex & Nate prefer managed service or control?
- What's the projected scale (# of customers)?
- Is data residency a concern for customers?
- Do we anticipate needing custom n8n nodes?

---

### Workflow Architecture: Monolith vs Microservices

**Option A: Single Workflow for All Customers**
```
Webhook receives all leads
  ↓
Lookup customer OAuth tokens from DB
  ↓
Enrich via API
  ↓
Write back to correct GHL location
```

**Pros:**
- ✅ Simple to manage (one workflow to debug/update)
- ✅ Easy to deploy changes (update once, affects all)
- ✅ Centralized error handling and monitoring
- ✅ Lower n8n execution costs (fewer workflow instances)

**Cons:**
- ⚠️ Single point of failure (if workflow breaks, all customers affected)
- ⚠️ Harder to isolate customer-specific issues
- ⚠️ May hit rate limits or performance bottlenecks at scale

---

**Option B: Router + Separate Workflows per Customer**
```
Main webhook endpoint
  ↓
Router workflow (identifies customer)
  ↓
Triggers customer-specific workflow
  ↓
Each customer has isolated enrichment workflow
```

**Pros:**
- ✅ Fault isolation (one customer's issue doesn't affect others)
- ✅ Customer-specific customization possible
- ✅ Easier to debug individual customer problems
- ✅ Can pause/disable specific customers without affecting others

**Cons:**
- ❌ Complex to manage (100s of workflows)
- ❌ Deployment nightmare (updating logic requires touching all workflows)
- ❌ Higher n8n costs (more workflow executions)
- ❌ Harder to maintain consistency

---

**Option C: Hybrid - Single Workflow with Pooled Execution**
```
Webhook receives all leads
  ↓
Queue system (Supabase or Redis)
  ↓
Worker workflow(s) process queue
  ↓
Write back to respective GHL locations
```

**Pros:**
- ✅ Best of both worlds (fault tolerance + manageability)
- ✅ Built-in rate limiting and backpressure handling
- ✅ Easy to scale (add more workers)
- ✅ Can retry failed enrichments
- ✅ Better observability (queue depth = system health)

**Cons:**
- ⚠️ More infrastructure complexity (need queue system)
- ⚠️ Slightly higher latency (async processing)

---

### Recommended Architecture: **Option C (Hybrid with Queue)**

**Why:**
1. **Scalability:** Can handle 10 customers or 10,000 without architectural changes
2. **Reliability:** Failed enrichments go back in queue, don't block others
3. **Observability:** Queue depth shows system health, easy to monitor
4. **Cost-efficient:** Process in batches, optimize API calls
5. **Future-proof:** Easy to add features like priority queues, scheduled retries

**Implementation:**
- Use Supabase table as simple queue (or Redis if we need more throughput)
- Single webhook receives all leads → writes to queue
- Worker workflow polls queue → processes → marks complete
- Can scale to multiple workers if needed

---

## Scalability Targets

### Questions to Answer:
- [ ] How many customers do we expect in Year 1?
- [ ] Average leads per customer per month?
- [ ] Peak load scenarios (what if one customer gets 10K leads in a day)?
- [ ] Budget for infrastructure?

### Rough Calculations:

**Assumptions:**
- 100 customers at scale
- 500 leads per customer per month
- 50,000 total enrichments/month

**Infrastructure needs:**
- Database: Standard Supabase tier ($25/mo) handles 50GB, way more than needed
- n8n: Self-hosted on Railway ($20/mo) or n8n Cloud ($50/mo)
- Enrichment API: Costs passed through to customers

**Bottlenecks to monitor:**
- GHL API rate limits (100 requests per 10 seconds per location)
- Enrichment API rate limits (unknown, need to confirm with Alex/Nate)
- Database connection pool (Supabase default: 60 connections)
- n8n execution limits (cloud: 5K executions/month on starter)

---

## Security Considerations

### Must-Haves:
- [ ] **OAuth token security**
  - Store encrypted in database (Supabase encryption at rest)
  - Never log tokens in n8n executions
  - Rotate refresh tokens regularly

- [ ] **Webhook authentication**
  - Validate incoming webhooks are from legitimate GHL locations
  - Use signature verification if GHL supports it
  - Rate limit webhook endpoint to prevent abuse

- [ ] **API key management**
  - Environment variables for enrichment API keys
  - Separate keys per environment (dev, staging, prod)
  - Key rotation policy

- [ ] **Data privacy**
  - GDPR compliance (if applicable)
  - Data retention policy (how long do we keep enrichment logs?)
  - Customer data deletion on account cancellation

---

## Monitoring & Observability

### What to Monitor:
- [ ] **System health**
  - Webhook endpoint uptime
  - Queue depth (if using queue architecture)
  - Database connection pool usage
  - n8n workflow execution success rate

- [ ] **Per-customer metrics**
  - Enrichments per day
  - Success vs. failure rate
  - API response times
  - Error patterns

- [ ] **Business metrics**
  - Active customers
  - Total enrichments processed
  - Revenue (via Stripe webhooks)

### Alerting Strategy:
- Slack/email alerts for:
  - Workflow execution failures (> 5% failure rate)
  - Database connection issues
  - Enrichment API downtime
  - Customer-specific errors (> 10 failures in 1 hour)

---

## Performance Optimization

### Strategies to Consider:
- [ ] **Batch processing** - Group multiple leads, enrich in single API call (if supported)
- [ ] **Caching** - Cache enrichment data for duplicate contacts (same email/phone)
- [ ] **Parallel execution** - Process multiple leads concurrently in n8n
- [ ] **Lazy field creation** - Only create GHL custom fields as needed, not all 40+ upfront

---

## Open Questions (To Discuss with Alex & Nate)

1. **Enrichment API specifics:**
   - What's the rate limit?
   - Does it support batch enrichment (multiple leads in one request)?
   - What's the typical response time (sync or async)?
   - How do we handle "no data found" vs. "API error"?

2. **Business model:**
   - Are enrichment costs included in customer subscription?
   - Do we need to track usage for billing?
   - What happens if a customer exceeds their plan limits?

3. **Customer support:**
   - Who handles "my leads aren't getting enriched" support tickets?
   - Do we need a customer dashboard to show enrichment status?
   - What level of logging/visibility do customers need?

4. **Data retention:**
   - How long do we keep enrichment logs?
   - Do customers need historical data export?
   - GDPR/privacy considerations?

---

## Decision Log

| Date | Decision | Rationale | Status |
|------|----------|-----------|--------|
| 2026-01-22 | Use HTTP requests instead of native n8n GHL nodes | More control, avoids credential management complexity | ✅ Decided |
| TBD | Hosting: Cloud vs self-hosted | Pending cost/scale analysis | 🤔 Open |
| TBD | Architecture: Monolith vs queue-based | Pending scalability target definition | 🤔 Open |

---

## Next Steps

- [ ] Get enrichment API documentation from Alex/Nate
- [ ] Define scalability targets (# customers, leads/month)
- [ ] Choose hosting approach (cloud vs self-hosted)
- [ ] Design database schema
- [ ] Prototype custom field ID retrieval logic
- [ ] Decide on architecture (monolith vs queue)
- [ ] Create monitoring/alerting plan

---

**Last Updated:** 2026-01-22
