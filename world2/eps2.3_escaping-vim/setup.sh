#!/bin/bash
# eps2.3_escaping-vim — setup
# 1. The drop: transmission from the live source (must survive
#    byte-identical; md5 stored for verify) + the handler's
#    half-written reply (player finishes it in vim)
# 2. The corpse: a stale .swp beside the draft, so vim's ATTENTION
#    screen fires on first open
# 3. .vimrc guard: nocompatible + sane backspace, so arrows behave
#    for beginners even if the image ships vim-tiny

set -e

command -v vim >/dev/null 2>&1 || apt-get install -y vim >/dev/null 2>&1 || true

D="/var/sigstop/drop"
mkdir -p "$D"

# ---------------------------------------------------------------
# The transmission (must remain exactly as it arrived)
# ---------------------------------------------------------------
cat > "$D/transmission_07.msg" << 'EOF'
[evidence // sigstop // id:EV-DROP07]
=====================================================================
 [relay intake // drop 07 // 03:14:22 // hold for vault]
=====================================================================
they moved the window again. closer. no numbers on this channel yet.

tanaka pulled the 4471 artifacts into a private sandbox last week.
after hours, personal token, no ticket. either tanaka is building
the case or building the cover, and i need to know which before i
touch anything else.

so prove the channel. every drop your people ever left was signed
the same way: everyone sees. nobody looks. that sentence has always
read unfinished to me — like a third clause somebody decided was
safer done than written. write it down. once. finish the sentence
in your reply, exactly, with the period. precision is identity.

clean reply: i go quiet, then i send the rest — and the rest will
not fit in one file.

wrong reply: i was never here.

— still inside
EOF

# ---------------------------------------------------------------
# The handler's half-written reply (ends on an open line — the
# player's cursor lands where the ending belongs)
# ---------------------------------------------------------------
cat > "$D/reply.draft" << 'EOF'
[reply // sigstop // drop-07]

channel restored. cache cleaned. relay rebuilt, burning clean.
you asked for the ending, so here is the ending:

EOF

# ---------------------------------------------------------------
# The corpse: dead session's swap. b0VIM magic so vim treats it as
# a swap file; fragments readable via strings/cat for the curious.
# ---------------------------------------------------------------
{
  printf 'b0VIM 8.2\000\000\000\000\000\000\000\000'
  printf 'operator\000sigstop\000'
  printf '/var/sigstop/drop/reply.draft\000\000\000\000'
  printf 'utf-8\000\000\000\000'
  printf '\000you asked for the ending, so here is the endi\000\000'
} > "$D/.reply.draft.swp"

# md5 of the transmission as it arrived — verify checks byte-identity
md5sum "$D/transmission_07.msg" | awk '{print $1}' > /tmp/.sigstop_drop07.sum

# vim guard: a vimrc alone forces nocompatible; backspace for beginners
cat > /root/.vimrc << 'EOF'
" sigstop box defaults
set nocompatible
set backspace=indent,eol,start
EOF

# ---------------------------------------------------------------
# Theming
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps2.3) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  the drop: /var/sigstop/drop"
  echo "  a transmission is in. the reply is half-written."
  echo "  there's a corpse in the room. look closely."
  echo ""
fi

# ONE milestone: the reply carries the ending.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 ]]; then
    if grep -qF 'we act.' /var/sigstop/drop/reply.draft 2>/dev/null; then
      touch /tmp/.sigstop_ms1
      echo ""
      echo "  [SIGSTOP] the drop is armed. relay takes it on the next pass."
      echo "  [SIGSTOP] that's the first thing we've said back since february."
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
