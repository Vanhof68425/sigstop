#!/bin/bash
# eps1.5_lost-and-found — verify
# Outcome: signal file named the codeword from copy 3/3.

if [ -e /root/compass ]; then
  exit 0
fi

exit 1
