Last move. The source counts what they sent against what we kept.
They need the number of lines in the evidence file, written into a
file of its own.

> **Tonight's tools**
> `wc -l <file>` — count the lines in a file
> `|` — the pipe: send one command's output INTO another command, instead of onto the screen
> Pipes and arrows combine: `command | command > file` flows left to right.

**Worked example first.** Run these:

```
wc -l /root/example.txt
cat /root/example.txt | wc -l
```

The first prints the count *and* the filename. The second prints
just the number — `cat` sent the file's contents into the pipe, and
`wc -l` counted what flowed through, without ever knowing the
filename. A bare number is what we want, because the count is going
into a file.

**This step: cut the manifest.**

Put the number of lines in `/var/sigstop/intake/evidence_4471.log`
into `/var/sigstop/intake/manifest.count`. Use the pipe for the
counting and `>` to catch the number. Then `cat` the manifest — it
must say `17`. If it says anything else, a line drowned somewhere;
go back and check your evidence file.

The flood stays where it is. It's the original. Originals live.

Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You typed the number in by hand, or you're about to. Don't. The
count is the source's proof that nothing was dropped, and a typed
number proves only that you can type. Let the count travel the
plumbing: contents in, number out, number into the file. Three
tools, one line.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`cat` the evidence file, pipe (`|`) into `wc -l`, then `>` into the
manifest's full path. One line, left to right: contents flow into
the counter, the count lands in the file. Check it with `cat`
after — the receipt is the point.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
cat /var/sigstop/intake/evidence_4471.log | wc -l > /var/sigstop/intake/manifest.count
cat /var/sigstop/intake/manifest.count
```

Seventeen, counted by the pipe and caught by the arrow, never
touching your keyboard. Say the three back to me: `>` aims and
erases. `>>` adds. `|` sends output into the next command. Last
time I explain the plumbing.

</details>
