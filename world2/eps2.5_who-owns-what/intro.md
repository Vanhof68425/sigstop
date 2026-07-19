# eps2.5_who-owns-what.grp

There's a second account on the box tonight. `courier`. Before you
trust it, look at it — `id courier` — and notice that I said *look*,
not *ask*. Asking gets you a story. Looking gets you a record. The
courier moves evidence off this network, on foot, and knows nothing
worth extracting: not your callsign, not the source, not what's in
the files. That's not me being cold. Compartments are how everyone
in them stays alive.

Tonight you learn the column nobody reads.

Run `ls -l` anywhere and it's been there since your first night:
every file on a Linux box carries two names — an owner and a group —
stamped into it, updated by the kernel, displayed forty times a day
to people who have trained themselves not to see it. The most
honest testimony a box gives, and the least read. Apex has forensics
staff whose whole career is that column. Now so do you.

The doctrine: **ownership is testimony.** A file owned by the wrong
account tells a story to whoever finds it — who made this, who
touched this, who was *here*. If the courier is stopped and searched,
every file in the handoff has to answer to the courier's name and no
other. A single file owned by root is a confession with a timestamp.

Groups are the other half. A group is a room: put accounts in the
room and the room can share what the individuals can't. Ours is
called `cell`. Small, by design. You change the stamp with `chown` —
change owner — and you'll notice, when you meet it, that it changes
groups too, because the two names travel together.

One more thing. There's a file in the handoff that answers to a
*number* instead of a name. That happens when an account is deleted
and its files stay behind — the box keeps pointing at where a person
used to be, forever, because the box doesn't understand that people
end. You'll fix the stamp. The pointing stops. That's as close to
closure as filesystems offer, and some nights I think it's more than
the rest of us get.

Read the column. Fill the room. Hand it over.

Click **START**.
