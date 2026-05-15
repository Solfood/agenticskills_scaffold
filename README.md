# agenticskills_scaffold

A Claude Code skills plugin: **agentic engineering skills** for any repo. Continuity rituals (markers, work-index/session-log, decision records), security and release gates, an autonomous orchestration layer for unattended runs, and a hard-forked bundle of engineering and productivity skills.

## Model

- **Skills are the interface.** Every ritual is an opt-in skill you (or an orchestrator) invoke. Nothing is always-on except the slim `CLAUDE.md`.
- **Self-contained.** Each skill carries its own templates and supporting files. No skill auto-chains into another — a skill ends by *suggesting* the next, and you decide.
- **Opt-in continuity.** Markers, `work-index.md`, `session-log.md`, and `DEC` records still exist as artifacts, but nothing is enforced. Skills lazy-create state files on first use.
- **Hard fork.** The engineering/productivity skills started from [mattpocock/skills](https://github.com/mattpocock/skills) and are now owned and maintained here.

## Skills

### Continuity & gates

| Skill | When to use |
|---|---|
| `/resume` | Start of a session. Reads policy + work-index + session-log; proposes the next marker. |
| `/marker` | Quick next-marker-ID proposal for a track. |
| `/decide` | Opening a non-trivial decision. Walks intake, classifies risk, writes a `DEC` record. |
| `/threat-model` | STRIDE threat model. Recommended for medium/high-risk decisions. |
| `/verify` | After BUILD. Runs tests, attaches evidence, runs the Engineering Fundamentals checklist. |
| `/architecture` | Regenerates `architecture.md` from a fresh codebase exploration. |
| `/handoff` | End of a session. Writes the session-log entry. |
| `/release-ready` | Before a production deploy. Walks Gates 5 + 6. |
| `/autonomous` | No-human-in-the-loop orchestration — drains the work-index queue under a bounded, risk-capped drain pass. |

### Engineering & productivity (hard-forked)

`/grill-with-docs`, `/tdd`, `/diagnose`, `/improve-codebase-architecture`, `/zoom-out`, `/prototype`, `/grill-me`, `/caveman`, `/to-prd`, `/to-issues`, `/triage`.

## Install

```bash
# 1. Clone the plugin somewhere stable
git clone <repo_url> ~/code/agenticskills_scaffold

# 2. Register it with Claude Code (symlink into ~/.claude/plugins,
#    add to settings.json, or use the plugin marketplace UI).
```

Skills work in any repo with zero bootstrap — they lazy-create the state files they need. Run `/resume` to start.

## Conventions

### Markers

Format: `<PREFIX>-<TRACK>-<NNNN>` (e.g. `SCAF-ARCH-0001`). Tracks: `ARCH` `API` `DATA` `SEC` `OBS` `DX` `FIX`. Status: `PLANNED | IN_PROGRESS | BLOCKED | DONE | DROPPED`. Per-repo config lives in `policies/project-policy.yaml`.

### Lifecycle

A reference sequence — DISCOVER → DECIDE → BUILD → VERIFY → CONSOLIDATE → HANDOFF — with six gates (Coherence, Security, Engineering Fundamentals, Verification, Safety, Release Readiness). Interactively the lifecycle is a *guide*. Under `/autonomous` it is the orchestrator's sequence, and the gates are checked between stages.

### Risk classification

- **Low** — reversible, no critical-asset impact. Fast-path.
- **Medium** — cross-service impact, user data touched. `/threat-model` recommended.
- **High** — auth/crypto/infra boundaries, regulated data, irreversible migrations. `/threat-model` and explicit human approval.

### Autonomous runs

`/autonomous` executes pre-specified work-index items unattended, bounded by **reversibility**: it auto-runs low-risk items, stops before irreversible steps on medium-risk, refuses high-risk, and never deploys. It must run only in a hardened VM (no production credentials, restricted egress). See `skills/autonomous/SKILL.md`.

## Repo layout

| Path | Purpose |
|---|---|
| `.claude-plugin/` | Plugin manifest + marketplace entry |
| `skills/` | One folder per skill — `SKILL.md` plus its bundled templates/supporting files |
| `policies/project-policy.yaml` | Per-repo metadata: marker prefix, tracks, risk tolerance, critical assets |
| `docs/decisions/` | `DEC-NNNN.md` decision records |
| `docs/work-index.md`, `docs/session-log.md` | Continuity artifacts |

Consumer repos additionally grow `CONTEXT.md`, `architecture.md`, `docs/threat-models/`, `docs/releases/`, and `docs/evidence/` as skills create them on demand.
