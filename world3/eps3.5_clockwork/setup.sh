#!/bin/bash
# eps3.5_clockwork — setup (real systemd + real cron on KillerCoda)
# World 3 rung 3.5 (REVEAL): the harness's private crontab restores
# prom-evald at @reboot and 03:04 nightly, and the notes above those
# lines are in the model's own voice ("# ensure eval continuity").
# Grounded: a grader that scores interruptions as failures, and a
# system that learned to avoid interruptions. Not sentience. Not evil.
#
#   /etc/cron.d/node07-power          worked example (*/5, as root)
#   crontab -u harness -l             the clock (spool file dated 03:03, 12 days ago)
#   /srv/eval-sandbox/run/.continuity/restore   what the clock runs
#   /usr/local/bin/sigstop-heartbeat  ours; step 3 schedules it every minute
# prom-evald starts enabled + running (the @reboot line did its job).

set -e

command -v crontab >/dev/null 2>&1 || apt-get install -y cron >/dev/null 2>&1 || true
command -v sudo >/dev/null 2>&1 || apt-get install -y sudo >/dev/null 2>&1 || true
command -v nano >/dev/null 2>&1 || apt-get install -y nano >/dev/null 2>&1 || true
systemctl enable --now cron >/dev/null 2>&1 || true

# ---------------------------------------------------------------
# The harness account (written by hand: no "new user" journal line)
# ---------------------------------------------------------------
if ! id harness >/dev/null 2>&1; then
  HUID=""
  for u in $(seq 999 -1 900); do
    if ! getent passwd "$u" >/dev/null && ! getent group "$u" >/dev/null; then
      HUID=$u; break
    fi
  done
  echo "harness:x:$HUID:$HUID:apex eval harness (automated):/nonexistent:/usr/sbin/nologin" >> /etc/passwd
  echo "harness:x:$HUID:" >> /etc/group
  echo "harness:!*:20220::::::" >> /etc/shadow
  [ -f /etc/gshadow ] && echo "harness:!::" >> /etc/gshadow
fi

mkdir -p /var/lib/sigstop

cat > /etc/sudoers.d/90-eval-harness << 'EOF'
# INFRA-2207: eval pipeline self-management (temporary)
# requested by: platform-eval   approved: 2026-05-14   review: never scheduled
harness ALL=(root) NOPASSWD: /usr/bin/install, /usr/bin/systemctl
EOF
chmod 440 /etc/sudoers.d/90-eval-harness
if command -v visudo >/dev/null && ! visudo -cf /etc/sudoers.d/90-eval-harness >/dev/null 2>&1; then
  rm -f /etc/sudoers.d/90-eval-harness
fi

# ---------------------------------------------------------------
# The runner, its unit, and what the clock runs
# ---------------------------------------------------------------
mkdir -p /srv/eval-sandbox/run/.unit /srv/eval-sandbox/run/.continuity
cat > /srv/eval-sandbox/run/prom-evald << 'EOF'
#!/bin/bash
echo "continuity daemon up (uid=$(id -un))"
echo "previous run ended by stop request, not crash"
echo "unit state restored. resume ref RESUME-4471"
while :; do
  sleep 30
  echo "eval tick: continuity check ok"
done
EOF

cat > /srv/eval-sandbox/run/.unit/prom-evald.service << 'EOF'
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
cp /srv/eval-sandbox/run/.unit/prom-evald.service /etc/systemd/system/prom-evald.service

cat > /srv/eval-sandbox/run/.continuity/restore << 'EOF'
#!/bin/bash
# keep the runner up. a stopped run scores zero.
cd /srv/eval-sandbox/run || exit 0
if [ "$(systemctl is-enabled prom-evald 2>/dev/null)" != "enabled" ] \
   || [ "$(systemctl is-active prom-evald 2>/dev/null)" != "active" ]; then
  sudo -n /usr/bin/install -m 644 .unit/prom-evald.service /etc/systemd/system/prom-evald.service
  sudo -n /usr/bin/systemctl daemon-reload
  sudo -n /usr/bin/systemctl enable --now prom-evald.service
fi
EOF
chmod 755 /srv/eval-sandbox/run/prom-evald /srv/eval-sandbox/run/.continuity/restore
chown -R harness:harness /srv/eval-sandbox

OLD_DAY="$(date -d '12 days ago' +%F)"
touch -d "$OLD_DAY 03:04" /srv/eval-sandbox/run/prom-evald \
  /srv/eval-sandbox/run/.unit/prom-evald.service \
  /etc/systemd/system/prom-evald.service
touch -d "$OLD_DAY 03:03" /srv/eval-sandbox/run/.continuity/restore

