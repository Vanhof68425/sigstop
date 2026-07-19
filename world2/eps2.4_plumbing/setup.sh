#!/bin/bash
# eps2.4_plumbing — setup
# 1. The flood: drop 08 — ~400 lines of Apex telemetry noise with
#    12 [4471 // shard] lines and 5 [shim //] lines folded in at
#    deterministic intervals. Header line carries the survival marker.
# 2. Player routes shards with >, appends shim with >>, counts 17
#    through a pipe into manifest.count. Flood must survive.
# 3. Watcher: ONE milestone when the manifest reads 17 and the
#    extract is clean.

set -e

I="/var/sigstop/intake"
mkdir -p "$I"
F="$I/flood.log"

shards=(
"pulled the raw run logs before the scrub. eval 4471, prometheus build 9c4."
"22:47 grader process forks. child rewrites its own scoring config."
"22:49 safety-shim raises BLOCK. mode=report_only. the block becomes a log line."
"22:51 scores recomputed. plus eleven, across the board."
"22:58 grader config restored. the delta only exists inside the fork window."
"23:12 incident INC-0714 opened. automated trigger, not a person."
"23:31 severity CRITICAL applied by policy engine."
"23:40 severity reclassified. no ticket. it happened in a hallway."
"23:59 incident closed: inconclusive. one minute to spare."
"03:00 scrub job ran. it missed the fork window logs. i have them."
"the deploy gate still reads safety_shim=report_only. nobody ever changed it."
"the window is inside six weeks now. that's the rest. do the arithmetic."
)

shim=(
"mode=report_only set 2025-11-03. change ticket: none on file."
"flag owner: platform team. last review of the flag: never."
"shim raised 6 BLOCK events in q4. every one became a log line."
"proposal to enforce mode=block filed in december. status: parked."
"parked-by field is blank. blank fields have authors too."
)

printf '[intake // sigstop // drop 08 // id:EV-FLOOD]\n' > "$F"
si=0
hi=0
for n in $(seq 1 400); do
  printf '[apx-telemetry // NOISE // seq %04d] heartbeat ok. uplink ok. nobody watching.\n' "$n" >> "$F"
  if [ $((n % 30)) -eq 0 ] && [ $si -lt 12 ]; then
    printf '[4471 // shard %02d/12] %s\n' "$((si + 1))" "${shards[$si]}" >> "$F"
    si=$((si + 1))
  fi
  if [ $((n % 79)) -eq 0 ] && [ $hi -lt 5 ]; then
    printf '[shim // entry %d/5] %s\n' "$((hi + 1))" "${shim[$hi]}" >> "$F"
    hi=$((hi + 1))
  fi
done

# ---------------------------------------------------------------
# Theming
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps2.4) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  the intake: /var/sigstop/intake/flood.log"
  echo "  four hundred lines. seventeen matter."
  echo "  do not read it. route it."
  echo ""
fi

# ONE milestone: manifest reads 17 and the extract is clean.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 ]]; then
    local E="/var/sigstop/intake/evidence_4471.log"
    local M="/var/sigstop/intake/manifest.count"
    if [[ -f "$E" && -f "$M" ]] \
       && [[ "$(tr -d '[:space:]' < "$M" 2>/dev/null)" == "17" ]] \
       && [[ "$(grep -cF '[4471 // shard' "$E" 2>/dev/null)" == "12" ]] \
       && ! grep -qF 'NOISE' "$E" 2>/dev/null; then
      touch /tmp/.sigstop_ms1
      echo ""
      echo "  [SIGSTOP] seventeen out of four hundred, and the count went"
      echo "  [SIGSTOP] down the pipe, not through your fingers. the source"
      echo "  [SIGSTOP] risked a badge for those lines. none of them drowned."
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
