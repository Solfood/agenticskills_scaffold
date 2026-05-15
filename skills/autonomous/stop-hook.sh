#!/usr/bin/env bash
# SAMPLE Stop hook for agenticskills_scaffold /autonomous.
#
# Backstop invariant: during an autonomous run, no work-index item may be
# marked DONE without verification evidence in docs/evidence/<marker>/.
# This is a backstop only — the controller's per-stage gate checks are the
# real enforcement. If this hook is absent, nothing breaks.
#
# INSTALL:
#   1. Copy this script OUTSIDE any repo working tree (autonomous subagents
#      can edit anything inside the repo — a guardrail inside it is no guard).
#   2. chmod +x it.
#   3. Register it as a Stop hook in .claude/settings.json — see
#      skills/autonomous/SKILL.md.
#
# It is autonomous-only: it no-ops unless the sentinel file exists. /autonomous
# creates the sentinel at the start of a drain pass and removes it at the end.

set -euo pipefail

# Sentinel — keep OUTSIDE the repo tree. Absent => not an autonomous run => no-op.
SENTINEL="${AGENTICSKILLS_AUTONOMOUS_SENTINEL:-$HOME/.agenticskills-autonomous-active}"
[ -f "$SENTINEL" ] || exit 0

REPO="${CLAUDE_PROJECT_DIR:-$PWD}"
WORK_INDEX="$REPO/docs/work-index.md"
[ -f "$WORK_INDEX" ] || exit 0

# Collect marker IDs on rows whose status cell is DONE.
missing=""
while IFS= read -r id; do
  [ -z "$id" ] && continue
  evdir="$REPO/docs/evidence/$id"
  if [ ! -d "$evdir" ] || [ -z "$(ls -A "$evdir" 2>/dev/null)" ]; then
    missing="$missing $id"
  fi
done < <(awk -F'|' '/[| ]DONE[ |]/ {gsub(/[ \t]/,"",$2); if ($2 != "") print $2}' "$WORK_INDEX")

if [ -n "$missing" ]; then
  echo "BLOCKED by Stop hook: autonomous run marked these items DONE with no" >&2
  echo "evidence in docs/evidence/<marker>/:$missing" >&2
  echo "Run /verify for each and attach evidence before completing the run." >&2
  exit 2
fi

exit 0
