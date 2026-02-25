# How SEDA Works and Why It Is Safer for OpenClaw

## What SEDA means in this harness

SEDA here means a staged, event-driven workflow:

- Work is split into explicit stages (`probe -> plan -> fetch -> install -> verify -> harden -> report`).
- Each stage outputs typed events instead of direct actions.
- The planner proposes; the harness executes.

This keeps operation deterministic and reviewable.

## How it works (operationally)

1. Stage boundaries
   - Every stage has a clear purpose and required outputs.
   - Stage transitions are explicit and policy-gated.

2. Typed event proposals
   - Side effects are externalized as events (`ProbeHost`, `Fetch`, `Exec`, `Elevate`, etc.).
   - Every event must include:
     - `justification`
     - `risk_class`
     - `required_policy`
     - `expected_state_change`
     - `verification_step`

3. Risk-aware approvals
   - R3+ events require supervisor approval.
   - R4 events require human approval.
   - `plan -> fetch` and `verify -> harden` are explicit human checkpoints.

4. Replay and audit
   - Events, approvals, and outputs are persisted for replay.
   - Replay verifies policy compliance and transition correctness.

## Why this is safer for OpenClaw
### 1) Prevents hidden actions

Without staged event mediation, model output can blur planning and execution.  
With SEDA, all side effects must be declared and approved before execution.

### 2) Reduces high-risk mistakes

Risk-tier binding (R0-R4) forces stronger controls for downloads, privilege changes, and service/network changes.

### 3) Protects secrets and identity data

The harness blocks secret leakage and personal detail disclosure by policy and deny patterns.

### 4) Improves incident response

Because each action is evented and verified, operators can quickly identify:

- what was proposed,
- what was approved,
- what actually changed,
- and how to roll forward safely.

### 5) Supports safe repeatability

Idempotent install rules ensure re-runs converge to the same secure state instead of compounding drift.

## Practical safety controls in this repo

- Nonce startup lock (`STOP WORK`, `STOP ALL WORK`, `STOP OPENCLAW`, and `RESUME WORK: <nonce>`).
- Supply-chain guardrails (version pin + digest/signature verification).
- Explicit privilege escalation events (`Elevate`) for privileged mutations.
- Post-install hardening and verification before closure.

## Semantic densification and safety

SEDA safety is stronger when plans are semantically densified:

- free-form instructions become typed events,
- typed events become policy-bound units,
- policy-bound units become replayable evidence.

This reduces interpretation risk between planner intent and harness execution.

See: `docs/semantic-densification.md`.

## What SEDA does not replace

SEDA does not replace operator judgment.  
It improves safety by making approval, evidence, and verification mandatory and visible.

## Recommended operator posture

1. Require complete event envelopes before approving.
2. Reject any unpinned/unverified fetch.
3. Reject privileged actions without explicit `Elevate`.
4. Treat verify findings as blocking until resolved.
5. Use replay artifacts as the source of truth for audits.
