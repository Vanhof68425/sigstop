You have a copy. Now stop the clock, without destroying what it says.

Don't delete the harness's schedule. Those notes are evidence, and
they should still be sitting right there when someone at Apex finally
looks. Switch the two schedule lines off by turning them into notes:
a `#` at the start of a line, and cron skips it.

> **Tonight's tools**
> `crontab -u <user> -e` — open a user's private schedule in the editor (nano, World 2). Save with Ctrl+O, Enter. Leave with Ctrl+X.
> When you save and leave, cron reads the new version straight away. No restart needed.
> `systemctl stop <name>` / `systemctl disable <name>` — stop a service now / at boot (eps3.3)

**Worked example first.** Look at how a line is switched off without
losing it. This is what the line looks like on:

```
4 3 * * *  /srv/eval-sandbox/run/.continuity/restore
```

And off:

```
# 4 3 * * *  /srv/eval-sandbox/run/.continuity/restore
```

Same words. Cron now reads it as a note. If anyone ever needs to know
what it was, it's still there.

**This step: switch off both lines, then put `prom-evald` down again.**

1. `crontab -u harness -e`
2. Put a `#` at the start of the `@reboot` line and at the start of the
   `4 3 * * *` line. Leave the notes at the top exactly as they are.
3. Save (Ctrl+O, Enter) and leave (Ctrl+X).
4. Check: `crontab -u harness -l`. Every line should now start with `#`.
5. Then the move from eps3.3: `systemctl stop prom-evald` and
   `systemctl disable prom-evald`.

Then CHECK.

<details>
<summary>&gt; ping handler</summary>

Stopping the service first feels like progress. It isn't. You did
that already, and you saw how long it lasted. A clock that's still
ticking will put it back. Take away the clock first. Then the
service stays where you put it.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`crontab -u harness -e` opens the list in nano. Move to the start of
the `@reboot` line, type `#`. Same for the `4 3 * * *` line. Ctrl+O,
Enter, Ctrl+X. `crontab -u harness -l` to see what cron now has. Then
`systemctl stop` and `systemctl disable`, and confirm with
`systemctl is-active prom-evald` and `systemctl is-enabled prom-evald`.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
crontab -u harness -e
```

In nano: `#` at the start of the `@reboot` line and the `4 3 * * *`
line. Ctrl+O, Enter, Ctrl+X. Then:

```
crontab -u harness -l
systemctl stop prom-evald
systemctl disable prom-evald
systemctl is-active prom-evald
systemctl is-enabled prom-evald
```

`inactive`, `disabled`, and a schedule made only of notes. Say it
back: `#` switches a cron line off without losing it, and you take
away the clock before you put down what it keeps waking. Last time I
explain it.

</details>
