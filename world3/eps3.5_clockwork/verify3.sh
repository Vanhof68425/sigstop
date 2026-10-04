#!/bin/bash
# eps3.5 step 3 — verify: an active cron line runs sigstop-heartbeat
# every minute. Checks the schedule, not the log, so the result never
# depends on where the minute boundary falls. Root's crontab, or a
# system crontab line (with its user field), both pass.

every_minute() {
  # stdin: cron lines. Pass if any uncommented line mentions the
  # heartbeat and its five time fields mean "every minute".
  grep -v '^[[:space:]]*#' | grep "sigstop-heartbeat" | awk '
    { ok = ($1 == "*" || $1 == "*/1"); for (i = 2; i <= 5; i++) if ($i != "*") ok = 0; if (ok) found = 1 }
    END { exit found ? 0 : 1 }'
}

crontab -l 2>/dev/null | every_minute && exit 0
cat /etc/crontab /etc/cron.d/* 2>/dev/null | every_minute && exit 0

exit 1
