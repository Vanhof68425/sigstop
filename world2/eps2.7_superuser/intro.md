# eps2.7_superuser.sudo

Confession first. You've been root since the night you typed
`whoami` and the box told you who you were. Every lock you've set,
every switch you've flipped — you did it as the one account the
switches don't apply to. Root doesn't open doors. Root is weather.
It goes through 000 the way rain goes through a chain-link fence,
and I let you soak in it for seven weeks because a person who learns
locks *before* learning the thing that ignores locks understands
what they're actually for.

Now the doctrine, and it's short: **nobody operates as root.**

Not because root is powerful. Because root is *unaccountable*. A
root session has no edges — every mistake it makes is a mistake
made everywhere at once, and you've read one session log that shows
exactly how big everywhere is. The collective runs on the least
identity that does the job, and when a job genuinely needs root, we
borrow it. One command wide. Logged. Returned.

The borrowing tool is `sudo`, and its ledger lives in
`/etc/sudoers` and the drop-in files under `/etc/sudoers.d/`. A
line in that ledger is a promise about the future: *this account
may run that command as root, and nothing else.* Read one and
you'll see the grammar — who, from where, as whom, which commands.
The width of the last field is the width of the hole in your box.

Which is why sudo is feared correctly, and here's the fear: the
word `ALL` in the commands field. `ALL` isn't a grant, it's an
abdication — root with extra steps and a false sense of paperwork.
Every vendor package that ships a convenience account with
`NOPASSWD: ALL`, every deploy script that "just needs" it, every
engineer who was going to scope it down after launch — that's the
industry's actual security posture, thousands of skeleton keys
under thousands of doormats, and the postmortems all use the
passive voice about how the attacker "obtained elevated privilege"
as if the ledger hadn't been holding the door.

Tonight there are two grants on this box. One is mine: narrow,
boring, correct. The other came with the relay vendor package, and
it is exactly what I just taught you to fear.

The courier's bag is locked, stamped, and waiting on one last
ritual: the burn. It needs root for four seconds. The courier will
borrow it — through my grant, not theirs.

Kill the key. Cross the room. Run the burn.

Click **START**.
