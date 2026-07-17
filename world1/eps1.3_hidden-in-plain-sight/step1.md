The workstations:

```
/var/apex-mirror/workstations/
```

Four engineers. Four home-directory snapshots. One buried delivery.

Sweep them. Every directory has more in it than `ls` admits — dotfiles,
config folders, the usual paperwork. Most of it is exactly as boring as
it looks. Learn to tell the paperwork from the anomaly: `.bashrc` in a
home directory is furniture. A dot-directory with a name you can't
explain is a lead.

Somewhere in one of them is our contact's delivery. Inside it, the
codeword. You know what to do with a codeword.

<details>
<summary>&gt; ping handler</summary>

You listed a directory, saw three files, and moved on. That's a summary,
not a sweep. Every one of these homes has hidden entries — the machine's
own paperwork guarantees it. Show *everything* in each workstation,
then ask of each dotted name: can I explain why this exists? The one
you can't explain is the one you want.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`ls -a` shows all entries, dots included. `ls -la` shows them with
detail — and the leading `d` in the detail column tells you which
entries are directories you can walk into. Sweep all four workstations
with it. Expect `.bashrc`, `.profile`, `.config` everywhere — furniture.
You're looking for the dot-name that doesn't belong in an engineer's
home. When you find it: it's a directory. Enter. Read.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
cd /var/apex-mirror/workstations
ls
ls -la okafor_c
ls -la reyes_m
ls -la tanaka_h
ls -la volkov_a
```

One of those listings shows a dot-directory that isn't standard
paperwork. `cd` into it, `ls -la` again, `cat` what you find, then home
and `touch` the codeword. And notice what you just did: four
directories, thirty seconds, nothing escaped you. That's what `-a`
buys. Last time I explain it.

</details>
