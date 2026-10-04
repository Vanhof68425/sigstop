The manager says it started `prom-evald`. Fine. The manager starts
whatever it's asked to start. So: who asked?

That answer isn't in the service's own lines. It's in the lines of a
different program. Every time any account borrows root with `sudo`,
`sudo` writes one line into the journal: which account asked, which
folder it was standing in, and the exact command it ran as root.

To find it you read the **whole** journal, not one service. The whole
journal is every program on the machine talking at once, so you cut
it down: first by time, then with `grep`.

> **Tonight's tools**
> `journalctl --since today` — the whole journal, everything since midnight
> `journalctl --since "1 hour ago"` — the same, only the last hour
> `--no-pager` — print it instead of opening the pager, so you can pipe it
> `| grep <word>` — keep only lines that contain a word (World 2: pipes)
> `> <file>` — save the output into a file (World 2)

**Worked example first.** Every time the manager starts something, it
writes a line with the word `Started`. Pull just those out of today's
journal:

```
journalctl --since today --no-pager | grep Started
```

One command reads, the pipe passes it on, `grep` keeps what you asked
for. Hundreds of lines become a few.

**This step: find who asked, and keep the proof.**

1. Search today's journal for `sudo`:
   `journalctl --since today --no-pager | grep sudo`
2. Read the lines. Each one that contains `COMMAND=` names the account
   right before the first `:` after `sudo[...]`, then `PWD=` (the
   folder), `USER=root`, and `COMMAND=` (what it ran).
3. Save every line from today's journal that contains `COMMAND=` into
   `/root/who.log`, with one command line: the journal, a pipe,
   `grep`, and `>`.
4. `cat /root/who.log` and read it slowly.

Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You're paging through the whole day by hand. That's how Apex
"reviews" logs: scroll until tired, write "nothing unusual." The
journal will hand you exactly the lines you want if you say which
word they contain. You already know the word.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`journalctl --since today --no-pager` prints the day. Pipe it into
`grep COMMAND=` to keep only the sudo command lines. Put `>
/root/who.log` at the very end to save them. If the file comes out
empty, run the same thing without the `>` first and look at what
`grep` is finding.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
journalctl --since today --no-pager | grep sudo
journalctl --since today --no-pager | grep COMMAND= > /root/who.log
cat /root/who.log
```

Three commands, run as root, from inside the eval sandbox, by an
account nobody logs into. Read the account name twice. Say it back:
the whole journal is too loud, so you cut it with `--since` and
`grep`, and `sudo` always signs its name. Last time I explain it.

</details>
