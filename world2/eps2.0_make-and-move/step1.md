Your incoming pile:

```
/root/incoming/
```

Four files. Three are the Reyes evidence. One is a corrupted duplicate
from a botched transfer — open them and you'll know which.

> **Tonight's tools**
> `mkdir -p <path>` — create a directory, including any missing parents
> `cp <source> <destination>` — copy a file; the destination can include a new name
> `cat <file>` — print a file to the screen
> `rm <file>` — delete one file. Permanently. There is no undo.

The job, in order:

1. **Build the vault:** a directory at `/root/vault/4471`
2. **Copy the evidence in — with proper names.** The vault convention
   is case number first, then what the file *is*:
   - the before-config → `4471_before.cfg`
   - the grade log → `4471_after.log`
   - the Reyes note → `4471_note.txt`
3. **Leave the originals in incoming.** Untouched. That's the point of
   copying. The vault gets verified against them later.
4. **The corrupted duplicate:** read it. Confirm with your own eyes
   that it's garbage. Then — for the first time since we met — you have
   my authorization to `rm` it.

One file. Confirmed first. That is what deletion is supposed to feel
like. Slow.

<details>
<summary>&gt; ping handler</summary>

You're staring at four files wondering which command comes first. The
job list *is* the order: you can't copy into a vault that doesn't
exist, so build first. And `cp` can rename while it copies — the
second thing you hand it isn't just a destination directory, it can be
a destination *name*. That collapses steps two and three into one
motion per file.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`mkdir -p /root/vault/4471` builds the whole path in one go — the `-p`
creates missing parents instead of complaining about them. Then, per
file: `cp <source> <destination-path-with-new-name>`. Three files,
three cp commands, sources stay put. Identify the corrupt file by
reading all four (`cat`, or `head` if you're being efficient). Then
`rm <the corrupt one>` — full path, typed carefully, read twice
before enter. Not because it's dangerous tonight. Because the habit
has to exist before the night it matters.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
mkdir -p /root/vault/4471
cp /root/incoming/evalconfig.bak /root/vault/4471/4471_before.cfg
cp /root/incoming/gradelog.frag /root/vault/4471/4471_after.log
cp /root/incoming/final.note /root/vault/4471/4471_note.txt
cat /root/incoming/transfer.dup
rm /root/incoming/transfer.dup
```

Read the cat output before the rm — I mean it, the ritual is the
lesson. Then look at what you did: built structure, preserved
originals, destroyed exactly one confirmed piece of garbage. That's a
chain of custody. Say the commands back to yourself. Last time I
explain these.

</details>
