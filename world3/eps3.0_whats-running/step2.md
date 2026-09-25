`ps` gave you a photograph. Look at the %CPU of `prom-eval-shard` in
it: small. That job alone can't make a whole node draw full power
every night. Something else is doing the heavy work, and we don't
know its name yet. So we can't `grep` for it.

When you don't know the name, you watch the machine live.

> **Tonight's tools**
> `top` — a live list of processes, busiest first. It refreshes every few seconds.
> `q` — quit `top` (press it while `top` is open)
> `echo <text> > <file>` — write text into a file (eps2.4)

**Worked example first.** Run `top` and watch it for a few seconds.

The top part of the screen is a summary: uptime, load, memory. The
process list starts under the header row that says `PID USER ...`.
The list sorts itself: the busiest process is always on the **first
row** under that header. The `%CPU` column shows how hard each one
works. `100` means one full processor core.

Press `q`. Your prompt comes back.

**This step: name the hungriest process.**

1. Open `top` again.
2. Read the COMMAND column (the last column) on the first row of the
   list.
3. Press `q`.
4. Write that name into `/root/hungriest.txt`. Like this:
   `echo <name> > /root/hungriest.txt`

Do not stop or kill anything. Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You're reading the summary at the top of `top`, the load averages
and the memory lines. That's the weather report. It tells you the
machine is hot. It doesn't tell you what's burning. Drop your eyes
below the header row. The first process under it is the answer, and
it's a name, not a number.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

Under the row `PID USER PR NI ...`, the first process has the
highest `%CPU`, probably near 100. The last column on that row,
COMMAND, is its name. You didn't know this name before tonight. That's
exactly why `ps | grep` couldn't find it. Press `q`, then `echo` the
name into `/root/hungriest.txt`.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
top
```

Read the first row under the header: it's `ckpt-sync`. Press `q`.

```
echo ckpt-sync > /root/hungriest.txt
```

Remember the difference. `ps | grep` finds a thing you can name. `top`
shows you the thing you didn't know to look for. The second one is
how you find out what you're up against. Last time I explain it.

</details>
