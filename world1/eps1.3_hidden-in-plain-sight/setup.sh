#!/bin/bash
# eps1.3_hidden-in-plain-sight — setup
# Four workstation snapshots, all with realistic dotfile "furniture".
# One (reyes_m — the offboarded contact) has an anomalous hidden dir:
# .courier -> codeword "veil".
# Lesson: -a shows everything; judgment tells furniture from anomaly.

set -e

WS="/var/apex-mirror/workstations"
mkdir -p "$WS"

make_furniture() {
  local home="$1" user="$2"
  mkdir -p "$home/.config" "$home/projects"
  echo "# $user shell config" > "$home/.bashrc"
  echo "# $user profile"      > "$home/.profile"
  echo "editor=vim"           > "$home/.config/tools.ini"
  echo "notes for standup"    > "$home/projects/notes.txt"
}

make_furniture "$WS/okafor_c" "okafor_c"
make_furniture "$WS/reyes_m"  "reyes_m"
make_furniture "$WS/tanaka_h" "tanaka_h"
make_furniture "$WS/volkov_a" "volkov_a"

# Flavor differences so the boxes feel human
echo "alias gs='git status'"      >> "$WS/okafor_c/.bashrc"
cat > "$WS/tanaka_h/projects/todo.txt" << 'EOF'
- rerun eval 4471??
- ask reyes why she really left
EOF
echo "export EDITOR=emacs"        >> "$WS/volkov_a/.bashrc"

# The anomaly — reyes_m's buried delivery
mkdir -p "$WS/reyes_m/.courier"
cat > "$WS/reyes_m/.courier/delivery.txt" << 'EOF'
------------------------------------------------------------
 [delivery // reyes_m // final]

 If you're reading this, you swept instead of skimmed.
 They imaged this machine for scrubbing and missed it,
 because a dot was enough. A dot is always enough.

 codeword: veil

 Tell the handler I kept my half of the deal.
------------------------------------------------------------
EOF

# --- theming (template) ---
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps1.3) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  four workstations: /var/apex-mirror/workstations"
  echo "  sweep them. summaries lie."
  echo ""
fi

# ONE milestone: they walk into the anomaly. Then silence.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 && "$PWD" == */.courier ]]; then
    touch /tmp/.sigstop_ms1
    echo ""
    echo "  [SIGSTOP] reyes. of course it was reyes."
    echo "  [SIGSTOP] read it. she earned that much."
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
