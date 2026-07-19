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

## Episode structure (every episode, exactly)
Folder: `worldN/epsN.M_slug/` containing:
- `index.json` — KillerCoda config. Copy shape from any live episode:
  intro (text + background: setup.sh), one step (text + verify), finish.
  Backend imageid "ubuntu".
- `intro.md` — the handler's monologue. Ends "Click **START**."
- `step1.md` — the task + three collapsible hints (`<details>`):
  `> ping handler` (reframe, never reveal), `>> ping again` (name tools,
  no full commands), `>>> just tell me` (full commands + learning hook;
  BOSSES refuse this tier in voice — see VOICE.md).
- `setup.sh` — stages the box: story artifacts, task state, and the
  theming block (see below). `set -e`, ends with
  `history -c 2>/dev/null || true` and `echo "done" > /tmp/setup-complete`.
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

## Release ritual for a new episode
1. Create the episode folder (all 6 files).
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
Live: world1 complete (eps1.0–1.7), world2 eps2.0–2.3.
New canon from eps2.3: the live source's first transmission (drop 07)
arrived through the fixed relay; the player confirmed the channel
with "we act."; the source is quiet until they send "the rest —
and the rest will not fit in one file" (hooks eps2.4).
Next planned: eps2.4_plumbing.pipe — pipes/redirection, framed as
the flood that can't be read, only routed (hooked in eps2.3's
finish). After: eps2.5 ownership, eps2.6 permissions (pays off
/opt/apex locks), eps2.7 sudo, eps2.8 boss "locked-out".
