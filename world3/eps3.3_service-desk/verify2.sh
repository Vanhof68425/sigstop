#!/bin/bash
# eps3.3 step 2 — verify: prom-evald stopped through the manager.
# Checks for exactly "inactive": a freshly killed unit shows
# "activating" while Restart=always brings it back, which must fail.

[ "$(systemctl is-active prom-evald 2>/dev/null)" = "inactive" ] || exit 1

exit 0
