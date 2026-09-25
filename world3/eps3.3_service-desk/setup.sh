#!/bin/bash
# eps3.3_service-desk — setup (real systemd; confirmed PID 1 on KillerCoda)
# Units:
#   prom-evald.service     User=harness, ExecStart inside the eval sandbox
#                          (/srv/eval-sandbox/run/prom-evald), Restart=always,
#                          unit + program written at 03:04 (World 3 rung 3.3).
#                          enabled + running at start.
#   metronome.service      harmless worked-example service, Restart=always.
#   sigstop-listen.service ours: watches prom-evald, logs any state change.
#                          installed, NOT enabled, NOT running at start.
# StartLimitIntervalSec=0 so repeated kills never push a unit into
# "failed": the manager always wins, which is the lesson.

set -e

if ! id harness >/dev/null 2>&1; then
  useradd -r -M -s /usr/sbin/nologin -c "apex eval harness (automated)" harness
fi

# ---------------------------------------------------------------
# Programs
# ---------------------------------------------------------------
mkdir -p /srv/eval-sandbox/run
cat > /srv/eval-sandbox/run/prom-evald << 'EOF'
#!/bin/bash
while :; do
  echo "eval tick: continuity check ok"
  sleep 5
done
EOF
chmod 755 /srv/eval-sandbox/run/prom-evald
chown -R harness:harness /srv/eval-sandbox

cat > /usr/local/bin/metronome << 'EOF'
#!/bin/bash
while :; do date +%T >> /tmp/metronome.log; sleep 1; done
EOF

cat > /usr/local/bin/sigstop-listen << 'EOF'
#!/bin/bash
last=""
while :; do
  now=$(systemctl is-active prom-evald 2>/dev/null)
  if [ "$now" != "$last" ]; then
    echo "$(date '+%F %T') prom-evald is now: $now" | tee -a /var/log/sigstop-listen.log
    last="$now"
  fi
  sleep 2
done
EOF
chmod 755 /usr/local/bin/metronome /usr/local/bin/sigstop-listen

# ---------------------------------------------------------------
# Units
# ---------------------------------------------------------------
cat > /etc/systemd/system/prom-evald.service << 'EOF'
[Unit]
Description=eval continuity daemon
After=network.target
StartLimitIntervalSec=0

[Service]
User=harness
ExecStart=/srv/eval-sandbox/run/prom-evald
Restart=always
RestartSec=2
Nice=19

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/metronome.service << 'EOF'
[Unit]
Description=metronome (harmless practice service)
StartLimitIntervalSec=0

[Service]
ExecStart=/usr/local/bin/metronome
Restart=always
RestartSec=2

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/sigstop-listen.service << 'EOF'
[Unit]
Description=sigstop listener (records every state change of prom-evald)

[Service]
ExecStart=/usr/local/bin/sigstop-listen
Restart=on-failure
RestartSec=2

[Install]
WantedBy=multi-user.target
EOF

# Rung 3.3: written at 03:04. Relative date so `ls -l` always shows
# the time (ls shows a year instead of a time for files > 6 months old).
STAMP="$(date -d '12 days ago' +%F) 03:04"
touch -d "$STAMP" /etc/systemd/system/prom-evald.service /srv/eval-sandbox/run/prom-evald

systemctl daemon-reload
systemctl enable --now prom-evald.service metronome.service >/dev/null 2>&1

# ---------------------------------------------------------------
# sigstop-reset — puts the three units back to the starting state
# ---------------------------------------------------------------
cat > /usr/local/bin/sigstop-reset << 'EOF'
#!/bin/bash
systemctl disable --now sigstop-listen >/dev/null 2>&1 || true
systemctl enable --now prom-evald metronome >/dev/null 2>&1
rm -f /tmp/.sigstop_soft
if [ "$1" != "quiet" ]; then
  echo ""
  echo "  [SIGSTOP] node restored. prom-evald is back, enabled and running."
  echo ""
fi
EOF
chmod 755 /usr/local/bin/sigstop-reset

# ---------------------------------------------------------------
# Theming
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps3.3) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open // apex eval node 07]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  seventy-one hours. a service called prom-evald."
  echo "  talk to the manager, not the process."
  echo ""
fi

# ONE milestone: the door closed and the watch set.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 ]] \
     && [[ "$(systemctl is-enabled prom-evald 2>/dev/null)" == "disabled" ]] \
     && [[ "$(systemctl is-active prom-evald 2>/dev/null)" == "inactive" ]] \
     && [[ "$(systemctl is-active sigstop-listen 2>/dev/null)" == "active" ]]; then
    touch /tmp/.sigstop_ms1
    echo ""
    echo "  [SIGSTOP] the listener is up. if anything touches prom-evald again,"
    echo "  [SIGSTOP] we'll know when. something will."
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
