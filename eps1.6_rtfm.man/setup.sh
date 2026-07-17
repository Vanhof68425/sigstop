#!/bin/bash
# eps1.6_rtfm — setup
# 40 near-identical notes with shuffled mtimes. The most recently
# modified one is the live drop -> codeword "doctrine".
# Discoverable instantly with ls -t (or -lt), which the player must
# dig out of man ls themselves.

set -e

PAD="/var/apex-mirror/scratchpad"
mkdir -p "$PAD"

DEAD_LINES=("drop collected 05/26. nothing further." \
            "drop collected. contents forwarded. burn after reading." \
            "stale. superseded by later drop." \
            "collected. courier confirms receipt.")

# 39 dead drops with randomized OLD mtimes (5-40 days ago)
for i in $(seq 1 39); do
  h=$(printf '%08x' $((RANDOM * RANDOM + i)))
  f="$PAD/note_$h.txt"
  echo "${DEAD_LINES[$RANDOM % ${#DEAD_LINES[@]}]}" > "$f"
  days=$((RANDOM % 36 + 5))
  hrs=$((RANDOM % 24))
  touch -d "-$days days -$hrs hours" "$f"
done

# The live drop — newest by hours, not obviously today-vs-old to the eye
LIVE="$PAD/note_$(printf '%08x' $((RANDOM * RANDOM + 4471))).txt"
cat > "$LIVE" << 'EOF'
[LIVE DROP // source: still inside]

You sorted by time. Which means the handler finally taught you to
read the manual, which means you're nearly done with the classroom.

Deployment window moved up. They know something's missing from the
scrub. Move faster.

codeword: doctrine
EOF
touch -d "-1 hour" "$LIVE"

# --- theming (template) ---
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps1.6) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  forty notes: /var/apex-mirror/scratchpad"
  echo "  one is live. the manual knows which."
  echo ""
fi

# ONE milestone: they open the manual. Fires on leaving man (PWD can't
# see inside man, so trigger on the scratchpad instead).
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 && "$PWD" == "/var/apex-mirror/scratchpad" ]]; then
    touch /tmp/.sigstop_ms1
    echo ""
    echo "  [SIGSTOP] forty coin flips, or one page of the manual."
    echo "  [SIGSTOP] choose like an operator."
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
