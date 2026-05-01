---
name: suite-check
description: Scan sibling repos in the suite for cross-cutting markers (typically SUITE-* prefix or shared parent refs) before starting local work. No-op if policy.yaml has no suite block. Use when starting non-trivial work in a multi-repo suite — flags conflicts and shared work-in-flight before you collide with it.
---

Check sibling repos for cross-cutting work in flight.

## Steps

1. **Read suite block from `policies/project-policy.yaml`.**
   - If absent or empty, this skill is a no-op. Say so explicitly and stop.

2. **For each sibling repo listed:**
   - Locate the working tree. Default search: `../<sibling-name>` relative to the current repo. Fall back to the `url` field if the local path doesn't exist.
   - Read the sibling's work-index. Conventional locations:
     - `docs/work-index.md` (default)
     - `_engineering/work-index.md` (used by repos that reserve `docs/` for content, e.g. MkDocs sites)
   - If neither exists, note it and skip that sibling (don't error).

3. **Filter for cross-cutting work.**
   Look for entries where any of:
   - The marker prefix is `SUITE-` (explicit suite-cross-cutting markers).
   - The `Parent refs` column references a `SUITE-*-NNNN` ID.
   - The title or status mentions another repo in the suite.

4. **Report.**
   List every match with:
   - Repo name
   - Marker ID
   - Title
   - Status
   - Last updated

   Highlight `IN_PROGRESS` and `BLOCKED` entries — those are the ones most likely to affect today's work.

5. **Confirm before proceeding.**
   Ask the user: "any of these affect what you're doing?" If yes, link the today's work to the relevant SUITE marker via `Parent refs` in `docs/work-index.md`.

## When to invoke

- Automatically as part of `/resume` when a suite block is present.
- Manually before any non-trivial change in a suite-member repo.
- Periodically (e.g. weekly) as a sanity sweep.

## Tier 2 lazy behavior

If `policies/project-policy.yaml` is missing entirely, defer to `/resume` to create it first. Don't try to operate without it.
