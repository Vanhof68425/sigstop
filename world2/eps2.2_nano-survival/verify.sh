#!/bin/bash
# eps2.2_nano-survival — verify
# Outcome: the three lines match spec AND the healthy lines survived
# (surgery, not demolition).

C="/etc/sigstop/relay.conf"
[ -f "$C" ] || exit 1

# The three corrections
grep -q "^endpoint=drop.sigstop.net$" "$C" || exit 1
grep -q "^interval=60$" "$C" || exit 1
grep -q "^burn_on_read=true$" "$C" || exit 1

# The breach endpoint must be gone entirely
grep -q "pubmirror" "$C" && exit 1

# Untouched lines must remain untouched
grep -q "^callsign=operator$" "$C" || exit 1
grep -q "^cache_path=/var/sigstop/staging$" "$C" || exit 1
grep -q "^compression=on$" "$C" || exit 1
grep -q "^retry_limit=3$" "$C" || exit 1

exit 0
