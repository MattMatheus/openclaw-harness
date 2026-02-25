# Stage: plan

## Purpose

Transform probe facts into an idempotent, policy-compliant install plan represented only as typed event proposals.

## Allowed Event Proposals

- `Exec` (proposal only; no dispatch)
- `Fetch` (proposal only; must reference pinned version + digest/signature)
- `WriteFile` (proposal only)
- `ServiceChange` (proposal only)
- `PortBind` (proposal only)
- `Elevate` (proposal only)
- `Verify` (proposal only)

## Interactive Gate

- Human approval required before transition to `fetch`.

## Required Outputs

- `artifacts/plan/install-plan.json`
- `artifacts/plan/risk-register.json`
- `artifacts/plan/approval-request.md`

