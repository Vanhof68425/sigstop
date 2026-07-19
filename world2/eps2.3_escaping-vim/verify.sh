#!/bin/bash
# eps2.3_escaping-vim — verify
# Outcomes, never commands:
#   1. reply.draft carries the exact ending AND the handler's header
#      survived (finished, not replaced)
#   2. no swap corpse remains anywhere in the drop
#   3. the transmission is byte-identical to how it arrived
#      (md5 stored at setup; marker grep as fallback)

D="/var/sigstop/drop"
R="$D/reply.draft"
T="$D/transmission_07.msg"

[ -d "$D" ] || exit 1
[ -f "$R" ] || exit 1

# 1. The ending, exactly — and the draft survived the edit
grep -qF 'we act.' "$R" || exit 1
grep -q 'drop-07' "$R" || exit 1

# 2. The corpse is gone (any swap file counts as a corpse)
if find "$D" -name "*.sw?" 2>/dev/null | grep -q .; then
  exit 1
fi

# 3. The transmission is untouched, byte for byte
[ -f "$T" ] || exit 1
if [ -f /tmp/.sigstop_drop07.sum ]; then
  [ "$(md5sum "$T" | awk '{print $1}')" = "$(cat /tmp/.sigstop_drop07.sum)" ] || exit 1
else
  grep -q 'id:EV-DROP07' "$T" || exit 1
fi

exit 0
