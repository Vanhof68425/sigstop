Three locks tonight. Work them in any order — except the door. The
door is last, and it closes behind you.

**Lock one — the handoff.** `/var/sigstop/handoff` is stamped
courier:cell from last night, but the switches are wide open —
anyone on the box can read the bag. Set them: the directory `750`,
every file inside `640`. Courier owns, the cell reads, strangers
starve.

**Lock two — the tool.** `/usr/local/bin/relay-burn` arrived with
the relay rebuild. It's the burn ritual for completed handoffs —
you'll run it soon, but not tonight. Right now the box considers it
a text file. Flip the one switch that makes it a tool.

**Lock three — the door.**

```
/opt/apex
```

Open it: give the owner full powers and no one else anything. Go
inside. Read `deploy_gate.conf`. The gate names the safety-shim's
mode — leave that mode word as an empty file in `/root`, spelled
exactly as the gate spells it. The way you've left codewords before.

Then seal the door. `000`. Everyone starves again, including you.
The mirror isn't for visiting. Tonight was the exception that
teaches the rule.

Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You're staring at nine letters like they're a password. They're
switches: read them in threes — owner's three, group's three,
everyone's three — and each position is either a power or a dash.
Now stop reading and start arithmetic: read 4, write 2, run 1. Add
the powers you want in each column and say the three digits out
loud. That's the entire skill. And the empty file in /root: you've
done this since World 1 — the tool that creates a file out of
nothing is the first tool you ever learned about making things.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`chmod 750` and `chmod 640` set whole rows by number — directory
gets the 750, files get the 640, and files means *each* file in the
handoff. `chmod +x` flips just the execute switch on the burn tool.
`chmod 700` opens the door for its owner alone; `chmod 000` seals
it for everyone. `ls -l` before and after every change — switches
lie to your memory, never to the listing. The gate file inside the
mirror reads like the relay config did: `key=value`. The value is
your codeword, spelled exactly, `touch`ed into /root.

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
ls -l /var/sigstop/handoff /usr/local/bin/relay-burn
ls -ld /opt/apex
```

The gate says `safety_shim=report_only`, and now there's a file in
your home spelled exactly that way — proof you stood inside the
mirror and read the line this whole war is about. Say the numbers
back: 4 read, 2 write, 1 run. 750 the room, 640 the papers, 000 the
wound. Last time I explain the switches.

</details>
