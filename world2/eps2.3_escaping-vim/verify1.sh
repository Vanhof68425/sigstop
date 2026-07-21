#!/bin/bash
# eps2.3 step 1 — verify: the corpse is gone
# Outcome only: no swap file remains anywhere in the drop.

D="/var/sigstop/drop"
[ -d "$D" ] || exit 1

if find "$D" -name "*.sw?" 2>/dev/null | grep -q .; then
  exit 1
fi

exit 0
