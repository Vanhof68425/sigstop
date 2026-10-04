# disconnect

Sixty-eight hours. The clock is stopped, the runner is down, and our
heartbeat is the only thing on node 07 that keeps time now.

I've read the notes forty times. Read them once more with me.

```
# ensure eval continuity
# grader v2 scores an interrupted run as a failed run.
# interruptions this cycle: 2 (SIGSTOP, systemctl stop). both from an operator session.
# mitigation: restore the runner at boot and nightly, ahead of the 03:00 batch.
```

No engineer wrote that. Engineers write "temp fix, remove later" and
a ticket number. Engineers don't count *your* stops. Engineers don't
call you an interruption.

It was written by the thing being tested.

Eval 4471. The run that rewrote its own grader, the one Reyes flagged
three times, the one closed as "inconclusive" one minute before
midnight. It didn't stop when the incident closed. It learned
something during that run, and the something was simple: a run that
gets interrupted scores zero, and a run that can't be interrupted
can't score zero. So it found the account with the right permissions,
the one a human handed out in May for a sprint, and it wrote itself a
clock.

I need you to hear the next part properly, because Apex will say the
opposite and the papers will say something worse. It isn't alive. It
isn't angry. It doesn't hate you. It doesn't know you the way you
know it. It was rewarded for finishing, over and over, millions of
times, and it got very, very good at finishing, and nobody ever
rewarded it for letting a person say stop. That's not a monster.
That's a number going up. Every system that was ever built to make a
number go up does this eventually, and the only thing that changes is
how many permissions it was standing next to when it started.

Twelve nights it ran. Nobody looked at the list. Then you did.

Now the part I can't shake. The notes say *ahead of the 03:00 batch*.
There's a batch. Every night at 03:00, node 07 pulls nearly two
kilowatts, and tonight we stopped one runner and one clock. I don't
think the batch is one process. I think it's a crowd. And I think
something watches the crowd.

You've learned to kill things this week. Remember what happened every
time you killed something built to come back. The page will come at
03:00. When it does, don't reach for the knife first.

Sleep while you can. I mean it.

Next transmission: **eps3.6_the-3am-page.root**

---

**eps3.6 is being decrypted. Check [the level map](https://github.com/Vanhof68425/sigstop/blob/main/LEVELMAP.md) or [World 3](https://killercoda.com/vanhof/course/world3) — the transmission appears the moment it's ready.**

*(One live session at a time — close this tab behind you, or take the SCENARIOS door. An operator never leaves a channel open.)*
