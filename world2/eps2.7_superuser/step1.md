The ledger:

```
/etc/sudoers.d/
```

Two drop-in files. Read both before touching either — `cat` works,
this is reading, not editing. One grants the courier exactly one
command. The other grants a vendor account everything, forever, no
password. You know which one dies.

Orders:

1. **Kill the skeleton key.** The vendor grant — the whole file —
   gets removed. This is a deletion, so it's an eps2.1 problem:
   look at what you're aiming at, confirm it's the right file, then
   fire once. Afterward, run `visudo -c`. It proofreads the whole
   ledger and says whether what remains is valid — the ritual after
   *any* change in that directory, no exceptions, because a broken
   ledger locks everyone out of borrowing at exactly the wrong
   moment.
2. **Cross the room.** `su - courier` — you're now the courier, and
   the weather stops. Try to read the sealed door or the burn
   receipt directory if you want to feel it. Denied is the correct
   experience. Remember it: that's what everyone who isn't you sees.
3. **Run the burn.** As the courier, borrow root for four seconds
   through my grant and run `/usr/local/bin/relay-burn`. Then
   `exit` — you return the borrowed identity the moment the job is
   done, the same way you return borrowed root.

The receipt has to name the courier. If it names anyone else, the
ledger tells the wrong story, and stories in that ledger get people
burned for real.

Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You're doing the burn as root, aren't you — or you're still root
*pretending* the grant matters, and the receipt is about to say so.
The weather doesn't borrow; the weather just rains. The whole point
of tonight is standing where the courier stands: an account the
locks apply to, holding one narrow permission. Become them. Then
borrow. And if you removed a file from the ledger and didn't run
the proofreader afterward, you don't know what state the ledger is
in. You believe. Operators don't believe.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`rm` the vendor drop-in — the filename tells you which one; read
both first. `visudo -c` validates the ledger. `su - courier`
switches you to the courier's identity (the `-` gives you their
real environment). As courier: `sudo` in front of the burn command
runs it as root — the grant in my drop-in is what makes that legal,
and *only* for that one path. `exit` returns you. Confirm the
receipt from your own seat: it lives under `/var/sigstop/burn/`,
and the name on it is the test.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
cat /etc/sudoers.d/courier /etc/sudoers.d/apex-compat
rm /etc/sudoers.d/apex-compat
visudo -c
su - courier
sudo /usr/local/bin/relay-burn
exit
cat /var/sigstop/burn/receipt.log
```

The receipt says `burned by: courier` — the borrow worked, the
ledger is one narrow line, and the skeleton key is out from under
the doormat. Say the fear back to me: the width of the commands
field is the width of the hole. `ALL` is an abdication. `visudo -c`
after every change. Last time I explain borrowed power.

</details>
