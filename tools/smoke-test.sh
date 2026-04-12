#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EMU="${EMU:-x64sc}"
PRG="$ROOT/build/snake64.prg"
DISPLAY_ID="${DISPLAY_ID:-:99}"
XVFB_LOG="${TMPDIR:-/tmp}/snake-smoke-xvfb.log"
VICE_LOG="${TMPDIR:-/tmp}/snake-smoke-vice.log"

"$ROOT/tools/build.sh" >/dev/null

Xvfb "$DISPLAY_ID" -ac -screen 0 1280x800x24 >"$XVFB_LOG" 2>&1 &
XVFB_PID=$!
trap 'kill "$XVFB_PID" >/dev/null 2>&1 || true' EXIT

for _ in $(seq 1 50); do
  if DISPLAY="$DISPLAY_ID" xset q >/dev/null 2>&1; then
    break
  fi
  sleep 0.1
done

set +e
DISPLAY="$DISPLAY_ID" timeout 8s "$EMU" -autostart "$PRG" >"$VICE_LOG" 2>&1
STATUS=$?
set -e

if [ "$STATUS" -ne 0 ] && [ "$STATUS" -ne 124 ]; then
  cat "$VICE_LOG"
  exit "$STATUS"
fi

printf 'VICE booted %s under %s\n' "$PRG" "$DISPLAY_ID"
