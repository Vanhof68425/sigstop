The intake:

```
/var/sigstop/intake/flood.log
```

About 400 lines. Most are Apex noise — every noise line starts with
`APX-NOISE`. Buried among them are 12 evidence lines that start with
`SHARD-4471`. Those are the run logs the scrub missed.

> **Tonight's tools**
> `grep <word> <file>` — print every line of the file that contains the word (World 1)
> `>` — send a command's output into a file instead of onto the screen. **Warning: `>` empties the target file first.** If the file doesn't exist, it is created.

**Worked example first.** Run these two commands and watch what
happens:

```
grep "APX-NOISE seq 0001" /var/sigstop/intake/flood.log
grep "APX-NOISE seq 0001" /var/sigstop/intake/flood.log > /root/example.txt
```

The first command printed one matching line on your screen. The
second printed nothing — because `>` aimed the same output into a
new file instead. Prove it: `cat /root/example.txt`. Same line,
caught instead of shown. That's all `>` does: it points a command's
output at a file.

**This step: route the shards.**

Create `/var/sigstop/intake/evidence_4471.log` containing every
`SHARD-4471` line from the flood. One grep, one `>`. Do not open the
flood in an editor — the file is born from the stream, not typed.

Read your result with `cat` when you're done. Twelve lines, no
noise.

<details>
<summary>&gt; ping handler</summary>

You opened the flood in an editor, didn't you. Four hundred lines,
scrolling, eyes swimming, like an Apex analyst at a dashboard.
Close it. You will never read this file. You already ran the worked
example — the task is the same two-part move with a different
search word and a different target file.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`grep SHARD-4471` against the flood prints the twelve lines on your
screen. Run that first and *look* at them — aim before you fire,
same as deletions. Then run it again with `> ` and the full path of
the new evidence file at the end. The screen shows nothing; the
file holds everything.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
grep SHARD-4471 /var/sigstop/intake/flood.log
grep SHARD-4471 /var/sigstop/intake/flood.log > /var/sigstop/intake/evidence_4471.log
cat /var/sigstop/intake/evidence_4471.log
```

See it, catch it, check it. Twelve shards. Say the rule back:
`>` aims output at a file, and it empties the file before writing.
Last time I explain this one.

</details>