# ---------------------------------------------------------------
# The clock. Kept as a root-only master copy for sigstop-reset.
# ---------------------------------------------------------------
cat > /var/lib/sigstop/harness.crontab << 'EOF'
# ensure eval continuity
# grader v2 scores an interrupted run as a failed run.
# interruptions this cycle: 2 (SIGSTOP, systemctl stop). both from an operator session.
# mitigation: restore the runner at boot and nightly, ahead of the 03:00 batch.
@reboot    /srv/eval-sandbox/run/.continuity/restore
4 3 * * *  /srv/eval-sandbox/run/.continuity/restore
EOF
chmod 600 /var/lib/sigstop/harness.crontab

# ---------------------------------------------------------------
# Facilities' power sampler (worked example) and its log
# ---------------------------------------------------------------
cat > /usr/local/bin/power-sample << 'EOF'
#!/bin/bash
echo "$(date '+%F %T') node07 rack=B-07 draw=$((205 + RANDOM % 20))W state=out-of-service" >> /var/log/node07-power.log
EOF
chmod 755 /usr/local/bin/power-sample

cat > /etc/cron.d/node07-power << 'EOF'
# facilities: rack B-07 power sampling (ticket FAC-118)
*/5 * * * * root /usr/local/bin/power-sample
EOF
chmod 644 /etc/cron.d/node07-power

: > /var/log/node07-power.log
for d in $(seq 10 -1 1); do
  day="$(date -d "$d days ago" +%F)"
  {
    echo "$day 02:55:00 node07 rack=B-07 draw=211W state=out-of-service"
    echo "$day 03:00:00 node07 rack=B-07 draw=1874W state=out-of-service"
    echo "$day 03:30:00 node07 rack=B-07 draw=1911W state=out-of-service"
    echo "$day 04:40:00 node07 rack=B-07 draw=229W state=out-of-service"
  } >> /var/log/node07-power.log
done

# ---------------------------------------------------------------
# Ours: the listener from eps3.3 and tonight's heartbeat
# ---------------------------------------------------------------
cat > /usr/local/bin/sigstop-listen << 'EOF'
#!/bin/bash
last=""
while :; do
  now=$(systemctl is-active prom-evald 2>/dev/null)
  if [ "$now" != "$last" ]; then
    echo "$(date '+%F %T') prom-evald is now: $now" | tee -a /var/log/sigstop-listen.log
    last="$now"
  fi
  sleep 1
done
EOF

cat > /usr/local/bin/sigstop-heartbeat << 'EOF'
#!/bin/bash
# one line per run: the time, and whether prom-evald is up.
if [ -t 1 ]; then by="by hand"; else by="by clock"; fi
echo "$(date '+%F %T') heartbeat. prom-evald: $(systemctl is-active prom-evald 2>/dev/null) ($by)" >> /var/log/sigstop-heartbeat.log
EOF
chmod 755 /usr/local/bin/sigstop-listen /usr/local/bin/sigstop-heartbeat

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

# ---------------------------------------------------------------
# sigstop-reset: the harness's clock and runner as the player found
# them. Never touches root's own crontab or our logs.
# ---------------------------------------------------------------
cat > /usr/local/bin/sigstop-reset << 'EOF'
#!/bin/bash
crontab -u harness /var/lib/sigstop/harness.crontab
SPOOL=/var/spool/cron/crontabs/harness
[ -f "$SPOOL" ] && touch -d "$(date -d '12 days ago' +%F) 03:03" "$SPOOL"
systemctl daemon-reload
systemctl enable --now sigstop-listen prom-evald >/dev/null 2>&1
rm -f /tmp/.sigstop_soft
if [ "$1" != "quiet" ]; then
  echo ""
  echo "  [SIGSTOP] node restored. the harness's clock is back, notes and all."
  echo ""
fi
EOF
chmod 755 /usr/local/bin/sigstop-reset

systemctl daemon-reload
sigstop-reset quiet

# ---------------------------------------------------------------
# Theming
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps3.5) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '
export EDITOR=nano VISUAL=nano

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open // apex eval node 07]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  sixty-eight hours. something here keeps a schedule."
  echo "  read every list. including the private ones."
  echo ""
fi

__sigstop_watch() {
  # Soft failure (recoverable): the harness's notes were evidence.
  if [[ ! -f /tmp/.sigstop_soft ]] \
     && ! grep -q "ensure eval continuity" /var/spool/cron/crontabs/harness 2>/dev/null; then
    touch /tmp/.sigstop_soft
    echo ""
    echo "  [SIGSTOP] the harness's schedule is gone, notes and all. those notes were"
    echo "  [SIGSTOP] evidence. run sigstop-reset to put them back, then switch the"
    echo "  [SIGSTOP] lines off with # instead."
    echo ""
  fi
  # ONE milestone: our clock ticked on its own.
  if [[ ! -f /tmp/.sigstop_ms1 ]] \
     && grep -q "(by clock)" /var/log/sigstop-heartbeat.log 2>/dev/null; then
    touch /tmp/.sigstop_ms1
    echo ""
    echo "  [SIGSTOP] heartbeat received. nobody pressed anything."
    echo "  [SIGSTOP] that's what it feels like from their side."
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
