# Stage: verify

## Purpose

Verify OpenClaw installation integrity, runtime viability, and policy compliance.

## Verification Domains

- Binary/package version matches lock.
- Artifact digest/signature records complete.
- Service/process state is expected.
- No unauthorized port exposure.
- No ambient secrets in config or logs.

## Allowed Events

- `ProbeHost`
- `Verify`
- `Report`

## Required Outputs

- `artifacts/verify/verification-report.json`
- `artifacts/verify/compliance-findings.json`
- `artifacts/verify/ready-for-harden.md`

