---
name: architecture
description: Regenerate architecture.md — a snapshot of the system's components, data flow, and key decisions — from a fresh codebase exploration. Use when the user wants an up-to-date architecture overview, asks how the system is structured, or after structural changes. Regenerates the file rather than incrementally maintaining it.
---

Produce a current architecture snapshot for this repo.

## Principle: regenerate, never maintain

`architecture.md` is a **generated snapshot**, not a hand-maintained document. Every invocation explores the codebase fresh and overwrites the file. A doc patched by side-effects always rots — and a stale architecture doc is worse than none, because readers (and `/autonomous` subagents) trust it. So this skill never patches: it regenerates. The file is either fresh (you just ran `/architecture`) or visibly dated (header timestamp).

## Steps

1. **Explore the codebase fresh.**
   - Use the Agent tool with `subagent_type=Explore` to walk the repo. Identify: major components (services, modules, data stores, external dependencies), how they depend on each other, and the primary request/data path.
   - Don't trust a prior `architecture.md` — derive everything from the current code.

2. **Read the domain and decision context.**
   - If `CONTEXT.md` exists, use its vocabulary for component and concept names — don't invent parallel terms.
   - If `docs/decisions/` exists, scan the DEC records for decisions that shaped the architecture. These populate the "Key Decisions" table.

3. **Fill the template.**
   - Copy this skill's bundled `architecture.md` as the structure.
   - Purpose (one paragraph), Components table, Data Flow, Key Decisions (link DEC records), Known Constraints, Open Questions.
   - Set the `Date` header to today and keep the "generated snapshot" status line.

4. **Write `architecture.md` at the repo root.**
   - Overwrite any existing file. This is expected — it's a regeneration, not a merge.

## Tier 2 lazy behavior

If `architecture.md` doesn't exist, create it. If `CONTEXT.md` or `docs/decisions/` don't exist, just skip those inputs — explore the code and note unresolved questions under Open Questions.

## Next

This skill does not auto-chain. After regenerating:

- `/improve-codebase-architecture` — turn the friction noticed during exploration into concrete deepening opportunities.
- `/decide` — if an Open Question is a real trade-off worth recording as a DEC.
