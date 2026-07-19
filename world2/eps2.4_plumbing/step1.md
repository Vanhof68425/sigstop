The intake:

```
/var/sigstop/intake/flood.log
```

Two kinds of signal are buried in the spray. Shard lines, tagged
`[4471 // shard`, twelve of them — the run logs the scrub missed.
Shim entries, tagged `[shim //`, five — the report-only paper trail.
Everything else is Apex heartbeat noise, and the noise stays in the
flood where it belongs.

Orders:

1. **Route the shards.** Every `[4471 // shard` line into
   `/var/sigstop/intake/evidence_4471.log`. One command. No editor —
   the file is born from the stream, not typed.
2. **Append the shim entries.** Every `[shim //` line onto the *end*
   of the same file. Choose your arrow carefully. One of them erases.
3. **Cut the manifest.** The source counts what they sent against
   what we kept. Put the number of lines in `evidence_4471.log` into
   `/var/sigstop/intake/manifest.count` — and let the count travel
   the plumbing, not your keyboard. If the manifest doesn't say
   seventeen, something drowned. Find it before you CHECK.
4. **The flood survives.** It's the original. Originals live.

<details>
<summary>&gt; ping handler</summary>

You opened the flood in an editor, didn't you. Four hundred lines,
scrolling, eyes swimming, like an Apex analyst at a dashboard. Close
it. You will never read this file, and after tonight that stops
feeling like a limitation. You own a tool that pulls matching lines
out of a stream — you've used it since World 1. The only new
question is where the matching lines *land*, and the answer is one
character long.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`grep` finds the lines. The bracket in the tag is a special
character to grep's pattern language, so either escape it or use
`grep -F`, which treats the pattern as plain text — plain text is
what you want. Then aim: `command > file` sends output into a file
after emptying it; `command >> file` adds to the end and erases
nothing. First write aims with `>`, second with `>>` — reverse them
and your shards die the quiet way. For the count: `wc -l` counts
lines of whatever flows into it, and a pipe (`|`) can feed it a
file's contents while `>` catches the number on the far side.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine. Watch the arrows.

```
grep -F '[4471 // shard' /var/sigstop/intake/flood.log > /var/sigstop/intake/evidence_4471.log
grep -F '[shim //' /var/sigstop/intake/flood.log >> /var/sigstop/intake/evidence_4471.log
cat /var/sigstop/intake/evidence_4471.log | wc -l > /var/sigstop/intake/manifest.count
cat /var/sigstop/intake/manifest.count
```

Twelve shards routed with `>`, five entries appended with `>>`,
seventeen counted through a pipe and caught in a file. The purists
will tell you `wc -l < evidence_4471.log` skips the `cat` — they're
right, and both doors open the same room. Say the three back to me:
`>` aims and erases. `>>` adds. `|` welds mouth to ear. Last time I
explain the plumbing.

</details>
