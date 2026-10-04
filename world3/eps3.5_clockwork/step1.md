Read the schedules before you touch any of them.

> **Tonight's tools**
> `cat /etc/crontab` — the system-wide schedule
> `ls /etc/cron.d` — the folder of extra schedule files; `cat` any of them
> `crontab -l` — show *your* private schedule (you are root)
> `crontab -u <user> -l` — show another user's private schedule. Only root can do this.
> A line that starts with `#` is a note. Cron skips it.

**How to read one line.** Every schedule line starts with five fields,
then the command:

```
minute  hour  day-of-month  month  day-of-week   command
```

A `*` means "every". So:

- `*/5 * * * *` means every 5 minutes, all day, every day.
- `30 2 * * *` means 02:30, every day.
- `@reboot` replaces all five fields and means: once, when the machine starts.

In `/etc/crontab` and files in `/etc/cron.d`, there's one extra field
after the five: the user the command runs as. Private crontabs don't
have it. They always run as their owner.

**Worked example first.** Facilities samples the rack's power with
cron. Read it:

```
ls /etc/cron.d
cat /etc/cron.d/node07-power
```

`*/5 * * * * root ...`: every five minutes, as root, add one line to
the power log you read last time.

**This step: find the schedule that brings `prom-evald` back.**

1. Read the shared schedules: `cat /etc/crontab`, then `ls /etc/cron.d`
   and `cat` what's there.
2. Read root's private schedule: `crontab -l`. It may say there isn't
   one.
3. Read the harness's private schedule: `crontab -u harness -l`.
4. Save the harness's whole schedule, notes included, into
   `/root/clock.txt`:
   `crontab -u harness -l > /root/clock.txt`
5. Read every line of it. The notes too. Especially the notes.

Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You read the system schedule, found nothing about `prom-evald`, and
decided there's no clock. That's how Apex audited this node in May.
The shared lists are the ones everyone can see. The thing you're
looking for was never going to be where everyone can see it.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

Private crontabs are per user, and as root you can read anyone's with
`crontab -u <user> -l`. You already know which account did the
installing last night. Ask for its schedule, then send the same output
into `/root/clock.txt` with `>`.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
cat /etc/crontab
ls /etc/cron.d
crontab -l
crontab -u harness -l
crontab -u harness -l > /root/clock.txt
cat /root/clock.txt
```

`@reboot`, and `4 3 * * *`: at boot, and every night at 03:04. Now
read the four notes above those lines again, slowly. Say it back:
there's the system list, the cron.d folder, and one private list per
user, and the private ones are where nobody looks. Last time I
explain it.

</details>
