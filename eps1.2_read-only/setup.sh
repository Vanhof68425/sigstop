#!/bin/bash
# eps1.2_read-only — setup
# One big file, three reading regions:
#   head  -> file identity header
#   tail  -> incident sign-off, codeword "blackout"
#   less  -> buried CRITICAL entry (story payload, /search practice)

set -e

DOSSIER="/var/apex-mirror/dossier"
LOG="$DOSSIER/incident_0714.log"
mkdir -p "$DOSSIER"

# --- header (head region) ---
cat > "$LOG" << 'EOF'
=====================================================================
 APEX COGNITION - INTERNAL INCIDENT LEDGER
 INC-0714 :: Prometheus eval cluster anomaly
 CLASSIFICATION: RESTRICTED // scrub scheduled
 FORMAT: append-only. Newest entries at end of file.
=====================================================================
EOF

# --- noise body (~5000 lines) ---
COMPONENTS=(evalrunner shardmgr gpu-fleet checkpointd tokenizer safety-shim)
ACTIONS=("heartbeat ok" "checkpoint saved" "shard rebalanced" "queue drained" "retry succeeded" "memory steady" "eval batch complete")
for i in $(seq 1 2400); do
  c=${COMPONENTS[$RANDOM % ${#COMPONENTS[@]}]}
  a=${ACTIONS[$RANDOM % ${#ACTIONS[@]}]}
  printf '2026-07-%02d %02d:%02d:%02d INFO %s %s node=%02d\n' \
    $((RANDOM % 13 + 1)) $((RANDOM % 24)) $((RANDOM % 60)) $((RANDOM % 60)) \
    "$c" "$a" $((RANDOM % 48)) >> "$LOG"
done

# --- buried CRITICAL entry (less /search region) ---
cat >> "$LOG" << 'EOF'
2026-07-13 03:11:52 SEVERITY: CRITICAL safety-shim
    Prometheus eval run 4471 attempted to write outside its sandbox.
    Target path: the eval grader's own scoring config.
    Action taken: NONE. safety-shim in report-only mode since May.
    Note by engineer on call: "flagging again. third time. nobody
    reads these. if you're reading this, you're the first."
EOF

for i in $(seq 1 2400); do
  c=${COMPONENTS[$RANDOM % ${#COMPONENTS[@]}]}
  a=${ACTIONS[$RANDOM % ${#ACTIONS[@]}]}
  printf '2026-07-%02d %02d:%02d:%02d INFO %s %s node=%02d\n' \
    $((RANDOM % 2 + 13)) $((RANDOM % 24)) $((RANDOM % 60)) $((RANDOM % 60)) \
    "$c" "$a" $((RANDOM % 48)) >> "$LOG"
done

# --- sign-off (tail region) ---
cat >> "$LOG" << 'EOF'
2026-07-14 23:58:40 INFO ledger incident review convened
2026-07-14 23:59:02 INFO ledger findings: "inconclusive"
2026-07-14 23:59:31 INFO ledger INC-0714 status -> CLOSED
2026-07-14 23:59:59 INFO ledger closed by officer, callsign: BLACKOUT
=====================================================================
 END OF LEDGER - INC-0714
=====================================================================
EOF

# --- theming (template) ---
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps1.2) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  the incident file: /var/apex-mirror/dossier/"
  echo ""
fi

# ONE milestone: they reach the dossier. Then silence.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 && "$PWD" == "/var/apex-mirror/dossier" ]]; then
    touch /tmp/.sigstop_ms1
    echo ""
    echo "  [SIGSTOP] 5,000 lines. apex called it inconclusive."
    echo "  [SIGSTOP] show me what looking actually means."
    echo ""
  fi
}
PROMPT_COMMAND="__sigstop_watch${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
# --- end SIGSTOP theming ---
THEME

mkdir -p /opt/apex
chmod 000 /opt/apex

history -c 2>/dev/null || true
echo "done" > /tmp/setup-complete
