#!/bin/bash
# eps2.4_plumbing — verify
# Outcomes, never commands:
#   1. evidence_4471.log: exactly 12 shard lines + 5 shim lines,
#      17 total, zero noise
#   2. manifest.count reads 17 (whitespace tolerated)
#   3. the flood survives (header marker intact)

I="/var/sigstop/intake"
F="$I/flood.log"
E="$I/evidence_4471.log"
M="$I/manifest.count"

[ -f "$E" ] || exit 1
[ -f "$M" ] || exit 1

# 1. The extract: complete and clean
[ "$(grep -cF '[4471 // shard' "$E")" = "12" ] || exit 1
[ "$(grep -cF '[shim //' "$E")" = "5" ] || exit 1
[ "$(wc -l < "$E")" = "17" ] || exit 1
grep -qF 'NOISE' "$E" && exit 1

# 2. The manifest
[ "$(tr -d '[:space:]' < "$M")" = "17" ] || exit 1

# 3. The original lives
[ -f "$F" ] || exit 1
grep -q 'id:EV-FLOOD' "$F" || exit 1

exit 0
