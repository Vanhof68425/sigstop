The handoff:

```
/var/sigstop/handoff/
```

The distilled evidence from drop 08, staged for the courier. Before
anything moves, learn who the box thinks these files belong to.

> **Tonight's tools**
> `ls -l <dir>` — list files with details. Third column: owner. Fourth column: group.
> `id <user>` — show an account's user id and every group it belongs to
> `usermod -aG <group> <user>` — ADD a user to a group

**Look first.** Run `ls -l /var/sigstop/handoff`. Most files say
`root root`. One says a number — `1201 1201` — instead of a name.
That happens when an account is deleted and its files stay behind.
Numbers in the owner column are ghosts. Recognize it; you'll see one
again someday. Then run `id courier` and read what it says: the
courier's groups. The group `cell` is not among them yet.

**This step: put the courier in the cell group.**

The command is `usermod -aG cell courier`.

**Plain warning, read it twice:** the `-a` means *append*. If you
type `-G` without the `-a`, the command doesn't add the group — it
*replaces* the courier's whole group list with only `cell`, silently
removing every other group they had. People make this mistake
weekly, on real boxes. Type the `-a`.

Confirm with `id courier` afterward — `cell` should now appear in
the list. Looking, not remembering.

<details>
<summary>&gt; ping handler</summary>

You ran something and you're not sure it took. Good instinct — now
stop being unsure: `id courier` is the receipt, before and after.
And if you're hesitating over the flag: the warning in your orders
is the entire trap, spelled out. Append adds. Bare replace erases.
You want the one that adds.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`usermod` changes an account. `-aG` is two flags working together:
`-G` names a group, `-a` says append it to the existing list. Then
`id courier` — the group list at the end of that line is the only
proof that counts.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
id courier
usermod -aG cell courier
id courier
```

Compare the two `id` outputs: `cell` appears, nothing else changed.
Say the flag back: `-aG` adds, `-G` alone replaces. Last time I
explain it.

</details>
