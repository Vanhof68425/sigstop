#!/bin/bash
# eps2.7_superuser — setup
# 1. courier account + scoped sudoers grant (relay-burn only)
# 2. apxsvc vendor account + the skeleton key: NOPASSWD ALL drop-in
#    (the player removes the file)
# 3. relay-burn installed executable; writes a root-owned receipt
#    naming ${SUDO_USER} — the receipt must read "burned by: courier",
#    which forces the su + sudo path
# 4. /var/sigstop/burn is root 700 so the courier cannot write the
#    receipt without borrowing
# 5. Watcher: ONE milestone when the receipt names the courier

set -e

command -v sudo >/dev/null 2>&1 || apt-get install -y sudo >/dev/null 2>&1 || true

groupadd -f cell
id -u courier >/dev/null 2>&1 || useradd -m -s /bin/bash courier
id -u apxsvc  >/dev/null 2>&1 || useradd -r -s /usr/sbin/nologin apxsvc

# The handoff, locked as eps2.6 left it
H="/var/sigstop/handoff"
mkdir -p "$H"
cat > "$H/evidence_4471.log" << 'EOF'
[evidence // sigstop // id:EV-DISTILLED]
(distilled drop 08 — bagged 2.5, locked 2.6, burns tonight.)
EOF
chown -R courier:cell "$H"
chmod 750 "$H"
chmod 640 "$H"/*

# The burn area: root-only, so borrowing is the only way in
mkdir -p /var/sigstop/burn
chmod 700 /var/sigstop/burn

cat > /usr/local/bin/relay-burn << 'EOF'
#!/bin/bash
# sigstop relay-burn — burn ritual for a completed handoff
set -e
B="/var/sigstop/burn"
mkdir -p "$B"
printf '[burn // sigstop // receipt]\nburned by: %s\nat: %s\n' \
  "${SUDO_USER:-$USER}" "$(date -u +%FT%TZ)" > "$B/receipt.log"
chmod 600 "$B/receipt.log"
echo "relay-burn: handoff burned. receipt written."
EOF
chmod 755 /usr/local/bin/relay-burn

# The ledger: one narrow grant, one abdication
cat > /etc/sudoers.d/courier << 'EOF'
# sigstop // the only borrow this box allows
courier ALL=(root) NOPASSWD: /usr/local/bin/relay-burn
EOF
chmod 440 /etc/sudoers.d/courier

cat > /etc/sudoers.d/apex-compat << 'EOF'
# relay vendor package // compat shim // "temporary" since install
apxsvc ALL=(ALL) NOPASSWD: ALL
EOF
chmod 440 /etc/sudoers.d/apex-compat

# ---------------------------------------------------------------
# Theming
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps2.7) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  the ledger: /etc/sudoers.d/"
  echo "  two grants. one is a skeleton key."
  echo "  kill the key. cross the room. run the burn."
  echo ""
fi

# ONE milestone: the receipt names the courier.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 ]]; then
    if grep -q '^burned by: courier$' /var/sigstop/burn/receipt.log 2>/dev/null \
       && [[ ! -e /etc/sudoers.d/apex-compat ]]; then
      touch /tmp/.sigstop_ms1
      echo ""
      echo "  [SIGSTOP] receipt reads courier. four seconds of root,"
      echo "  [SIGSTOP] borrowed and returned. that's the only relationship"
      echo "  [SIGSTOP] with power this collective trusts."
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
