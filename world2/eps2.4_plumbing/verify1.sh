#!/bin/bash
# eps2.4 step 1 — verify: shards routed with >
# Outcome only: evidence file holds all 12 shard lines, zero noise.

E="/var/sigstop/intake/evidence_4471.log"

[ -f "$E" ] || exit 1
[ "$(grep -c 'SHARD-4471' "$E")" = "12" ] || exit 1
grep -q 'APX-NOISE' "$E" && exit 1

exit 0
