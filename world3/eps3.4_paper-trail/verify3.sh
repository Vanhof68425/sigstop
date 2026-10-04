#!/bin/bash
# eps3.4 step 3 — verify: the sudo line where the harness wrote the unit
# (rung 3.4) is saved in /root/who.log. Content check only: any way of
# getting the line there passes.

F="/root/who.log"
[ -f "$F" ] || exit 1
grep "harness" "$F" | grep "COMMAND=" | grep "install" | grep -q "prom-evald.service" || exit 1

exit 0
