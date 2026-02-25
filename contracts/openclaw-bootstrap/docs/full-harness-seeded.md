# Full Harness (Seeded from AthenaWork)

## What was seeded

From `AthenaWork` (read-only source), this harness now includes sanitized equivalents of:

- Program control plane
- Stage exit gates
- Unified metadata contract
- Content rejection/safety decision contract
- Prompt system pattern

Seed outputs are implemented in:

- `contracts/openclaw-bootstrap/contracts/*.contract.yaml`
- `contracts/openclaw-bootstrap/prompts/**`

## Seeded contract map

1. `contracts/control-plane.contract.yaml`
   - Delivery + knowledge plane lifecycle discipline
2. `contracts/stage-exit-gates.contract.yaml`
   - Explicit gate conditions per stage
3. `contracts/metadata.contract.yaml`
   - Required metadata fields and schemas
4. `contracts/content-safety.contract.yaml`
   - Decision outcomes and non-negotiable safety rules

## Prompt map

- `prompts/planner-system.md`
- `prompts/stages/{probe,plan,fetch,install,verify,harden,report}.md`
- `prompts/operator/checkpoints.md`

## Why this is a full harness

The harness now has:

- Primary contract (`contract.yaml`)
- Sub-contracts (control plane, metadata, safety, stage gates)
- Policy stack (risk, escalation, deny, disclosure, security baseline)
- Stage specs
- Prompt pack for planner and operator
- Replay/audit docs
- Startup nonce lock and stop/resume controls

## Sanitization guarantees

- Seeded artifacts intentionally remove vendor-specific and person-specific references.
- Personal identifiers are replaced by role-based placeholders.
- Prohibited references are blocked by disclosure and deny policies.

