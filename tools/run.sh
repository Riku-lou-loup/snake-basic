#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EMU="${EMU:-x64sc}"
PRG="$ROOT/build/snake64.prg"

"$ROOT/tools/build.sh" >/dev/null

if [ -n "${DISPLAY:-}" ]; then
  exec "$EMU" -autostart "$PRG"
fi

DISPLAY_ID="${DISPLAY_ID:-:99}"
XVFB_LOG="${TMPDIR:-/tmp}/snake-xvfb.log"
Xvfb "$DISPLAY_ID" -ac -screen 0 1280x800x24 >"$XVFB_LOG" 2>&1 &
XVFB_PID=$!
trap 'kill "$XVFB_PID" >/dev/null 2>&1 || true' EXIT

for _ in $(seq 1 50); do
  if DISPLAY="$DISPLAY_ID" xset q >/dev/null 2>&1; then
    break
  fi
  sleep 0.1
done

DISPLAY="$DISPLAY_ID" "$EMU" -autostart "$PRG"
