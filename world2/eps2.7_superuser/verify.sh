#!/bin/bash
# eps2.7_superuser — verify
# Outcomes, never commands:
#   1. the skeleton key is gone; the scoped grant survives
#   2. the ledger still parses (visudo -c, if available)
#   3. the burn ran as the courier: receipt names them
#   4. the handoff evidence survived the night

[ ! -e /etc/sudoers.d/apex-compat ] || exit 1
[ -f /etc/sudoers.d/courier ] || exit 1
grep -q 'courier ALL=(root) NOPASSWD: /usr/local/bin/relay-burn' /etc/sudoers.d/courier || exit 1

if command -v visudo >/dev/null 2>&1; then
  visudo -c >/dev/null 2>&1 || exit 1
fi

R="/var/sigstop/burn/receipt.log"
[ -f "$R" ] || exit 1
grep -q '\[burn // sigstop // receipt\]' "$R" || exit 1
grep -q '^burned by: courier$' "$R" || exit 1

grep -rq 'id:EV-DISTILLED' /var/sigstop/handoff || exit 1

exit 0
