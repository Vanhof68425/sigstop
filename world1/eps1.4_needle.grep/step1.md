The channels:

```
/var/apex-mirror/comms/
```

Three files. Forty thousand lines. Six mentions of the number that
matters. Pull them all — every mention, across every channel — and read
them in order. They tell a short, ugly story, and the last word of it
is yours.

Then home, signal file, as always.

<details>
<summary>&gt; ping handler</summary>

You opened one of those files, didn't you. Scrolled a bit. Felt the
size of it. Good — now stop. This isn't a reading job. You have a
pattern: the eval number. You have a place: the comms directory. The
tool that takes a pattern and a place is one you met in the dead-drop
logs. This time, point it at all three files at once.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`grep -r "4471" /var/apex-mirror/comms/` — the `-r` sweeps the whole
directory, and each hit is prefixed with the file it came from. Read
the hits like a timeline: the channel names and dates tell you who
said what, where, and how it ended. If a match feels cut off, grep can
show context: `-A 2` adds the two lines after each hit. The codeword
is in the last thing Reyes ever wrote in there.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
grep -r "4471" /var/apex-mirror/comms/
```

One command. Read the six lines it returns — actually read them, they
cost people careers — and the final one, from Reyes in the offsite
channel, hands you the codeword directly. Home. `touch` it. And notice
the arithmetic: forty thousand lines, one command, six answers. That
ratio is why grep exists. Last time I explain it.

</details>
