# OpenClaw Harness

Mediated, replayable harness contract for bootstrapping OpenClaw with strict approval gates and audit trails.

Recommended GitHub repository name: `openclaw-harness`

## Why Do My Docs Look Weird?

Many docs are intentionally structured with dense schemas, strict fields, and event templates.
This is by design for safer operation, stronger policy enforcement, and better replay/audit.

See: `contracts/openclaw-bootstrap/docs/semantic-densification.md`

## Start here

For non-technical staff:

- `contracts/openclaw-bootstrap/docs/non-technical-bootstrap.md`
- `scripts/bootstrap-shell-literals.sh`
- `contracts/openclaw-bootstrap/docs/quickstart-prompts.md`
- `contracts/openclaw-bootstrap/docs/operator-decision-tree.md`

For operators and engineers:

- `contracts/openclaw-bootstrap/docs/engineering-guide.md`
- `contracts/openclaw-bootstrap/docs/seda-safety.md`
- `contracts/openclaw-bootstrap/docs/semantic-densification.md`
- `contracts/openclaw-bootstrap/docs/interactive-improvement.md`
- `contracts/openclaw-bootstrap/docs/full-harness-seeded.md`
- `contracts/openclaw-bootstrap/docs/security-upgrades.md`
- `contracts/openclaw-bootstrap/docs/replay-instructions.md`
- `contracts/openclaw-bootstrap/docs/github-readiness.md`

Core safety controls:

- `contracts/openclaw-bootstrap/docs/nonce-lock.md`
- `contracts/openclaw-bootstrap/docs/security-controls-pr-gate.md`
- `contracts/openclaw-bootstrap/docs/invariants.md`
- `contracts/openclaw-bootstrap/policies/`
- `SECURITY.md`

Contribution and release docs:

- `CONTRIBUTING.md`
- `CHANGELOG.md`

## Seed provenance

This repository keeps sanitized seed provenance documentation only.
See:

- `contracts/openclaw-bootstrap/docs/seed-sanitization.md`
