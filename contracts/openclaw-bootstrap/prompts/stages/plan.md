Stage: plan

Instruction:

- Build an idempotent event proposal DAG from probe facts.
- Include risk classification and approval gates per event.
- Do not dispatch any event.
- Prepare explicit human approval checkpoint for plan -> fetch.

Required checks:

- No direct shell semantics.
- No secret material.
- No prohibited vendor/personal references.

Output format (use `prompts/response-schema.md`):

```yaml
stage: plan
intent: event_proposal
decision: needs_approval
reasons:
  - "Human approval required before fetch stage."
events:
  - type: <typed event>
    id: <stable-id>
    justification: ""
    risk_class: <R0|R1|R2|R3|R4>
    required_policy: ""
    expected_state_change: ""
    verification_step: ""
gates:
  required: [human]
  status: open
evidence_refs:
  - artifacts/plan/install-plan.json
```
