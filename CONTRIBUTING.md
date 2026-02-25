# Contributing

## Purpose

Contributions must preserve safety, auditability, and non-technical usability.

## Required before PR merge

1. Run docs safety checks:

```bash
bash scripts/check-docs-safety.sh
```

2. Ensure no prohibited disclosure appears in generated harness artifacts.
3. Ensure required event envelope fields are preserved in examples/contracts.
4. Update docs when behavior or policy changes.
5. Add/update `CHANGELOG.md` entry.

## Contribution rules

- Do not weaken approval gates (`plan->fetch`, R3+, R4, `verify->harden`).
- Do not add raw secrets, credentials, or personal identifiers.
- Do not bypass pinned version + digest/signature requirements.
- Keep user-facing docs clear for non-technical operators.
- Keep seed provenance sanitized and do not reintroduce raw seed content containing personal or vendor-specific details.

## Suggested PR checklist

- [ ] Safety checks pass.
- [ ] Docs updated.
- [ ] Changelog updated.
- [ ] Replay/audit semantics preserved.
- [ ] No prohibited disclosure in generated harness content.
