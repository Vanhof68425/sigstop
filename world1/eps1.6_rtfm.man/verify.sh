#!/bin/bash
# eps1.6_rtfm — verify
# Outcome: signal file named the codeword from the live drop.

if [ -e /root/doctrine ]; then
  exit 0
fi

exit 1
