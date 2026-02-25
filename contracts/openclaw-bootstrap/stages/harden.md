# Stage: harden

## Purpose

Apply post-install hardening to remove ambient risk and reduce runtime exposure.

## Interactive Gate

- Human confirmation required after `verify` and before `harden`.

## Hardening Targets

- Ensure loopback-only bind unless explicitly approved otherwise.
- Remove transient install credentials and tokens.
- Restrict service persistence to approved mechanism only.
- Enforce least-privilege runtime settings.

## Allowed Events

- `WriteFile`
- `ServiceChange`
- `PortBind`
- `Verify`

## Required Outputs

- `artifacts/harden/hardening-events.jsonl`
- `artifacts/harden/runtime-policy-state.json`
- `artifacts/harden/post-harden-verify.json`

