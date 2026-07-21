The flood also holds 5 lines that start with `SHIM-ENTRY` — the
report-only paper trail. They belong in the same evidence file,
after the shards.

> **Tonight's tools**
> `>>` — send output to the END of a file, keeping what's already there
> The difference matters: `>` empties the file first. `>>` adds. Pick the wrong arrow here and your twelve shards die silently.

**Worked example first.** You made `/root/example.txt` in the last
step. Now run:

```
grep "APX-NOISE seq 0002" /var/sigstop/intake/flood.log >> /root/example.txt
cat /root/example.txt
```

Two lines now — the old one survived, the new one landed under it.
That's `>>`. If you had used `>` instead, the first line would be
gone.

**This step: append the shim entries.**

Add every `SHIM-ENTRY` line from the flood to the end of
`/var/sigstop/intake/evidence_4471.log`. One grep, one `>>`.

Then `cat` the evidence file: seventeen lines — twelve shards on
top, five entries under them. If you see only five lines, you used
the wrong arrow and erased the shards — rerun step 1's grep with
`>`, then this step's with `>>`.

<details>
<summary>&gt; ping handler</summary>

Before you press Enter, look at your arrow. Count its heads. One
head empties the target and writes. Two heads keep the target and
add. You are adding. This is the whole step — the command is
step 1's command with a different search word and a different
arrow.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`grep SHIM-ENTRY` against the flood, then `>>` and the evidence
file's full path. Run the grep without the arrow first if you want
to see the five lines before you commit them — seeing before doing
is never wasted.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
grep SHIM-ENTRY /var/sigstop/intake/flood.log >> /var/sigstop/intake/evidence_4471.log
cat /var/sigstop/intake/evidence_4471.log
```

Seventeen lines. Say the rule back: `>` erases, `>>` adds. That
one character is the difference between an archive and an accident.
Last time I explain it.

</details>
