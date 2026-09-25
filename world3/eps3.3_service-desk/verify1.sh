#!/bin/bash
# eps3.3 step 1 — verify: the player reported the program path from
# the CGroup line (the eval-sandbox location: rung 3.3).

F="/root/service.path"
[ -f "$F" ] || exit 1
grep -q "eval-sandbox/run/prom-evald" "$F" || exit 1

exit 0
