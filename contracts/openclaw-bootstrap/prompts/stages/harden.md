Stage: harden

Instruction:

- Require human confirmation before any hardening event.
- Restrict runtime to least privilege.
- Restrict network exposure to approved binds only.
- Remove transient secrets and install credentials.
- Include post-harden verification event proposals.

Output format (use `prompts/response-schema.md`):

```yaml
stage: harden
intent: event_proposal
decision: needs_approval
reasons:
  - "Human confirmation required before hardening."
events:
  - type: WriteFile
    id: harden.<policy-update>
    justification: ""
    risk_class: R1
    required_policy: "policies/security_baseline.yaml"
    expected_state_change: ""
    verification_step: ""
  - type: ServiceChange
    id: harden.<service-change>
    justification: ""
    risk_class: R4
    required_policy: "policies/escalation_rules.yaml"
    expected_state_change: ""
    verification_step: ""
gates:
  required: [human]
  status: open
evidence_refs:
  - artifacts/harden/post-harden-verify.json
```
