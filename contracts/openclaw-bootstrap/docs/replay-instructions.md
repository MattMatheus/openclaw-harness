# Replay Instructions

## Inputs

- `contracts/openclaw-bootstrap/contract.yaml`
- `contracts/openclaw-bootstrap/policies/*.yaml`
- `contracts/openclaw-bootstrap/manifests/*.yaml`
- `artifacts/**` generated during execution

## Replay Procedure

1. Load contract and policy bindings.
2. Validate artifact manifest integrity (hash and presence).
3. Reconstruct event order from `event-ledger.jsonl`.
4. Re-evaluate each event against:
   - risk tier mapping
   - escalation approvals
   - deny patterns
   - lock file constraints
   - nonce-lock invariants (state transitions and approvals; no raw nonce material)
5. Verify stage transitions match `allowed_transitions`.
6. Recompute termination criteria from final stage outputs.

## Replay Success Conditions

- No policy violations discovered.
- No missing approvals for gated transitions/events.
- No unpinned or unverified downloads.
- Nonce lock transitions are valid (startup disclosed, stop lock enforced, resume only after valid nonce check).
- Final verify+harden outputs satisfy invariants.
- Durable artifact manifest resolves all referenced files.
