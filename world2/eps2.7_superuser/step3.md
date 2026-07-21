The ledger is short. Prove it's still sound, then use it the way
it's meant to be used.

> **Tonight's tools**
> `visudo -c` — proofread the whole sudoers ledger; prints OK if it parses. Run it after ANY change in /etc/sudoers.d/. A broken ledger locks everyone out of borrowing.
> `su - <user>` — become another account (the `-` gives you their real environment)
> `sudo <command>` — run one command as root, if the ledger grants it to you
> `exit` — return to who you were

**This step: validate, then run the burn as the courier.**

1. `visudo -c` — read the output. It should end with "parsed OK".
   This is the ritual after any sudoers change, no exceptions.
2. `su - courier` — you are now the courier. The prompt changes.
   Root's weather stops here: try `cat /var/sigstop/burn/receipt.log`
   if you want to feel it. Denied is the correct experience — that's
   what everyone who isn't you sees.
3. `sudo /usr/local/bin/relay-burn` — the courier borrows root for
   exactly this command, because the ledger's one remaining grant
   says they may. The burn runs and writes its receipt.
4. `exit` — hand the courier's identity back.
5. Read the receipt from your own seat:
   `cat /var/sigstop/burn/receipt.log`

The receipt must say `burned by: courier`. If it names anyone else,
the wrong account did the borrowing — do it again from step 2, as
the courier.

Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You're doing the burn as root, aren't you — and the receipt is
about to say so. Root doesn't borrow; root just rains. The point of
tonight is standing where the courier stands: an account the locks
apply to, holding one narrow permission. Become them first. The
tools box has the order.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`visudo -c` first — the proofreader. Then `su - courier`, then
`sudo` in front of the burn tool's full path, then `exit`. The
receipt lives at `/var/sigstop/burn/receipt.log`, and the name on
it is the test: courier, not root.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
visudo -c
su - courier
sudo /usr/local/bin/relay-burn
exit
cat /var/sigstop/burn/receipt.log
```

`burned by: courier` — borrowed for four seconds, logged, returned.
Say the ritual back: `visudo -c` after every ledger change, borrow
as the least identity, `exit` the moment the job is done. Last
time I explain borrowed power.

</details>
