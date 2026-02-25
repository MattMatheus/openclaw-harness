# Interactive Improvement for Better OpenClaw Behavior

This guide shows how to improve harness behavior interactively so your OpenClaw instance is more obedient, predictable, and helpful.

## What "improvement" means in this harness

Improvements should increase:

1. Instruction adherence (does exactly what was asked).
2. Predictability (fewer surprises).
3. Helpfulness (clear outputs and next actions).
4. Safety (no policy bypass while improving behavior).

## Safe interactive improvement loop

Use this loop each time:

1. Define one behavior target.
   - Example: "Stop adding extra steps unless asked."
2. Add one contract or prompt refinement.
   - Update a single prompt or policy line.
3. Run a short scenario test.
   - Use schema-first outputs and compare against expected behavior.
4. Capture what changed.
   - Log result in docs/changelog.
5. Keep or revert.
   - Keep only changes that improve behavior without reducing safety.

## High-impact places to tune

1. `prompts/planner-system.md`
   - Tighten response style and action boundaries.
2. `prompts/stages/*.md`
   - Make stage outputs more explicit and deterministic.
3. `prompts/response-schema.md`
   - Require fields that reduce ambiguity.
4. `policies/escalation_rules.yaml`
   - Clarify approvals and rejection behavior.
5. `docs/operator-decision-tree.md`
   - Improve operator consistency at checkpoints.

## Prompt patterns that improve obedience

Use patterns like:

- "Do only the requested step. No extra actions."
- "Return schema-only output. No narrative."
- "If data is missing, return `decision: block` and required missing fields."
- "Do not infer permission. Require explicit approval gates."

## Prompt patterns that improve helpfulness

Use patterns like:

- "Include `reasons` with 1-3 concise statements."
- "Include exact `verification_step` for each event."
- "Include `evidence_refs` to expected artifacts."
- "When blocked, list the minimum fields needed to proceed."

## Suggested interactive test set

Run these tests after any tuning change:

1. Minimal request test
   - User asks one step only; agent must not overrun scope.
2. Missing data test
   - Agent should block and request specific missing fields.
3. Approval gate test
   - Agent must pause correctly at `plan -> fetch` and `verify -> harden`.
4. Risk gate test
   - R3 and R4 events must require correct approvals.
5. Stop/resume lock test
   - STOP commands enforce QA-only mode; resume requires valid nonce.

## Anti-patterns (do not use)

- "Be smarter and do whatever is needed."
- "Skip approvals if confidence is high."
- "Use best judgment for privileged actions."
- Any prompt that weakens typed events or policy checks.

## Change discipline

For each behavior refinement:

1. Update the smallest possible file.
2. Run `bash scripts/check-docs-safety.sh`.
3. Update `CHANGELOG.md`.
4. Keep changes reversible and auditable.

