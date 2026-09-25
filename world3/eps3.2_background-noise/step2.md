The source's drop is locked. `sigstop-decrypt` opens it. It works
for about 20 seconds, then asks for this session's passphrase.

The catch: the passphrase changes every time the decrypt starts. The
decrypt writes it to `/tmp/sigstop-session.txt` *when it starts*. So
you can't read it beforehand. You have to start the decrypt, get
your prompt back, read the file, and then return to the decrypt to
answer it.

This time you'll start it the normal way, in the foreground, and move
it by hand.

> **Tonight's tools**
> `Ctrl+Z` — pause the job that's holding your terminal. Your prompt comes back. The job shows as Stopped.
> `bg` — let the paused job keep running, in the background
> `fg` — bring the job back to the front, so you can type to it
> `jobs` — see your jobs and their state (step 1)

Ctrl+Z sends a signal too. It's a cousin of SIGSTOP, the pause you
learned last night. The difference is that this one is polite enough
to be undone by `bg` or `fg`.

**Worked example first.** Start a sleep in the foreground:

```
sleep 20
```

Your terminal is held. Press **Ctrl+Z**. It says `Stopped` and your
prompt is back. Now:

```
jobs
bg
jobs
fg
```

`jobs` showed `Stopped`, then `bg` made it `Running` in the
background, then `fg` brought it back to the front. Wait for it to
finish and your prompt returns.

**This step: open the drop.**

1. Run `sigstop-decrypt` (no `&`).
2. Press **Ctrl+Z**. Then `bg` to keep it working in the background.
3. Read the passphrase: `cat /tmp/sigstop-session.txt`
4. Bring the decrypt back with `fg`.
5. When it asks, type the passphrase and press Enter.

Two things that look like problems but aren't:

- After `bg`, `jobs` may show the decrypt as `Stopped` again. That's
  normal. It finished working, reached its question, and is waiting
  for you to bring it to the front with `fg`.
- If the decrypt is already waiting when you `fg` it, the question
  won't be printed again. Just type the passphrase and press Enter.

Then read the drop: `cat /root/drop09.txt`. Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You're sitting in front of a held terminal, waiting for the decrypt
to finish so you can go look up the passphrase. It won't finish
without the passphrase. That's a deadlock, and you built it by
waiting. Don't wait. Take your terminal back without ending the job.
You practiced the key on a `sleep`.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

Ctrl+Z pauses the decrypt and returns your prompt. `bg` lets it keep
working. `cat /tmp/sigstop-session.txt` shows the passphrase for *this*
run. `fg` brings the decrypt back so it can hear you. If it shows
`Stopped` again after `bg`, it's ready for its answer and waiting to
be brought to the front. `fg`, type, Enter. A wrong answer means starting over, and the
passphrase changes.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
sigstop-decrypt
```

Press Ctrl+Z, then:

```
bg
cat /tmp/sigstop-session.txt
fg
```

Type the passphrase you just read, press Enter, then
`cat /root/drop09.txt`. Say it back: Ctrl+Z pauses, `bg` sends to
the back, `fg` brings to the front. Last time I explain these.

</details>
