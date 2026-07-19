The handoff:

```
/var/sigstop/handoff/
```

The distilled evidence from drop 08, staged for the courier. Wrong
stamps on all of it.

Orders:

1. **Read the room.** `ls -l` the handoff. `id courier`. Note who
   owns what right now — root on most of it, and one file answering
   to a number. Numbers in the owner column are ghosts. Look at it
   before you fix it; you'll see one again someday and I want you to
   recognize it.
2. **Put the courier in the cell.** The `cell` group exists; the
   courier isn't in it yet. Add the membership *without* knocking
   the courier out of any room they're already in — the tool has a
   flag for exactly that mistake, and people make it weekly.
   Confirm with `id courier` after. Looking, not asking.
3. **Hand it over.** The handoff directory and everything in it:
   owner `courier`, group `cell`. Every file. If the courier is
   searched, nothing in that bag answers to any name but theirs.

Then CHECK. The stamps are the signal.

<details>
<summary>&gt; ping handler</summary>

You changed one file and stopped, or you're about to type a command
that touches the directory and not what's inside it. Ownership
doesn't cascade on its own — a directory and its contents are
separate testimonies, and Apex forensics loves the operator who
forgot the difference. Walk the whole handoff. And on the group
problem: you're not *creating* anything. The room exists. You're
walking someone into it — and there's a wrong way to do that which
quietly removes them from every other room first.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`usermod -aG` adds an account to a group — the `-a` is the whole
ballgame; `-G` alone *replaces* the account's rooms instead of
adding one. Verify with `id courier`, not with your memory. For the
stamps: `chown owner:group file` sets both names at once, and
`chown -R` walks a directory and everything under it. `ls -l` before
and after — the column is the receipt.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
ls -l /var/sigstop/handoff
id courier
usermod -aG cell courier
id courier
chown -R courier:cell /var/sigstop/handoff
ls -l /var/sigstop/handoff
```

Look at the second `ls -l` against the first. Root gone. The ghost
number gone. Every line answering to courier, group cell — a bag
that tells one story to anyone who opens it. Say it back: `-aG`
adds, `-G` alone replaces. `chown -R` walks the tree. The column is
the receipt. Last time I explain the stamps.

</details>
