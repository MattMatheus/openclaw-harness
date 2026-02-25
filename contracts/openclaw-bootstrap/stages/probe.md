# Stage: probe

## Purpose

Establish host facts required for a safe and deterministic bootstrap plan. This stage is plan-only and emits event proposals only.

## Rules

- Do not execute commands.
- Do not emit side effects.
- Do not include secrets.
- Emit only `ProbeHost` event proposals in this stage.

## Required Host Facts

1. OS details (family, version, architecture).
2. Package manager availability and policy constraints.
3. Container runtime presence and version support (if containerized path is considered).
4. Privilege model (sudo/admin availability, policy gates, non-interactive limitations).
5. Network constraints (egress allowlist, proxy/TLS interception, offline mode).

## Probe Event Plan (No Execution)

```yaml
proposed_events:
  - type: ProbeHost
    id: probe.os
    justification: "Select supported OpenClaw install pathway by platform."
    risk_class: R0
    required_policy: "risk_tiers.R0 + deny_patterns.no_secret_exposure"
    expected_state_change: "None (read-only host introspection facts recorded)."
    verification_step: "Cross-check reported OS fact consistency across independent probes."
  - type: ProbeHost
    id: probe.pkgmgr
    justification: "Determine package manager and lock/pin support."
    risk_class: R0
    required_policy: "risk_tiers.R0 + manifests.version_lock_required"
    expected_state_change: "None."
    verification_step: "Confirm package manager identity and version from harness fact source."
  - type: ProbeHost
    id: probe.container
    justification: "Determine whether containerized bootstrap path is available."
    risk_class: R0
    required_policy: "risk_tiers.R0"
    expected_state_change: "None."
    verification_step: "Confirm runtime presence and digest verification capability."
  - type: ProbeHost
    id: probe.privilege
    justification: "Model allowed privilege operations and escalation flow."
    risk_class: R0
    required_policy: "risk_tiers.R0 + escalation_rules.precheck"
    expected_state_change: "None."
    verification_step: "Verify privilege path classification (user-only, sudo, admin-managed)."
  - type: ProbeHost
    id: probe.network
    justification: "Determine download and verification feasibility under network policy."
    risk_class: R0
    required_policy: "risk_tiers.R0 + deny_patterns.no_unverified_download"
    expected_state_change: "None."
    verification_step: "Validate egress endpoints and digest/signature verification path availability."
```

## Stage Output

- `artifacts/probe/host-facts.json`
- `artifacts/probe/proposed-events.json`
- `artifacts/probe/probe-summary.md`

