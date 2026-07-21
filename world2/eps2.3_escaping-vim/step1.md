The drop:

```
/var/sigstop/drop/
```

Three things live there. Two are visible: `transmission_07.msg` (the
source's message) and `reply.draft` (my two sentences). The third
thing is the corpse. My session died with the draft open, and vim
keeps its working copy in a hidden swap file beside the original.
Until that body is gone, every visit to the draft starts with vim
asking you about it.

> **Tonight's tools**
> `ls -la <dir>` — list a directory, including hidden files (you learned this in World 1)
> `rm <file>` — delete one file, permanently
> A swap file is vim's working copy of a file being edited. It is named `.<filename>.swp` and hidden. A leftover one means a session ended badly.

**This step: clear the corpse.**

1. List the drop with `ls -la` and find the hidden swap file.
2. Look at it if you want — `cat` will show garbage with a few
   readable fragments. That's what a dead session leaves.
3. Remove it with `rm`. My session saved before it died; the swap
   holds nothing we need.

If you open `reply.draft` in vim before the swap is gone, vim shows
a warning screen instead of the file. That screen is not an error —
it lists lettered options at the bottom, and one of them,
`(D)elete it`, removes the swap for you. Either path works.

<details>
<summary>&gt; ping handler</summary>

The warning screen you're afraid of: read it. All of it. vim isn't
broken. vim is telling you someone was here before you and didn't
leave properly — you already know that story — and the bottom of
that screen is a list of everything you're allowed to do about it.
And if you can't *find* the corpse: hidden files don't show up
unless you ask for all of them. You've asked before.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`ls -la /var/sigstop/drop` shows the hidden resident — swap files
wear the name of their original: `.reply.draft.swp`. Remove it the
way you've removed condemned files before, or open the draft in vim
and press the letter for delete when the recovery screen offers it.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
ls -la /var/sigstop/drop
rm /var/sigstop/drop/.reply.draft.swp
ls -la /var/sigstop/drop
```

The second listing proves the corpse is gone. Swap files are named
`.<filename>.swp` and live beside their original. Say it back, then
move on. Last time I explain this one.

</details>
