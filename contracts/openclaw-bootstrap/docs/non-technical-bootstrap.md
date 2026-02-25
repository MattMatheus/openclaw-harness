# Non-Technical Bootstrap

Use this helper script to generate copy/paste shell literals and prompt text:

```bash
bash scripts/bootstrap-shell-literals.sh
```

Generated output:

- `artifacts/user-bootstrap/harness-literals.sh`
- `artifacts/user-bootstrap/harness-prompts.txt`
- `artifacts/user-bootstrap/README.txt`

What it does:

- Provides simple commands to view harness docs/prompts.
- Provides simple prompt snippets for stage-by-stage operation.

What it does not do:

- Does not install OpenClaw.
- Does not execute harness side effects.
- Does not bypass approvals or policy gates.

