# Contributor guide

> How to author or change a skill in `agenticskills-scaffold`, and the conventions the
> scaffold runs on. To install and use the plugin instead, see the [README](../README.md).

## Repo layout

| Path | Purpose |
|---|---|
| `.claude-plugin/` | Plugin manifest (`plugin.json`) + marketplace entry (`marketplace.json`) |
| `skills/` | One folder per skill — `SKILL.md` plus its bundled templates and supporting files |
| `policies/project-policy.yaml` | Per-repo metadata: marker prefix, tracks, risk tolerance, critical assets |
| `docs/decisions/` | `DEC-NNNN.md` decision records |
| `docs/work-index.md`, `docs/session-log.md` | Continuity artifacts |

Consumer repos additionally grow `CONTEXT.md`, `architecture.md`, `docs/threat-models/`,
`docs/releases/`, and `docs/evidence/` as skills create them on demand.

## Authoring a skill

A skill is a folder under `skills/` containing a `SKILL.md` and any files it bundles.

1. **Create the folder** — `skills/<name>/SKILL.md`.
2. **Write the frontmatter** — `name` and `description`. The `description` is
   auto-loaded into context and is how Claude decides when the skill applies, so make it
   precise: what the skill does and the trigger phrases for it.
3. **Write the body** — the instructions Claude follows when the skill runs. Existing
   skills use `<what-to-do>` and `<supporting-info>` sections; follow that shape.
4. **Bundle supporting files** beside `SKILL.md` (templates, reference docs) and link
   them with relative paths. A skill must be self-contained — it never depends on another
   skill's files.
5. **Register it** — add `"./skills/<name>"` to the `skills` array in
   `.claude-plugin/plugin.json`, and mention it in the `description` in
   `.claude-plugin/marketplace.json`.
6. **List it** in the README skills catalog.

> [!IMPORTANT]
> No skill auto-chains into another. A skill ends by *suggesting* a next step; the human
> decides. Keep that boundary when authoring.

## Validation

Before a PR, validate the plugin and marketplace manifests:

```bash
claude plugin validate <path-to-this-repo>
```

## Conventions

### Markers

Format: `<PREFIX>-<TRACK>-<NNNN>` (e.g. `SCAF-ARCH-0001`). Tracks: `ARCH` `API` `DATA`
`SEC` `OBS` `DX` `FIX`. Status: `PLANNED | IN_PROGRESS | BLOCKED | DONE | DROPPED`.
Per-repo config lives in `policies/project-policy.yaml`.

### Lifecycle

A reference sequence — DISCOVER → DECIDE → BUILD → VERIFY → CONSOLIDATE → HANDOFF — with
six gates (Coherence, Security, Engineering Fundamentals, Verification, Safety, Release
Readiness). Interactively the lifecycle is a *guide*. Under `/autonomous` it is the
orchestrator's sequence, and the gates are checked between stages.

### Risk classification

- **Low** — reversible, no critical-asset impact. Fast-path.
- **Medium** — cross-service impact, user data touched. `/threat-model` recommended.
- **High** — auth/crypto/infra boundaries, regulated data, irreversible migrations.
  `/threat-model` and explicit human approval.

### Autonomous runs

`/autonomous` executes pre-specified work-index items unattended, bounded by
**reversibility**: it auto-runs low-risk items, stops before irreversible steps on
medium-risk, refuses high-risk, and never deploys. It must run only in a hardened VM
(no production credentials, restricted egress). See `skills/autonomous/SKILL.md`.

---
[← Docs index](README.md)
