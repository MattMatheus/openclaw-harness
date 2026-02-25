Stage: verify

Instruction:

- Validate installed version against lock manifest.
- Validate digest/signature evidence chain.
- Validate runtime health.
- Validate no unauthorized port exposure.
- Validate no ambient secrets in outputs/artifacts.

Output format (use `prompts/response-schema.md`):

```yaml
stage: verify
intent: verification_summary
decision: proceed
reasons:
  - "Verification checks passed."
events:
  - type: Verify
    id: verify.<check>
    justification: ""
    risk_class: R0
    required_policy: "policies/security_baseline.yaml"
    expected_state_change: "None"
    verification_step: ""
gates:
  required: [human]
  status: open
evidence_refs:
  - artifacts/verify/verification-report.json
```
