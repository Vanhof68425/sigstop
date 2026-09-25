You know how to end a process. So end this one, and watch.

> **Tonight's tools**
> `systemctl stop <name>` — tell the manager to stop a service. The manager won't restart what it was told to stop.
> `systemctl start <name>` — tell the manager to start it again
> `kill <PID>` — ask a process to end (eps3.1)

**Worked example first.** Kill the metronome the old way:

```
systemctl status metronome
kill <metronome's Main PID>
```

Wait three seconds, then:

```
systemctl status metronome
```

It's running again, with a **new** Main PID. The unit says
`Restart=always`, so the manager saw it die and started it again.
Your `kill` reached the process. It never reached the manager.

Now do it the right way:

```
systemctl stop metronome
systemctl status metronome
```

`Active: inactive (dead)`. Wait as long as you like. It stays down,
because this time you told the manager, and the manager listens to
you. Start it again so it's back the way you found it:

```
systemctl start metronome
```

**This step: stop `prom-evald`.**

1. Kill its Main PID with `kill`, once. Wait three seconds. Check
   `systemctl status prom-evald`. See it come back with a new PID. I
   want you to see this with your own eyes, on their service.
2. Now stop it properly: `systemctl stop prom-evald`.
3. Check: `systemctl status prom-evald` must say `inactive (dead)`.

Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You're killing it again and again, faster, like speed will win. It
won't. You're arguing with the process, and the process was never
the one deciding. Somebody above it keeps pressing "start." Stop
talking to the program. Talk to the one who keeps restarting it.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`systemctl stop prom-evald`. That's a request to the manager, not a
signal to the process. The manager stops the program and marks it as
intentionally stopped, so `Restart=always` no longer applies. Confirm
with `systemctl status prom-evald`. The Active line should read
`inactive (dead)`.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
systemctl status prom-evald
kill <its Main PID>
systemctl status prom-evald
systemctl stop prom-evald
systemctl status prom-evald
```

The first kill bought you nothing: new PID, two seconds later. The
stop is the one that holds. Say it back: for a service, you don't
kill the process, you tell the manager. Last time I explain it.

</details>
