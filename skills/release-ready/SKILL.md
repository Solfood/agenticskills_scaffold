---
name: release-ready
description: Walk Gates 5 (Safety) and 6 (Release Readiness) before shipping. Copies release-readiness.md template, validates rollback plan, deployment plan, and confirms all prior gates passed. Use before any release or deployment to production. Blocks shipping if any gate fails.
---

Walk the release-readiness checklist before shipping.

## Steps

1. **Copy template.**
   - Copy the plugin's `templates/release-readiness.md` to `docs/releases/RELEASE-<YYYY-MM-DD>.md` (or `RELEASE-<NNNN>.md` if you prefer numbered releases).
   - If `docs/releases/` doesn't exist, create it.

2. **Walk gates 1-6.**
   For each, confirm pass / fail with notes:

   | Gate | Name | What to confirm |
   |---|---|---|
   | 1 | Coherence | Linked DEC is complete; scope is bounded; no scope drift since intake |
   | 2 | Security | If risk class is medium or high, threat model is complete and approved |
   | 3 | Engineering Fundamentals | `/verify` checklist all-green; evidence attached |
   | 4 | Verification | Tests pass; CI green; manual checks done |
   | 5 | Safety | Rollback plan documented in DEC; rollback path actually tested if irreversible |
   | 6 | Release Readiness | Deployment plan exists; staged rollout plan if applicable; observability ready |

3. **Block on any fail.**
   - If any gate fails, document the block in the release record. Stop. Resolve the failure (re-run `/verify`, complete the threat model, document a rollback) and re-run `/release-ready` from the top.
   - Alternatively, document explicit risk acceptance with rationale and approver. Use sparingly — this is the audit trail.

4. **Final decision.**
   - `approve` — all gates green, ship it.
   - `approve-with-conditions` — ship but with named follow-ups (e.g. monitor specific metric for X hours).
   - `block` — do not ship; fix and re-run.
   - Note approver (for solo work, the user; for shared work, the reviewer).

5. **Update `docs/work-index.md`.**
   - Only after the release succeeds, mark associated entries `DONE`.
   - If the release is staged (gradual rollout), keep entries `IN_PROGRESS` with notes on rollout %.

## Tier 2 lazy behavior

Create `docs/releases/` if missing.

## When to skip

- Pure documentation changes, no code.
- Internal tooling with no production deployment.
- Experimental branches that won't merge.

For everything else that touches production: don't skip. Gates exist because incidents are expensive.
