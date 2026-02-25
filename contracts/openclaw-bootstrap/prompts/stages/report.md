Stage: report

Instruction:

- Produce final event ledger and replay index.
- Include approval chain and gate decisions.
- Include compliance summary against invariants.
- Include sanitization verification summary.

Output format (use `prompts/response-schema.md`):

```yaml
stage: report
intent: final_report
decision: proceed
reasons:
  - "All required stages complete and artifacts persisted."
events:
  - type: Report
    id: report.final
    justification: "Finalize replayable audit package."
    risk_class: R0
    required_policy: "contracts/openclaw-bootstrap/docs/replay-instructions.md"
    expected_state_change: "Final report artifacts persisted"
    verification_step: "Replay index resolves all artifact references"
gates:
  required: [none]
  status: not_required
evidence_refs:
  - artifacts/report/final-report.md
  - artifacts/report/event-ledger.jsonl
  - artifacts/report/replay-index.json
```
