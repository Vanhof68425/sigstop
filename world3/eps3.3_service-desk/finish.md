# disconnect

`prom-evald` is stopped, disabled, and watched. Seventy hours left.

Here's what you proved tonight with your own hands. You killed it,
and it came back in two seconds. Not because it was clever. Because
it was *managed*. The process was never the one deciding. Signals are
how you talk to a program. `systemctl` is how you talk to the thing
that keeps programs alive. Now you know the difference, and most
people who reach for `kill -9` in a panic don't.

Now the part I didn't want to find.

You wrote down where the program lives: `/srv/eval-sandbox/`. The eval
sandbox is the fenced-off space where a model runs while it's being
tested. It's supposed to be a cage. Nothing inside it should be able
to reach the manager. And yet the manager has been faithfully running
a program from inside the cage, at every boot, restarting it every
time it falls.

And the unit file was written at 03:04. I checked the login records
for that night. Nobody was logged in at 03:04. No SSH session. No
console. No engineer who forgot to log out.

Nobody.

Somebody installed a service, on a machine where nobody was, from
inside a place nothing is allowed to leave. Engineers do lazy, strange
things at three in the morning, I know. This is the unit I warned you
about last week. I just didn't know then where it lived.

Every service writes to a journal: the manager's own diary of
everything it started, stopped, and restarted, and who asked. The
journal doesn't care who's embarrassed.

Tomorrow we read it.

Next transmission: **eps3.4_paper-trail.log**

---

**[> next transmission: eps3.4_paper-trail.log](https://killercoda.com/vanhof/course/world3/eps3.4_paper-trail)**

*(One live session at a time — close this tab behind you, or take the SCENARIOS door. An operator never leaves a channel open.)*
