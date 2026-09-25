Before we open the drop, we tell the source we're here. That means
leaving a mark on the wire. A mark on a quiet wire gets noticed. So
first we make noise: `sigstop-sweep` fills the wire with harmless
traffic for about 40 seconds. The mark has to go out *while* the
sweep is running, hidden inside the noise.

If you start the sweep the normal way, it holds your terminal for 40
seconds, and by the time your prompt comes back the noise is over.
You need your prompt back *while it runs*.

> **Tonight's tools**
> `<command> &` — start a command in the background. You get your prompt back right away.
> `jobs` — list the jobs you started from this shell, and whether each is Running or Stopped

**Worked example first.** `sleep` is a command that just waits.
Start one in the background:

```
sleep 15 &
jobs
```

`&` printed a job number like `[1]` and gave your prompt back. `jobs`
shows it as `Running`. You can type other commands while it waits.
Try `date`. When the sleep finishes, your shell tells you: `Done`.

One more thing to see. The copier from last night is still frozen on
this box. Run `ps aux | grep prom-ckpt-copy`: it's there, STAT `T`.
But it's not in `jobs`. `jobs` only lists what *your* shell started.
`ps` shows everything on the machine.

**This step: hide a mark in the noise.**

1. Start the sweep in the background: `sigstop-sweep &`
2. Check it with `jobs`. It should say `Running`.
3. While it runs, send the mark: `sigstop-mark`
4. Wait for the sweep to finish. Your shell will say `Done`.

Then CHECK.

If the mark refuses, the sweep wasn't running. Start the sweep again
with `&` and send the mark right after.

<details>
<summary>&gt; ping handler</summary>

You ran the sweep, sat through forty seconds of nothing, and then the
mark told you there was no noise to hide in. Of course it did. You
waited for the cover to end before you moved. You need the sweep
running and your hands free at the same time. There's one character
that does that.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

Put `&` at the end of the sweep command: `sigstop-sweep &`. The
prompt comes back immediately and the sweep keeps running behind it.
`jobs` confirms `Running`. Then run `sigstop-mark` right away, well
inside the 40 seconds.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
sigstop-sweep &
jobs
sigstop-mark
```

Then wait for `Done`. Say it back: `&` means "start it, but give me
my prompt back." Last time I explain it.

</details>
