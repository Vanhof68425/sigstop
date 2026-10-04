#!/bin/bash
# eps3.4 step 2 — verify: the resume reference prom-evald printed to
# the journal on startup.

F="/root/resume.ref"
[ -f "$F" ] || exit 1
grep -q "RESUME-4471" "$F" || exit 1

exit 0
