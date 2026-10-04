Their clock is stopped. Now we leave one of our own.

`/usr/local/bin/sigstop-heartbeat` is a small script I put on this
node. Every time it runs, it writes one line into
`/var/log/sigstop-heartbeat.log`: the time, and whether `prom-evald`
is running. Run it once a minute and we'll have a record of this node
all the way to the wipe, minute by minute, written by a clock that
answers to us.

> **Tonight's tools**
> `crontab -e` — open *your own* (root's) private schedule in nano
> A schedule line: five time fields, then the command. `* * * * *` means every minute.
> `cat <file>` / `tail <file>` — read the log once a minute has passed

**Worked example first.** Before you schedule anything, run the
command once by hand. If it doesn't work by hand, it won't work from
cron either, and cron won't tell you:

```
/usr/local/bin/sigstop-heartbeat
tail -n 1 /var/log/sigstop-heartbeat.log
```

One line, with the time and `prom-evald: inactive`. Good.

**This step: schedule the heartbeat every minute.**

1. `crontab -e`
2. On a new line at the bottom, add:
   `* * * * * /usr/local/bin/sigstop-heartbeat`
3. Save (Ctrl+O, Enter) and leave (Ctrl+X).
4. Check: `crontab -l` shows your line.
5. Wait for the next minute to turn over, then
   `tail /var/log/sigstop-heartbeat.log`. A new line should appear
   every minute, on its own.

Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You're staring at the log waiting for it to fill, and it won't,
because nothing is scheduled yet, or you scheduled it somewhere cron
doesn't read. A cron line is a promise to a very literal machine. It
does exactly what the five fields say, and nothing else.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`crontab -e` with no `-u` opens root's own schedule, the one you
want. Five stars, a space, then the full path of the command. Full
path, always: cron doesn't know where you were standing when you
wrote it. Check with `crontab -l`. The first line in the log can take
up to a minute to show up.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
crontab -e
```

At the bottom: `* * * * * /usr/local/bin/sigstop-heartbeat`. Ctrl+O,
Enter, Ctrl+X. Then:

```
crontab -l
tail /var/log/sigstop-heartbeat.log
```

Say it back: five fields, then the full path, and test it by hand
before you trust it to the clock. Last time I explain it.

</details>
