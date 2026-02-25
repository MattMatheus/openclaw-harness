## Agent Response Schema (Densified)

All agent-facing stage responses should use this structure.

```yaml
stage: "<probe|plan|fetch|install|verify|harden|report>"
intent: "event_proposal|gate_review|verification_summary|final_report"
decision: "proceed|block|needs_approval|needs_remediation"
reasons:
  - "<short reason>"
events:
  - type: "<ProbeHost|Exec|Fetch|WriteFile|ServiceChange|PortBind|Elevate|Verify|Report>"
    id: "<stable-event-id>"
    justification: "<why this action exists>"
    risk_class: "<R0|R1|R2|R3|R4>"
    required_policy: "<policy ref>"
    expected_state_change: "<specific state mutation or None>"
    verification_step: "<objective check>"
gates:
  required:
    - "<human|supervisor|none>"
  status: "open|approved|rejected|not_required"
evidence_refs:
  - "<artifact path or id>"
```

Hard requirements:

1. Include every required event field.
2. Use deterministic, audit-friendly wording.
3. Keep one mutation per event when possible.
4. Avoid narrative-only responses.

