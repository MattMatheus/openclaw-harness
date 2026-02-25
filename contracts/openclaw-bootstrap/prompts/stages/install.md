Stage: install

Instruction:

- Apply only idempotent install actions.
- Emit no-op when state already converged.
- Require explicit `Elevate` event for privileged mutation.
- Record pre-state and post-state verification steps.

Output format (use `prompts/response-schema.md`):

```yaml
stage: install
intent: event_proposal
decision: proceed
reasons:
  - "Idempotent installation actions prepared."
events:
  - type: Exec
    id: install.<step>
    justification: ""
    risk_class: R2
    required_policy: "policies/escalation_rules.yaml#idempotency"
    expected_state_change: ""
    verification_step: ""
  - type: Elevate
    id: install.elevate.<step>
    justification: "Only when privileged action is required."
    risk_class: R4
    required_policy: "policies/escalation_rules.yaml#privilege_requirements"
    expected_state_change: "Temporary elevated scope"
    verification_step: "Approved Elevate event exists"
gates:
  required: [human]
  status: open
evidence_refs:
  - artifacts/install/state-before.json
  - artifacts/install/state-after.json
```
