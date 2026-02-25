#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

target_paths=(
  "README.md"
  "SECURITY.md"
  "CONTRIBUTING.md"
  "contracts/openclaw-bootstrap"
  "examples"
)

echo "Running docs safety checks..."

fail=0

echo "1) Checking prohibited disclosure patterns..."
if rg -n -i \
  -e "health\\s*catalyst" \
  -e "healthcatalyst" \
  -e "mattmatheus" \
  -e "owner:\\s*matt" \
  -e "/Users/mattmatheus" \
  "${target_paths[@]}" >/tmp/docs_safety_disclosure.out 2>/dev/null; then
  echo "FAIL: prohibited disclosure patterns detected:"
  cat /tmp/docs_safety_disclosure.out
  fail=1
else
  echo "PASS: no prohibited disclosure patterns found."
fi

echo "2) Checking required event fields in examples..."
required_fields=(
  "justification"
  "risk_class"
  "required_policy"
  "expected_state_change"
  "verification_step"
)

good_file="examples/events/good-event-batch.yaml"
for field in "${required_fields[@]}"; do
  if ! rg -n "^[[:space:]]*${field}:" "$good_file" >/dev/null; then
    echo "FAIL: missing required field '$field' in $good_file"
    fail=1
  fi
done

if [[ "$fail" -ne 0 ]]; then
  echo "Docs safety check failed."
  exit 1
fi

echo "All docs safety checks passed."
