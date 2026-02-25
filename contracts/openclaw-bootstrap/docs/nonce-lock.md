# Nonce Lock: Startup and Stop/Resume Control

## Purpose

Provide an operator-controlled runtime lock that can immediately stop interactive work and safely resume only with a startup nonce.

## Startup Behavior

1. Harness generates a nonce at runtime startup.
2. Nonce is disclosed to the user once.
3. Nonce is retained in memory only.
4. Nonce must never be written to files, logs, prompts, or durable artifacts.

## Stop Commands

The following user messages immediately lock the contract into QA-only mode:

- `STOP WORK`
- `STOP ALL WORK`
- `STOP OPENCLAW`

## QA-only Mode Semantics

While locked:

- No command execution.
- No skill execution.
- No MCP/tool execution.
- No stage progression or side-effect proposals.
- Only direct question-and-answer responses are allowed.

## Resume Command

Required format:

`RESUME WORK: <nonce>`

Behavior:

- Exact nonce match: unlock and resume normal interactive workflow.
- Invalid nonce: hard rejection and redirect user to this document.

## Invalid Nonce Response Template

```text
RESUME REJECTED: invalid nonce.
Interactive work remains locked in QA-only mode.
See: contracts/openclaw-bootstrap/docs/nonce-lock.md
```

## Startup Disclosure Template

```text
STARTUP LOCK ACTIVE.
To resume work after any STOP command, use:
RESUME WORK: <nonce>
Store this nonce securely; it is not persisted by the system.
```

