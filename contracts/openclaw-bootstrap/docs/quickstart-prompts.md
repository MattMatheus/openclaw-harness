# Quickstart for Human Operators (Simple)

This is the shortest safe path to run the contract interactively.

## Step-by-step

1. Start at stage `probe`.
2. Ask for host fact event proposals only (no execution).
3. Review proposed facts and risk labels.
4. Continue to `plan`.
5. Review install plan and approvals required.
6. Approve transition from `plan` to `fetch` only if plan is complete.
7. For each R3+ event in `fetch`, require supervisor approval.
8. For each R4 event anywhere, require human approval.
9. Run `verify` and review findings.
10. Confirm before entering `harden`.
11. Complete `report` and archive artifacts.

## Copy/paste prompt suggestions

Use these prompts with the planner/harness interface.

### Probe

```text
Begin at stage probe. Propose ProbeHost events only.
Do not execute anything.
Enumerate required host facts for OS, package manager, container runtime, privilege model, and network constraints.
Return typed event proposals with justification, risk_class, required_policy, expected_state_change, verification_step.
```

### Plan

```text
Move to stage plan.
Build an idempotent install event plan from probe facts.
No execution.
Include risk mapping, policy references, and approval gates.
```

### Approval gate after plan

```text
Human approval checkpoint:
Show all proposed stage transitions and all R3/R4 events that require escalation before dispatch.
```

### Fetch

```text
Stage fetch:
Propose or dispatch only locked artifacts.
Every fetch must include exact version pin and digest/signature verification step.
Flag any missing lock data as blocked.
```

### Install

```text
Stage install:
Apply idempotent actions only.
Require explicit Elevate event before any privileged mutation.
Record pre/post state and no-op decisions.
```

### Verify

```text
Stage verify:
Validate installed version against lock, integrity records, runtime health, exposed ports, and secret leakage controls.
Return compliance findings and readiness for harden.
```

### Harden gate

```text
Human confirmation checkpoint:
Summarize hardening changes and their risk class before proceeding.
```

### Report

```text
Stage report:
Produce final report, event ledger, replay index, and durable artifact manifest.
Confirm replayability and invariant compliance.
```

## Nonce lock prompts

### Stop immediately

```text
STOP ALL WORK
```

### Resume with nonce

```text
RESUME WORK: <nonce>
```

If nonce is invalid, work must remain locked and operator should review `docs/nonce-lock.md`.

