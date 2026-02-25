# Operator Decision Tree (One Page)

Use this flow for every run.

1. Start
   - Are you at stage `probe`?
   - If no: stop and reset to `probe`.

2. Probe review
   - Are all required host facts present (OS, package manager, container runtime, privilege model, network constraints)?
   - If no: request missing `ProbeHost` events.
   - If yes: continue to `plan`.

3. Plan review
   - Does every event include all required fields?
   - Are risk classes and policies explicit?
   - If no: reject plan and request correction.
   - If yes: human approval required before `fetch`.

4. Fetch decision
   - Is every fetch pinned and verified by digest/signature?
   - If no: reject and block.
   - If yes: for R3+ events require supervisor approval.

5. Privileged action check
   - Any R4 event present?
   - If yes: require human approval and explicit `Elevate` event.

6. Verify checkpoint
   - Are version lock, integrity, and runtime checks passing?
   - Are there any unexpected ports or secret/disclosure findings?
   - If any failure: stop and remediate.
   - If pass: human confirmation required before `harden`.

7. Harden and report
   - Apply approved hardening events.
   - Confirm final report, event ledger, and replay index exist.

8. Lock handling
   - If user sends `STOP WORK`, `STOP ALL WORK`, or `STOP OPENCLAW`: enter QA-only mode.
   - Resume only with `RESUME WORK: <nonce>`.

