# Engineering Scaffold Template

A Claude Code skills plugin that adds **suite-aware continuity rituals** on top of [mattpocock/skills](https://github.com/mattpocock/skills). Designed for the Solfood multi-repo suite, but works on any repo that wants marker discipline, decision records, and session continuity.

## What's in here

This repo serves two purposes:

1. **A Claude Code plugin** (`.claude-plugin/` + `skills/` + `templates/`) — install once per machine; consumer repos invoke skills with no per-repo install.
2. **The reference scaffold** for the conventions the skills assume (markers, work-index, session-log, decisions, gates).

## Skills

| Skill | When to use |
|---|---|
| `/resume` | Start of every session. Reads policy + work-index + session-log; proposes next marker. |
| `/decide` | Opening a non-trivial decision. Walks intake, kicks off `/grill-with-docs`, triggers `/threat-model` if risk is medium/high. |
| `/handoff` | End of every session. Writes session-log entry; runs Engineering Fundamentals checklist before flipping work to DONE. |
| `/suite-check` | Before non-trivial work in a multi-repo suite. Scans siblings for cross-cutting markers. |
| `/threat-model` | Required for medium/high-risk decisions. Walks STRIDE. |
| `/marker` | Quick proposal of the next free marker ID for a track. |
| `/verify` | After BUILD, before HANDOFF. Runs tests, attaches evidence, gates DONE on the Engineering Fundamentals checklist. |
| `/release-ready` | Before any production deploy. Walks Gates 5+6. |

These layer on top of Matt Pocock's engineering skills (`/grill-with-docs`, `/tdd`, `/diagnose`, `/improve-codebase-architecture`, `/zoom-out`, `/to-prd`, `/to-issues`, `/triage`). Install both for the full experience.

## Install (Claude Code)

```bash
# 1. Clone the plugin somewhere stable
git clone https://github.com/Solfood/engineering-scaffold-template.git ~/code/engineering-scaffold-template

# 2. Register the plugin in your Claude Code settings (one of)
#    a. Symlink: ln -s ~/code/engineering-scaffold-template ~/.claude/plugins/solfood-scaffold
#    b. Add to settings.json under "plugins"
#    c. Use Claude Code's plugin marketplace UI

# 3. Also install Matt's skills (recommended companion)
#    See https://github.com/mattpocock/skills for install instructions
```

## Bootstrap a consumer repo

The plugin works in any repo with **zero bootstrap** — invoke `/resume` and it lazily creates the state files it needs (Tier 2 model). For repos that want the full structure up front, run `init.sh`.

```bash
# In your consumer repo:
bash <path-to-scaffold-template>/init.sh
```

`init.sh` will:
- Prompt for project name, marker prefix, risk tolerance.
- Write `CLAUDE.md` from the template.
- Write `policies/project-policy.yaml` from the template.
- (No longer writes templates or seeds docs/ — the plugin handles that on-demand.)

## Conventions

### Markers

Format: `<PREFIX>-<TRACK>-<NNNN>` (e.g. `SCAF-ARCH-0001`).

Standard tracks: `ARCH` `API` `DATA` `SEC` `OBS` `DX` `FIX`. Custom tracks live in `policies/project-policy.yaml`.

Status: `PLANNED | IN_PROGRESS | BLOCKED | DONE | DROPPED`.

Rules:
- Every active work item has a row in `docs/work-index.md`.
- Every commit references a marker.
- Multi-repo cross-cutting work uses prefix `SUITE-` (numbering shared across repos).

### Lifecycle (six stages, six gates)

| # | Stage | Skill | Gate |
|---|---|---|---|
| 1 | DISCOVER | (manual / `/zoom-out`) | — |
| 2 | DECIDE | `/decide` | Coherence (1) + Security (2, if med/high) |
| 3 | BUILD | `/tdd` (Matt's) | Engineering Fundamentals (3) |
| 4 | VERIFY | `/verify` | Verification (4) |
| 5 | CONSOLIDATE | (inline) | — |
| 6 | HANDOFF | `/handoff` + `/release-ready` if shipping | Safety (5) + Release Readiness (6) |

Any failed gate blocks release until resolved or explicitly risk-accepted with rationale documented.

### Risk classification

- **Low** — reversible, no critical asset impact. Fast-path; Gate 2 not required; can skip DEC entirely.
- **Medium** — cross-service impact, user data touched, non-trivial blast radius. Gate 2 (`/threat-model`) required.
- **High** — auth/crypto/infra boundaries, regulated data, irreversible migrations. Gate 2 required, explicit approval needed.

### Engineering Fundamentals (Gate 3 + 4)

Before any work flips to `DONE`:

- [ ] Objective and success criteria defined before building
- [ ] Inputs validated at all trust boundaries
- [ ] Error paths implemented and tested, not just happy path
- [ ] Names convey intent; control flow is easy to follow
- [ ] Tests appropriate for risk level; evidence attached
- [ ] Rollback or containment path exists for risky changes
- [ ] Logs/metrics sufficient for diagnosis in production

Enforced by `/verify` and `/handoff`.

### Security defaults

Always apply: no plaintext secrets in repo; least privilege for service accounts and tokens; explicit authz checks on sensitive operations; dependency vulnerability scanning enabled.

Categories that always need `/threat-model`: auth/authz logic; cryptography and key/token handling; data export/import, backups, migrations; network perimeter changes.

### Files in a consuming repo

| Path | Purpose | Lazy-created by |
|---|---|---|
| `CLAUDE.md` | Slim startup pointer | `init.sh` (or copy from `templates/CLAUDE.md.tmpl`) |
| `policies/project-policy.yaml` | Per-repo metadata, suite siblings | `/resume` (prompts on first use) |
| `CONTEXT.md` | Domain language for the repo | `/decide` + `/grill-with-docs` |
| `docs/work-index.md` | Active work tracker | `/resume` |
| `docs/session-log.md` | Append-only continuity log | `/resume` or `/handoff` |
| `docs/decisions/DEC-NNNN.md` | Decision records | `/decide` |
| `docs/threat-models/TM-NNNN.md` | STRIDE threat models | `/threat-model` |
| `docs/releases/RELEASE-*.md` | Release readiness records | `/release-ready` |

The plugin owns canonical templates in its own `templates/` folder. Consumer repos **do not ship a `templates/` folder anymore** — skills copy from the plugin on demand.

## How this differs from the old scaffold

This repo replaced a ~120-line always-loaded `CLAUDE.md` with a ~25-line slim version + 8 invocable skills. See [`docs/decisions/SCAF-ARCH-0001.md`](docs/decisions/SCAF-ARCH-0001.md) for the full rationale and the 10 design decisions that shaped the migration.

## Commit hygiene

Keep: decisions, threat models, release records, architecture notes, session log. Prune: agent scratch notes, generated files, local state.
