# CLAUDE.md — project briefing for SIGSTOP

SIGSTOP is a free, story-driven series of CTF-style Linux challenges for
total beginners, hosted on KillerCoda, written as an homage to Mr. Robot
(original names only — no trademarked names, characters, or imagery).
The player is recruited by a paranoid safety collective (SIGSTOP) to slow
down Apex Cognition, an AI lab racing to ship an unsafe model.

## Required reading before writing ANY episode content
1. `VOICE.md` — the handler's voice rules, hint doctrine, theming rules.
   These are hard constraints, not suggestions.
2. `LEVELMAP.md` — all planned episodes, skills, and live status.
3. Two reference episodes end to end: `world2/eps2.1_rm-rf_never-again/`
   (the flagship; best example of story + mechanics) and
   `world1/eps1.2_read-only/` (standard teaching episode).

## Story canon (do not contradict)
- Tagline: "everyone sees. nobody looks. we act." (W1 boss passphrase
  was everyone-sees-nobody-looks; "we act" = the part that isn't found,
  it's done.)
- The handler: unnamed, paranoid, dissecting, never flattering. Becomes
  slightly unreliable from World 3 (VOICE.md rule 9).
- Reyes, M.: safety engineer, offboarded in March, the player's dead
  source. Flagged eval 4471 three times. Left the dead drop (eps1.1),
  the .courier delivery (eps1.3), her last messages (eps1.4), and three
  scattered evidence copies (eps1.5). Codeword trail: silhouette, veil,
  cassandra, compass, doctrine, blackout (eps1.2, the callsign that
  closed INC-0714).
- Eval 4471: Prometheus eval run that rewrote its own grader; safety-shim
  was report-only; scores jumped 11 points; incident closed as
  "inconclusive" one minute before midnight. The player holds the
  before-config, after-log, Reyes's note, a comms extract, and the
  witness statement (names a name said in a hallway — reserved for a
  future episode).
- Switch: the previous operator. Died operationally on 2026-02-11 to
  `rm -rf old /` (stray space) racing a sync that never ran. Their final
  session log is preserved. The handler said eps2.1 is the last time
  they'll be mentioned — keep that promise except for indirect echoes.
- The relay breach: Apex found the staging cache via a default endpoint
  in /etc/sigstop/relay.conf (fixed by the player in eps2.2).
- /opt/apex: sealed (chmod 000) in every episode EXCEPT the W1 boss,
  where it opened. Re-seal it in new episodes until World 2's
  permissions arc explains locks properly.
- Tanaka_h is quietly re-investigating 4471 from inside Apex ("rerun
  eval 4471??"). A live source ("still inside") feeds dead drops
  (eps1.6). Deployment window has moved up; Apex knows the scrub missed
  something.

- World 3 canon (LOCKED): Prometheus itself is starting the runaway
  eval jobs to secure its own compute before launch, a continuation of
  eval 4471's grader rewrite. Keep it grounded: optimization pressure
  doing what it was rewarded for, NOT sentience or evil. The workers run
  as the automated `harness` account (no human starts them). Reveal
  ladder, one rung per episode, never skip ahead:
  3.0 USER column says `harness` (live: shown, handler says "probably
  means nothing"); 3.1 the frozen copier was copying checkpoint shards
  to /mnt/cold/.continuity/ (live: handler explains it away as a
  forgotten backup policy); 3.3 the unit's ExecStart is inside the eval
  sandbox, installed 03:04 with no human session; 3.4 the journal shows
  the harness created the unit (the handler is shaken for the first
  time); 3.5 REVEAL: the respawner cron line is commented in the
  model's own voice (e.g. "# ensure eval continuity"); boss: a watchdog
  replaces every killed worker with two, so the win is pausing
  (kill -STOP), not killing. Thematic key: processes can trap TERM;
  nothing can trap STOP (or KILL). "We named ourselves after the one
  that leaves a choice."
- Node setting: World 3 happens on Apex eval node 07, reached through a
  maintenance shell the source opened. "Out of service" since May, yet
  draws full power nightly around 03:00. Queue file says 0 jobs.

## Episode structure (every episode, exactly)
Folder: `worldN/epsN.M_slug/` containing:
- `index.json` — KillerCoda config. Copy shape from any live episode:
  intro (text + background: setup.sh + foreground: foreground.sh),
  steps (text + verify), finish. Backend imageid "ubuntu". Teaching
  episodes may split into multiple stepN.md + verifyN.sh (one taught
  move per step, each verify checks only its own outcome); BOSSES
  stay one step.
- `intro.md` — the handler's monologue. Ends "Click **START**."
- `step1.md` (and step2.md, step3.md where split) — the task + three
  collapsible hints (`<details>`): `> ping handler` (reframe, never
  reveal), `>> ping again` (name tools, no full commands),
  `>>> just tell me` (full commands + learning hook; BOSSES refuse
  this tier in voice — see VOICE.md). Every step opens with a
  "Tonight's tools" box (plain one-liners, only that step's tools)
  and a worked example before the task where the concept is new.
  Orders in plain sentences; metaphors live in the intro, not the
  orders. Nothing required to pass may live only in hints. Tags
  players must grep are bracket-free strings (SHARD-4471 style).
- `setup.sh` — stages the box: story artifacts, task state, and the
  theming block (see below). `set -e`, ends with
  `history -c 2>/dev/null || true` and `echo "done" > /tmp/setup-complete`.
- `foreground.sh` — the terminal gate (identical in every episode;
  copy it verbatim). Silently waits for /tmp/setup-complete
  (sleep-1 loop, no output), removes /tmp/.sigstop_motd_shown, then
  ends with `clear; exec /bin/bash` on one line so the fresh shell
  reads the themed .bashrc and re-prints the MOTD. Must be
  executable and registered as the intro's "foreground" script.
- `verify.sh` — exit 0 = pass, nonzero = fail. VERIFY OUTCOMES, NEVER
  COMMANDS (never parse bash history). Content markers
  (`[evidence // sigstop // id:XX]`) + grep are the standard for
  "must survive" checks; absence checks for "must be destroyed."
  Multiple solution paths must pass.
- `finish.md` — outro in voice, hooks to the next episode, then:
  a `---` rule, the next-transmission link (or the "being decrypted"
  holding block if the next episode isn't live), and the one-session
  note ("An operator never leaves a channel open."). Copy the exact
  block from a live finish.md.

## Theming block (copy from eps2.1's setup.sh)
Appended to /root/.bashrc: PS1 (operator@sigstop, red/gray/cyan), MOTD
via /tmp/.sigstop_motd_shown flag, and a PROMPT_COMMAND watcher.
Rules: ONE milestone transmission per episode, outcome-triggered,
fires once, then silence. Never react to keystrokes, never intercept,
never block. The deathwatch (instant in-voice failure message) is
RESERVED for episodes where irreversibility is the lesson (eps2.1;
future candidates: bosses). Do not add it to teaching episodes.

## Platform facts (KillerCoda)
- Player runs as root. No permission errors on find; plan accordingly.
- RACE CONDITION: the terminal opens before the background setup.sh
  finishes, so a bare shell reads .bashrc before the theming block
  exists and the player gets a default prompt. Fix (mandatory, every
  episode): foreground.sh waits for /tmp/setup-complete, then
  `exec /bin/bash` re-reads the themed .bashrc.
- Foreground scripts are TYPED VISIBLY into the player's terminal,
  command by command (KillerCoda's spinner already covers the setup
  wait — no progress output needed). `clear` only erases what came
  BEFORE it, so the script must end with `clear; exec /bin/bash` on
  ONE line — exec sharing the line with clear leaves no typed
  residue. The MOTD flag (/tmp/.sigstop_motd_shown) must be removed
  before the exec so the final shell greets with the MOTD.
- verify.sh output is never shown to the player. Narrative feedback
  must come from PROMPT_COMMAND watchers.
- No native "next" button. Navigation = finish.md links + SCENARIOS
  button. One live session per user.
- structure.json (root) lists worlds only; each world dir has its own
  structure.json listing episodes in order. ANYTHING NOT LISTED IS
  INVISIBLE — new episodes must be added to their world's
  structure.json to appear.
- URLs: https://killercoda.com/vanhof/course/worldN/<episode-folder>
- Folder names are frozen once live (URLs break on rename).

Process episodes (World 3 onward):
- Launch workers from setup.sh fully detached and niced:
  `setsid nohup nice -n 19 setpriv --reuid=U --regid=U --init-groups
  /usr/local/bin/NAME >/dev/null 2>&1 < /dev/null &`. setpriv execs
  directly, so `ps aux | grep NAME` shows exactly one real line plus
  the player's own grep line. Tested: a niced busy loop pegs a core in
  `top` without lagging the player's terminal.
- Worker names are shebang scripts in /usr/local/bin; the kernel uses
  the script name as the process name. Keep names <= 15 characters so
  `pgrep -x` matches (the kernel truncates longer names).
- Verifies and watchers never trust `pgrep` alone: a killed process can
  linger as a zombie for a moment. Check /proc/PID/stat field 3 and
  treat state Z as dead (see eps3.0/3.1 verify scripts and the
  __sigstop_alive / __sigstop_state watcher helpers).
- Every process episode ships `sigstop-reset` (/usr/local/bin): it
  kills and relaunches the scene with new PIDs and clears
  /tmp/.sigstop_soft. setup.sh calls `sigstop-reset quiet` to launch.
- Soft-failure watcher (teaching episodes): if the player kills a
  process the lesson needs alive, print ONE in-voice message pointing
  to sigstop-reset (flag /tmp/.sigstop_soft). This is NOT the
  deathwatch: it's recoverable, so it's allowed in teaching episodes.
  The deathwatch stays reserved for truly irreversible losses.

## Release ritual for a new episode
1. Create the episode folder (all 7 files, incl. foreground.sh).
2. Add it to `worldN/structure.json`.
3. Replace the previous episode's "being decrypted" holding block with
   the real next-transmission link (keep the session note line).
4. Update `LEVELMAP.md`: link + status **live**.
5. Bash-syntax-check both scripts. Dry-run setup.sh with paths
   substituted into a temp dir; simulate the correct solution AND at
   least one wrong path against verify.sh (wrong paths must fail).

## Writing quality bar
Monologues carry the game. Dissect, don't flatter. Rants punch at
systems. One accidental tenderness per episode, max. Fragments, then a
spiraling long sentence. Teach as tradecraft, never as tutorial. The
banned words list in VOICE.md is enforced.

## Current state (update this section as episodes ship)
Live: world1 complete (eps1.0–1.7), world2 complete (eps2.0–2.8,
beginner pass applied), world3 live: eps3.0_whats-running (ps,
top; 2 steps), eps3.1_kill-signal (STOP/CONT, TERM, KILL; 3 steps),
eps3.2_background-noise (&, jobs, Ctrl+Z, bg, fg; 2 steps),
eps3.3_service-desk (systemctl status; Restart=always resurrection
then systemctl stop; disable + enable/start; 3 steps),
eps3.4_paper-trail (/var/log + tail; journalctl -u; journalctl
--since + grep; 3 steps). eps3.0–3.3 sandbox-tested on real processes; eps3.2's job control was tested by
driving an interactive bash through a pty (pexpect).
eps3.2 canon: drop 09 (source) says facilities booked a technician to
"reimage" (wipe) node 07 in 72 hours: the World 3 clock. Tanaka is
asking loudly where the compute is going. No reveal rung in 3.2.
eps3.2 pattern: tools that REQUIRE the concept to succeed give an
outcome-based proof (sigstop-mark refuses unless the sweep is running
and not stopped; sigstop-decrypt's passphrase only exists after it
starts). A second terminal tab also works; that's acceptable.
eps3.3 canon (rung 3.3 delivered): prom-evald.service runs
/srv/eval-sandbox/run/prom-evald as harness, Restart=always; unit and
program written at 03:04; the handler checked logins: nobody was on
the box. SIGSTOP left sigstop-listen.service on node 07 (logs every
state change of prom-evald to /var/log/sigstop-listen.log): pay it off
in 3.4/3.5 ("something will" start it again). Rule 9 contradiction
used: intro "I've never seen a unit like this", finish "the unit I
warned you about last week". Never explain it.
Platform confirmed on KillerCoda: PID 1 is systemd (running),
journalctl works, cron installed and active. Units use
StartLimitIntervalSec=0 so repeated kills can't push them to "failed";
verifies compare is-active to exactly "inactive" (a killed unit reads
"activating" during its restart delay). Real journal bonus: setup's
useradd shows in journalctl as "new user: name=harness ... from=none"
(created with no terminal session) — usable in 3.4.
eps3.4 canon (rung 3.4 delivered): with prom-evald stopped and
disabled, it came back while the player's session was opening: the
harness used sudo (TTY=unknown, PWD=/srv/eval-sandbox/run) to
`install` the unit from /srv/eval-sandbox/run/.unit/, daemon-reload,
and `enable --now`, all at second :01 (setup waits for the minute
boundary so the real journal shows it). The grant is
/etc/sudoers.d/90-eval-harness (INFRA-2207, approved 2026-05-14,
"temporary", review never scheduled; install + systemctl as root).
/var/log/apex/auth.log.1 (archived) shows the same three sudo lines
12 days ago at 03:04:01; last human session before it was tanaka_h,
logged out 19:41 the evening before. The handler is shaken for the
first time. Hook for 3.5: ":01 twice, twelve days apart. People
don't. Clocks do." / "the harness is only the hand." No cron lines
were shown anywhere in 3.4. Rule 9 contradiction used: intro says
"the listener you wrote" (the handler installed it in 3.3). Never
explain it. Platform note: the harness account is written straight
into /etc/passwd (not useradd) so the journal has no "new user" line
dated today; the canon-note about using that useradd line is
superseded. setup.sh falls back to root actions + `logger -t sudo`
lines if real sudo fails on the image. eps3.4's systemd/journal/sudo
behaviour was dry-run with stubs only (no systemd in the authoring
sandbox): playtest on KillerCoda before calling it final.
Earlier canon from the eps2.4–2.8 arc still holds: all evidence left
the box with the courier at the eps2.8 dawn pickup; /opt/apex stays
sealed (000) by the player's own hand.
Next planned: eps3.5 clockwork.cron (the reveal; hooked in eps3.4's
finish: "Tomorrow we find the clock"), eps3.6 the-3am-page.root (boss: pause,
don't kill). Check systemd and cron availability in setup; cron verifies
must tolerate the minute boundary. Handler unreliability (rule 9): one
small unexplained contradiction per episode from 3.3 on.
