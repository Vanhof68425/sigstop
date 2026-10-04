#!/bin/bash
# eps3.4 step 1 — verify: the player reported a time (HH:MM:SS) at which
# our listener logged "prom-evald is now: active". Checked against the
# listener log itself, so any real "active" line passes.

F="/root/back.time"
L="/var/log/sigstop-listen.log"
[ -f "$F" ] && [ -f "$L" ] || exit 1

T="$(grep -oE '[0-9]{2}:[0-9]{2}:[0-9]{2}' "$F" | head -n 1)"
[ -n "$T" ] || exit 1
grep -q " $T prom-evald is now: active" "$L" || exit 1

exit 0
