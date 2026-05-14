#!/usr/bin/env bash
# Verify that the kit's agents in claude-agents/ match what is installed in
# the target agents directory (defaults to ~/.claude/agents). Exits non-zero
# on any drift so this can be called from precheck.sh or CI.
#
# Usage:
#   bin/verify-agents.sh                  # check ~/.claude/agents
#   bin/verify-agents.sh /path/to/target  # check a custom target
#   bin/verify-agents.sh --project        # check ./.claude/agents

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$REPO_ROOT/claude-agents"

TARGET=""
for arg in "$@"; do
  case "$arg" in
    --project) TARGET="$REPO_ROOT/.claude/agents" ;;
    --help|-h)
      sed -n '2,9p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
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
if [[ ! -d "$TARGET" ]]; then
  echo "FAIL  target not found: $TARGET"
  echo "      run bin/install-agents.sh first"
  exit 1
fi

shopt -s nullglob
SOURCE_FILES=("$SOURCE_DIR"/*.md)

missing=()
drifted=()
ok=0
for src in "${SOURCE_FILES[@]}"; do
  name="$(basename "$src")"
  dst="$TARGET/$name"
  if [[ ! -e "$dst" ]]; then
    missing+=("$name")
  elif ! cmp -s "$src" "$dst"; then
    drifted+=("$name")
  else
    ok=$((ok + 1))
  fi
done

echo "checked: $TARGET"
echo "  in-sync : $ok"
echo "  drifted : ${#drifted[@]}"
echo "  missing : ${#missing[@]}"

if [[ ${#drifted[@]} -gt 0 ]]; then
  echo
  echo "drifted files (target differs from kit source):"
  for f in "${drifted[@]}"; do
    echo "  - $f"
  done
fi
if [[ ${#missing[@]} -gt 0 ]]; then
  echo
  echo "missing files (in kit but not in target):"
  for f in "${missing[@]}"; do
    echo "  - $f"
  done
fi

if [[ ${#drifted[@]} -gt 0 || ${#missing[@]} -gt 0 ]]; then
  echo
  echo "FAIL  re-run bin/install-agents.sh to sync."
  exit 1
fi

echo
echo "PASS  agents in target match the kit source."
