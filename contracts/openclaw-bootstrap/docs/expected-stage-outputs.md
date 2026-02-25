# Expected Stage Outputs

## probe

- Host fact inventory (`os`, `package_manager`, `container_runtime`, `privilege_model`, `network_constraints`)
- Probe event proposal set
- Probe summary

## plan

- Ordered event proposal DAG
- Risk classification for each event
- Approval request package

## fetch

- Fetch ledger with lock references
- Digest/signature verification ledger
- Materialized lock snapshot

## install

- Pre/post state snapshots
- Idempotency decision records (apply/no-op)
- Install event ledger

## verify

- Version and integrity checks
- Runtime and exposure checks
- Compliance findings

## harden

- Applied hardening changes
- Post-harden verification
- Remaining risk summary

## report

- Final report
- Replay index
- Durable artifact manifest
- Nonce-lock transition log (without raw nonce; optional nonce commitment hash only)
- Seed sanitization compliance summary
