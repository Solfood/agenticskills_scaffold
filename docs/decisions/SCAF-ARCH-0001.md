# DEC-0001: Migrate scaffold from CLAUDE.md-driven manual to Claude Code skills plugin

- Date: 2026-04-30
- Status: accepted
- Owner: Solfood
- Marker: SCAF-ARCH-0001
- Supersedes: N/A

## Context

The original scaffold (introduced 2026-04-24) loads a ~120-line `CLAUDE.md` into every session. It encodes the lifecycle, gates, fundamentals checklist, security defaults, and files table inline. Every session pays the full context cost regardless of the task. As Claude Code's skill system matured and Matt Pocock's `mattpocock/skills` repo demonstrated a small/composable/on-demand alternative, the always-on operating manual approach started looking like premature centralization. This decision captures the shift to a skills-based model.

## Intake

- Objective: Reduce always-on context bloat and refactor scaffold rituals into invocable skills, while preserving the continuity layer (markers, work-index, session-log, decisions) that gives sessions multi-day coherence.
- In scope: New `.claude-plugin` + `skills/` tree inside this repo; slim `CLAUDE.md`; templates relocated as plugin-internal canon; `CONTEXT.md` adoption; bluray as pilot consumer.
- Out of scope (this DEC): retrofitting Willowbrook and recipes-wiki, advanced hooks, settings.json automation.
- Risk class: low (fully reversible — old CLAUDE.md preserved in git history; consumer repos opt in per-repo).
- Critical assets touched: scaffold_conventions only. No production assets.
- Dependencies: Claude Code plugin model; Matt Pocock's `mattpocock/skills` (forked 2026-04-30).
- Expected evidence: plugin.json validates, all 8 SKILL.md files have correct frontmatter, slim CLAUDE.md ≤ 30 lines, bluray pilot exercises each skill on real work without regressions.

## Options Considered

1. **Status quo** — keep the heavy CLAUDE.md, ignore skills paradigm. Rejected: fights the harness; misses real ergonomic and maintenance wins.
2. **Replace scaffold with Matt's skills wholesale** — adopt Matt's plugin and discard our continuity layer. Rejected: throws away the suite-aware ritual layer (markers, cross-repo refs, session-log) which is genuinely useful.
3. **Hybrid (chosen)** — adopt Matt's skills as-is, layer 8 suite-aware skills on top, slim CLAUDE.md to a 15-30 line continuity-only stub.

## Decision

Adopt the hybrid model with the following 10 sub-decisions, each settled in the design grill of 2026-04-30:

1. **Migration scope**: refactor `engineering-scaffold-template`; pilot the new model in `bluray`; defer Willowbrook and recipes-wiki until the pilot proves stable.
2. **Distribution**: hybrid — plugin core + per-repo override drop-ins.
3. **Relationship to Matt's skills**: adopt wholesale. Build only the suite-aware ritual layer that Matt doesn't have.
4. **Startup protocol**: dual-track — slim `CLAUDE.md` (~15 lines, always-on, harness-agnostic) + `/resume` skill (richer logic, mid-session re-anchoring). Skip `SessionStart` hook (harness-specific, hidden, fragile).
5. **Skill inventory (8 skills)**: `/resume`, `/decide`, `/handoff`, `/suite-check`, `/threat-model`, `/marker`, `/verify`, `/release-ready`.
6. **Template location**: canonical templates live in the plugin (single source of truth). `policies/project-policy.yaml` stays per-repo (it carries per-repo state, not template content).
7. **Plugin location**: the plugin lives inside `engineering-scaffold-template` itself. The repo is both the template source and the runtime plugin.
8. **Structure rigidity (Tier 2 — lazy/JIT)**: skills detect missing state files and create them on first use. `init.sh` shrinks dramatically. Bare repos work; structure emerges as the user reaches for it.
9. **`CONTEXT.md` adoption**: full adoption at repo root. Auto-created lazily by `/decide`. Format follows Matt's `CONTEXT-FORMAT.md` so his skills (`/grill-with-docs`, `/improve-codebase-architecture`, `/zoom-out`) read it natively.
10. **Skill naming**: flat names (no `/scaffold-` prefix). No current collisions with Matt's skill list.

## Why

The skills paradigm matches how this scaffold actually gets used: most rituals are invoked at specific moments (start of session, decision time, end of session, before release). Loading the entire manual into every session was never serving the work — it was insurance against forgetting any one piece of it. Skills provide better insurance because they're loaded *when relevant* with full body, instead of always-on with token pressure forcing skim-reads.

Adopting Matt's skills wholesale is the highest-leverage choice in this DEC. His `/grill-with-docs`, `/tdd`, `/diagnose`, `/improve-codebase-architecture` are battle-tested and map 1:1 onto failure modes the scaffold's gates were trying to prevent. Building parallel versions would be vanity work.

Tier 2 lazy initialization is the philosophical center: structure should emerge from use, not be imposed up front. Repos that don't need the full continuity layer don't pay for it. Repos that grow into it get it created for them as they invoke skills. This is how the scaffold becomes useful for non-Solfood repos too, without forcing them to bootstrap the whole apparatus.

## Risks & Mitigations

- **Risk**: opt-in skills mean rituals can be forgotten (the failure mode of any non-mandatory tooling).
  **Mitigation**: slim `CLAUDE.md` retains the four-step startup protocol inline (cannot be forgotten as long as `CLAUDE.md` is read). Critical rituals (DEC writing, threat-modeling, release readiness) are reinforced by skill-to-skill chaining: `/decide` triggers `/threat-model` for medium/high risk; `/handoff` triggers `/release-ready` if shipping.

- **Risk**: skill drift between plugin core and bluray's local overrides (hybrid distribution can get messy).
  **Mitigation**: pilot is single-repo. No real overrides until the pilot surfaces a genuine need. If/when overrides appear, document them in the consuming repo's `docs/decisions/`.

- **Risk**: Tier 2 lazy creation prompts the user during work (interrupts flow).
  **Mitigation**: skills create state files silently using sensible defaults (project name from `package.json` / dir name; prefix prompted only if no `policy.yaml` exists). Prompts only when truly necessary.

- **Risk**: Matt's upstream changes break our integration.
  **Mitigation**: we install Matt's skills via his plugin (separate from ours). Updates are pinned per-machine. Our skills only depend on Matt's via skill invocation (`/grill-with-docs`, `/tdd`), not via file-path assumptions.

## Rollback Plan

The pre-migration `CLAUDE.md` and structure are preserved in git history at the parent commit of this DEC. Rollback is `git revert` of the migration commits. No data loss possible — work-index, session-log, and existing decisions/experiments are unchanged in this migration. Bluray pilot can be rolled back independently by reverting bluray's adoption commit.

## Evidence

To be attached after implementation:

- [ ] `.claude-plugin/plugin.json` validates (parse OK, all skill paths resolve)
- [ ] All 8 SKILL.md files have `name` and `description` frontmatter
- [ ] Slim `CLAUDE.md` ≤ 30 lines
- [ ] `templates/CONTEXT.md` exists and matches Matt's CONTEXT-FORMAT
- [ ] README.md explains the new model
- [ ] init.sh trimmed for Tier 2 lazy model
- [ ] bluray pilot: `/resume` works, `/decide` works end-to-end on at least one real decision, `/handoff` works
