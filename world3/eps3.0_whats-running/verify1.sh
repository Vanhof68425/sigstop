#!/bin/bash
# eps3.0 step 1 — verify: /root/runaway.pid holds the live PID of
# prom-eval-shard. Outcome only. Zombies don't count as alive.

F="/root/runaway.pid"
[ -f "$F" ] || exit 1
GIVEN=$(tr -d '[:space:]' < "$F")
[ -n "$GIVEN" ] || exit 1

for p in $(pgrep -x prom-eval-shard); do
  st=$(awk '{print $3}' /proc/"$p"/stat 2>/dev/null)
  if [ -n "$st" ] && [ "$st" != "Z" ] && [ "$p" = "$GIVEN" ]; then
    exit 0
  fi
done

exit 1
