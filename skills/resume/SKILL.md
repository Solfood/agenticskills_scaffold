---
name: resume
description: Start-of-session continuity ritual. Reads project policy, work-index, session-log, and proposes the next marker. Lazy-creates state files if missing. Use at the start of every session, or any time you need to re-anchor mid-session ("we lost the thread, /resume").
---

Run the startup protocol for this repo.

## Steps

1. **Read project policy.**
   - If `policies/project-policy.yaml` exists, read it. Note: project name, marker prefix, tracks, risk tolerance, critical assets, mandatory gates.
   - If it doesn't exist, ask the user: project name, marker prefix (2-6 uppercase letters), risk tolerance (low/medium/high). Write a fresh `policies/project-policy.yaml` from the plugin's `templates/project-policy.yaml.tmpl`. Don't block the session — get the minimum and continue.

2. **Read work-index.**
   - If `docs/work-index.md` exists, read all three tables (Active, Completed, Dropped).
   - If missing, create from the plugin's `templates/work-index.md.tmpl` (empty Active/Completed/Dropped tables).

3. **Read session-log.**
   - If `docs/session-log.md` exists, read the most recent entry — `Next actions` is what you'll continue.
   - If missing, create from the plugin's `templates/session-log.md.tmpl`.

4. **Propose next marker.**
   - Scan `docs/work-index.md` for the highest existing `<PREFIX>-<TRACK>-NNNN` per track.
   - Ask the user (or infer from context) which track today's work belongs to (ARCH/API/DATA/SEC/OBS/DX/FIX, or other from `tracks` in policy.yaml).
   - Propose the next ID, zero-padded to 4 digits.

5. **State acceptance criteria.**
   - Confirm in plain language what "done" looks like for today's work. Don't start implementing until this is explicit.

## Tier 2 lazy behavior

If any state file is missing, create it from the plugin's templates without ceremony. Don't pause to ask permission — just initialize and continue. The exception is `policy.yaml`, which needs project name + prefix + risk class from the user; ask for the minimum and write.

## Mid-session use

`/resume` is also useful mid-session when context drifts. Re-reads work-index and session-log to re-anchor.
