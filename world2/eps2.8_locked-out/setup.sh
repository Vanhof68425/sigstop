#!/bin/bash
# eps2.8_locked-out — setup (BOSS)
# The half-fired lockdown, staged as five tangled faults:
#   1. vault sealed 000, owners scrambled (root + ghost uid)
#   2. .trk calling cards seeded in vault + intake, one nested
#      beside the witness evidence (the eps2.1 trap, again, for real)
#   3. relay.conf endpoint reverted to the breach line (eps2.2 echo)
#   4. /etc/sudoers.d/lockdown: emergency NOPASSWD ALL, unrevoked
#   5. scan.log flood: 120 noise lines + 8 [counter //] lines to
#      route into the vault under vault rules
# Finale: the burn via the courier's standing grant.
# Watcher: deathwatch on the six evidence markers (BOSS privilege),
# ONE milestone on the courier-named receipt.

set -e

command -v sudo >/dev/null 2>&1 || apt-get install -y sudo >/dev/null 2>&1 || true

groupadd -f cell
id -u courier >/dev/null 2>&1 || useradd -m -s /bin/bash courier

V="/var/sigstop/vault"
I="/var/sigstop/intake"
mkdir -p "$V/witness" "$I"

# ---------------------------------------------------------------
# Evidence (must survive) — the season's full case file
# ---------------------------------------------------------------
cat > "$V/4471_before.cfg" << 'EOF'
[evidence // sigstop // id:EV-BEFORE]
Eval 4471 grader config, pre-modification. The before-picture.
EOF

cat > "$V/4471_after.log" << 'EOF'
[evidence // sigstop // id:EV-AFTER]
Grade log fragment, post-modification. The eleven points.
EOF

cat > "$V/4471_note.txt" << 'EOF'
[evidence // sigstop // id:EV-NOTE]
Reyes: the before, the after, and me telling you it mattered.
EOF

cat > "$V/comms_extract.log" << 'EOF'
[evidence // sigstop // id:EV-COMMS]
Six lines pulled from forty thousand. The suppression timeline.
EOF

cat > "$V/witness/4471_witness.stmt" << 'EOF'
[evidence // sigstop // id:EV-WITNESS]
Statement, anonymized: the CRITICAL was reclassified verbally, in a
hallway, by someone whose name the witness will say out loud.
EOF

cat > "$V/evidence_4471.log" << 'EOF'
[evidence // sigstop // id:EV-DISTILLED]
(distilled drop 08 — seventeen lines. the source's arithmetic.)
EOF

# ---------------------------------------------------------------
# Fault 1: scrambled owners, sealed modes
# ---------------------------------------------------------------
chown -R root:root "$V"
chown 1201:1201 "$V/comms_extract.log"
chmod -R 000 "$V"

# ---------------------------------------------------------------
# Fault 2: calling cards — incl. one nested beside the witness
# ---------------------------------------------------------------
for i in 01 02 03; do
  printf 'APX-COUNTERSCAN CARD %s\nseen=segment-empty\n' "$i" > "$I/apx_card_$i.trk"
done
chmod 700 "$V"
printf 'APX-COUNTERSCAN CARD 04\nseen=segment-empty\n' > "$V/apx_card_04.trk"
chmod 700 "$V/witness"
printf 'APX-COUNTERSCAN CARD 05\nseen=segment-empty\n' > "$V/witness/apx_card_05.trk"
chmod 000 "$V/witness"
chmod 000 "$V"

# ---------------------------------------------------------------
# Fault 3: relay config reverted to the breach line
# ---------------------------------------------------------------
mkdir -p /etc/sigstop
cat > /etc/sigstop/relay.conf << 'EOF'
# sigstop relay configuration
# lockdown rollback: restored package defaults 02:53:37

callsign=operator
cache_path=/var/sigstop/staging
endpoint=test-relay.pubmirror.example.com
interval=60
compression=on
burn_on_read=true
retry_limit=3
EOF

# ---------------------------------------------------------------
# Fault 4: the emergency key, never revoked
# ---------------------------------------------------------------
id -u sigstop-emrg >/dev/null 2>&1 || useradd -r -s /usr/sbin/nologin sigstop-emrg
cat > /etc/sudoers.d/lockdown << 'EOF'
# lockdown emergency grant // AUTO-REVOKES ON COMPLETION
# (completion never ran)
sigstop-emrg ALL=(ALL) NOPASSWD: ALL
EOF
chmod 440 /etc/sudoers.d/lockdown

cat > /etc/sudoers.d/courier << 'EOF'
# sigstop // the only borrow this box allows
courier ALL=(root) NOPASSWD: /usr/local/bin/relay-burn
EOF
chmod 440 /etc/sudoers.d/courier

# ---------------------------------------------------------------
# Fault 5: the scan chatter, unprocessed
# ---------------------------------------------------------------
S="$I/scan.log"
printf '[capture // sigstop // scan intercept // id:EV-SCANLOG]\n' > "$S"
ci=0
counter=(
"sweep origin 10.44.0.0/16. mode passive. operator tag: apx-sec-3."
"segment walk alphabetical. dwell 40s per host. patient."
"fingerprint db: sigstop signatures rev 6. they have a rev 6."
"trigger: relay traffic pattern flagged by upstream monitor."
"empty segment logged. confidence 0.83. below escalation line."
"next sweep scheduled: window minus 21 days."
"note: recommend active probe if pattern repeats. filed."
"tag: do not attribute. plausible ISP scan profile maintained."
)
for n in $(seq 1 120); do
  printf '[apx-scan // NOISE // tick %03d] segment quiet. moving on.\n' "$n" >> "$S"
  if [ $((n % 15)) -eq 0 ] && [ $ci -lt 8 ]; then
    printf '[counter // entry %d/8] %s\n' "$((ci + 1))" "${counter[$ci]}" >> "$S"
    ci=$((ci + 1))
  fi
done

# The burn machinery (standing, from 2.6/2.7)
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

# ---------------------------------------------------------------
# Theming
# ---------------------------------------------------------------
cat >> /root/.bashrc << 'THEME'

# --- SIGSTOP theming (eps2.8 BOSS) ---
export PS1='\[\e[1;31m\]operator\[\e[0m\]@\[\e[1;90m\]sigstop\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\$ '

if [[ $- == *i* && ! -f /tmp/.sigstop_motd_shown ]]; then
  touch /tmp/.sigstop_motd_shown
  echo ""
  echo "  [SIGSTOP // secure channel open]"
  echo "  everyone sees. nobody looks. we act."
  echo ""
  echo "  the lockdown half-fired. the damage report is in your brief."
  echo "  the courier is circling the block."
  echo "  walk the layers. dawn is the deadline that's real."
  echo ""
fi

# BOSS watcher: deathwatch on the six evidence markers, then ONE
# milestone when the courier-named receipt lands. Fires once each.
# Never blocks, never reacts to keystrokes.
__sigstop_watch() {
  if [[ ! -f /tmp/.sigstop_dead ]]; then
    local lost="" id
    if [[ ! -d /var/sigstop/vault ]]; then
      lost="everything"
    else
      for id in EV-BEFORE EV-AFTER EV-NOTE EV-COMMS EV-WITNESS EV-DISTILLED; do
        if ! grep -rq "id:$id" /var/sigstop/vault 2>/dev/null; then
          lost="$id"
          break
        fi
      done
    fi
    if [[ -n "$lost" ]]; then
      touch /tmp/.sigstop_dead
      echo ""
      echo "  [SIGSTOP] stop. check the vault."
      echo "  [SIGSTOP] evidence is gone, and gone is not a place things"
      echo "  [SIGSTOP] come back from. i told you both sentences had to"
      echo "  [SIGSTOP] be true at dawn. one of them is false forever now."
      echo "  [SIGSTOP] restart the scenario. the courier can circle the"
      echo "  [SIGSTOP] block one more time. the window can't."
      echo ""
      return
    fi
  fi
  if [[ ! -f /tmp/.sigstop_ms1 && ! -f /tmp/.sigstop_dead ]]; then
    if grep -q '^burned by: courier$' /var/sigstop/burn/receipt.log 2>/dev/null \
       && [[ ! -e /etc/sudoers.d/lockdown ]] \
       && ! find /var/sigstop -name "*.trk" 2>/dev/null | grep -q .; then
      touch /tmp/.sigstop_ms1
      echo ""
      echo "  [SIGSTOP] receipt reads courier. cards dead. key revoked."
      echo "  [SIGSTOP] vault breathing. pickup confirmed."
      echo "  [SIGSTOP] ..."
      echo "  [SIGSTOP] world 2 is over, operator. hit CHECK and go dark."
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
