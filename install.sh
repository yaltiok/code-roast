#!/bin/bash
# code-roast installer — one command, zero friction

set -e

SKILL_DIR="$HOME/.claude/skills/code-roast"

echo "🔥 Installing code-roast..."

# Create skill directory
mkdir -p "$SKILL_DIR"

# Copy skill files
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cp "$SCRIPT_DIR/skill.md" "$SKILL_DIR/SKILL.md"
cp -r "$SCRIPT_DIR/characters" "$SKILL_DIR/"

echo "✅ Installed to $SKILL_DIR"
echo ""
echo "Usage: /code-roast src/auth.ts"
echo "       /code-roast src/api.ts as Shakespeare"
echo "       /code-roast src/utils.ts grandma, gentle"
echo ""
echo "🔥 Happy roasting!"
