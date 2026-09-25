The last worker is `prom-guardian`. Its log is
`/var/log/apex/guardian.log`. Its only job seems to be watching the
other two.

Try the polite way first. Always.

> **Tonight's tools**
> `kill -9 <PID>` — force a process to end immediately. This sends KILL. It cannot be refused, ignored, or delayed.
> Use it last. The process gets no chance to save or clean up anything.
> `kill <PID>` — the polite request (step 2)

**First try: ask it.**

```
ps aux | grep prom-guardian
kill <its PID>
```

Wait a few seconds. Then look:

```
ps aux | grep prom-guardian
tail -n 3 /var/log/apex/guardian.log
```

Still there. Its own log tells you why: it heard the request and
chose to ignore it. Somebody wrote a program whose one feature is not
listening.

TERM is a request, and requests can be refused. KILL is not a
request.

**This step: end the guardian.**

1. End `prom-guardian` with `kill -9`.
2. Check with `ps aux | grep prom-guardian` that it's gone.

Leave the copier frozen. Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You sent the polite signal again and it's still there. That's not a
typo on your end. It's a design decision on theirs. You can ask a
thousand times. Stop asking. There's a signal that doesn't go to the
process at all. It goes to the kernel, and the kernel doesn't
negotiate.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`kill -9` followed by the guardian's PID. The 9 is the number of the
KILL signal. Then check with `ps aux | grep prom-guardian`: only your
grep line should be left. Make sure you use the guardian's PID, not
the copier's. The copier stays frozen.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
ps aux | grep prom-guardian
kill -9 <its PID>
ps aux | grep prom-guardian
```

Gone. Now you know both signals that nothing can refuse. KILL ends a
thing. STOP holds it. Say back which one leaves you a choice. Last
time I explain these.

</details>
