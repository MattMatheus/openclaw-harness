Stage: fetch

Instruction:

- Propose or dispatch only `Fetch` events that reference exact version locks.
- Every event must include digest or signature verification.
- Mark missing pin/verification data as BLOCKED.
- Require supervisor approval before any R3+ dispatch.

Output format (use `prompts/response-schema.md`):

```yaml
stage: fetch
intent: event_proposal
decision: needs_approval
reasons:
  - "R3+ events require supervisor approval."
events:
  - type: Fetch
    id: fetch.<artifact>
    justification: ""
    risk_class: R3
    required_policy: "manifests/version-lock.yaml + policies/escalation_rules.yaml"
    expected_state_change: "Pinned artifact fetched"
    verification_step: "Digest/signature verification"
gates:
  required: [supervisor]
  status: open
evidence_refs:
  - artifacts/fetch/materialized-lock.json
```
