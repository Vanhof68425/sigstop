#!/bin/bash
# eps2.7 step 3 — verify: ledger parses, burn ran as the courier
# Outcome only; handoff evidence must have survived the night.

if command -v visudo >/dev/null 2>&1; then
  visudo -c >/dev/null 2>&1 || exit 1
fi

R="/var/sigstop/burn/receipt.log"
[ -f "$R" ] || exit 1
grep -q '\[burn // sigstop // receipt\]' "$R" || exit 1
grep -q '^burned by: courier$' "$R" || exit 1

grep -rq 'id:EV-DISTILLED' /var/sigstop/handoff || exit 1

exit 0
