The damage report, verbatim from the lockdown's dying log:

```
[lockdown // partial // 02:53:41]
 sealed: /var/sigstop/vault          (mode 000, owners scrambled)
 seeded: apx calling cards (*.trk)   (vault + intake, nested)
 reverted: /etc/sigstop/relay.conf   (endpoint rollback, pre-breach)
 granted: /etc/sudoers.d/lockdown    (emergency key, NOT revoked)
 captured: /var/sigstop/intake/scan.log  (their chatter, unprocessed)
 pending: the burn                   (courier waiting)
[log ends]
```

Operational spec — the state this box is in at dawn:

- **The vault lives again.** `/var/sigstop/vault`: directory owned
  `courier:cell` at `750`; every file inside owned `courier:cell`
  at `640`. Every file — including any you create tonight.
- **Every calling card dies.** No `.trk` survives anywhere under
  `/var/sigstop`. Every piece of evidence survives. Both sentences
  are true at dawn.
- **The relay tells no strangers.** The config speaks to
  `drop.sigstop.net` and nothing else. You have fixed this exact
  line before. It stays fixed.
- **Their chatter, distilled.** Every `[counter //` line from the
  scan log, routed into `/var/sigstop/vault/counterscan.extract` —
  their scan pattern is intelligence, and it belongs in the vault,
  which means it follows vault rules. Nothing else rides along.
- **The emergency key is revoked.** The lockdown grant is removed
  from the ledger, and the ledger still parses.
- **The burn runs.** As the courier, through the standing grant.
  The receipt names them. That's the signal the courier's watcher
  is waiting for.

Then CHECK — but you'll know before you ask.

<details>
<summary>&gt; ping handler</summary>

Breathe. Count the layers, out loud if you have to: who owns it,
what the switches say, who may borrow, what flows where, what dies.
Five questions, and every fault on this box is an answer to exactly
one of them. You're not facing anything new — you're facing
everything old, wearing each other's coats. Start with the vault:
you can't stamp, lock, or fill a room you haven't reopened. And
before anything dies tonight, you look at it. You know why.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

In dependency order, tools only: the door opens with `chmod`, the
stamps with `chown -R`, the file switches with `chmod` again —
directory and contents are different numbers, you know them. The
cards: `find` with a name pattern to *see* them all first, then
delete what you saw — one of them is nested beside evidence, so no
flattening. The config: an editor, one line, and you've held that
scalpel twice. The extract: `grep -F` and an arrow, then remember
the extract is now a vault file and vault rules apply to it. The
key: `rm` in the ledger directory, then the proofreader. The burn:
cross the room first. The receipt tells you if you crossed it right.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

No. This is the job. Everything you need, you already have. Scroll
up through your own history — that's not cheating, that's what
operators do.

</details>
