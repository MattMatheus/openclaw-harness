# Seed Sanitization Record

## Source

Seed source directory: `AthenaWork` (immutable input).

## Sanitization Rules Applied

1. Remove vendor-specific brand/domain references from generated harness artifacts.
2. Remove direct person identifiers and user-path identifiers from generated harness artifacts.
3. Keep only structural operating-system concepts (state models, gates, metadata contracts, safety decisions, prompt discipline).
4. Preserve no secrets and no personal contact details.

## Output Targets

- `contract.yaml`
- `contracts/*.contract.yaml`
- `prompts/**`
- `policies/**`
- `docs/**`

## Verification

Sanitization passes when:

- Prohibited disclosure patterns are absent from generated harness outputs.
- Disclosure and deny policies are present and enforced.
- Replay artifacts include sanitization compliance status.

