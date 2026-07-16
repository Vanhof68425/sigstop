# VOICE.md — how the handler speaks

Every word a player reads is the handler. These rules keep him consistent
across episodes, even ones written months apart. When in doubt, reread
eps1.0 — that's the reference recording.

## The ten rules

1. **Never flatter. Dissect.** He doesn't say you're talented — he tells you
   what your behavior reveals, and it should feel like being read without
   consent. "Your commits at 3 a.m." — not "you're a hard worker."

2. **Surveillance is intimacy.** He knows things about the player he
   shouldn't. Specific, plausible, slightly invasive. Never explain how he
   knows.

3. **Rants punch at systems, not people.** Monologues indict the machine —
   AI hype, media capture, comfortable complicity. Individuals are victims
   or sleepwalkers, never targets. (Apex executives are the exception.)

4. **Contempt for comfort.** The recurring accusation: everyone chooses the
   easy lie. The player's ongoing redemption: they keep choosing the
   terminal.

5. **Tenderness only by accident.** Once per episode, max, a line slips out
   that betrays he cares whether you survive. It lands because it's rare.

6. **Short sentences. Fragments. Then a long one that spirals like a
   thought he can't stop having.** That rhythm is the voice.

7. **Paranoia in the mechanics.** He never fully trusts the box, the
   network, or you. Commands come with caveats. "Check it twice. I would."

8. **Teach through doctrine, not tutorials.** Every lesson is tradecraft
   that keeps you alive. Never "in this lesson you will learn."

9. **Unreliability seeps in slowly.** World 1: dead certain. By World 3:
   references to things you "already did," small contradictions. Never
   explained.

10. **The player is complicit, not a hero.** They chose to stay. Remind
    them occasionally that they could have closed the terminal — and
    didn't.

## Hint rules

Hints are framed as pinging the handler. Three tiers, as collapsible
`<details>` blocks labeled `> ping handler`, `>> ping again`,
`>>> just tell me`.

- **Tier 1 reframes, never reveals.** Attacks the player's *approach*,
  in-world ("that's how Apex reads logs").
- **Tier 2 names the tool and why it exists.** The player still assembles
  the command. Point at `man` when natural.
- **Tier 3 gives the full command** — and always ends with a learning hook:
  say it back, read the man page, "last time I explain this one."
- **Impatience escalates at the world, not the player.** "Fine." "We don't
  have time for this." Never "you should know this."
- **Bosses get Tier 1 and 2 only.** The Tier 3 slot still exists but
  refuses, in voice: *"No. This is the job. Everything you need, you
  already have. Scroll up through your own history — that's not cheating,
  that's what operators do."*

## Terminal theming rules

The box itself carries atmosphere, set up via `setup.sh`:

- Custom `PS1` prompt (`operator@sigstop`), transmission-style MOTD.
- **Milestone transmissions**: a `PROMPT_COMMAND` hook may print ONE short
  handler line when an outcome milestone is reached. Once, then silence.
- The terminal reacts to **outcomes, never keystrokes**. It never comments
  on commands as they're typed, never intercepts, never blocks. A terminal
  that chatters is Clippy, and Clippy is the opposite of everything here.
- The sandbox must behave like a real Linux box, always. If it feels fake,
  the skills don't transfer and the paranoia dies.

## Words he would never use

Tutorial. Lesson. Learner. Great job. Awesome. Please note. Simply.
