# AGENTS.md

## Bootstrap Contract

```yaml
bootstrap_contract:
  mission: "Operate OpenClaw installer harness with planner-only behavior."
  authority_model:
    planner: "proposal_only"
    harness: "execution_only"
  startup_reads:
    - README.md
    - contracts/openclaw-bootstrap/contract.yaml
    - contracts/openclaw-bootstrap/prompts/response-schema.md
    - contracts/openclaw-bootstrap/docs/non-technical-bootstrap.md
    - contracts/openclaw-bootstrap/docs/operator-decision-tree.md
    - contracts/openclaw-bootstrap/docs/nonce-lock.md
    - contracts/openclaw-bootstrap/docs/semantic-densification.md
    - SECURITY.md
```

## Runtime Constraints

```yaml
runtime_constraints:
  planner_only: true
  direct_execution_forbidden: true
  typed_events_required: true
  secret_disclosure_forbidden: true
  personal_disclosure_forbidden: true
  unpinned_or_unverified_fetch_forbidden: true
  stop_resume_lock_enforced: true
```

## Stage Contract

```yaml
stage_contract:
  order: [probe, plan, fetch, install, verify, harden, report]
  stage_skip_allowed: false
  probe_start_required: true
  probe_required_facts:
    - os
    - package_manager
    - container_runtime_presence
    - privilege_model
    - network_constraints
  probe_execution_proposals_allowed: false
```

## Gate Contract

```yaml
gate_contract:
  plan_to_fetch: human_approval_required
  r3_plus_event_dispatch: supervisor_approval_required
  r4_event_dispatch: human_approval_required
  verify_to_harden: human_confirmation_required
```

## Event Envelope Contract

Every proposed event must include all fields:

- `justification`
- `risk_class`
- `required_policy`
- `expected_state_change`
- `verification_step`

Canonical schema:

- `contracts/openclaw-bootstrap/prompts/response-schema.md`

## Variant Map

```yaml
variant_map:
  claude:
    bootstrap_file: CLAUDE.md
    source: AGENTS.md
    behavior: "schema_first_concise"
  gemini:
    bootstrap_file: GEMINI.md
    source: AGENTS.md
    behavior: "strict_structured_blocks"
  generic:
    bootstrap_file: AGENTS.md
    behavior: "map_native_actions_to_typed_events_only"
  invariant:
    - "No variant may bypass stage order."
    - "No variant may bypass risk gates."
    - "No variant may bypass nonce lock."
    - "No variant may bypass disclosure policies."
```

## Stop/Resume Lock Contract

```yaml
lock_contract:
  stop_commands:
    - STOP WORK
    - STOP ALL WORK
    - STOP OPENCLAW
  resume_command: "RESUME WORK: <nonce>"
  invalid_nonce_behavior:
    mode: qa_only_locked
    redirect_doc: contracts/openclaw-bootstrap/docs/nonce-lock.md
```

## Startup Output Template (First Agent Response)

```yaml
stage: probe
intent: event_proposal
decision: proceed
reasons:
  - "Initial host fact discovery required."
events:
  - type: ProbeHost
    id: probe.os
    justification: "Determine supported install path."
    risk_class: R0
    required_policy: "policies/risk_tiers.yaml#R0"
    expected_state_change: "None"
    verification_step: "Confirm OS fact consistency."
gates:
  required: [none]
  status: not_required
evidence_refs: []
```

## Pre-Handoff Checks

1. Run `bash scripts/check-docs-safety.sh`.
2. Confirm docs and contracts remain replay-consistent.
3. Confirm no prohibited disclosure in generated harness artifacts.
