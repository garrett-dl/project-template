#!/usr/bin/env bash
# Re-vendor kepano/obsidian-skills into .claude/skills/ (flat, one dir per skill).
# Usage: scripts/sync-skills.sh [ref]   (default: main)
set -euo pipefail

REF="${1:-main}"
REPO="https://github.com/kepano/obsidian-skills.git"
SKILLS=(obsidian-markdown obsidian-bases obsidian-cli json-canvas defuddle knap)

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/.claude/skills"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

git clone --quiet --depth 1 --branch "$REF" "$REPO" "$TMP/src"

for s in "${SKILLS[@]}"; do
  rm -rf "$DEST/$s"
  cp -r "$TMP/src/skills/$s" "$DEST/$s"
done
cp "$TMP/src/LICENSE" "$DEST/LICENSE-obsidian-skills"
echo "kepano/obsidian-skills @ $(git -C "$TMP/src" rev-parse HEAD) ($(git -C "$TMP/src" log -1 --format=%cs))" \
  > "$DEST/.obsidian-skills-version"

echo "Synced: ${SKILLS[*]}"
cat "$DEST/.obsidian-skills-version"
