# Stage: fetch

## Purpose

Acquire required OpenClaw artifacts under harness mediation.

## Constraints

- Every download must include exact version pin.
- Every download must include digest or signature verification.
- `Fetch` without lock entry is denied.

## Interactive Gate

- Supervisor approval required before any `R3+` event dispatch.

## Required Outputs

- `artifacts/fetch/fetch-log.jsonl`
- `artifacts/fetch/verification-log.jsonl`
- `artifacts/fetch/materialized-lock.json`

