# Security Policy

## Scope

This repository defines a mediated harness for bootstrapping OpenClaw with staged controls, typed events, and replayable audit artifacts.

## Security Goals

1. Planner cannot directly execute side effects.
2. Harness is the only execution authority.
3. All side effects are typed, policy-bound events.
4. High-risk actions require explicit approval gates.
5. Secrets and personal details are not disclosed in artifacts.
6. Supply-chain inputs are pinned and verified.

## Threat Model (High Level)

Primary risks addressed:

- Hidden or implicit execution from planning output.
- Unapproved privilege escalation.
- Unverified downloads and dependency tampering.
- Secret leakage in prompts/logs/artifacts.
- Personal or sensitive disclosure in generated docs/outputs.

Residual risks:

- Operator approval mistakes.
- Misconfigured host environment controls outside this repository.
- Incomplete upstream verification material for third-party artifacts.

## Reporting a Security Issue

If you find a vulnerability in this repository:

1. Do not create a public issue with exploit details.
2. Report privately to the repository maintainers through your approved private channel.
3. Include:
   - affected file(s)
   - impact summary
   - reproduction steps
   - suggested remediation

If no private channel is configured yet, establish one before public release.

## Disclosure Handling Rules

- Never commit raw secrets, tokens, private keys, or credentials.
- Never include personal identifiers in generated harness artifacts.
- Use redaction placeholders for sensitive content:
  - `[REDACTED:PERSON]`
  - `[REDACTED:ORG]`
  - `[REDACTED:PATH]`
  - `[REDACTED:CONTACT]`

## Approval and Escalation Requirements

- `plan -> fetch`: human approval required.
- `R3` events: supervisor approval required before dispatch.
- `R4` events: human approval required before dispatch.
- Privileged mutations require explicit `Elevate` event.

## Supply Chain Requirements

- Exact version pinning required for external artifacts.
- Digest or signature verification required before use.
- Unlocked or unverified fetch events are rejected.

## Runtime Lock Safety

The harness supports startup nonce lock behavior:

- Stop commands:
  - `STOP WORK`
  - `STOP ALL WORK`
  - `STOP OPENCLAW`
- Resume command:
  - `RESUME WORK: <nonce>`

Invalid nonce attempts are rejected and remain in QA-only mode.

## Verification and Audit

Security-relevant runs must produce:

- event ledger
- approval trail
- verification artifacts
- replay index

Replay must confirm:

- valid transitions
- valid approvals
- policy compliance
- no prohibited disclosure

