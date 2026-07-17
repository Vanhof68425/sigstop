Three files. Names starting with `4471_`. Locations unknown — that's
the design, not the obstacle.

Hunt them down. Read all three. Assemble what Reyes was actually
telling us, and take the codeword to your home directory the usual way.

One warning: patterns with wildcards want quotes around them, or the
shell gets clever before the tool ever sees them. You'll learn why the
hard way eventually. Tonight, just quote.

<details>
<summary>&gt; ping handler</summary>

You're browsing directories hoping to stumble into them. That's how
Apex's auditors worked, and they found zero of three. You're not
searching a place. You're asking the whole filesystem a question:
*what do you have whose name starts with 4471?* One tool answers
questions like that, and you point it at the root of everything.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`find / -name "4471_*"` — start at `/`, match names against the
pattern, quotes keeping the `*` intact for find instead of the shell.
Three paths come back. `cat` each one. On a box where you're not
root, you'd add `2>/dev/null` to mute the permission noise — free
tradecraft, no charge.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
find / -name "4471_*"
```

Three results. `cat` all three — the codeword is in the one that
reads like a goodbye. Home, `touch`, done. And understand what just
happened: Reyes hid these from a corporation's entire decommissioning
process, but not from you, because she *chose names findable by the
right person*. Hiding and signaling are the same skill pointed in
different directions. Last time I explain it.

</details>
