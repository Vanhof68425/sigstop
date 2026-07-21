#!/bin/bash
# eps2.4 step 2 — verify: shim entries appended with >>
# Outcome only: 12 shards + 5 entries, 17 lines total, zero noise
# (a > instead of >> would have left only 5 lines — that fails).

E="/var/sigstop/intake/evidence_4471.log"

[ -f "$E" ] || exit 1
[ "$(grep -c 'SHARD-4471' "$E")" = "12" ] || exit 1
[ "$(grep -c 'SHIM-ENTRY' "$E")" = "5" ] || exit 1
[ "$(wc -l < "$E")" = "17" ] || exit 1
grep -q 'APX-NOISE' "$E" && exit 1

exit 0
