#!/bin/bash
# eps2.5 step 1 — verify: courier is in the cell group
# Outcome only.

id -nG courier 2>/dev/null | tr ' ' '\n' | grep -qx cell || exit 1

exit 0
