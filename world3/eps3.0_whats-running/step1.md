The source gave us one name: `prom-eval-shard`. It's the job that
keeps running while the queue is empty. Find it.

> **Tonight's tools**
> `ps aux` — list every running process: who owns it (USER), its number (PID), how hard it works (%CPU), and its command
> `ps aux | grep <word>` — the same list, but only the lines that contain the word (the pipe from eps2.4)
> `echo <text> > <file>` — write text into a file (eps2.4)

**Worked example first.** Your own shell is a process too. Run:

```
ps aux | grep bash
```

Each line is one process. Read the columns from left to right:

- **USER** — the account that runs it.
- **PID** — the process ID. Every process gets a number. No two
  processes share one.
- **COMMAND** — the last column. What it's running.

One line ends with `grep bash`. That's your own search, finding
itself. Ignore that line. It will show up every time you do this.

**This step: find the runaway's PID.**

1. Find the `prom-eval-shard` process with `ps aux | grep`.
2. Read its PID. That's the second column.
3. Write the PID into `/root/runaway.pid`. With your number, like
   this: `echo 1234 > /root/runaway.pid`

Look at the USER column while you're there.

Do not stop or kill anything. Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You ran `ps aux` and got a wall of processes, and now you're
scrolling for one name. Don't scroll. You learned in World 2 that
you never read a flood. You route it. The pipe you used on the
intake log works on the process list too.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`ps aux | grep prom-eval-shard` gives you two lines: the real process
and your own grep. The real one is the line that does *not* end in
`grep prom-eval-shard`. Its PID is the first number on the line,
right after the username. Put that number into the file with `echo`
and `>`, then `cat` the file to check it.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
ps aux | grep prom-eval-shard
echo <the PID you read> > /root/runaway.pid
cat /root/runaway.pid
```

I can't type the number for you. It's different on every machine,
every time the process starts. That's the point of a PID: it's a
name for *this* run, not for the program. Read it, copy it, check it.
Last time I explain this one.

</details>
