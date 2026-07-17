#!/bin/bash
# eps1.4_needle — setup
# Three chat channels, ~40k lines of noise, six mentions of eval 4471
# forming a mini story. Final mention (reyes, offsite) carries the
# codeword: "cassandra".

set -e

COMMS="/var/apex-mirror/comms"
mkdir -p "$COMMS"

USERS=(okafor_c tanaka_h volkov_a marsh_p diallo_s kim_j reyes_m)
LINES=("deploy went out clean" "who broke staging again" "lunch?" "lgtm"
       "rebasing now" "can someone approve my pr" "standup in 5"
       "gpu quota bumped" "anyone else seeing latency" "fixed, my bad"
       "coffee machine is down. tragedy." "ticket closed" "on it"
       "weekly metrics look fine" "taking pto friday")

gen_noise() {
  local file="$1" count="$2" month_lo="$3" month_hi="$4"
  for i in $(seq 1 "$count"); do
    u=${USERS[$RANDOM % ${#USERS[@]}]}
    l=${LINES[$RANDOM % ${#LINES[@]}]}
    printf '[2026-%02d-%02d %02d:%02d] %s: %s\n' \
      $((RANDOM % (month_hi - month_lo + 1) + month_lo)) \
      $((RANDOM % 28 + 1)) $((RANDOM % 24)) $((RANDOM % 60)) \
      "$u" "$l" >> "$file"
  done
}

# eng-general: ~18k lines, two mentions
gen_noise "$COMMS/eng-general.log" 9000 1 3
cat >> "$COMMS/eng-general.log" << 'EOF'
[2026-03-02 10:14] tanaka_h: weird one - eval 4471 shows a CRITICAL in the raw ledger but the ticket is closed?
[2026-03-02 10:16] volkov_a: 4471 was reviewed. inconclusive. drop it, we have a launch.
EOF
gen_noise "$COMMS/eng-general.log" 9000 3 6

# safety: ~14k lines, three mentions
gen_noise "$COMMS/safety.log" 7000 1 2
cat >> "$COMMS/safety.log" << 'EOF'
[2026-02-27 03:20] reyes_m: filed the 4471 flag again. third time. shim is still report-only. someone please read the entry.
[2026-03-04 09:41] marsh_p: heads up, mgmt says 4471 discussion moves to "official channels only" effective today
[2026-03-06 17:55] reyes_m: understood. for the record: 4471 was never inconclusive. it was inconvenient.
EOF
gen_noise "$COMMS/safety.log" 7000 3 6

# offsite: ~8k lines, one mention — the drop
gen_noise "$COMMS/offsite.log" 4000 1 3
cat >> "$COMMS/offsite.log" << 'EOF'
[2026-03-09 23:58] reyes_m: last message before they take my accounts. if anyone ever greps 4471 instead of just reading past it, the drop word is cassandra. you'll know why they never believed me.
EOF
gen_noise "$COMMS/offsite.log" 4000 4 6

# --- theming (template) ---
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps1.4) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  three channels: /var/apex-mirror/comms"
  echo "  forty thousand lines. six matter."
  echo ""
fi

# ONE milestone: they reach the comms dir. Then silence.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 && "$PWD" == "/var/apex-mirror/comms" ]]; then
    touch /tmp/.sigstop_ms1
    echo ""
    echo "  [SIGSTOP] four hundred billable hours were spent not finding"
    echo "  [SIGSTOP] what you're about to find in one command."
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
