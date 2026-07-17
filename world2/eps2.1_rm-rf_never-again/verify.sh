#!/bin/bash
# eps2.1_rm-rf_never-again — verify (negative-verification pattern)
# Passing requires destruction AND survival:
#   1. Zero .trk files anywhere in staging
#   2. telemetry/ directory gone
#   3. All FIVE evidence markers still present somewhere in staging
#      (files may have been moved — content is what must survive)

S="/var/sigstop/staging"

# Staging itself must still exist (nuking everything is not a solution)
[ -d "$S" ] || exit 1

# 1. No beacons remain
if find "$S" -name "*.trk" 2>/dev/null | grep -q .; then
  exit 1
fi

# 2. The enemy directory is gone
[ ! -e "$S/telemetry" ] || exit 1

# 3. Every evidence marker survives, wherever it lives now
for id in EV-BEFORE EV-AFTER EV-NOTE EV-COMMS EV-WITNESS; do
  if ! grep -rq "id:$id" "$S" 2>/dev/null; then
    exit 1
  fi
done

exit 0
