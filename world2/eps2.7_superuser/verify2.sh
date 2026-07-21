#!/bin/bash
# eps2.7 step 2 — verify: skeleton key gone, courier grant kept
# Outcome only.

[ ! -e /etc/sudoers.d/apex-compat ] || exit 1

[ -f /etc/sudoers.d/courier ] || exit 1
grep -q 'courier ALL=(root) NOPASSWD: /usr/local/bin/relay-burn' /etc/sudoers.d/courier || exit 1

exit 0
