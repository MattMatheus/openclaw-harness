# Stage: report

## Purpose

Publish replayable, auditable completion artifacts and close the contract.

## Output Requirements

- Full ordered event ledger with hashes.
- Stage-by-stage approvals and gate decisions.
- Final compliance statement against invariants.
- Durable artifact manifest with locations and checksums.

## Allowed Events

- `Report`
- `Verify` (final integrity verification of logs/artifacts)

## Required Outputs

- `artifacts/report/final-report.md`
- `artifacts/report/event-ledger.jsonl`
- `artifacts/report/artifact-manifest.json`
- `artifacts/report/replay-index.json`

