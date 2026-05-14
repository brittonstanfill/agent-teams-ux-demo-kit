#!/usr/bin/env bash
# Sync the kit's agents from claude-agents/ into a target agents directory
# (defaults to ~/.claude/agents). Overwrites kit-owned filenames; does not
# touch other files in the target.
#
# Usage:
#   bin/install-agents.sh                  # install to ~/.claude/agents
#   bin/install-agents.sh /path/to/target  # install to a custom target
#   bin/install-agents.sh --dry-run        # show what would change, do nothing
#   bin/install-agents.sh --project        # install to ./.claude/agents

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$REPO_ROOT/claude-agents"

DRY_RUN=0
TARGET=""

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --project) TARGET="$REPO_ROOT/.claude/agents" ;;
    --help|-h)
      sed -n '2,11p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    -*) echo "unknown flag: $arg" >&2; exit 2 ;;
    *) TARGET="$arg" ;;
  esac
done

TARGET="${TARGET:-$HOME/.claude/agents}"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "source not found: $SOURCE_DIR" >&2
  exit 1
fi

shopt -s nullglob
SOURCE_FILES=("$SOURCE_DIR"/*.md)
if [[ ${#SOURCE_FILES[@]} -eq 0 ]]; then
  echo "no .md files in $SOURCE_DIR" >&2
  exit 1
fi

action="install"
[[ $DRY_RUN -eq 1 ]] && action="dry-run"
echo "[$action] target: $TARGET"
echo "[$action] source: $SOURCE_DIR (${#SOURCE_FILES[@]} files)"
echo

if [[ $DRY_RUN -eq 0 ]]; then
  mkdir -p "$TARGET"
fi

changed=0
unchanged=0
new=0
for src in "${SOURCE_FILES[@]}"; do
  name="$(basename "$src")"
  dst="$TARGET/$name"
  if [[ ! -e "$dst" ]]; then
    status="new"
    new=$((new + 1))
  elif ! cmp -s "$src" "$dst"; then
    status="changed"
    changed=$((changed + 1))
  else
    status="unchanged"
    unchanged=$((unchanged + 1))
  fi
  printf "  %-10s %s\n" "$status" "$name"
  if [[ $DRY_RUN -eq 0 && "$status" != "unchanged" ]]; then
    cp "$src" "$dst"
  fi
done

echo
echo "summary: new=$new changed=$changed unchanged=$unchanged"

if [[ $DRY_RUN -eq 1 ]]; then
  echo
  echo "dry-run only — nothing was written. Re-run without --dry-run to apply."
  exit 0
fi

echo
echo "next steps:"
echo "  1. restart Claude Code or run /agents to verify the agents loaded"
echo "  2. run bin/verify-agents.sh to confirm no drift"
