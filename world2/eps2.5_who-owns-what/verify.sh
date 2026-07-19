#!/bin/bash
# eps2.5_who-owns-what — verify
# Outcomes, never commands:
#   1. courier is in the cell group
#   2. handoff dir + every file inside owned courier:cell
#   3. evidence markers survive (content is the testimony)

H="/var/sigstop/handoff"

[ -d "$H" ] || exit 1

# 1. The courier is in the room
id -nG courier 2>/dev/null | tr ' ' '\n' | grep -qx cell || exit 1

# 2. Every stamp reads courier:cell
[ "$(stat -c '%U:%G' "$H")" = "courier:cell" ] || exit 1
for f in "$H"/*; do
  [ -e "$f" ] || continue
  [ "$(stat -c '%U:%G' "$f")" = "courier:cell" ] || exit 1
done

# 3. The evidence survived the re-stamping
grep -rq 'id:EV-DISTILLED' "$H" || exit 1
grep -rq 'id:EV-LEDGER' "$H" || exit 1

exit 0
