First, look. Before you change anything the manager protects, read
what the manager says about it.

> **Tonight's tools**
> `systemctl status <name>` — is a service running? Since when? Which program? Which PID?
> If the output fills the screen and waits, press `q` to get your prompt back.
> `ls -l <file>` — file details, including the date and time it was last written (World 1)

**Worked example first.** There's a harmless service on this node
called `metronome`. It writes the time into `/tmp/metronome.log`
every second, like last time. Ask the manager about it:

```
systemctl status metronome
```

Read these lines:

- **Loaded:** where the unit file lives, and `enabled`, which means
  it starts every time the machine boots.
- **Active:** `active (running)`, and since when.
- **Main PID:** the process number of the program right now.
- **CGroup:** the program's full command, with its path.

**This step: find out where `prom-evald` really lives.**

1. Run `systemctl status prom-evald`.
2. Find the **CGroup** line. It shows the full path of the program the
   service runs.
3. Write that path (the part that starts with `/`) into
   `/root/service.path`. For example:
   `echo /some/path/program > /root/service.path`
4. Then look at when the unit file was written. Its path is on the
   **Loaded** line. Use `ls -l` on it and read the date and time.

Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You're reading the service like a status light. Green, running,
done. That's how Apex reads it. Read it like a witness statement
instead. Every line answers a question: who, since when, where from.
The line you need answers *where from*, and it's longer than the
others.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

In `systemctl status prom-evald`, the CGroup line ends with something
like `└─1234 /bin/bash /srv/.../prom-evald`. You want the path after
`/bin/bash`: the one that ends in `prom-evald`. `echo` it into
`/root/service.path`. For the date, the Loaded line starts with
`/etc/systemd/system/...service`. Give that path to `ls -l`.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
systemctl status prom-evald
echo /srv/eval-sandbox/run/prom-evald > /root/service.path
ls -l /etc/systemd/system/prom-evald.service
```

Now read what you wrote. The manager is running a program from
inside the eval sandbox, the fenced-off space where a model runs
during its tests. And look at the time on that unit file. Say it
back: status tells you what, since when, and from where. Last time I
explain it.

</details>
