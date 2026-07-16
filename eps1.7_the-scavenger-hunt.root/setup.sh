#!/bin/bash
# eps1.7_the-scavenger-hunt — setup (BOSS)
# Four fragments -> passphrase "everyone-sees-nobody-looks"
#   1. hidden dotfile in home            (ls -la)
#   2. one line inside noisy logs        (grep -r)
#   3. a filename with no address        (find / -name)
#   4. inside /opt/apex — door now OPEN  (continuity payoff from eps1.0)
# Verify is outcome-based: signal file named the passphrase, in home.

set -e

# ---------------------------------------------------------------
# The brief
# ---------------------------------------------------------------
cat > /root/job.brief << 'EOF'
------------------------------------------------------------
 [SIGSTOP // job 001 // recovery]

 Four fragments. Work in order.

 1. The first one never left home. It's beside you right
    now, hiding the way names hide.

 2. The second is one line in the mirror's logs.
    /var/apex-mirror/logs — thousands of lines of Apex
    telemetry. One of them mentions a fragment. Don't
    read. Interrogate.

 3. The third is a file called

        shard.key

    I lost track of where I put it. That's not carelessness.
    That's a test. Start from the root of everything.

 4. The fourth is behind the door that was sealed.
    You know the one. It's open tonight.

 Join the words: hyphens, lowercase, fragment order.
 Plant the signal file at home. Then we talk.
------------------------------------------------------------
EOF

# ---------------------------------------------------------------
# Fragment 1 — hidden dotfile in home
# ---------------------------------------------------------------
cat > /root/.initiation << 'EOF'
[fragment 1/4: everyone]
You looked where most people never do. Keep going.
EOF

# ---------------------------------------------------------------
# Fragment 2 — one line among thousands
# ---------------------------------------------------------------
mkdir -p /var/apex-mirror/logs
SVCS=(ingest scheduler telemetry authsvc modelgw billing)
LVLS=(INFO INFO INFO WARN DEBUG)
for f in ingest scheduler telemetry; do
  LOG="/var/apex-mirror/logs/$f.log"
  : > "$LOG"
  for i in $(seq 1 800); do
    svc=${SVCS[$RANDOM % ${#SVCS[@]}]}
    lvl=${LVLS[$RANDOM % ${#LVLS[@]}]}
    printf '2026-07-%02d %02d:%02d:%02d %s %s req=%04x latency=%dms status=200\n' \
      $((RANDOM % 15 + 1)) $((RANDOM % 24)) $((RANDOM % 60)) $((RANDOM % 60)) \
      "$lvl" "$svc" $RANDOM $((RANDOM % 900)) >> "$LOG"
  done
done
# The needle — buried mid-file in scheduler.log
sed -i '412i 2026-07-09 03:14:07 DEBUG scheduler [fragment 2/4: sees] do-not-index' \
  /var/apex-mirror/logs/scheduler.log

# ---------------------------------------------------------------
# Fragment 3 — shard.key, address unknown
# ---------------------------------------------------------------
mkdir -p /usr/share/apex-telemetry/cache/9f/e2
cat > /usr/share/apex-telemetry/cache/9f/e2/shard.key << 'EOF'
[fragment 3/4: nobody]
No address, no problem. find is how operators remember.
EOF

# ---------------------------------------------------------------
# Fragment 4 — the door opens
# ---------------------------------------------------------------
mkdir -p /opt/apex/vault
chmod 755 /opt/apex /opt/apex/vault
cat > /opt/apex/vault/fragment.txt << 'EOF'
[fragment 4/4: looks]
Seven sessions you walked past this door. Tonight you walked in.
Remember what that took. It never gets easier. You get readier.
EOF
cat > /opt/apex/README << 'EOF'
This directory is a fraction of what Apex keeps behind doors.
World 2 is where you learn why the locks work the way they do —
and how to be the one holding the keys.
EOF

# ---------------------------------------------------------------
# Theming (template from eps1.1)
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps1.7 BOSS) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open // JOB ACTIVE]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  the brief is in your home directory. work it in order."
  echo ""
fi

# ONE milestone: crossing the threshold of the door that was sealed.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 && "$PWD" == /opt/apex* ]]; then
    touch /tmp/.sigstop_ms1
    echo ""
    echo "  [SIGSTOP] seven sessions past this door."
    echo "  [SIGSTOP] told you we'd be back for it."
    echo ""
  fi
}
PROMPT_COMMAND="__sigstop_watch${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
# --- end SIGSTOP theming ---
THEME

history -c 2>/dev/null || true
echo "done" > /tmp/setup-complete
