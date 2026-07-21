#!/bin/bash
# eps2.3 step 2 — verify: the transmission is untouched
# Outcome only: file present and byte-identical to how it arrived
# (md5 stored at setup; marker grep as fallback).

T="/var/sigstop/drop/transmission_07.msg"
[ -f "$T" ] || exit 1

if [ -f /tmp/.sigstop_drop07.sum ]; then
  [ "$(md5sum "$T" | awk '{print $1}')" = "$(cat /tmp/.sigstop_drop07.sum)" ] || exit 1
else
  grep -q 'id:EV-DROP07' "$T" || exit 1
fi

exit 0
