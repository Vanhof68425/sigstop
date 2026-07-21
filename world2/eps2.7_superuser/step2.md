You've read the ledger. Now it gets one line shorter.

> **Tonight's tools**
> `rm <file>` — delete one file, permanently (eps2.1 rules apply: look, confirm, then fire once)
> `ls -l <dir>` — the receipt, before and after

**This step: remove the skeleton key. Keep the courier grant.**

1. Look again at what you're aiming at:
   `ls -l /etc/sudoers.d/` — two files. The vendor file with the
   `ALL` grant is the target. The courier file is not.
2. `rm` the vendor file, by full path, typed carefully.
3. `ls -l /etc/sudoers.d/` again — one file left, and it's the
   courier's.

If you removed the wrong file, stop and say so at the next hint —
do not try to retype a sudoers file from memory.

<details>
<summary>&gt; ping handler</summary>

This is a deletion, so it's an eps2.1 problem wearing new clothes:
you already know the ritual. See the target. Confirm it's the one
with `ALL` in it — `cat` it once more if there's any doubt in your
hands. Then one `rm`, one file, and the listing afterward is your
receipt.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`rm /etc/sudoers.d/` plus the vendor file's name — you read it in
step 1. Then `ls -l /etc/sudoers.d/` and count: one file, named
courier. The grant you kept is the narrow one. That's the whole
step.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
cat /etc/sudoers.d/apex-compat
rm /etc/sudoers.d/apex-compat
ls -l /etc/sudoers.d/
```

Read it, remove it, confirm what remains. One narrow grant left.
Say it back: `ALL` is an abdication, and the fix was one careful
`rm`. Last time I explain it.

</details>
