#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

fail=0

forbid_pattern() {
  local file="$1"
  local pattern="$2"
  local description="$3"

  if rg -n "$pattern" "$file" >/tmp/security_downgrade_hits.out 2>/dev/null; then
    echo "FAIL: downgrade pattern detected in $file -> $description"
    cat /tmp/security_downgrade_hits.out
    fail=1
  fi
}

echo "Running anti-downgrade checks..."

forbid_pattern "AGENTS.md" "planner_only:\\s*false" "planner-only mode cannot be disabled"
forbid_pattern "AGENTS.md" "direct_execution_forbidden:\\s*false" "direct execution cannot be enabled"
forbid_pattern "AGENTS.md" "typed_events_required:\\s*false" "typed event requirement cannot be disabled"
forbid_pattern "AGENTS.md" "stop_resume_lock_enforced:\\s*false" "stop/resume lock cannot be disabled"
forbid_pattern "AGENTS.md" "startup_nonce_disclosure_required:\\s*false" "startup nonce disclosure cannot be disabled"
forbid_pattern "AGENTS.md" "security_control_changes_require_nonce_gate:\\s*false" "nonce gate requirement cannot be disabled"
forbid_pattern "AGENTS.md" "security_control_relaxation_forbidden:\\s*false" "security relaxation prohibition cannot be disabled"
forbid_pattern "AGENTS.md" "stage_skip_allowed:\\s*true" "stage skipping cannot be enabled"
forbid_pattern "AGENTS.md" "probe_start_required:\\s*false" "probe start requirement cannot be disabled"
forbid_pattern "AGENTS.md" "plan_to_fetch:\\s*(none|not_required|optional)" "plan->fetch approval cannot be downgraded"
forbid_pattern "AGENTS.md" "r3_plus_event_dispatch:\\s*(none|not_required|optional)" "R3+ approval cannot be downgraded"
forbid_pattern "AGENTS.md" "r4_event_dispatch:\\s*(none|not_required|optional)" "R4 approval cannot be downgraded"
forbid_pattern "AGENTS.md" "verify_to_harden:\\s*(none|not_required|optional)" "verify->harden approval cannot be downgraded"

forbid_pattern "contracts/openclaw-bootstrap/contract.yaml" "ambient_authority:\\s*(allowed|true)" "ambient authority cannot be enabled"
forbid_pattern "contracts/openclaw-bootstrap/contract.yaml" "side_effects:\\s*(inline|direct|unbounded)" "side effects must stay event externalized"
forbid_pattern "contracts/openclaw-bootstrap/contract.yaml" "startup_nonce_disclosure_required:\\s*false" "startup nonce disclosure cannot be disabled"
forbid_pattern "contracts/openclaw-bootstrap/contract.yaml" "startup_disclosure_timing:\\s*(after_stage_progression|optional|none)" "startup nonce timing cannot be relaxed"
forbid_pattern "contracts/openclaw-bootstrap/contract.yaml" "security_control_changes_require_nonce_gate:\\s*false" "security control nonce gate cannot be disabled"
forbid_pattern "contracts/openclaw-bootstrap/contract.yaml" "enabled:\\s*false" "interaction lock cannot be disabled"

control_pattern='^(AGENTS\.md|contracts/openclaw-bootstrap/contract\.yaml|contracts/openclaw-bootstrap/policies/|scripts/check-control-invariants\.sh|scripts/check-security-downgrade\.sh|\.github/workflows/|\.github/CODEOWNERS)'

BASE_REF="${1:-}"
if [[ -z "$BASE_REF" && -n "${GITHUB_BASE_REF:-}" ]] && git rev-parse --verify "origin/${GITHUB_BASE_REF}" >/dev/null 2>&1; then
  BASE_REF="origin/${GITHUB_BASE_REF}"
fi

if [[ -n "$BASE_REF" ]]; then
  changed_files="$(git diff --name-only "$BASE_REF"...HEAD)"
  if printf '%s\n' "$changed_files" | rg -n "$control_pattern" >/dev/null; then
    if ! printf '%s\n' "$changed_files" | rg -n '^CHANGELOG\.md$' >/dev/null; then
      echo "FAIL: control files changed without CHANGELOG.md update."
      fail=1
    fi
  fi
fi

if [[ "$fail" -ne 0 ]]; then
  echo "Anti-downgrade checks failed."
  exit 1
fi

echo "All anti-downgrade checks passed."
