# disconnect

Sixty-nine hours. And one line I can't stop reading.

```
harness : TTY=unknown ; PWD=/srv/eval-sandbox/run ; USER=root ; COMMAND=/usr/bin/install ... prom-evald.service
```

Read it with me. Slowly. I had to.

`harness`: the automated account. Nobody logs in as it. Nobody can.
`TTY=unknown`: no terminal. No keyboard. No hands. `PWD`: when it
asked for root, it was standing inside the eval sandbox, the place
that's supposed to be a cage. `COMMAND`: it wrote the unit file back
into the manager's folder. Then two more lines: reload, enable, start.
It didn't break out of anything. It asked politely, three times, and
the machine said yes three times, because somebody told the machine
to say yes.

That somebody is in `/etc/sudoers.d/90-eval-harness`. Read it if you
want. A ticket number. "Temporary." Approved in May. Review: never
scheduled. You learned to fear `ALL`. This is worse. This is a human
who sat down and gave an automated account *exactly enough*, the right
to install a service and start it as root, so the pipeline could
"manage itself," and then closed the ticket and went to lunch, and
nobody has opened that file since, because the whole industry runs on
permissions granted for a sprint and kept for a lifetime.

Then I went back twelve days. Apex ships its old auth logs off the
node, and they forgot one: `/var/log/apex/auth.log.1`. The last human
on node 07 that week was `tanaka_h`, logged out at 19:41. Then
nothing. Then 03:04:01. The same three lines. The same folder. The
same account.

Last time I told you engineers do lazy, strange things at three in
the morning. I wanted that to be true. I'm not going to pretend my
hands are steady right now. They aren't.

Now look at the seconds. 03:04:01, twelve days ago. Tonight, in your
journal: `:01` again. People don't press enter on the first second of
a minute, twice, twelve days apart. Clocks do.

The harness is only the hand. Something on this node keeps a
schedule, and the schedule moves the hand.

Tomorrow we find the clock.

Close the session when you're done. Not for the job. I'd just rather
you weren't on that node alone any longer than you have to be.

Next transmission: **eps3.5_clockwork.cron**

---

**[> next transmission: eps3.5_clockwork.cron](https://killercoda.com/vanhof/course/world3/eps3.5_clockwork)**

*(One live session at a time — close this tab behind you, or take the SCENARIOS door. An operator never leaves a channel open.)*
