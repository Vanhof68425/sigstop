Start with the oldest kind of paper: plain text files.

> **Tonight's tools**
> `ls -lt /var/log` — list the log folder, most recently changed first
> `tail <file>` — show the last 10 lines of a file (World 1)
> `tail -n 20 <file>` — show the last 20 lines
> Every line in a log starts with a date and a time. The newest lines are at the bottom.

**Worked example first.** Facilities keeps a power meter on node 07's
rack. Every few minutes it writes one line into
`/var/log/node07-power.log`. Look at the folder, then at the end of
that file:

```
ls -lt /var/log | head
tail -n 8 /var/log/node07-power.log
```

Read each line left to right: date, time, which node, how many watts,
and what state the node is *supposed* to be in. Now look at the watts
around 03:00. A node that is "out-of-service" doesn't draw 1,800 watts.

**This step: find out when `prom-evald` came back.**

1. Read the end of `/var/log/sigstop-listen.log`. That's our
   listener's log: it writes one line every time `prom-evald` changes
   state.
2. Find the **last** line that says `prom-evald is now: active`.
3. Write that line's time, exactly as written (`HH:MM:SS`), into
   `/root/back.time`. For example:
   `echo 14:07:02 > /root/back.time`

Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You're opening the whole file and scrolling from the top, like it's a
book. It isn't. A log only grows at one end. Whatever happened most
recently is always in the same place, and it isn't the beginning.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`tail` on `/var/log/sigstop-listen.log`. The last line with
`is now: active` has a date, then a time with seconds. Copy only the
time, `HH:MM:SS`, and `echo` it into `/root/back.time`. Not the line
from days ago. Tonight's.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
tail /var/log/sigstop-listen.log
echo <the time on the last "is now: active" line> > /root/back.time
cat /root/back.time
```

Look at the lines above it: `inactive` from the night you stopped
it, `inactive` again when the node came up tonight. Then `active`.
Say it back: a log grows at the bottom, so the end of the file is the
newest truth. Last time I explain it.

</details>
