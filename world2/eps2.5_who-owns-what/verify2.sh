#!/bin/bash
# eps2.5 step 2 — verify: the whole handoff answers to courier:cell
# Outcome only; evidence markers must survive the re-stamping.

H="/var/sigstop/handoff"

[ -d "$H" ] || exit 1
[ "$(stat -c '%U:%G' "$H")" = "courier:cell" ] || exit 1
for f in "$H"/*; do
  [ -e "$f" ] || continue
  [ "$(stat -c '%U:%G' "$f")" = "courier:cell" ] || exit 1
done

grep -rq 'id:EV-DISTILLED' "$H" || exit 1
grep -rq 'id:EV-LEDGER' "$H" || exit 1

exit 0
