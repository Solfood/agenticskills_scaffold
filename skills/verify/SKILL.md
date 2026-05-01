---
name: verify
description: Run the test/verification suite for current work, attach evidence to the work-index entry, and gate progress to DONE via the Engineering Fundamentals checklist. Wraps Matt's /tdd cycle and adds the evidence-attachment ritual. Use after BUILD stage, before /handoff or /release-ready.
---

Verify work and attach evidence before marking DONE.

## Steps

1. **Confirm marker.**
   - Which work-index entry is being verified? Ask if unclear. Read the linked DEC's `Expected evidence` section to know what counts as sufficient verification.

2. **Run the suite.**
   - If you're not yet in a red-green-refactor loop and the work warrants it, invoke Matt's `/tdd`. Otherwise, run what exists:
     - Unit tests
     - Integration tests
     - Type check / linter
     - Manual checks listed in the DEC's `Expected evidence`
     - For UI changes: actually open the browser and use the feature, including edge cases. Type checks and tests verify code correctness, not feature correctness.

3. **Capture evidence.**
   - Save raw output to `docs/decisions/DEC-<NNNN>-evidence/` (create if missing) or attach inline in the DEC's `Evidence` section.
   - Include: test runner stdout, screenshots, curl output, before/after metrics. Raw is better than summarized.
   - **No prose-only claims.** "Tests pass" without attached output is not evidence — it's a promise.

4. **Engineering Fundamentals checklist.** (Gate 3 + Gate 4 combined)
   - [ ] Objective and success criteria met
   - [ ] Inputs validated at all trust boundaries
   - [ ] Error paths tested, not just happy path
   - [ ] Names convey intent; control flow is easy to follow
   - [ ] Tests appropriate for risk class (more rigorous for medium/high risk DECs)
   - [ ] Rollback or containment path documented for risky changes
   - [ ] Logs/metrics sufficient for diagnosis in production

5. **Update `docs/work-index.md`.**
   - Mark `Status = DONE` only if all checklist items pass and evidence is attached.
   - Otherwise: keep `IN_PROGRESS` (more work to do) or mark `BLOCKED` with the failing item documented in the row.

## Tier 2 lazy behavior

Create the evidence directory on first attachment. Don't ask permission — just write.

## When to invoke

- After every meaningful BUILD slice that changes behavior.
- Before `/handoff` if the session's work is being marked DONE.
- Before `/release-ready` for any shipping work.
