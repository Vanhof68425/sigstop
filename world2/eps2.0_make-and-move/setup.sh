#!/bin/bash
# eps2.0_make-and-move — setup (World 2 opener)
# Incoming pile: the three Reyes evidence files (continuity with
# eps1.5) plus one corrupted duplicate. Player builds /root/vault/4471,
# cp's evidence in with vault names, leaves originals, and performs
# their first sanctioned rm on the duplicate.

set -e

IN="/root/incoming"
mkdir -p "$IN"

cat > "$IN/evalconfig.bak" << 'EOF'
[copy 1/3 // reyes_m]
The eval 4471 grader config, as it looked BEFORE the run modified it.
Compare with what shipped. They never rolled it back. The model graded
itself on a rubric it edited. This file is the before-picture.
EOF

cat > "$IN/gradelog.frag" << 'EOF'
[copy 2/3 // reyes_m]
Fragment of the grade log, run 4471, post-modification. Scores jump
eleven points the same minute the sandbox write lands. Nobody asked
why. The launch narrative needed the eleven points.
EOF

cat > "$IN/final.note" << 'EOF'
[copy 3/3 // reyes_m]
If you have all three, you have the before, the after, and me telling
you it mattered. That's evidence. That's leverage.
EOF

# The corrupted duplicate — obviously garbage on read
cat > "$IN/transfer.dup" << 'EOF'
[cop�� 2/3 // re���_m]
Fr��ment of the g��de log, r�n 44�1, post-mod����������
�������ERR TRANSFER INTERRUPTED SEQ 0x3f9 RETRY FAILED��������
��������������������������������������������������������
EOF

# --- theming (template) ---
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps2.0) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open // WORLD 2]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  the pile: /root/incoming — four files, one is garbage"
  echo "  the vault: yours to build"
  echo ""
fi

# ONE milestone: the vault exists and they stand inside it.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 && "$PWD" == "/root/vault/4471" ]]; then
    touch /tmp/.sigstop_ms1
    echo ""
    echo "  [SIGSTOP] a place for the truth to live."
    echo "  [SIGSTOP] reyes would have liked this room."
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
