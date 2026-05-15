---
name: decide
description: Open a decision record (DEC-NNNN.md) for a non-trivial choice. Runs intake, classifies risk, and updates CONTEXT.md as new domain terms emerge. Suggests /grill-with-docs and /threat-model as follow-ups. Use when about to make a design choice that's hard to reverse, surprising without context, or the result of a real trade-off.
---

Open and fill a decision record for a non-trivial decision.

## When to invoke

Open a DEC only when **all three** are true:

1. **Hard to reverse** — cost of changing your mind later is meaningful.
2. **Surprising without context** — a future reader will wonder "why this way?".
3. **Real trade-off** — there were genuine alternatives.

If any one is missing, skip the DEC and just add an entry to `docs/work-index.md`.

## Steps

1. **Propose marker.**
   - If the user hasn't chosen, invoke `/marker` (or scan work-index inline) for the next free `<PREFIX>-<TRACK>-NNNN`. Default track for design decisions is `ARCH`.

2. **Copy template.**
   - Copy this skill's bundled `decision-record.md` to `docs/decisions/DEC-<NNNN>.md`. Numbering: scan `docs/decisions/` for the highest existing `DEC-NNNN`, increment, zero-pad to 4 digits.
   - If `docs/decisions/` doesn't exist, create it.

3. **Fill the Intake section first.**
   - Walk the user through: Objective, In scope, Out of scope, Risk class (low/medium/high), Critical assets touched, Dependencies, Expected evidence. Do this before anything else — it forces scope clarity.
   - Risk class is load-bearing: it drives whether a threat model is warranted, and whether `/autonomous` may execute the item unattended.

4. **Fill the remaining DEC sections.**
   - Options Considered, Decision, Why, Risks & Mitigations, Rollback Plan. Evidence is filled later (after VERIFY).
   - As new domain terms surface, update `CONTEXT.md` inline (see `/grill-with-docs` for the format). Create `CONTEXT.md` lazily if it doesn't exist.

5. **Update work-index.**
   - Add an entry referencing the DEC. Status starts as `PLANNED` or `IN_PROGRESS` depending on whether implementation begins immediately.

## Tier 2 lazy behavior

Create `docs/decisions/`, `CONTEXT.md` if missing. Don't block on bootstrapping — initialize silently and continue.

## What to skip

- Reversible bug fixes
- Routine dep bumps
- Renames, refactors with no behavioral change
- Anything where the answer is obvious from existing code

A work-index entry is enough for those.

## Next

This skill does not auto-chain. Once the DEC is drafted, suggest to the user:

- `/grill-with-docs` — stress-test the plan against the project's domain language and existing decisions. Recommended for any DEC.
- `/threat-model` — **strongly recommended if Risk class is medium or high.** Walks STRIDE; the result links back into this DEC.
- `/tdd` — when ready to build.
