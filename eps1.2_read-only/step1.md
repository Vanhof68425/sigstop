The file:

```
/var/apex-mirror/dossier/incident_0714.log
```

Three questions, three reading techniques:

1. **What is this file?** The answer is in its first lines.
2. **Who closed the incident?** Incidents close at the end. The sign-off
   is in the final lines — and the closing officer's callsign is your
   codeword.
3. Somewhere in the middle, one entry is marked `SEVERITY: CRITICAL`.
   Read it. It's not required for the codeword. It's required for you.

When you have the codeword: home, and the signal file, same as always.

Do **not** `cat` the whole thing. I'll know. I won't stop you — I don't
stop people from learning slowly. I just remember.

<details>
<summary>&gt; ping handler</summary>

You're trying to read 5,000 lines with a tool built for 50. The file has
three regions you care about — its beginning, its end, its middle — and
operators have a separate tool for each. Two of them are named after the
body part of the file they show you.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`head` shows the first lines of a file. `tail` shows the last — and
`tail -n 30` shows the last thirty, if ten isn't enough to catch the
sign-off. For the middle: `less` opens a file one page at a time. Inside
less: space to page down, `/CRITICAL` to search, `n` for next match,
`q` to leave. That `/` search is the single most useful thing you'll
learn tonight.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
head /var/apex-mirror/dossier/incident_0714.log
tail -n 30 /var/apex-mirror/dossier/incident_0714.log
less /var/apex-mirror/dossier/incident_0714.log
```

In less, type `/CRITICAL`, press enter, read the entry, press `q`. The
sign-off at the tail names the closing officer's callsign — lowercase it,
go home, `touch` it. Three tools, three regions. Say it back: head is the
top, tail is the bottom, less is everything between. Last time I explain
these.

</details>
