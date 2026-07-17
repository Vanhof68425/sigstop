#!/bin/bash
# eps1.0_hellofriend — verify
# Convention: verify OUTCOMES, not commands. Exit 0 = complete.
# The artifact told the player to create a file named "awake"
# in their home directory. That's the only thing we check —
# it proves they oriented (whoami/pwd/ls), found the file (cat),
# and acted on it. Any path to that outcome counts.

if [ -e /root/awake ]; then
  exit 0
fi

exit 1
