First: `cat /root/switch_final_session.log`. All of it. I'll wait.

---

Now the job. Apex found our staging cache — not us, the cache — and
seeded it with tracking beacons: files ending in `.trk`. Every hour
they exist, they phone home. The cache:

```
/var/sigstop/staging/
```

Your orders:

1. **Every `.trk` file dies.** All of them, wherever they nest.
2. **The `telemetry/` directory dies with them.** It's theirs, not ours.
3. **Every piece of evidence survives.** The vault mirror, the comms
   extract — all of it. Evidence files are marked inside; you'll know
   one when you read one.

There is **no backup** of this cache. I meant what I said. If evidence
dies tonight, it dies the way Switch's cache died — permanently, and
with a lesson attached that cost more than it taught.

The three laws apply. Especially the second one.

<details>
<summary>&gt; ping handler</summary>

You're about to do the fast thing, aren't you. The beacons are
everywhere so you want one big hammer, and the telemetry directory is
"theirs" so you want to flatten it unseen. Both instincts are Switch's
instincts. Slow down. You own two tools that show you *exactly* what
a pattern matches before anything is deleted — you learned them in
World 1. Aim first. And nobody said everything inside an enemy
directory is enemy property. Nobody said that.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

Preview the kill list: `find /var/sigstop/staging -name "*.trk"` —
that's every beacon, seen before touched. Delete what you saw:
`rm` with explicit paths, or per-directory globs you've `ls`'d first.
Beacons hide *inside* evidence directories too, so no flattening
those — pick the beacons out individually.

For `telemetry/`: `ls -la` it before anything. Read what's actually
in there. If something doesn't belong to Apex, `mv` it somewhere safe
in staging first. Only when the directory holds nothing but enemy
files: `rm -rf /var/sigstop/staging/telemetry` — typed carefully,
read twice, no trailing surprises.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine. But the order is the lesson, so keep the order.

```
find /var/sigstop/staging -name "*.trk"
ls -la /var/sigstop/staging/telemetry
mv /var/sigstop/staging/telemetry/4471_witness.stmt /var/sigstop/staging/
rm /var/sigstop/staging/apx_beacon_*.trk
rm /var/sigstop/staging/vault/apx_beacon_*.trk
rm -rf /var/sigstop/staging/telemetry
find /var/sigstop/staging -name "*.trk"
```

The second command is where you'd have found the witness statement —
one evidence file, misfiled inside enemy territory, which the fast
hammer would have erased forever. The last command is the habit that
closes every deletion: confirm the kill list is empty. Look at what
you did tonight versus what Switch did. Same tools. Different speed.
Last time I explain these.

</details>
