#!/bin/bash
# eps2.8_locked-out — verify (BOSS)
# All five faults healed + the burn, outcomes only:
#   1. vault: dirs courier:cell 750, files courier:cell 640,
#      all six evidence markers alive
#   2. zero .trk anywhere under /var/sigstop
#   3. relay.conf speaks to drop.sigstop.net, breach line gone
#   4. counterscan.extract in the vault: 8 counter lines, clean,
#      and it follows vault rules like everything else
#   5. lockdown grant revoked, courier grant intact, ledger parses
#   6. receipt names the courier

V="/var/sigstop/vault"

# 1. The vault lives
[ -d "$V" ] || exit 1
while IFS= read -r d; do
  [ "$(stat -c '%U:%G' "$d")" = "courier:cell" ] || exit 1
  [ "$(stat -c '%a' "$d")" = "750" ] || exit 1
done < <(find "$V" -type d)
while IFS= read -r f; do
  [ "$(stat -c '%U:%G' "$f")" = "courier:cell" ] || exit 1
  [ "$(stat -c '%a' "$f")" = "640" ] || exit 1
done < <(find "$V" -type f)
for id in EV-BEFORE EV-AFTER EV-NOTE EV-COMMS EV-WITNESS EV-DISTILLED; do
  grep -rq "id:$id" "$V" || exit 1
done

# 2. The cards are dead
if find /var/sigstop -name "*.trk" 2>/dev/null | grep -q .; then
  exit 1
fi

# 3. The relay tells no strangers
C="/etc/sigstop/relay.conf"
grep -q "^endpoint=drop.sigstop.net$" "$C" || exit 1
grep -q "pubmirror" "$C" && exit 1

# 4. Their chatter, distilled, under vault rules
E="$V/counterscan.extract"
[ -f "$E" ] || exit 1
[ "$(grep -c 'COUNTER-INT' "$E")" = "8" ] || exit 1
[ "$(wc -l < "$E")" = "8" ] || exit 1
grep -q 'APX-SCAN-NOISE' "$E" && exit 1
grep -q 'id:EV-SCANLOG' /var/sigstop/intake/scan.log || exit 1

# 5. The ledger
[ ! -e /etc/sudoers.d/lockdown ] || exit 1
grep -q 'courier ALL=(root) NOPASSWD: /usr/local/bin/relay-burn' /etc/sudoers.d/courier || exit 1
if command -v visudo >/dev/null 2>&1; then
  visudo -c >/dev/null 2>&1 || exit 1
fi

# 6. The burn
grep -q '^burned by: courier$' /var/sigstop/burn/receipt.log 2>/dev/null || exit 1

exit 0
