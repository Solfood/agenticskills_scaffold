#!/usr/bin/env bash
set -euo pipefail

# init.sh — Tier 2 lazy bootstrap.
#
# Writes the minimum a consumer repo needs to start using the engineering scaffold:
#   - CLAUDE.md (slim startup pointer)
#   - policies/project-policy.yaml (per-repo metadata)
#
# Everything else (docs/work-index.md, docs/session-log.md, docs/decisions/, CONTEXT.md)
# is created lazily by the skills (/resume, /decide, /handoff, etc.) on first use.
#
# This script is OPTIONAL. Skills work on a bare repo with no bootstrap — they create
# state files as needed. Run init.sh only if you want the structure pre-seeded.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-$PWD}"

echo "Engineering scaffold — consumer repo initializer"
echo "============================================"
echo "Target: $TARGET_DIR"
echo ""

read -rp "Project name (e.g. MyApp): " PROJECT_NAME
read -rp "Marker prefix, 2-6 uppercase letters (e.g. MYAPP): " MARKER_PREFIX
read -rp "Owner (e.g. github org or your name): " OWNER
read -rp "Repo URL (optional, can leave blank): " REPO_URL
read -rp "Tech stack (e.g. 'React 18 + Vite + TypeScript'): " TECH_STACK
read -rp "Deployment env (e.g. 'GitHub Pages', 'Cloudflare Workers'): " DEPLOYMENT_ENV
read -rp "Risk tolerance (low/medium/high) [medium]: " RISK_TOLERANCE
RISK_TOLERANCE="${RISK_TOLERANCE:-medium}"

if [[ -z "$PROJECT_NAME" || -z "$MARKER_PREFIX" ]]; then
  echo "Error: project name and marker prefix are required." >&2
  exit 1
fi

MARKER_PREFIX="${MARKER_PREFIX^^}"

mkdir -p "$TARGET_DIR/policies"

# Slim CLAUDE.md
sed \
  "s|<MARKER_PREFIX>|${MARKER_PREFIX}|g" \
  "$SCRIPT_DIR/templates/CLAUDE.md.tmpl" > "$TARGET_DIR/CLAUDE.md"
echo "  wrote $TARGET_DIR/CLAUDE.md"

# project-policy.yaml
sed \
  -e "s|<PROJECT_NAME>|${PROJECT_NAME}|g" \
  -e "s|<MARKER_PREFIX>|${MARKER_PREFIX}|g" \
  -e "s|<OWNER>|${OWNER}|g" \
  -e "s|<REPO_URL>|${REPO_URL}|g" \
  -e "s|<TECH_STACK>|${TECH_STACK}|g" \
  -e "s|<DEPLOYMENT_ENV>|${DEPLOYMENT_ENV}|g" \
  -e "s|^risk_tolerance: \"medium\"|risk_tolerance: \"${RISK_TOLERANCE}\"|" \
  "$SCRIPT_DIR/templates/project-policy.yaml.tmpl" > "$TARGET_DIR/policies/project-policy.yaml"
echo "  wrote $TARGET_DIR/policies/project-policy.yaml"

echo ""
echo "Done. Next steps:"
echo "  1. Make sure the engineering-scaffold plugin is registered with Claude Code."
echo "     (Symlink, settings.json, or marketplace — see scaffold-template README.)"
echo "  2. Open Claude Code in this repo and run /resume to begin your first session."
echo "     The skill will lazy-create docs/work-index.md and docs/session-log.md."
echo "  3. Review policies/project-policy.yaml and update owner, repo_url, and tracks."
echo ""
echo "First commit:"
echo "  git add CLAUDE.md policies/"
echo "  git commit -m '${MARKER_PREFIX}-DX-0001 scaffold init'"
