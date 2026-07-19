#!/bin/bash
# eps2.6_permission-denied — verify
# Outcomes, never commands:
#   1. handoff: dir 750, every file 640 (stamps from 2.5 intact)
#   2. relay-burn is executable
#   3. /opt/apex sealed back to 000, gate file still inside,
#      codeword file proves the player read the gate

H="/var/sigstop/handoff"

# 1. The handoff locks
[ -d "$H" ] || exit 1
[ "$(stat -c '%a' "$H")" = "750" ] || exit 1
[ "$(stat -c '%U:%G' "$H")" = "courier:cell" ] || exit 1
for f in "$H"/*; do
  [ -e "$f" ] || continue
  [ "$(stat -c '%a' "$f")" = "640" ] || exit 1
done
grep -rq 'id:EV-DISTILLED' "$H" || exit 1

# 2. The tool is armed
[ -x /usr/local/bin/relay-burn ] || exit 1

# 3. The door: sealed again, contents alive, codeword home
[ "$(stat -c '%a' /opt/apex)" = "0" ] || exit 1
grep -q 'id:EV-GATE' /opt/apex/deploy_gate.conf 2>/dev/null || exit 1
if [ ! -e /root/report_only ] && [ ! -e /root/report-only ]; then
  exit 1
fi

exit 0
