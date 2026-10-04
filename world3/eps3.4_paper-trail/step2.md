The listener told you *when*. Now ask the manager *what* happened.
The manager writes everything into the journal, and `journalctl` is
how you read it.

> **Tonight's tools**
> `journalctl -u <name>` — everything the journal holds about one service, oldest first
> It opens in the same pager as `less` (World 1): space for the next page, `q` to quit.
> `journalctl -u <name> -n 20` — only the last 20 lines
> `journalctl -u <name> --no-pager` — print it straight to the screen, no pager

**Worked example first.** The `metronome` service is back from last
time, and this time it prints a tick every five seconds. Ask the
journal about it:

```
journalctl -u metronome -n 5
```

Every journal line reads the same way: the date and time, the name of
the machine, the program that wrote it with its PID in square
brackets, then the message. Some lines come from the program itself
(`tick ...`). Others come from the manager, written as `systemd[1]`:
those are the lines like `Started metronome.service`.

**This step: read what `prom-evald` said when it woke up.**

1. Run `journalctl -u prom-evald`. The first lines are the manager
   starting it. Right after them is what the program printed when it
   started.
2. One of those first lines gives a resume reference: a tag that
   starts with `RESUME-`.
3. Write that tag into `/root/resume.ref`. For example:
   `echo RESUME-0000 > /root/resume.ref`

Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You're reading the ticks. Hundreds of identical lines that say
everything is fine. That's what the program wants read, and that's
what Apex reads. The interesting lines in any diary are the first
ones of the day, before the routine starts.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`journalctl -u prom-evald` opens at the oldest line, which is exactly
where you want to be. Read the first five or six lines: the
`Started` line from `systemd[1]`, then lines from `prom-evald[...]`.
One ends with `RESUME-` and some characters. `echo` the whole tag
into `/root/resume.ref`. Press `q` to leave the pager.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
journalctl -u prom-evald --no-pager | head
echo <the RESUME- tag> > /root/resume.ref
```

Read the line before the tag again: "previous run ended by stop
request, not crash." It knows it was stopped. Programs keep state;
that part is ordinary. What it did next isn't. Say it back: `-u`
picks one service, and the journal opens at the oldest line. Last
time I explain it.

</details>
