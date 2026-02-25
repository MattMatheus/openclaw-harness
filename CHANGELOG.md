# Changelog

## 2026-02-25

### Added

- Initial OpenClaw harness contract capsule (`contracts/openclaw-bootstrap/`).
- Nonce startup lock documentation and policy controls.
- Seeded contract set (control plane, stage gates, metadata, content safety).
- Prompt pack for planner, stages, and operators.
- SEDA safety and semantic densification documentation.
- Non-technical bootstrap helper script:
  - `scripts/bootstrap-shell-literals.sh`
- Docs safety linter:
  - `scripts/check-docs-safety.sh`
- Event examples:
  - `examples/events/good-event-batch.yaml`
  - `examples/events/rejected-event-batch.yaml`
- Security policy:
  - `SECURITY.md`
- Operator decision tree:
  - `contracts/openclaw-bootstrap/docs/operator-decision-tree.md`
- Security-control PR nonce gate documentation:
  - `contracts/openclaw-bootstrap/docs/security-controls-pr-gate.md`

### Changed

- Repository docs polished for GitHub readiness.
- Naming shifted to user-facing "OpenClaw Harness" language.
- Enforced startup nonce disclosure as a required precondition before any stage progression in lock contract definitions.
- Added guardrail automation via CODEOWNERS, CI invariant checks, anti-downgrade checks, and a maintainer-only PR nonce gate scaffold.
- Tightened agent-side security-change contract and made nonce-gated security controls explicit invariants.
