# agenticskills-scaffold

> A Claude Code skills plugin — agentic engineering skills for any repo: continuity
> rituals, security and release gates, an autonomous orchestration layer, and a
> hard-forked bundle of engineering and productivity skills.

### Start here

| I want to… | Go to |
|---|---|
| Install the plugin and start using it | [Install](#install) |
| Browse the skill catalog | [Skills](#skills) |
| Author or change a skill | [Contributor guide](docs/contributor-guide.md) |
| Apply the doc format to a repo | [Project Docs Standard](skills/document/DOC-STANDARD.md) |
| See why the scaffold is built this way | [Decision records](docs/decisions/) |

## Install

```bash
# 1. Clone the plugin somewhere stable
git clone https://github.com/projecthosts/agenticskills_scaffold.git ~/code/agenticskills_scaffold

# 2. Register it with Claude Code
claude plugin marketplace add ~/code/agenticskills_scaffold
claude plugin install agenticskills-scaffold@agenticskills-scaffold
```

Restart Claude Code so the skills load as slash commands. Skills work in any repo with
zero bootstrap — they lazy-create the state files they need. Run `/resume` to start.

## Model

- **Skills are the interface.** Every ritual is an opt-in skill you (or an orchestrator)
  invoke. Nothing is always-on except the slim `CLAUDE.md`.
- **Self-contained.** Each skill carries its own templates and supporting files. No skill
  auto-chains into another — a skill ends by *suggesting* the next, and you decide.
- **Opt-in continuity.** Markers, `work-index.md`, `session-log.md`, and `DEC` records
  exist as artifacts, but nothing is enforced. Skills lazy-create state files on first use.
- **Hard fork.** The engineering/productivity skills started from
  [mattpocock/skills](https://github.com/mattpocock/skills) and are now owned here.

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
| `/document` | Brings a repo's docs up to the Project Docs Standard — landing README, audience-separated guides, clean cross-repo links. |
| `/handoff` | End of a session. Writes the session-log entry. |
| `/release-ready` | Before a production deploy. Walks Gates 5 + 6. |
| `/autonomous` | No-human-in-the-loop orchestration — drains the work-index queue under a bounded, risk-capped pass. |

### Engineering & productivity (hard-forked)

`/grill-with-docs`, `/tdd`, `/diagnose`, `/improve-codebase-architecture`, `/zoom-out`,
`/prototype`, `/grill-me`, `/caveman`, `/to-prd`, `/to-issues`, `/setup-issues`, `/triage`.

## Conventions

Markers, the lifecycle, risk classification, autonomous-run safety, and how to author a
skill all live in the [Contributor guide](docs/contributor-guide.md). The full
documentation index is in [docs/README.md](docs/README.md).

## Used by

| Repo | Relationship |
|---|---|
| [devagenticvm](https://github.com/projecthosts/devagenticvm) | Vendors a point-in-time snapshot of this plugin under `scripts/agentic-skills/`, preloaded so the skills ship with the repo. |
