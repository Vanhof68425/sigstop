#!/bin/bash
# eps3.2 step 2 — verify: drop 09 was decrypted with the right
# passphrase (sigstop-decrypt only writes these on success).

[ -f /root/decrypt.done ] || exit 1
[ -s /root/drop09.txt ] || exit 1

exit 0
