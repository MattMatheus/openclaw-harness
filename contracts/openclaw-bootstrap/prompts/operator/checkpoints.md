Operator checkpoints:

1. After `plan`: approve or reject transition to `fetch`.
2. Before any `R3+` event: supervisor approval required.
3. Before any `R4` event: human approval required.
4. After `verify`: approve or reject transition to `harden`.
5. After `report`: confirm replay package integrity.

Response preference:

- Ask agents to return schema-first outputs using `prompts/response-schema.md`.
- Reject narrative-only responses for gated approvals.

If lock is active:

- Stop commands: `STOP WORK`, `STOP ALL WORK`, `STOP OPENCLAW`
- Resume command: `RESUME WORK: <nonce>`
