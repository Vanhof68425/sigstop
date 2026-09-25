#!/bin/bash
# eps3.3 step 3 — verify: prom-evald disabled and down; our listener
# enabled and running.

[ "$(systemctl is-enabled prom-evald 2>/dev/null)" = "disabled" ] || exit 1
[ "$(systemctl is-active prom-evald 2>/dev/null)" = "inactive" ] || exit 1
[ "$(systemctl is-enabled sigstop-listen 2>/dev/null)" = "enabled" ] || exit 1
[ "$(systemctl is-active sigstop-listen 2>/dev/null)" = "active" ] || exit 1

exit 0
