# Semantic Densification

## Definition

Semantic densification is the process of turning low-structure planning text into high-structure, machine-checkable units without changing intent.

In this harness, densification means converting broad instructions into:

- explicit stages,
- typed events,
- risk labels,
- policy bindings,
- verification steps,
- and audit artifacts.

## Why it matters for safety

Densification improves safety by reducing ambiguity:

1. Less implicit behavior
   - Fewer hidden assumptions between planner output and execution.
2. Better policy enforcement
   - Every action is mapped to risk and required approval.
3. Better auditability
   - Replay can verify what was intended, approved, and executed.
4. Better operator control
   - Humans can evaluate compact, structured proposals instead of long prose.

## Densification pattern used here

1. Intent statement
   - Example: "Install OpenClaw safely."
2. Stage mapping
   - `probe -> plan -> fetch -> install -> verify -> harden -> report`
3. Event extraction
   - Emit typed events (`ProbeHost`, `Fetch`, `Exec`, `Elevate`, etc.)
4. Risk assignment
   - Assign `R0..R4` per event.
5. Policy binding
   - Attach `required_policy` reference for each event.
6. Verification binding
   - Add concrete `verification_step` to each event.
7. Evidence emission
   - Persist event ledger and stage artifacts.

## Quality bar for densified outputs

A densified proposal is acceptable only when:

- every side effect is represented as a typed event,
- every event has all required fields,
- approvals are explicit for gated risks/stages,
- verification is testable and specific,
- no secrets or personal details are disclosed.

## Anti-patterns to avoid

- Long narrative plans with no event schema.
- Events missing risk class or verification.
- "Do-everything" commands that bundle multiple authority scopes.
- Policy references that are vague or missing.
- Non-deterministic wording such as "if needed" without criteria.

## Practical operator check

Before approving an event batch, ask:

1. Is each mutation explicit and isolated?
2. Is the risk class justified?
3. Is the required policy concrete?
4. Is verification objective and repeatable?
5. Can this batch be replayed and audited without interpretation?

