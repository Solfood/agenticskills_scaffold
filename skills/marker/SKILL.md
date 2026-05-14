---
name: marker
description: Propose the next free marker ID for a given track by scanning work-index. Use when starting a new work item and you need an ID without invoking the full /resume protocol. Returns the proposed ID; doesn't write to work-index — that's the caller's job (typically /decide or /resume).
---

Propose the next free marker ID.

## Steps

1. **Read project prefix.**
   - From `policies/project-policy.yaml`, read `marker_prefix`. If the file or field is missing, defer to `/resume` to bootstrap policy first.

2. **Determine track.**
   - If the user provided a track, use it.
   - Otherwise, ask: "what track?" Default options come from `tracks` in `policies/project-policy.yaml`. Common: `ARCH`, `API`, `DATA`, `SEC`, `OBS`, `DX`, `FIX`.

3. **Scan `docs/work-index.md`.**
   - Look at all three tables (Active, Completed, Dropped).
   - Find the highest existing `<PREFIX>-<TRACK>-NNNN` for the chosen track.
   - If none exists for that track, start at `0001`.

4. **Propose.**
   - Increment by 1, zero-padded to 4 digits.
   - Return: `<PREFIX>-<TRACK>-<NNNN>`.

5. **Don't write yet.**
   - This skill is read-only. The caller (typically `/decide`, `/resume`, or the user directly) writes the new entry to `docs/work-index.md` once details are filled in.

