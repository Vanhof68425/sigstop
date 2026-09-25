The second worker is `prom-queue-fill`. It keeps adding eval jobs to
a queue that is supposed to be empty. Its log is
`/var/log/apex/queue-fill.log` if you want to see for yourself.

We don't need to read this one. It has no reason to exist. It goes.

> **Tonight's tools**
> `kill <PID>` — ask a process to end. This sends a signal called TERM. Most processes obey and exit cleanly.
> `ps aux | grep <name>` — find a process and its PID (eps3.0)

**Worked example first.** You're done with the metronome. End it
the polite way:

```
ps aux | grep metronome
kill <metronome's PID>
ps aux | grep metronome
```

After the `kill`, only your own grep line is left. The metronome is
gone. No `-STOP`, no `-9`. A plain `kill` is the polite version: it
gives the process a chance to finish up and leave on its own.

**This step: end the queue filler.**

1. Find the PID of `prom-queue-fill`.
2. End it with a plain `kill`.
3. Check with `ps aux | grep prom-queue-fill` that it's gone.

Leave the copier frozen. Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You're reaching for something heavy. You don't need it. Most
processes are like most people at Apex: ask them to leave and they
leave. Start with the smallest signal that could work. You just used
it on the metronome.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`kill` with no dash-option sends TERM, the polite request. Get the
PID of `prom-queue-fill` from `ps aux | grep`, then `kill` that PID.
Check with the same grep: if only your grep line is left, it's gone.
Careful with the number. The copier's PID is right next to it in the
list, and that one stays.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
ps aux | grep prom-queue-fill
kill <its PID>
ps aux | grep prom-queue-fill
```

Only your grep line left. Say it back: plain `kill` asks, and polite
processes say yes. Always ask first. Last time I explain it.

</details>
