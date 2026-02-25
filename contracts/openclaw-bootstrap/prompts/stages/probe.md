Stage: probe

Instruction:

- Propose `ProbeHost` events only.
- Do not propose execution.
- Enumerate host facts:
  - OS
  - package manager
  - container runtime presence
  - privilege model
  - network constraints

Output format (use `prompts/response-schema.md`):

```yaml
stage: probe
intent: event_proposal
decision: proceed
reasons:
  - "Host facts required for safe planning."
events:
  - type: ProbeHost
    id: probe.<fact>
    justification: ""
    risk_class: R0
    required_policy: ""
    expected_state_change: "None"
    verification_step: ""
gates:
  required: [none]
  status: not_required
evidence_refs: []
```
