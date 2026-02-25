# Stage: install

## Purpose

Install OpenClaw with idempotent state transitions and explicit authority boundaries.

## Idempotency Contract

- Installation checks desired state marker before mutation.
- Re-running stage must converge to same installed version and config hash.
- Existing compliant state must result in no-op events.

## Allowed Events

- `Exec` (scoped, deterministic arguments only)
- `WriteFile`
- `ServiceChange` (if approved and policy-bound)
- `Elevate` (required before privileged mutation)

## Required Outputs

- `artifacts/install/install-events.jsonl`
- `artifacts/install/state-before.json`
- `artifacts/install/state-after.json`

