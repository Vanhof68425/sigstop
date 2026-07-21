Three locks tonight. Work them in any order — except the door. The
door is last, and it closes behind you.

> **Tonight's tools**
> `ls -l` — the nine letters before the names: owner's rwx, group's rwx, everyone's rwx. `r` read, `w` write, `x` run (on a directory: enter). A `-` means that power is off.
> `chmod <number> <target>` — set all nine switches at once. Per column: read = 4, write = 2, run = 1, add them up. `750` = owner everything, group read+enter, others nothing. `640` = owner read+write, group read, others nothing. `000` = nobody, not even the owner.
> `chmod +x <file>` — flip just the run switch on
> `touch <file>` — create an empty file (World 1)

**Worked example first.** Watch the switches move:

```
touch /root/probe.txt
ls -l /root/probe.txt
chmod 640 /root/probe.txt
ls -l /root/probe.txt
```

The letters at the start of the line changed to `-rw-r-----`:
owner reads and writes (`rw-`), group reads (`r--`), everyone else
starves (`---`). That's 640, spelled out. Every chmod you run
tonight, check the same way: `ls -l` before and after.

**Lock one — the handoff.** `/var/sigstop/handoff` is stamped
courier:cell from last night, but the switches are wide open —
anyone on the box can read the bag. Set them:

- the directory: `750`
- every file inside: `640`

The directory and the files are separate targets. `ls -l` the
directory's contents to check the files; `ls -ld` the directory to
check the directory itself.

**Lock two — the tool.** `/usr/local/bin/relay-burn` is the burn
ritual for completed handoffs — you'll run it in the next episode.
Right now the box considers it a text file. Flip its run switch on
with `chmod +x`.

**Lock three — the door.**

```
/opt/apex
```

In order:

1. Open it: `chmod 700 /opt/apex` — owner gets everything, no one
   else gets anything.
2. Read the file inside: `cat /opt/apex/deploy_gate.conf`
3. The gate names the safety-shim's mode on one line, written as
   `safety_shim=<mode>`. Create an empty file in `/root` named
   exactly that mode word — the way you've left codewords before.
4. Seal the door: `chmod 000 /opt/apex`. Everyone starves again,
   including you. Tonight was the exception that teaches the rule.

Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You're staring at nine letters like they're a password. They're
switches: read them in threes — owner's three, group's three,
everyone's three. The arithmetic is in your tools box, and the
worked example already showed you a 640. The other numbers work the
same way. And the mode word for the codeword file: it's the value
after the `=` sign, spelled exactly as the gate spells it.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`chmod 750` the handoff directory, `chmod 640` each file inside
(a `*` after the directory path reaches all of them at once).
`chmod +x` the burn tool. `chmod 700` the door, `cat` the gate
file, `touch` the mode word into `/root`, `chmod 000` the door.
`ls -l` after every move — switches lie to your memory, never to
the listing.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine. In order, and the order matters at the end.

```
chmod 750 /var/sigstop/handoff
chmod 640 /var/sigstop/handoff/*
chmod +x /usr/local/bin/relay-burn
chmod 700 /opt/apex
cat /opt/apex/deploy_gate.conf
touch /root/report_only
chmod 000 /opt/apex
ls -ld /var/sigstop/handoff /opt/apex
ls -l /var/sigstop/handoff /usr/local/bin/relay-burn
```

The gate says `safety_shim=report_only`, and now there's a file in
your home spelled exactly that way — proof you stood inside the
mirror and read the line this whole war is about. Say the numbers
back: 4 read, 2 write, 1 run. 750 the room, 640 the papers, 000
the wound. Last time I explain the switches.

</details>
