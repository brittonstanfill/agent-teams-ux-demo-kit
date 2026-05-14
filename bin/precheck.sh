#!/usr/bin/env bash
# Pre-flight check for a live demo or a clean-room experiment run.
# Verifies: Claude Code version, experimental flag, tmux, agent drift,
# and demo-output cleanliness. Prints a summary and exits non-zero on
# any failure so the user knows to stop before the demo begins.
#
# Usage:
#   bin/precheck.sh            # check everything
#   bin/precheck.sh --clean    # also clean demo-output/ after confirmation

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

CLEAN=0
for arg in "$@"; do
  case "$arg" in
    --clean) CLEAN=1 ;;
    --help|-h)
      sed -n '2,9p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *) echo "unknown flag: $arg" >&2; exit 2 ;;
  esac
done

pass=0
fail=0
warn=0
note() { echo "  $1"; }
ok()   { echo "PASS  $1"; pass=$((pass + 1)); }
bad()  { echo "FAIL  $1"; fail=$((fail + 1)); }
warning()  { echo "WARN  $1"; warn=$((warn + 1)); }

echo "== Claude Code version =="
if command -v claude >/dev/null 2>&1; then
  ver_line="$(claude --version 2>/dev/null | head -n1 || true)"
  ver="$(echo "$ver_line" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n1 || true)"
  if [[ -z "$ver" ]]; then
    warning "could not parse Claude Code version from: $ver_line"
  else
    note "found: $ver"
    # require >= 2.1.32
    IFS=. read -r maj min pat <<<"$ver"
    if (( maj > 2 )) || (( maj == 2 && min > 1 )) || (( maj == 2 && min == 1 && pat >= 32 )); then
      ok "claude >= 2.1.32"
    else
      bad "claude $ver is older than 2.1.32 (agent teams need this)"
    fi
  fi
else
  warning "claude binary not on PATH — skipping version check"
fi

echo
echo "== Agent teams experimental flag =="
if [[ "${CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS:-}" == "1" ]]; then
  ok "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1"
else
  bad "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS is not set to 1 (export it or set in ~/.claude/settings.json)"
fi

echo
echo "== tmux state =="
if command -v tmux >/dev/null 2>&1; then
  if tmux ls >/dev/null 2>&1; then
    sessions="$(tmux ls 2>/dev/null | wc -l | tr -d ' ')"
    if [[ "$sessions" -gt 0 ]]; then
      warning "$sessions existing tmux session(s) — run 'tmux kill-server' if they are orphaned demo sessions"
    else
      ok "no orphaned tmux sessions"
    fi
  else
    ok "no tmux server running (sessions will start fresh)"
  fi
else
  warning "tmux not installed — agent teams need teammateMode=tmux"
fi

echo
echo "== Agent drift =="
if "$REPO_ROOT/bin/verify-agents.sh" >/tmp/precheck-verify.$$ 2>&1; then
  ok "agents in ~/.claude/agents/ match kit source"
  rm -f /tmp/precheck-verify.$$
else
  bad "agents in ~/.claude/agents/ have drifted from kit source"
  sed 's/^/      /' /tmp/precheck-verify.$$
  rm -f /tmp/precheck-verify.$$
  note "fix: bin/install-agents.sh"
fi

echo
echo "== demo-output cleanliness =="
leftover_files=()
while IFS= read -r -d '' f; do
  leftover_files+=("$f")
done < <(find demo-output -type f ! -name .gitkeep -print0 2>/dev/null)

if [[ ${#leftover_files[@]} -eq 0 ]]; then
  ok "demo-output/ is clean"
else
  bad "demo-output/ has ${#leftover_files[@]} leftover file(s) — a clean-room run requires an empty workspace"
  for f in "${leftover_files[@]:0:5}"; do note "$f"; done
  if [[ ${#leftover_files[@]} -gt 5 ]]; then note "(and $((${#leftover_files[@]} - 5)) more)"; fi
  if [[ $CLEAN -eq 1 ]]; then
    echo
    read -r -p "delete these files? [y/N] " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      for f in "${leftover_files[@]}"; do rm -f "$f"; done
      find demo-output -type d -empty -not -name demo-output -delete 2>/dev/null || true
      echo "cleaned."
      fail=$((fail - 1)); pass=$((pass + 1))
    else
      note "skipped cleanup"
    fi
  else
    note "to clean: bin/precheck.sh --clean"
  fi
fi

echo
echo "== Summary =="
echo "  passed : $pass"
echo "  warned : $warn"
echo "  failed : $fail"

if [[ $fail -gt 0 ]]; then
  echo
  echo "STOP — fix the failures above before running a demo or experiment."
  exit 1
fi

if [[ $warn -gt 0 ]]; then
  echo
  echo "OK with warnings — review them, then proceed."
  exit 0
fi

echo
echo "READY — clear to run."
exit 0
