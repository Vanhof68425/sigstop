The ledger:

```
/etc/sudoers.d/
```

Files in this directory are grants: each line names who may borrow
root, and for which commands. Two drop-in files live there tonight.

> **Tonight's tools**
> `ls -l <dir>` — list the directory (World 1)
> `cat <file>` — print a file (reading is safe; editing this directory is not tonight's job)
> A sudoers line reads: `who  where=(as-whom)  options: which-commands`. The last field — which commands — is the entire size of the grant.

**This step: read both grants. Change nothing yet.**

1. `ls -l /etc/sudoers.d/` — two files.
2. `cat` each one. Read the last field of each grant line.

One file grants the `courier` account exactly one command — the
burn tool's full path. That grant is mine, and it stays.

The other grants a vendor account `ALL`, with no password. `ALL`
in the commands field means *every command on the box, as root,
forever*. That is not a grant. That's a skeleton key under a
doormat, and it has been there since the relay package installed
it.

When you've read both and can say which file is which, this step
is done. Knowing what's in the ledger *before* touching it is the
step.

<details>
<summary>&gt; ping handler</summary>

You want to start deleting. Not yet. An operator who edits a ledger
they haven't read is an operator guessing, and guessing with root
grants ends careers. Two files. Read both. The width of the last
field tells you everything — one is a single path, one is a word
that means everything.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`ls -l /etc/sudoers.d/` then `cat` each file by its full path. In
each, find the grant line (the one not starting with `#`) and read
its last field: one says `/usr/local/bin/relay-burn`, one says
`ALL`. That difference is the whole of tonight.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
ls -l /etc/sudoers.d/
cat /etc/sudoers.d/courier
cat /etc/sudoers.d/apex-compat
```

The courier file grants one command by full path. The apex-compat
file grants ALL, no password, to a vendor account. Say the fear
back: the width of the commands field is the width of the hole in
your box. Last time I explain the grammar.

</details>
