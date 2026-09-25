#!/bin/bash
# eps3.1 step 1 — verify: prom-ckpt-copy is alive and frozen (state T).
# Outcome only. Killed copier = fail (sigstop-reset recovers).

for p in $(pgrep -x prom-ckpt-copy); do
  st=$(awk '{print $3}' /proc/"$p"/stat 2>/dev/null)
  [ "$st" = "T" ] && exit 0
done

exit 1
