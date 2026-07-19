#!/bin/bash
# eps2.5_who-owns-what — setup
# 1. courier account + cell group (courier NOT in cell yet — the
#    player adds the membership with usermod -aG)
# 2. /var/sigstop/handoff: distilled drop-08 evidence, root-owned,
#    plus one file owned by a ghost uid (deleted account)
# 3. Watcher: ONE milestone when the whole handoff answers to
#    courier:cell

set -e

groupadd -f cell
id -u courier >/dev/null 2>&1 || useradd -m -s /bin/bash courier

H="/var/sigstop/handoff"
mkdir -p "$H"

cat > "$H/evidence_4471.log" << 'EOF'
[evidence // sigstop // id:EV-DISTILLED]
[4471 // shard 01/12] pulled the raw run logs before the scrub. eval 4471, prometheus build 9c4.
[4471 // shard 04/12] 22:51 scores recomputed. plus eleven, across the board.
[4471 // shard 08/12] 23:40 severity reclassified. no ticket. it happened in a hallway.
[4471 // shard 12/12] the window is inside six weeks now. that's the rest. do the arithmetic.
[shim // entry 1/5] mode=report_only set 2025-11-03. change ticket: none on file.
(full extract: seventeen lines. abridged copy staged for handoff.)
EOF

cat > "$H/manifest.count" << 'EOF'
17
EOF

cat > "$H/ledger.psv" << 'EOF'
[evidence // sigstop // id:EV-LEDGER]
drop|received|routed|burned
07|yes|yes|yes
08|yes|yes|pending
EOF

# The ghost: a deleted account's uid, still stamped on the ledger
chown 1201:1201 "$H/ledger.psv"

# ---------------------------------------------------------------
# Theming
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps2.5) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  the handoff: /var/sigstop/handoff"
  echo "  a courier is waiting. the stamps are wrong."
  echo "  read the column before you change it."
  echo ""
fi

# ONE milestone: the whole handoff answers to courier:cell.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 ]]; then
    local H="/var/sigstop/handoff" ok=1 f
    [[ -d "$H" ]] || return
    [[ "$(stat -c '%U:%G' "$H" 2>/dev/null)" == "courier:cell" ]] || ok=0
    for f in "$H"/*; do
      [[ -e "$f" ]] || continue
      [[ "$(stat -c '%U:%G' "$f" 2>/dev/null)" == "courier:cell" ]] || ok=0
    done
    id -nG courier 2>/dev/null | tr ' ' '\n' | grep -qx cell || ok=0
    if [[ "$ok" == "1" ]]; then
      touch /tmp/.sigstop_ms1
      echo ""
      echo "  [SIGSTOP] every stamp in the bag reads courier. including the"
      echo "  [SIGSTOP] one that answered to a number. the pointing stops."
      echo ""
    fi
  fi
}
PROMPT_COMMAND="__sigstop_watch${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
# --- end SIGSTOP theming ---
THEME

mkdir -p /opt/apex
chmod 000 /opt/apex

history -c 2>/dev/null || true
echo "done" > /tmp/setup-complete
