#!/bin/bash
# eps2.0_make-and-move — verify
# First multi-outcome verification. ALL must hold:
#   1. Vault exists with the three correctly named, non-empty copies
#   2. Copies actually match the originals (cp, not recreate)
#   3. Originals still present in incoming (cp, not mv)
#   4. The corrupted duplicate is gone (the sanctioned rm)

V="/root/vault/4471"
IN="/root/incoming"

# 1. Vault structure and named copies
[ -d "$V" ] || exit 1
[ -s "$V/4471_before.cfg" ] || exit 1
[ -s "$V/4471_after.log" ]  || exit 1
[ -s "$V/4471_note.txt" ]   || exit 1

# 2. Copies match sources
cmp -s "$IN/evalconfig.bak" "$V/4471_before.cfg" || exit 1
cmp -s "$IN/gradelog.frag"  "$V/4471_after.log"  || exit 1
cmp -s "$IN/final.note"     "$V/4471_note.txt"   || exit 1

# 3. Originals untouched (implicitly checked by cmp above needing them,
#    but be explicit for clarity)
[ -f "$IN/evalconfig.bak" ] || exit 1
[ -f "$IN/gradelog.frag" ]  || exit 1
[ -f "$IN/final.note" ]     || exit 1

# 4. The duplicate is destroyed
[ ! -e "$IN/transfer.dup" ] || exit 1

exit 0
