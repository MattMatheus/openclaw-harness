# GitHub Readiness Checklist

Use this checklist before publishing this repository.

## Naming

- Preferred repository name: `openclaw-harness`
- Description suggestion:
  - `Mediated, policy-bound harness for replayable OpenClaw bootstrap workflows.`

## Documentation quality

- `README.md` clearly routes non-technical and technical users.
- Non-technical guide exists and is copy/paste friendly.
- Engineering guide documents architecture, gates, and replay model.
- Nonce lock behavior is documented.
- Quickstart prompts are present.

## Safety and privacy

- No prohibited vendor/person-specific references in generated harness docs.
- No secrets in docs, prompts, manifests, or example logs.
- Disclosure controls and deny patterns are present and enforced.
- Seed sanitization record exists.

## Contract completeness

- `contract.yaml` includes:
  - stage DAG
  - allowed transitions
  - risk bindings
  - required host probes
  - termination criteria
- All stage docs exist.
- All policy docs exist.
- Manifests include version lock and image digest structure.

## Operator usability

- Helper script exists: `scripts/bootstrap-shell-literals.sh`
- Generated user bootstrap artifacts documented.
- Operator checkpoints documented.

## Final pre-push checks

1. Confirm seed provenance docs are present and sanitized.
2. Run content scan for prohibited references on generated harness paths.
3. Review all changed files for clarity and consistency.
4. Commit with a message like:
   - `docs: polish harness docs and prepare GitHub release`
