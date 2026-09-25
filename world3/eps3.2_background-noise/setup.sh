#!/bin/bash
# eps3.2_background-noise — setup
# Scene: the copier from eps3.1, still frozen (continuity; also teaches
# that `jobs` only lists what your own shell started).
# Tools (all re-runnable, so no soft-failure is needed):
#   sigstop-sweep    40 s of "noise"; writes /root/sweep.done at the end
#   sigstop-mark     only works while the sweep is running (not stopped)
#                    -> writes /root/mark.ok          (step 1: & + jobs)
#   sigstop-decrypt  writes a fresh passphrase to /tmp/sigstop-session.txt
#                    when it starts, works 20 s, then asks for it on the
#                    terminal -> /root/drop09.txt + /root/decrypt.done
#                    (step 2: Ctrl+Z, bg, fg)
# No World 3 reveal rung in this episode (ladder: 3.0, 3.1, 3.3, 3.4, 3.5).

set -e

if ! id harness >/dev/null 2>&1; then
  useradd -r -M -s /usr/sbin/nologin -c "apex eval harness (automated)" harness
fi

mkdir -p /var/log/apex /mnt/cold/.continuity
chown harness:harness /var/log/apex /mnt/cold/.continuity

# ---------------------------------------------------------------
# Continuity: the copier, frozen where the operator left it
# ---------------------------------------------------------------
cat > /usr/local/bin/prom-ckpt-copy << 'EOF'
#!/bin/bash
n=417
while [ "$n" -le 4096 ]; do
  printf -v s '%04d' "$n"
  touch "/mnt/cold/.continuity/shard-$s.ckpt"
  echo "$(date +%T) copied shard $s/4096 -> /mnt/cold/.continuity/" >> /var/log/apex/ckpt-copy.log
  n=$((n + 1))
  sleep 2
done
EOF
chmod 755 /usr/local/bin/prom-ckpt-copy

# ---------------------------------------------------------------
# Our tools
# ---------------------------------------------------------------
cat > /usr/local/bin/sigstop-sweep << 'EOF'
#!/bin/bash
rm -f /root/sweep.done
echo "[sweep] running. about 40 seconds of noise on the wire."
sleep 40
touch /root/sweep.done
EOF

cat > /usr/local/bin/sigstop-mark << 'EOF'
#!/bin/bash
state=""
for p in $(pgrep -x sigstop-sweep); do
  st=$(awk '{print $3}' /proc/"$p"/stat 2>/dev/null)
  if [ -n "$st" ] && [ "$st" != "Z" ]; then state="$st"; break; fi
done
if [ -z "$state" ]; then
  echo "[mark] refused: the wire is quiet. no noise to hide in."
  echo "[mark] start the sweep in the background first, then mark."
  exit 1
fi
if [ "$state" = "T" ]; then
  echo "[mark] refused: the sweep is paused, so the wire is quiet."
  echo "[mark] let it run (bg), then mark."
  exit 1
fi
date +%T > /root/mark.ok
echo "[mark] sent. hidden in the noise. the source will see it."
EOF

cat > /usr/local/bin/sigstop-decrypt << 'EOF'
#!/bin/bash
w=$(shuf -n1 -e cobalt ember lantern quartz harbor falcon signal static)
pp="$w-$((RANDOM % 90 + 10))"
echo "passphrase for this session: $pp" > /tmp/sigstop-session.txt
chmod 600 /tmp/sigstop-session.txt
echo "[decrypt] drop 09 received. decrypting, about 20 seconds."
echo "[decrypt] this session's passphrase: /tmp/sigstop-session.txt"
sleep 20
read -r -p "[decrypt] passphrase: " given
if [ "$given" = "$pp" ]; then
  cat > /root/drop09.txt << 'DROP'
------------------------------------------------------------
 [drop 09 // source // still inside]

 Facilities flagged node 07's power bill. A technician is
 booked to "reimage" it in 72 hours. Reimage means wipe.
 Whatever is running on that node, whatever it's been doing
 at night, you have three days to understand it before it's
 erased along with every trace.

 Tanaka is asking about 4471 again. Loudly, in meetings. I
 told them to stop. They said someone has to ask where the
 compute is going. They're not wrong. They're just early.

 Be careful on 07. I don't know who else is looking at it.
------------------------------------------------------------
DROP
  touch /root/decrypt.done
  echo "[decrypt] accepted. drop 09 -> /root/drop09.txt"
else
  echo "[decrypt] wrong passphrase. run sigstop-decrypt again."
  echo "[decrypt] the passphrase changes every run."
  exit 1
fi
EOF

chmod 755 /usr/local/bin/sigstop-sweep /usr/local/bin/sigstop-mark /usr/local/bin/sigstop-decrypt

# ---------------------------------------------------------------
# sigstop-reset — relaunches the frozen copier (the scene).
# Our tools need no reset: just run them again.
# ---------------------------------------------------------------
cat > /usr/local/bin/sigstop-reset << 'EOF'
#!/bin/bash
pkill -9 -x prom-ckpt-copy 2>/dev/null || true
sleep 1
setsid nohup nice -n 19 setpriv --reuid=harness --regid=harness --init-groups \
  /usr/local/bin/prom-ckpt-copy >/dev/null 2>&1 < /dev/null &
sleep 1
kill -STOP "$(pgrep -x prom-ckpt-copy | head -1)" 2>/dev/null || true
rm -f /tmp/.sigstop_soft
if [ "$1" != "quiet" ]; then
  echo ""
  echo "  [SIGSTOP] node restored. the copier is frozen again. new PID."
  echo ""
fi
EOF
chmod 755 /usr/local/bin/sigstop-reset
/usr/local/bin/sigstop-reset quiet

# ---------------------------------------------------------------
# Theming
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps3.2) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open // apex eval node 07]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  the copier is still frozen. the source sent drop 09. it's locked."
  echo "  tonight your hands do two things at once."
  echo ""
fi

# ONE milestone: drop 09 opened.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_ms1 && -f /root/decrypt.done ]]; then
    touch /tmp/.sigstop_ms1
    echo ""
    echo "  [SIGSTOP] seventy-two hours. then they wipe the node,"
    echo "  [SIGSTOP] and whatever it has been doing goes with it."
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
