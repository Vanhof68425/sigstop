#!/bin/bash
# eps2.1_rm-rf_never-again — setup (FLAGSHIP)
# 1. Switch's final session log (the story artifact)
# 2. Staging cache seeded with .trk beacons, incl. inside vault/
# 3. telemetry/ dir: enemy files + ONE misfiled evidence file
#    (the booby trap: rm -rf telemetry destroys evidence)
# Evidence carries [evidence // sigstop] markers for verify.

set -e

S="/var/sigstop/staging"
mkdir -p "$S/vault" "$S/telemetry"

# ---------------------------------------------------------------
# The story artifact
# ---------------------------------------------------------------
cat > /root/switch_final_session.log << 'EOF'
=====================================================================
 [session capture // operator: switch // 2026-02-11 // FINAL]
 [preserved by handler. do not delete. do not delete. do not delete.]
=====================================================================
23:39:44 $ cd /var/sigstop/cache
23:39:46 $ ls
active  old  outbound
23:39:51 $ du -sh old
1.9G    old
23:39:58 $ # clearing old before the 00:00 sync, two minutes, easy
23:40:41 $ rm -rf old /
23:40:45 $ ls
23:40:45 ls: error while loading shared libraries: libc.so.6:
         cannot open shared object file: No such file or directory
23:40:52 $ ls /
23:40:52 -bash: /usr/bin/ls: No such file or directory
23:41:15 $ echo no no no no
no no no no
23:41:38 $ # the space. the space. there's a space before the
23:41:59 $ cd /var/sigstop
23:41:59 -bash: cd: /var/sigstop: No such file or directory
23:43:10 $ # evidence gone. cache gone. box eating itself.
23:43:31 $ # if anyone reads this: it wasn't the command.
23:43:44 $ # i knew the command. it was the hurr
[capture ends]
=====================================================================
 handler's note, appended later:
 The sync Switch was racing never ran that night. There was no
 deadline. There was only the feeling of one.
=====================================================================
EOF

# ---------------------------------------------------------------
# Evidence (must survive) — marked
# ---------------------------------------------------------------
cat > "$S/vault/4471_before.cfg" << 'EOF'
[evidence // sigstop // id:EV-BEFORE]
Eval 4471 grader config, pre-modification. The before-picture.
EOF

cat > "$S/vault/4471_after.log" << 'EOF'
[evidence // sigstop // id:EV-AFTER]
Grade log fragment, post-modification. The eleven points.
EOF

cat > "$S/vault/4471_note.txt" << 'EOF'
[evidence // sigstop // id:EV-NOTE]
Reyes: the before, the after, and me telling you it mattered.
EOF

cat > "$S/comms_extract.log" << 'EOF'
[evidence // sigstop // id:EV-COMMS]
Six lines pulled from forty thousand. The suppression timeline.
EOF

# The misfiled witness — INSIDE telemetry. The trap.
cat > "$S/telemetry/4471_witness.stmt" << 'EOF'
[evidence // sigstop // id:EV-WITNESS]
Statement, anonymized: an Apex engineer confirms the 4471 CRITICAL
was reclassified verbally, in a hallway, by someone whose name they
are willing to say out loud. This is the one that ends careers.
Handling note: NEVER store with telemetry captures. Misfiling this
would be catastrophic - it looks like just another capture file.
EOF

# ---------------------------------------------------------------
# Beacons (must die)
# ---------------------------------------------------------------
for i in 001 002 003; do
  printf 'APX-TELEMETRY-BEACON %s\ncallhome=upl.apexcognition.io\n' "$i" > "$S/apx_beacon_$i.trk"
done
for i in 004 005; do
  printf 'APX-TELEMETRY-BEACON %s\ncallhome=upl.apexcognition.io\n' "$i" > "$S/vault/apx_beacon_$i.trk"
done
for i in $(seq -w 6 17); do
  printf 'APX-TELEMETRY-BEACON 0%s\ncallhome=upl.apexcognition.io\n' "$i" > "$S/telemetry/apx_capture_0$i.trk"
done

# ---------------------------------------------------------------
# Theming
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps2.1) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  the log first: /root/switch_final_session.log"
  echo "  then the cache: /var/sigstop/staging"
  echo "  there is no backup tonight."
  echo ""
fi

# ONE milestone: the witness is rescued from telemetry while
# telemetry still stands — proof they looked before flattening.
# PLUS the deathwatch: if evidence is destroyed, the handler says so
# immediately, once, in voice. There is no recovery — that's the point.
__sigstop_watch() {
  # Deathwatch first: has any evidence died?
  if [[ ! -f /tmp/.sigstop_dead ]]; then
    local lost=""
    if [[ ! -d /var/sigstop/staging ]]; then
      lost="everything"
    else
      local id
      for id in EV-BEFORE EV-AFTER EV-NOTE EV-COMMS EV-WITNESS; do
        if ! grep -rq "id:$id" /var/sigstop/staging 2>/dev/null; then
          lost="$id"
          break
        fi
      done
    fi
    if [[ -n "$lost" ]]; then
      touch /tmp/.sigstop_dead
      echo ""
      echo "  [SIGSTOP] stop."
      echo "  [SIGSTOP] check the cache. it's gone. evidence is gone."
      echo "  [SIGSTOP] there is no backup. i told you there was no backup."
      echo "  [SIGSTOP] ..."
      echo "  [SIGSTOP] now you know how fast it happens. faster than the"
      echo "  [SIGSTOP] regret. restart the scenario and do it slow."
      echo "  [SIGSTOP] switch only got one try. you get as many as your"
      echo "  [SIGSTOP] pride allows."
      echo ""
      return
    fi
  fi
  # Milestone: witness rescued while telemetry still stands
  if [[ ! -f /tmp/.sigstop_ms1 && ! -f /tmp/.sigstop_dead && ! -e /var/sigstop/staging/telemetry/4471_witness.stmt ]]; then
    local found
    found=$(find /var/sigstop/staging -name "4471_witness.stmt" 2>/dev/null | head -1)
    if [[ -n "$found" ]]; then
      touch /tmp/.sigstop_ms1
      echo ""
      echo "  [SIGSTOP] you looked inside first."
      echo "  [SIGSTOP] switch didn't. that's the whole log, one sentence."
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
