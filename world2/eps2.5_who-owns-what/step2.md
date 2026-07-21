The courier is in the room. Now the bag has to answer to their name.

> **Tonight's tools**
> `chown <owner>:<group> <file>` — set a file's owner and group in one move
> `chown -R <owner>:<group> <dir>` — the same, for a directory AND everything inside it
> `ls -l <dir>` — the receipt: owner and group columns, before and after

**Worked example first.** Change one file, then look:

```
chown courier:cell /var/sigstop/handoff/manifest.count
ls -l /var/sigstop/handoff
```

One line now reads `courier cell` where it said `root root`. The
other files are unchanged — `chown` touches exactly what you name,
nothing more. A directory and the files inside it are separate:
changing the directory's owner does NOT change the files' owners.
That's what `-R` is for — it walks the directory and changes
everything under it.

**This step: hand the whole thing over.**

The handoff directory and every file in it: owner `courier`, group
`cell`. Including the ghost file — after your command, the number
is gone and a name is back. If the courier is stopped and searched,
every file in that bag answers to their name and no other.

Check with `ls -l` when you're done: every line reads
`courier cell`. Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You changed one file and stopped, or you changed the directory and
believe the inside followed. It didn't. Ownership doesn't cascade
on its own — you proved that in the worked example. There's a flag
whose whole job is walking the tree for you, and you've seen its
letter on other commands tonight's world already used.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`chown -R courier:cell` on the handoff directory does the directory
and everything inside in one move. Then `ls -l` — every owner
column says `courier`, every group column says `cell`, and the
ghost number is gone.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
chown -R courier:cell /var/sigstop/handoff
ls -l /var/sigstop/handoff
```

Every line answers to courier, group cell — a bag that tells one
story to anyone who opens it. Say it back: `chown owner:group`,
`-R` walks the tree, the column is the receipt. Last time I
explain the stamps.

</details>
