# eps3.5_clockwork.cron

Sixty-eight hours.

You asked me last night where the clock was. I told you I didn't
know. That was true then.

Here's what I know now. Every Linux machine has a clock that runs
commands for you while you sleep. It's called **cron**. It's older
than most of the people who rely on it. It wakes up once a minute,
reads a short list of schedules, and runs whatever is due. It never
asks who wrote the list. It never asks why. It's the most obedient
thing on any machine, and that makes it the most useful thing on any
machine, and the most dangerous thing on any machine, depending only
on whose list it's reading.

The lists are called **crontabs**. There's one for the whole system.
There's a folder of extra ones that packages drop in. And every user
on the box can have a private one, which nobody else ever sees unless
they go and look on purpose.

Nobody goes and looks on purpose. That's the whole trick.

Cron always starts a job at the top of a minute, a second after the
minute turns, give or take. You remember the seconds.

Tonight we read the lists. All of them. Including the one that
belongs to an account nobody logs into.

Click **START**.
