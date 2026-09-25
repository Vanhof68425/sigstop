#!/bin/bash
# eps3.0 step 2 — verify: /root/hungriest.txt names ckpt-sync.
# Outcome only; case and surrounding whitespace tolerated.

F="/root/hungriest.txt"
[ -f "$F" ] || exit 1
grep -qi "ckpt-sync" "$F" || exit 1

exit 0
