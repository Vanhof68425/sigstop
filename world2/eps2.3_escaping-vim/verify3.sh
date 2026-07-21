#!/bin/bash
# eps2.3 step 3 — verify: the reply is finished
# Outcome only: exact ending present, handler's header survived.

R="/var/sigstop/drop/reply.draft"
[ -f "$R" ] || exit 1

grep -qF 'we act.' "$R" || exit 1
grep -q 'drop-07' "$R" || exit 1

exit 0
