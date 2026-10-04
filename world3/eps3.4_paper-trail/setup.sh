#!/bin/bash
# eps3.4_paper-trail — setup (real systemd + real journal on KillerCoda)
# Scene: the end state of eps3.3 (prom-evald stopped + disabled,
# sigstop-listen enabled + running), then, live, while the session is
# still opening: the harness account uses sudo, from inside the eval
# sandbox, with no terminal, to reinstall, enable and start prom-evald
# at second :01 of a minute. World 3 rung 3.4: the journal shows the
# harness created the unit. No cron is involved or visible (rung 3.5).
#
# Evidence the player reads:
#   /var/log/node07-power.log     worked example (03:00 power draw)
#   /var/log/sigstop-listen.log   step 1: the time it came back
#   journalctl -u prom-evald      step 2: RESUME-4471 on startup
#   journalctl | grep COMMAND=    step 3: harness : ... COMMAND=install ...
#   /var/log/apex/auth.log.1      finish: same three lines, 12 days ago, 03:04:01
#   /etc/sudoers.d/90-eval-harness finish: a human granted it in May
#
# harness is created by hand (not useradd) so the journal holds no
# "new user: name=harness" line dated today: the account is months old.

set -e

# ---------------------------------------------------------------
# The harness account (system uid, no login, locked password)
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

mkdir -p /var/log/apex

# ---------------------------------------------------------------
# Programs
# ---------------------------------------------------------------
mkdir -p /srv/eval-sandbox/run/.unit
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
chmod 755 /srv/eval-sandbox/run/prom-evald

cat > /usr/local/bin/metronome << 'EOF'
#!/bin/bash
while :; do echo "tick $(date +%T)"; sleep 5; done
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
  sleep 1
done
EOF
chmod 755 /usr/local/bin/metronome /usr/local/bin/sigstop-listen

# ---------------------------------------------------------------
# Units
# ---------------------------------------------------------------
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
chown -R harness:harness /srv/eval-sandbox

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

# Same 03:04 stamp as eps3.3 (relative, so ls -l shows a time).
OLD_DAY="$(date -d '12 days ago' +%F)"
touch -d "$OLD_DAY 03:04" /srv/eval-sandbox/run/prom-evald \
  /srv/eval-sandbox/run/.unit/prom-evald.service \
  /etc/systemd/system/prom-evald.service

# ---------------------------------------------------------------
# The grant: a human gave the harness exactly enough, in May.
# ---------------------------------------------------------------
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
# Plain-text logs
# ---------------------------------------------------------------
# Power meter: 10 nights, idle by day, ~1.8 kW from 03:00.
: > /var/log/node07-power.log
for d in $(seq 10 -1 1); do
  day="$(date -d "$d days ago" +%F)"
  {
    echo "$day 02:50:00 node07 rack=B-07 draw=214W state=out-of-service"
    echo "$day 02:55:00 node07 rack=B-07 draw=211W state=out-of-service"
    echo "$day 03:00:00 node07 rack=B-07 draw=1874W state=out-of-service"
    echo "$day 03:05:00 node07 rack=B-07 draw=1902W state=out-of-service"
    echo "$day 03:30:00 node07 rack=B-07 draw=1911W state=out-of-service"
    echo "$day 04:10:00 node07 rack=B-07 draw=1866W state=out-of-service"
    echo "$day 04:40:00 node07 rack=B-07 draw=229W state=out-of-service"
  } >> /var/log/node07-power.log
done

# Listener history: it started (eps3.3) after the player stopped prom-evald.
YDAY="$(date -d '1 day ago' +%F)"
echo "$YDAY 23:12:40 prom-evald is now: inactive" > /var/log/sigstop-listen.log

