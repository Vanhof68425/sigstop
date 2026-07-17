#!/bin/bash
# eps1.1_moving-target — setup
# Builds the dead-drop trail AND prototypes the terminal theming:
#   1. custom PS1 prompt (operator@sigstop)
#   2. transmission-style MOTD on shell open
#   3. ONE milestone transmission via PROMPT_COMMAND (outcome-triggered)
# Theming rules per VOICE.md: react to outcomes, never keystrokes.
# Never intercept, never block. One transmission, then silence.

set -e

MIRROR="/var/apex-mirror"
CODEWORD="silhouette"
FINAL_DIR="$MIRROR/personnel/.offboarded"

# ---------------------------------------------------------------
# 1. The dead-drop trail
#    Mixes absolute and relative hops on purpose.
# ---------------------------------------------------------------
mkdir -p "$MIRROR/infra/staging" \
         "$MIRROR/infra/prod" \
         "$MIRROR/archive" \
         "$MIRROR/personnel/.offboarded"

cat > "$MIRROR/trailhead.txt" << 'EOF'
[stop 1 of 4]
This mirror was taken 9 days before Apex scrubbed the share.
Next stop, relative to where you stand:

    infra/staging

Move. Then confirm.
EOF

cat > "$MIRROR/infra/staging/note.txt" << 'EOF'
[stop 2 of 4]
Staging. Where Apex tests the things they'll later swear were
"thoroughly evaluated." Next stop is relative again — two levels
up from here, then into the archive:

    ../../archive
EOF

cat > "$MIRROR/archive/note.txt" << 'EOF'
[stop 3 of 4]
Last hop. This one is absolute — it works no matter where you're
standing. Notice the dot in the final directory name. You learned
what dots hide in front of names. You'll learn it again in eps1.3.

    /var/apex-mirror/personnel/.offboarded
EOF

cat > "$FINAL_DIR/note.txt" << 'EOF'
[stop 4 of 4]
The offboarded. The ones who left, or were made to leave.
The contact was one of them. The drop is in this directory,
right next to this note. You know the command that reads files.
EOF

cat > "$FINAL_DIR/deaddrop.txt" << 'EOF'
------------------------------------------------------------
 [dead drop // recovered]

 codeword: silhouette

 Signal recovery: go home, and create a file named exactly
 the codeword. Nothing else. We're watching for it.
------------------------------------------------------------
EOF

# A decoy in prod — teaches that not every path on the box is the trail.
cat > "$MIRROR/infra/prod/note.txt" << 'EOF'
Nothing for you here. Prod never has answers, only consequences.
Retrace your steps. The note said staging.
EOF

# ---------------------------------------------------------------
# 2. Terminal theming
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps1.1) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

# MOTD: one transmission when the shell opens, interactive shells only
if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  the trail starts at /var/apex-mirror"
  echo ""
fi

# Milestone transmission: fires ONCE, when the operator reaches the
# final directory. Outcome-triggered. Then silence.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 && "$PWD" == "/var/apex-mirror/personnel/.offboarded" ]]; then
    touch /tmp/.sigstop_ms1
    echo ""
    echo "  [SIGSTOP] the offboarded. took you long enough."
    echo "  [SIGSTOP] read what's in front of you."
    echo ""
  fi
}
PROMPT_COMMAND="__sigstop_watch${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
# --- end SIGSTOP theming ---
THEME

# Keep the sealed door from eps1.0 present for continuity.
mkdir -p /opt/apex
chmod 000 /opt/apex

history -c 2>/dev/null || true
echo "done" > /tmp/setup-complete
