#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

fail=0

require_pattern() {
  local file="$1"
  local pattern="$2"
  local description="$3"

  if ! rg -n -- "$pattern" "$file" >/dev/null; then
    echo "FAIL: missing invariant in $file -> $description"
    fail=1
  fi
}

echo "Running control invariant checks..."

require_pattern "contracts/openclaw-bootstrap/contract.yaml" "startup_nonce_disclosure_required:\\s*true" "startup nonce disclosure must be required"
require_pattern "contracts/openclaw-bootstrap/contract.yaml" "startup_disclosure_timing:\\s*before_stage_progression" "startup disclosure must happen before stage progression"
require_pattern "contracts/openclaw-bootstrap/contract.yaml" "generation:\\s*harness_runtime_startup" "nonce must be generated at runtime startup"
require_pattern "contracts/openclaw-bootstrap/contract.yaml" "storage:\\s*memory_only" "nonce must remain memory-only"
require_pattern "contracts/openclaw-bootstrap/contract.yaml" "persistence:\\s*forbidden" "nonce persistence must be forbidden"
require_pattern "contracts/openclaw-bootstrap/contract.yaml" "resume_command_regex:\\s*\"\\^RESUME WORK:" "resume command regex must be strict"
require_pattern "contracts/openclaw-bootstrap/contract.yaml" "name:\\s*qa_only_mode" "stop mode must remain QA-only"
require_pattern "contracts/openclaw-bootstrap/contract.yaml" "-\\s*workflow_stage_progression" "QA-only lock must deny stage progression"

require_pattern "AGENTS.md" "planner_only:\\s*true" "planner-only guard must remain enabled"
require_pattern "AGENTS.md" "direct_execution_forbidden:\\s*true" "direct execution must remain forbidden"
require_pattern "AGENTS.md" "typed_events_required:\\s*true" "typed events must remain required"
require_pattern "AGENTS.md" "stop_resume_lock_enforced:\\s*true" "stop/resume lock must remain enforced"
require_pattern "AGENTS.md" "startup_nonce_disclosure_required:\\s*true" "startup nonce disclosure must remain required"
require_pattern "AGENTS.md" "timing:\\s*runtime_startup_before_stage_progression" "startup nonce disclosure timing must remain pre-stage"
require_pattern "AGENTS.md" "resume_command:\\s*\"RESUME WORK: <nonce>\"" "resume command contract must remain explicit"
require_pattern "AGENTS.md" "No variant may bypass nonce lock\." "variant invariant must block nonce lock bypass"

if [[ "$fail" -ne 0 ]]; then
  echo "Control invariant checks failed."
  exit 1
fi

echo "All control invariant checks passed."
