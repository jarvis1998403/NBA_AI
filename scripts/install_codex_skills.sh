#!/usr/bin/env bash
set -euo pipefail

CODEX_HOME="${CODEX_HOME:-/opt/codex}"
SKILL_ROOT="$CODEX_HOME/skills"
SYSTEM_SKILLS_DIR="$SKILL_ROOT/.system"
INSTALLER="$SYSTEM_SKILLS_DIR/skill-installer/scripts/install-skill-from-github.py"

printf "[info] CODEX_HOME=%s\n" "$CODEX_HOME"

if [[ ! -d "$SYSTEM_SKILLS_DIR" ]]; then
  echo "[error] System skills directory not found: $SYSTEM_SKILLS_DIR"
  exit 1
fi

# These are preinstalled system skills in this runtime.
required_system_skills=(
  "skill-creator"
  "skill-installer"
)

missing=0
for s in "${required_system_skills[@]}"; do
  if [[ -f "$SYSTEM_SKILLS_DIR/$s/SKILL.md" ]]; then
    echo "[ok] system skill present: $s"
  else
    echo "[warn] system skill missing: $s"
    missing=1
  fi
done

if [[ "$missing" -eq 1 ]]; then
  echo "[warn] One or more system skills are missing in this environment."
fi

# Optional GitHub installs for custom skills, if URLs are passed.
if [[ "$#" -gt 0 ]]; then
  if [[ ! -f "$INSTALLER" ]]; then
    echo "[error] Installer not found: $INSTALLER"
    exit 1
  fi
  for url in "$@"; do
    echo "[info] installing skill from: $url"
    python "$INSTALLER" --url "$url" --dest "$SKILL_ROOT"
  done
  echo "[info] custom skill installation complete. Restart Codex to pick up new skills."
else
  echo "[info] No custom skill URLs provided."
  echo "[info] For OpenClaw + Polymarket deployment, Codex skills are optional helpers;"
  echo "       main requirements are OpenClaw strategy/execution config and market API credentials."
fi
