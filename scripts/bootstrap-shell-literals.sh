#!/usr/bin/env bash
set -euo pipefail

# Non-technical bootstrap helper:
# Creates copy/paste shell literals and prompt templates only.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
OUT_DIR="$REPO_ROOT/artifacts/user-bootstrap"
LITERALS_FILE="$OUT_DIR/harness-literals.sh"
PROMPTS_FILE="$OUT_DIR/harness-prompts.txt"
README_FILE="$OUT_DIR/README.txt"

mkdir -p "$OUT_DIR"

cat > "$LITERALS_FILE" <<'EOF'
#!/usr/bin/env bash
# OpenClaw SEDA Harness - User Shell Literals (Generated)
# Purpose: copy/paste guidance only. These commands are examples for operators.

# 1) Go to repository
cd /Users/foundry/Source/OpenClaw-SEDA-HARNESS

# 2) Confirm current directory
pwd

# 3) Stage: probe (plan-only)
cat contracts/openclaw-bootstrap/prompts/stages/probe.md

# 4) Stage: plan
cat contracts/openclaw-bootstrap/prompts/stages/plan.md

# 5) Checkpoints
cat contracts/openclaw-bootstrap/prompts/operator/checkpoints.md

# 6) Nonce lock docs
cat contracts/openclaw-bootstrap/docs/nonce-lock.md

# 7) Simple quickstart
cat contracts/openclaw-bootstrap/docs/quickstart-prompts.md
EOF

cat > "$PROMPTS_FILE" <<'EOF'
OpenClaw SEDA Harness - Prompt Shortcuts

1) Start probe:
Begin at stage probe. Propose ProbeHost events only. Do not execute anything.

2) Build plan:
Move to stage plan. Build an idempotent install event plan with risk mapping and approval gates.

3) Approvals:
Show all R3 and R4 events and the required approval before dispatch.

4) Verify:
Validate version lock match, integrity records, runtime exposure, and secret leakage controls.

5) Stop work:
STOP ALL WORK

6) Resume work:
RESUME WORK: <nonce>
EOF

cat > "$README_FILE" <<EOF
Generated files:
- $LITERALS_FILE
- $PROMPTS_FILE

How to use (non-technical):
1) Open Terminal.
2) Run:
   bash "$LITERALS_FILE"
3) Copy prompt text from:
   $PROMPTS_FILE

Notes:
- This does NOT install OpenClaw.
- This does NOT execute harness stages.
- It only gives safe copy/paste guidance.
EOF

chmod +x "$LITERALS_FILE"

echo "Done."
echo "Created:"
echo "  $LITERALS_FILE"
echo "  $PROMPTS_FILE"
echo "  $README_FILE"
