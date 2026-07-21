#!/bin/bash
# eps2.4 step 3 — verify: the manifest and the surviving original
# Outcome only: manifest reads 17 (whitespace tolerated), flood's
# survival marker intact.

I="/var/sigstop/intake"
M="$I/manifest.count"

[ -f "$M" ] || exit 1
[ "$(tr -d '[:space:]' < "$M")" = "17" ] || exit 1

[ -f "$I/flood.log" ] || exit 1
grep -q 'id:EV-FLOOD' "$I/flood.log" || exit 1

exit 0
