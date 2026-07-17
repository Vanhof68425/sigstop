#!/bin/bash
# eps2.2_nano-survival — setup
# Broken relay.conf (3 wrong lines, incl. the endpoint that caused
# the eps2.1 breach) + signed spec. Player fixes it in nano.
# Outcome-based verify; milestone fires when the config goes clean.

set -e

mkdir -p /etc/sigstop

cat > /etc/sigstop/relay.conf << 'EOF'
# sigstop relay configuration
# touched by: nobody, apparently, since install

callsign=operator
cache_path=/var/sigstop/staging
endpoint=test-relay.pubmirror.example.com
interval=1
compression=on
burn_on_read=false
retry_limit=3
EOF

cat > /root/relay.spec << 'EOF'
------------------------------------------------------------
 [SIGSTOP // relay spec v2 // signed: handler]

 Correct values. The config matches this, or the relay
 stays dark. Three lines currently disagree.

   endpoint=drop.sigstop.net
       The breach line. Defaults phone strangers.

   interval=60
       Once a minute, not once a second. Chatty relays
       are findable relays.

   burn_on_read=true
       What the cache sends, the cache forgets. After
       eps2.1 I shouldn't have to explain why.

 Everything else in the config is correct. Leave it be.
------------------------------------------------------------
EOF

# --- theming (template) ---
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps2.2) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  the spec:   /root/relay.spec"
  echo "  the config: /etc/sigstop/relay.conf"
  echo "  three lines are lying. fix them from inside."
  echo ""
fi

# ONE milestone: the config goes clean.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 ]]; then
    if grep -q "^endpoint=drop.sigstop.net$" /etc/sigstop/relay.conf 2>/dev/null \
       && grep -q "^interval=60$" /etc/sigstop/relay.conf 2>/dev/null \
       && grep -q "^burn_on_read=true$" /etc/sigstop/relay.conf 2>/dev/null; then
      touch /tmp/.sigstop_ms1
      echo ""
      echo "  [SIGSTOP] relay's talking to us again. first time since february."
      echo "  [SIGSTOP] one file, three lines. that's how close breaches live."
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
