#!/bin/bash
# eps2.6_permission-denied — setup
# 1. Handoff staged from eps2.5 (courier:cell, switches wide open —
#    player sets 750/640)
# 2. relay-burn installed without execute (player flips +x; the tool
#    gets USED in eps2.7)
# 3. /opt/apex: the payoff. Mirror of Apex's deploy tree with
#    deploy_gate.conf inside, sealed 000. Player opens (700), reads
#    the gate, leaves the shim mode as a /root codeword file, and
#    re-seals to 000. Canon: the mirror stays sealed going forward.
# 4. Watcher: ONE milestone when the codeword exists and the door is
#    sealed again.

set -e

groupadd -f cell
id -u courier >/dev/null 2>&1 || useradd -m -s /bin/bash courier

H="/var/sigstop/handoff"
mkdir -p "$H"

cat > "$H/evidence_4471.log" << 'EOF'
[evidence // sigstop // id:EV-DISTILLED]
(distilled drop 08 — seventeen lines. stamped and bagged, eps2.5.)
EOF

cat > "$H/ledger.psv" << 'EOF'
[evidence // sigstop // id:EV-LEDGER]
drop|received|routed|burned
08|yes|yes|pending
EOF

chown -R courier:cell "$H"
chmod 777 "$H"
chmod 666 "$H"/*

# The burn tool — delivered inert. eps2.6 arms it; eps2.7 fires it.
cat > /usr/local/bin/relay-burn << 'EOF'
#!/bin/bash
# sigstop relay-burn — burn ritual for a completed handoff
set -e
B="/var/sigstop/burn"
mkdir -p "$B"
printf '[burn // sigstop // receipt]\nburned by: %s\nat: %s\n' \
  "${SUDO_USER:-$USER}" "$(date -u +%FT%TZ)" > "$B/receipt.log"
chmod 600 "$B/receipt.log"
echo "relay-burn: handoff burned. receipt written."
EOF
chmod 644 /usr/local/bin/relay-burn

# ---------------------------------------------------------------
# The door. Contents first, then the seal.
# ---------------------------------------------------------------
mkdir -p /opt/apex
cat > /opt/apex/deploy_gate.conf << 'EOF'
# apex cognition // prometheus deployment gate
# mirror capture — [evidence // sigstop // id:EV-GATE]

model=prometheus
build=9c4
eval_baseline=4471
safety_shim=report_only
window=advanced
approvals=auto
EOF
chmod 600 /opt/apex/deploy_gate.conf
chmod 000 /opt/apex

# ---------------------------------------------------------------
# Theming
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps2.6) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  three locks: the handoff, the tool, the door."
  echo "  the door is /opt/apex. it opens tonight. once."
  echo "  it closes behind you."
  echo ""
fi

# ONE milestone: the codeword is home and the door is sealed again.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 ]]; then
    if [[ -e /root/report_only || -e /root/report-only ]] \
       && [[ "$(stat -c '%a' /opt/apex 2>/dev/null)" == "0" ]]; then
      touch /tmp/.sigstop_ms1
      echo ""
      echo "  [SIGSTOP] opened. read. sealed. you now know what the gate"
      echo "  [SIGSTOP] knows: one underscore word between prometheus and"
      echo "  [SIGSTOP] the world. that word is why we exist."
      echo ""
    fi
  fi
}
PROMPT_COMMAND="__sigstop_watch${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
# --- end SIGSTOP theming ---
THEME

history -c 2>/dev/null || true
echo "done" > /tmp/setup-complete
