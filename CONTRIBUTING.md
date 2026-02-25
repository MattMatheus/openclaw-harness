# Contributing

## Purpose

Contributions must preserve safety, auditability, and non-technical usability.

## Required before PR merge

1. Run docs safety checks:

```bash
bash scripts/check-docs-safety.sh
```

2. Run control invariant checks:

```bash
bash scripts/check-control-invariants.sh
```

3. Run anti-downgrade checks:

```bash
bash scripts/check-security-downgrade.sh
```

4. Ensure no prohibited disclosure appears in generated harness artifacts.
5. Ensure required event envelope fields are preserved in examples/contracts.
6. Update docs when behavior or policy changes.
7. Add/update `CHANGELOG.md` entry.
8. If PR changes security-control files, include:
   - `Security-Review-Nonce: <nonce>` in the PR body.

## Contribution rules

- Do not weaken approval gates (`plan->fetch`, R3+, R4, `verify->harden`).
- Do not add raw secrets, credentials, or personal identifiers.
- Do not bypass pinned version + digest/signature requirements.
- Keep user-facing docs clear for non-technical operators.
- Keep seed provenance sanitized and do not reintroduce raw seed content containing personal or vendor-specific details.

## Suggested PR checklist

- [ ] Safety checks pass.
- [ ] Control invariants check passes.
- [ ] Anti-downgrade check passes.
- [ ] Docs updated.
- [ ] Changelog updated.
- [ ] Replay/audit semantics preserved.
- [ ] No prohibited disclosure in generated harness content.
