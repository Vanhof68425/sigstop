#!/bin/bash
# eps1.2_read-only — verify
# Outcome: signal file named the closing officer's callsign, lowercase.

if [ -e /root/blackout ]; then
  exit 0
fi

exit 1
