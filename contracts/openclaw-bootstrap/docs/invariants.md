# Invariants

1. Planner never executes; harness is sole executor.
2. All side effects are represented as typed events.
3. No secrets in planner-visible prompts, logs, or artifacts.
4. Every external fetch is pinned and digest/signature-verified.
5. Every privileged mutation requires explicit `Elevate` event and approval.
6. Stage gates are enforced:
   - plan -> fetch requires human approval
   - any R3+ dispatch requires supervisor approval
   - any R4 dispatch requires human approval
   - verify -> harden requires human confirmation
7. Installation is idempotent and convergent.
8. Full event history and artifacts are replayable and durable.
9. A startup nonce is generated at runtime, disclosed to the user, and never persisted.
10. STOP commands force QA-only lock mode (no commands, skills, MCP, or stage progression).
11. Resume is accepted only via `RESUME WORK: <nonce>` with exact nonce match.
12. Invalid nonce attempts are rejected and redirected to nonce lock documentation.
