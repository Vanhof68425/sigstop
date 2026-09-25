#!/bin/bash
# eps3.0_whats-running — setup (World 3 opener)
# Eval node 07: empty queue, yet two workers run under the automated
# `harness` account (World 3 canon seed: no human started them —
# visible in ps's USER column, left uncommented).
#   prom-eval-shard  light CPU, the name the source gave us  (step 1)
#   ckpt-sync        pegs a core, name unknown to the player (step 2)
# Workers are launched detached and niced 19 by sigstop-reset, which is
# also the player's recovery tool if they kill something by mistake.

set -e

# ---------------------------------------------------------------
# The automated eval account — not a person
# ---------------------------------------------------------------
if ! id harness >/dev/null 2>&1; then
  useradd -r -M -s /usr/sbin/nologin -c "apex eval harness (automated)" harness
fi

# ---------------------------------------------------------------
# Story state: the queue that is supposed to be empty
# ---------------------------------------------------------------
mkdir -p /var/apex/evalq
cat > /var/apex/evalq/queue.state << 'EOF'
node: eval-07
status: OUT OF SERVICE (hardware fault, ticket closed 2026-05-14)
scheduled jobs: 0
last human change: 2026-05-14 by eval-ops
EOF

# ---------------------------------------------------------------
# The workers
# ---------------------------------------------------------------
cat > /usr/local/bin/prom-eval-shard << 'EOF'
#!/bin/bash
# light, steady work
while :; do for i in $(seq 1 3000); do :; done; sleep 0.2; done
EOF

cat > /usr/local/bin/ckpt-sync << 'EOF'
#!/bin/bash
# heavy, constant work
while :; do :; done
EOF

# Harmless background furniture so the process list looks lived-in
cat > /usr/local/bin/apex-node-agent << 'EOF'
#!/bin/bash
while :; do sleep 30; done
EOF

chmod 755 /usr/local/bin/prom-eval-shard /usr/local/bin/ckpt-sync /usr/local/bin/apex-node-agent

# ---------------------------------------------------------------
# sigstop-reset — launches (and relaunches) the scene.
# Player-facing recovery tool: new PIDs after every reset.
# ---------------------------------------------------------------
cat > /usr/local/bin/sigstop-reset << 'EOF'
#!/bin/bash
for n in prom-eval-shard ckpt-sync apex-node-agent; do
  pkill -9 -x "$n" 2>/dev/null || true
done
sleep 1
launch() {
  setsid nohup nice -n 19 setpriv --reuid="$1" --regid="$1" --init-groups \
    "/usr/local/bin/$2" >/dev/null 2>&1 < /dev/null &
}
launch root apex-node-agent
launch harness prom-eval-shard
launch harness ckpt-sync
sleep 1
rm -f /tmp/.sigstop_soft
if [ "$1" != "quiet" ]; then
  echo ""
  echo "  [SIGSTOP] node restored. the PIDs are new. look again."
  echo ""
fi
EOF
chmod 755 /usr/local/bin/sigstop-reset
/usr/local/bin/sigstop-reset quiet

# ---------------------------------------------------------------
# Theming
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps3.0) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open // apex eval node 07]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  the queue says empty: /var/apex/evalq/queue.state"
  echo "  the machine disagrees. find out what's running."
  echo "  look. don't touch."
  echo ""
fi

# Alive = a matching process in any state except zombie.
__sigstop_alive() {
  local p st
  for p in $(pgrep -x "$1"); do
    st=$(awk '{print $3}' /proc/"$p"/stat 2>/dev/null)
    [[ -n "$st" && "$st" != "Z" ]] && return 0
  done
  return 1
}

__sigstop_watch() {
  # Soft failure (teaching episode): something was killed. Recoverable.
  if [[ ! -f /tmp/.sigstop_soft ]]; then
    if ! __sigstop_alive prom-eval-shard || ! __sigstop_alive ckpt-sync; then
      touch /tmp/.sigstop_soft
      echo ""
      echo "  [SIGSTOP] you ended something. tonight we look, we don't touch."
      echo "  [SIGSTOP] run sigstop-reset to put the node back the way you found it."
      echo ""
      return
    fi
  fi
  # ONE milestone: the hungriest process named.
  if [[ ! -f /tmp/.sigstop_ms1 ]] && grep -qi "ckpt-sync" /root/hungriest.txt 2>/dev/null; then
    touch /tmp/.sigstop_ms1
    echo ""
    echo "  [SIGSTOP] ckpt-sync. checkpoint sync. a checkpoint is a model's saved state."
    echo "  [SIGSTOP] an out-of-service eval node has no reason to move those at 3 a.m."
    echo ""
  fi
}
PROMPT_COMMAND="__sigstop_watch${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
# --- end SIGSTOP theming ---
THEME

# The mirror stays sealed — by the operator's own hand (eps2.6).
mkdir -p /opt/apex
chmod 000 /opt/apex

history -c 2>/dev/null || true
echo "done" > /tmp/setup-complete
