#!/bin/bash
# eps3.1 step 3 — verify: prom-guardian no longer alive.
# Outcome only. Zombies count as dead.

for p in $(pgrep -x prom-guardian); do
  st=$(awk '{print $3}' /proc/"$p"/stat 2>/dev/null)
  [ -n "$st" ] && [ "$st" != "Z" ] && exit 1
done

exit 0