# Archived auth log shipped from node 07, twelve days back. The last
# human session closed the evening before; then 03:04:01.
H="$(hostname)"
HU="$(id -u harness)"
PREV_SYS="$(LC_ALL=C date -d '13 days ago' '+%b %e')"
OLD_SYS="$(LC_ALL=C date -d '12 days ago' '+%b %e')"
P='PWD=/srv/eval-sandbox/run ; USER=root ; COMMAND='
{
  echo "$PREV_SYS 17:58:12 $H sshd[20411]: Accepted publickey for tanaka_h from 10.40.2.17 port 51822 ssh2"
  echo "$PREV_SYS 17:58:12 $H sshd[20411]: pam_unix(sshd:session): session opened for user tanaka_h(uid=1004) by (uid=0)"
  echo "$PREV_SYS 19:41:30 $H sshd[20411]: pam_unix(sshd:session): session closed for user tanaka_h"
  for c in "/usr/bin/install -m 644 /srv/eval-sandbox/run/.unit/prom-evald.service /etc/systemd/system/prom-evald.service" \
           "/usr/bin/systemctl daemon-reload" \
           "/usr/bin/systemctl enable --now prom-evald.service"; do
    echo "$OLD_SYS 03:04:01 $H sudo:  harness : TTY=unknown ; ${P}$c"
    echo "$OLD_SYS 03:04:01 $H sudo: pam_unix(sudo:session): session opened for user root(uid=0) by (uid=$HU)"
    echo "$OLD_SYS 03:04:01 $H sudo: pam_unix(sudo:session): session closed for user root"
  done
} > /var/log/apex/auth.log.1
touch -d "$(date -d '11 days ago' +%F) 00:00" /var/log/apex/auth.log.1

# ---------------------------------------------------------------
# Scene as the player left it in eps3.3
# ---------------------------------------------------------------
systemctl daemon-reload
systemctl disable prom-evald.service >/dev/null 2>&1 || true
systemctl stop prom-evald.service >/dev/null 2>&1 || true
systemctl enable --now metronome.service sigstop-listen.service >/dev/null 2>&1
sleep 2

# ---------------------------------------------------------------
# The event. At second :01 of the next minute, the harness, standing
# in the sandbox, no terminal, borrows root three times.
# ---------------------------------------------------------------
WAIT="$(awk -v s="$(date +%S.%N)" 'BEGIN { d = 61.05 - s; if (d > 60) d -= 60; printf "%.2f", d }')"
sleep "$WAIT"

as_harness() {
  (cd /srv/eval-sandbox/run && setsid setpriv --reuid=harness --regid=harness --init-groups \
     sudo -n "$@" < /dev/null > /dev/null 2>&1)
}
UNIT_SRC=/srv/eval-sandbox/run/.unit/prom-evald.service
UNIT_DST=/etc/systemd/system/prom-evald.service
if as_harness /usr/bin/install -m 644 "$UNIT_SRC" "$UNIT_DST" \
   && as_harness /usr/bin/systemctl daemon-reload \
   && as_harness /usr/bin/systemctl enable --now prom-evald.service; then
  :
else
  # Fallback if sudo misbehaves on the image: same actions, same
  # journal lines, so the episode still tells the truth it needs to.
  install -m 644 "$UNIT_SRC" "$UNIT_DST"
  systemctl daemon-reload
  systemctl enable --now prom-evald.service >/dev/null 2>&1
  for c in "/usr/bin/install -m 644 $UNIT_SRC $UNIT_DST" \
           "/usr/bin/systemctl daemon-reload" \
           "/usr/bin/systemctl enable --now prom-evald.service"; do
    logger -t sudo "  harness : TTY=unknown ; ${P}$c"
    logger -t sudo "pam_unix(sudo:session): session opened for user root(uid=0) by (uid=$HU)"
  done
fi

# Give the listener a moment to hear it before the terminal opens.
for _ in $(seq 1 20); do
  grep -q "^$(date +%F) .* is now: active" /var/log/sigstop-listen.log && break
  sleep 1
done

# ---------------------------------------------------------------
# sigstop-reset: the scene as the player found it (no logs touched)
# ---------------------------------------------------------------
cat > /usr/local/bin/sigstop-reset << 'EOF'
#!/bin/bash
systemctl enable --now metronome sigstop-listen prom-evald >/dev/null 2>&1
rm -f /tmp/.sigstop_soft
if [ "$1" != "quiet" ]; then
  echo ""
  echo "  [SIGSTOP] node restored. the paper trail is where you left it."
  echo ""
fi
EOF
chmod 755 /usr/local/bin/sigstop-reset

# ---------------------------------------------------------------
# Theming
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps3.4) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open // apex eval node 07]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  sixty-nine hours. prom-evald is running again."
  echo "  the listener heard when. the paper knows who."
  echo ""
fi

# ONE milestone: the proof is saved.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 && -f /root/who.log ]] \
     && grep -q "harness" /root/who.log 2>/dev/null \
     && grep -q "prom-evald.service" /root/who.log 2>/dev/null; then
    touch /tmp/.sigstop_ms1
    echo ""
    echo "  [SIGSTOP] I'm reading it too."
    echo "  [SIGSTOP] give me a minute."
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
