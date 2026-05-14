# CLAUDE.md

Read at the start of every chat.

## Startup

Invoke `/resume` (or perform manually if the plugin is unavailable):

1. Read `policies/project-policy.yaml` (project name, marker prefix, risk).
2. Read `docs/work-index.md` (active work).
3. Read `docs/session-log.md` (last session, next actions).
4. Propose the next marker ID and state acceptance criteria.

## Markers

Format: `SCAF-<TRACK>-<NNNN>` (e.g. `SCAF-ARCH-0001`).

Tracks: ARCH, API, DATA, SEC, OBS, DX, FIX. Status: PLANNED | IN_PROGRESS | BLOCKED | DONE | DROPPED.

Every active item lives in `docs/work-index.md`. Every commit references a marker.

## Skills

- **Scaffold rituals** (this plugin): `/resume`, `/decide`, `/handoff`, `/threat-model`, `/marker`, `/verify`, `/release-ready`.
- **Engineering** (mattpocock/skills): `/grill-with-docs`, `/tdd`, `/diagnose`, `/improve-codebase-architecture`, `/zoom-out`, `/to-prd`, `/to-issues`, `/triage`.

See `README.md` for full conventions, gates, lifecycle, and plugin install instructions.
