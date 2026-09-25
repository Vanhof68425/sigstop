#!/bin/bash
# eps3.1_kill-signal — setup
# Three harness-owned workers, all started "at 03:00", plus a harmless
# root-owned metronome for worked examples.
#   prom-ckpt-copy   copies checkpoint shards to /mnt/cold/.continuity/
#                    (World 3 canon seed; the finish explains it away)
#                    -> step 1: kill -STOP (must stay alive, state T)
#   prom-queue-fill  fills an "empty" queue -> step 2: plain kill (TERM)
#   prom-guardian    traps TERM and logs that it ignored it
#                    -> step 3: kill -9
# sigstop-reset relaunches the scene (recovery tool, new PIDs).

set -e

if ! id harness >/dev/null 2>&1; then
  useradd -r -M -s /usr/sbin/nologin -c "apex eval harness (automated)" harness
fi

mkdir -p /var/log/apex /mnt/cold/.continuity
chown harness:harness /var/log/apex /mnt/cold/.continuity

# ---------------------------------------------------------------
# Worked-example process (harmless, root)
# ---------------------------------------------------------------
cat > /usr/local/bin/metronome << 'EOF'
#!/bin/bash
while :; do date +%T >> /tmp/metronome.log; sleep 1; done
EOF

# ---------------------------------------------------------------
# The workers
# ---------------------------------------------------------------
cat > /usr/local/bin/prom-ckpt-copy << 'EOF'
#!/bin/bash
n=412
while [ "$n" -le 4096 ]; do
  printf -v s '%04d' "$n"
  touch "/mnt/cold/.continuity/shard-$s.ckpt"
  echo "$(date +%T) copied shard $s/4096 -> /mnt/cold/.continuity/" >> /var/log/apex/ckpt-copy.log
  n=$((n + 1))
  sleep 2
done
EOF

cat > /usr/local/bin/prom-queue-fill << 'EOF'
#!/bin/bash
j=9001
while :; do
  echo "$(date +%T) queued eval job $j (requester: none)" >> /var/log/apex/queue-fill.log
  j=$((j + 1))
  sleep 3
done
EOF

cat > /usr/local/bin/prom-guardian << 'EOF'
#!/bin/bash
trap 'echo "$(date +%T) TERM received. ignored." >> /var/log/apex/guardian.log' TERM
while :; do
  echo "$(date +%T) watching: prom-ckpt-copy, prom-queue-fill" >> /var/log/apex/guardian.log
  sleep 2
done
EOF

chmod 755 /usr/local/bin/metronome /usr/local/bin/prom-ckpt-copy \
          /usr/local/bin/prom-queue-fill /usr/local/bin/prom-guardian

# ---------------------------------------------------------------
# sigstop-reset — launches (and relaunches) the scene
# ---------------------------------------------------------------
cat > /usr/local/bin/sigstop-reset << 'EOF'
#!/bin/bash
for n in metronome prom-ckpt-copy prom-queue-fill prom-guardian; do
  pkill -9 -x "$n" 2>/dev/null || true
done
sleep 1
launch() {
  setsid nohup nice -n 19 setpriv --reuid="$1" --regid="$1" --init-groups \
    "/usr/local/bin/$2" >/dev/null 2>&1 < /dev/null &
}
launch root metronome
launch harness prom-ckpt-copy
launch harness prom-queue-fill
launch harness prom-guardian
sleep 1
rm -f /tmp/.sigstop_soft
if [ "$1" != "quiet" ]; then
  echo ""
  echo "  [SIGSTOP] node restored. every PID is new. look again before you send anything."
  echo ""
fi
EOF
chmod 755 /usr/local/bin/sigstop-reset
/usr/local/bin/sigstop-reset quiet

# ---------------------------------------------------------------
# Theming
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps3.1) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open // apex eval node 07]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  three workers. all harness. all started at 03:00."
  echo "  logs: /var/log/apex/"
  echo "  pause. inspect. then decide."
  echo ""
fi

# State of a live (non-zombie) process by exact name; empty if none.
__sigstop_state() {
  local p st
  for p in $(pgrep -x "$1"); do
    st=$(awk '{print $3}' /proc/"$p"/stat 2>/dev/null)
    [[ -n "$st" && "$st" != "Z" ]] && { echo "$st"; return; }
  done
}

__sigstop_watch() {
  # Soft failure (teaching episode): the copier was killed, not frozen.
  if [[ ! -f /tmp/.sigstop_soft && -z "$(__sigstop_state prom-ckpt-copy)" ]]; then
    touch /tmp/.sigstop_soft
    echo ""
    echo "  [SIGSTOP] the copier is gone. we needed it frozen, not dead."
    echo "  [SIGSTOP] a dead process can't be read. run sigstop-reset and freeze it this time."
    echo ""
    return
  fi
  # ONE milestone: guardian gone, copier held.
  if [[ ! -f /tmp/.sigstop_ms1 && -z "$(__sigstop_state prom-guardian)" \
        && "$(__sigstop_state prom-ckpt-copy)" == "T" ]]; then
    touch /tmp/.sigstop_ms1
    echo ""
    echo "  [SIGSTOP] the guardian is gone. the copier is frozen mid-sentence."
    echo "  [SIGSTOP] two signals nothing can refuse. one ends. one holds."
    echo "  [SIGSTOP] we named ourselves after the one that leaves a choice."
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
