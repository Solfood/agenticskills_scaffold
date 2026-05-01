---
name: handoff
description: End-of-session continuity ritual. Writes a session-log entry capturing markers worked, work completed, verification, decisions, blockers, next actions. Runs the Engineering Fundamentals checklist before allowing any work-index entry to flip to DONE. Optionally invokes /release-ready if the work is shipping. Use at the end of every working session.
---

Close the session by writing a session-log entry that lets the next session pick up cleanly.

## Steps

1. **Append to `docs/session-log.md`.**
   Use the entry template:

   ```
   ### YYYY-MM-DD - Session <N>

   - Markers: <list of marker IDs touched>
   - Objective:
   - Work completed:
   - Verification: (evidence — test output, screenshots, command output; no prose-only claims)
   - Decisions made: (link to DEC-NNNN)
   - Open issues/blockers:
   - Next actions: (specific enough that the next session can act without asking)
   - References:
   ```

2. **Engineering Fundamentals check.**
   Before flipping any work-index entry to `DONE`, confirm:
   - [ ] Objective and success criteria defined before building
   - [ ] Inputs validated at all trust boundaries
   - [ ] Error paths implemented and tested, not just happy path
   - [ ] Names convey intent; control flow is easy to follow
   - [ ] Tests appropriate for risk class; evidence attached
   - [ ] Rollback or containment path exists for risky changes
   - [ ] Logs/metrics sufficient for diagnosis in production

   If any item fails, the entry stays `IN_PROGRESS` or moves to `BLOCKED` with the failed item documented.

3. **Update `docs/work-index.md`.**
   - Move completed items to the `Completed` table.
   - Update `Status` and `Updated` for in-progress items.
   - Add new items discovered this session.

4. **If shipping: invoke `/release-ready`.**
   Walks Gates 5 (Safety) and 6 (Release Readiness) before deployment.

## Tier 2 lazy behavior

If `docs/session-log.md` doesn't exist, create from the plugin's `templates/session-log.md.tmpl` and write the first entry. Same for `docs/work-index.md`.

## Why this ritual matters

The session-log entry is the single most valuable artifact for multi-session continuity. The next session — possibly days later, possibly a different agent — reads `Next actions` and picks up immediately. Skipping `/handoff` is the fastest way to lose continuity and start every session cold.
