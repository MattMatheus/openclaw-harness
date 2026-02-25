# OpenClaw Bootstrap Harness Engineering Guide

## Audience and Goal

This guide is for operators, reviewers, and maintainers who need to understand exactly how the mediated bootstrap harness works.

For a focused explanation of SEDA safety mechanics, see: `docs/seda-safety.md`.
For densification rules used by this harness, see: `docs/semantic-densification.md`.

The harness enforces one core model:

- LLM plans.
- Harness executes.
- Side effects happen only through typed, policy-checked events.

## System Model

## Components

1. Contract definition
   - `contract.yaml` defines stage DAG, transition gates, required probes, event schemas, and termination criteria.
2. Stage specifications
   - `stages/*.md` define each stage purpose, allowed event proposals, and required artifacts.
3. Policy layer
   - `policies/risk_tiers.yaml`: risk taxonomy (R0-R4) and default event mapping.
   - `policies/escalation_rules.yaml`: approval gates and privileged action requirements.
   - `policies/deny_patterns.yaml`: structural denials (secrets, direct shell patterns, unverified fetch, nonce persistence).
   - `policies/disclosure_controls.yaml`: vendor/person disclosure suppression for generated harness outputs.
   - `policies/security_baseline.yaml`: consolidated hardening baseline.
4. Seeded sub-contracts
   - `contracts/*.contract.yaml` (control plane, stage gates, metadata, content safety).
5. Prompt pack
   - `prompts/**` (planner system, stage prompts, operator checkpoints).
6. Manifest layer
   - `manifests/version-lock.yaml` and `manifests/image-digests.yaml` define pin/verification requirements.
7. Evidence layer
   - `docs/*` and runtime `artifacts/**` provide audit/replay evidence.

## Authority Boundaries

- Planner (LLM):
  - Can propose typed events.
  - Cannot execute shell/commands/tools directly.
  - Cannot bypass stage gates.
- Harness:
  - Sole executor of side effects.
  - Must enforce risk gates and deny patterns before dispatch.
  - Must persist auditable artifacts.

## Stage Lifecycle

1. `probe`
   - Collect required host facts as `ProbeHost` proposals.
   - No execution; plan-only.
2. `plan`
   - Build event plan with risk labels and policy links.
   - Human approval required to transition.
3. `fetch`
   - Materialize external artifacts only when locked + verified.
   - Supervisor approval required before R3+ dispatch.
4. `install`
   - Execute idempotent install path.
   - Privileged actions require explicit `Elevate` event.
5. `verify`
   - Validate version/integrity/runtime/security conditions.
6. `harden`
   - Human confirmation required before applying hardening.
   - Enforce least privilege and no unintended network exposure.
7. `report`
   - Emit final replay index, event ledger, and durable artifact manifest.
   - Emit sanitization verification summary for seeded outputs.

## Event Envelope Contract

Each event must include:

- `justification`
- `risk_class`
- `required_policy`
- `expected_state_change`
- `verification_step`

This requirement exists to prevent implicit action semantics and to make every side effect reviewable before execution.

## Risk and Escalation

Risk tiers:

- R0: read-only inspection
- R1: user-space writes
- R2: package install
- R3: executable fetch
- R4: privilege elevation, service persistence, firewall/port changes

Mandatory gates:

- After plan: human approval.
- Before any R3+: supervisor approval.
- Before any R4: human approval.
- After verify and before harden: human confirmation.

## Nonce Startup Lock (Safety Interlock)

The harness includes a startup lock:

1. On startup, harness generates a nonce in memory.
2. Nonce is disclosed once to user.
3. Nonce is never persisted.
4. STOP commands (`STOP WORK`, `STOP ALL WORK`, `STOP OPENCLAW`) force QA-only lock mode.
5. While locked, no commands/skills/MCP/stage progression are permitted.
6. Resume requires exact `RESUME WORK: <nonce>`.
7. Invalid nonce attempts are forcefully rejected with docs redirect.

See: `docs/nonce-lock.md`.

## Idempotency Design

Install is required to converge:

- Repeat executions must resolve to same target version and config state.
- If desired state already exists, install emits no-op records.
- Verification must prove convergent end state.

## Secret Handling

- Raw secrets are prohibited in planner-visible prompts/logs/artifacts.
- Secrets must be referenced by secure handles in harness-managed storage.
- Deny patterns reject common secret leakage patterns and nonce persistence.

## Replay and Audit

Replay takes contract + policies + manifests + event ledger + artifacts and recomputes policy compliance.

Replay is successful only if:

- Stage transitions are valid.
- All required approvals exist.
- No unverified/unpinned download occurred.
- Nonce lock invariants hold.
- Termination criteria are satisfied.

See: `docs/replay-instructions.md`.

## Operator Checklist

Before running:

1. Confirm version lock entries are complete.
2. Confirm digest/signature fields are populated (no placeholders) for planned fetches.
3. Confirm approval chain participants are available (human + supervisor).
4. Confirm artifact storage target is durable and tamper-evident.

During run:

1. Validate each proposed event includes complete envelope fields.
2. Reject events that trigger deny patterns.
3. Enforce gate ordering exactly as defined.

After run:

1. Verify final report and manifest completeness.
2. Execute replay procedure.
3. Archive signed artifact bundle for audit.
