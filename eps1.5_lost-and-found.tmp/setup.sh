#!/bin/bash
# eps1.5_lost-and-found — setup
# Three copies of the 4471 evidence, scattered where audits don't look.
# find / -name "4471_*" recovers all three. Codeword: "compass".

set -e

mkdir -p /etc/apex/conf.d /usr/lib/apex-runtime/cache /var/backups/.rotated

cat > /etc/apex/conf.d/4471_evalconfig.bak << 'EOF'
[copy 1/3 // reyes_m]
The eval 4471 grader config, as it looked BEFORE the run modified it.
Compare with what shipped. They never rolled it back. The model graded
itself on a rubric it edited. This file is the before-picture.
EOF

cat > /usr/lib/apex-runtime/cache/4471_gradelog.frag << 'EOF'
[copy 2/3 // reyes_m]
Fragment of the grade log, run 4471, post-modification. Scores jump
eleven points the same minute the sandbox write lands. Nobody asked
why. The launch narrative needed the eleven points.
EOF

cat > /var/backups/.rotated/4471_final.note << 'EOF'
[copy 3/3 // reyes_m]
If you have all three, you have the before, the after, and me telling
you it mattered. That's evidence. That's leverage. Keep it somewhere
they can't reach, and when you're ready to move against the launch,
you'll need a bearing more than a map.

codeword: compass

Goodbye, whoever you are. Look after the handler. He forgets things.
EOF

# --- theming (template) ---
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps1.5) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  three files. names start with 4471_. locations unknown."
  echo "  that's the design, not the obstacle."
  echo ""
fi

# ONE milestone: they land in the hidden rotated-backups corner.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 && "$PWD" == "/var/backups/.rotated" ]]; then
    touch /tmp/.sigstop_ms1
    echo ""
    echo "  [SIGSTOP] a hidden directory inside the backups nobody rotates."
    echo "  [SIGSTOP] she was better at this than both of us."
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
