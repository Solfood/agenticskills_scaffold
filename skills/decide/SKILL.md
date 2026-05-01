---
name: decide
description: Open a decision record (DEC-NNNN.md) for a non-trivial choice. Runs intake, classifies risk, triggers /grill-with-docs for design alignment, kicks off /threat-model for medium/high risk, and updates CONTEXT.md inline as new domain terms emerge. Use when about to make a design choice that's hard to reverse, surprising without context, or the result of a real trade-off.
---

Walk the DECIDE stage for a non-trivial decision.

## When to invoke

Open a DEC only when **all three** are true (same filter as Matt's `/grill-with-docs`):

1. **Hard to reverse** — cost of changing your mind later is meaningful.
2. **Surprising without context** — a future reader will wonder "why this way?".
3. **Real trade-off** — there were genuine alternatives.

If any one is missing, skip the DEC and just add an entry to `docs/work-index.md`.

## Steps

1. **Propose marker.**
   - If the user hasn't chosen, invoke `/marker` (or scan work-index inline) for the next free `<PREFIX>-<TRACK>-NNNN`. Default track for design decisions is `ARCH`.

2. **Copy template.**
   - Copy the plugin's `templates/decision-record.md` to `docs/decisions/DEC-<NNNN>.md`. Numbering: scan `docs/decisions/` for the highest existing `DEC-NNNN`, increment, zero-pad to 4 digits.
   - If `docs/decisions/` doesn't exist, create it.

3. **Fill the Intake section first.**
   - Walk the user through: Objective, In scope, Out of scope, Risk class (low/medium/high), Critical assets touched, Dependencies, Expected evidence. Do this before anything else — it forces scope clarity.

4. **Trigger `/grill-with-docs`.**
   - Once intake is filled, invoke Matt's `/grill-with-docs` to stress-test the plan against the project's domain language and existing decisions. Captured terms get written to `CONTEXT.md` inline by that skill. If `CONTEXT.md` doesn't exist, `/grill-with-docs` will create it lazily.

5. **If risk is medium or high: invoke `/threat-model`.**
   - Walk STRIDE for the change. Result lives in `docs/threat-models/TM-<NNNN>.md`, linked from the DEC.

6. **Fill remaining DEC sections.**
   - Options Considered, Decision, Why, Risks & Mitigations, Rollback Plan. Evidence is filled later (after VERIFY).

7. **Update work-index.**
   - Add an entry referencing the DEC. Status starts as `PLANNED` or `IN_PROGRESS` depending on whether implementation begins immediately.

## Tier 2 lazy behavior

Create `docs/decisions/`, `docs/threat-models/`, `CONTEXT.md` if missing. Don't block on bootstrapping — initialize silently and continue.

## What to skip

- Reversible bug fixes
- Routine dep bumps
- Renames, refactors with no behavioral change
- Anything where the answer is obvious from existing code

A work-index entry is enough for those.
