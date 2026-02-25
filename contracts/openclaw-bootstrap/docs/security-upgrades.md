# Security Upgrades Applied

This harness was upgraded with additional controls derived from AthenaWork patterns and hardened for OpenClaw bootstrap mediation.

## Upgrades

1. Added disclosure policy:
   - `policies/disclosure_controls.yaml`
   - Blocks prohibited vendor/person references in generated harness outputs.

2. Added explicit security baseline:
   - `policies/security_baseline.yaml`
   - Captures least privilege, secret handling, supply chain validation, runtime hardening, and audit requirements.

3. Strengthened deny patterns:
   - `policies/deny_patterns.yaml`
   - Added blocking patterns for prohibited vendor/personal disclosure.

4. Strengthened core contract:
   - `contract.yaml`
   - Added seed provenance, sanitization constraints, and completion criteria for sanitized outputs.

5. Strengthened operational prompts:
   - `prompts/**`
   - Planner/system/stage prompts enforce typed-event planning and disclosure constraints.

## Resulting Security Posture

- No direct shell execution by planner.
- No ambient authority.
- No secret persistence in planner context.
- External downloads must be pinned and verified.
- Privileged operations require explicit escalation events.
- Stop/resume nonce lock can force immediate QA-only mode.
- Generated harness artifacts block prohibited disclosure patterns.

