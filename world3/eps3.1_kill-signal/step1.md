The first worker is `prom-ckpt-copy`. It writes a line to its log
every two seconds. Watch it work:

```
tail -n 5 /var/log/apex/ckpt-copy.log
```

Run that twice, a few seconds apart. New lines each time. It's still
copying.

> **Tonight's tools**
> `kill -STOP <PID>` — freeze a process exactly where it is. It cannot refuse.
> `kill -CONT <PID>` — let a frozen process continue
> `ps aux | grep <name>` — find a process and its PID (eps3.0)
> `tail -n <N> <file>` — show the last N lines of a file (eps1.2)

**Worked example first.** There's a harmless process on this box
called `metronome`. It writes the time into `/tmp/metronome.log`
once a second. Practice on it:

```
ps aux | grep metronome
tail -n 3 /tmp/metronome.log
kill -STOP <metronome's PID>
```

Now run `tail -n 3 /tmp/metronome.log` twice, a few seconds apart.
The time stopped moving. Run `ps aux | grep metronome` again: the
STAT column now starts with `T`. T means stopped.

Wake it up:

```
kill -CONT <metronome's PID>
tail -n 3 /tmp/metronome.log
```

It's ticking again. Nothing was lost. It was only held.

That signal is **SIGSTOP**. It's the one we're named after. A process
can be written to ignore almost any signal. Not this one.

**This step: freeze the copier.**

1. Find the PID of `prom-ckpt-copy`.
2. Freeze it with `kill -STOP`.
3. Check it: its STAT shows `T`, and its log stops growing.

Do **not** kill it. We need it frozen, not gone. A dead process
can't be read.

Now that it's frozen, read the last lines of its log. Look at where
it was copying to. Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You're thinking of this as stopping the copier. It isn't stopping.
Stopped is forever. This is holding it still so we can look at it,
the same way you froze the metronome a minute ago. Same move,
different PID.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`ps aux | grep prom-ckpt-copy` gives you its PID in the second
column. Send `kill -STOP` with that number. Run the same `ps aux |
grep` again: the STAT column should start with `T`. Then
`tail -n 5 /var/log/apex/ckpt-copy.log` twice. If the last line
doesn't change, it's frozen.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
ps aux | grep prom-ckpt-copy
kill -STOP <its PID>
ps aux | grep prom-ckpt-copy
tail -n 5 /var/log/apex/ckpt-copy.log
```

T in the STAT column. A log that stopped mid-copy. Say it back: STOP
holds, CONT releases, and nothing on this machine can refuse either.
Last time I explain this one.

</details>
