# Security Controls PR Nonce Gate

## Purpose

Require an additional maintainer-held, short-lived nonce for pull requests that modify security-critical harness controls.

This gate is distinct from the runtime stop/resume nonce.

## Protected Files

The nonce gate applies when a PR changes any of:

- `AGENTS.md`
- `SECURITY.md`
- `contracts/openclaw-bootstrap/**`
- `scripts/check-docs-safety.sh`
- `scripts/check-control-invariants.sh`
- `scripts/check-security-downgrade.sh`
- `.github/workflows/**`
- `.github/CODEOWNERS`

## Workflow

Implemented by:

- `.github/workflows/security-control-nonce-gate.yml`

Behavior:

1. On `pull_request_target`, list files changed in the PR.
2. If no protected files are changed, the gate exits successfully.
3. If protected files are changed, require:
   - repository secret `SECURITY_REVIEW_NONCE` to be set
   - PR body line `Security-Review-Nonce: <nonce>`
4. Gate passes only when the provided nonce exactly matches the secret.

## Maintainer Procedure

1. Generate a short-lived nonce for the review window.
2. Set repository secret `SECURITY_REVIEW_NONCE` to that nonce.
3. Share nonce with approved maintainers through a secure channel.
4. Ensure PR body includes `Security-Review-Nonce: <nonce>`.
5. Rotate or clear the secret after merge/close.

## Notes

- This gate is a scaffold for stronger change control.
- Pair this with branch protection and required status checks.
- Keep nonce lifetime short to reduce replay risk.
