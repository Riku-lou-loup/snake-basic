#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/src/snake.bas"
OUT_DIR="$ROOT/build"
PRG="$OUT_DIR/snake64.prg"
D64="$OUT_DIR/snake64.d64"

mkdir -p "$OUT_DIR"

petcat -w2 -o "$PRG" -- "$SRC"
c1541 -format snake64,64 d64 "$D64" -attach "$D64" -write "$PRG" snake64 >/dev/null

printf 'Built %s\n' "$PRG"
printf 'Built %s\n' "$D64"
