The drop:

```
/var/sigstop/drop/
```

Three things live there. Two are visible.

`transmission_07.msg` — the source's message. Read it first, and read
it *in the theater*: open it in vim, move through it, leave with
`:q!`. The original goes to the vault later, byte for byte, exactly
as it arrived. `:q!` is the only exit that guarantees you changed
nothing — which is why operators leave evidence rooms backwards, with
their hands visible.

`reply.draft` — my two sentences. You'll see where I stopped.

The third thing is the corpse. My session died with the draft open,
and vim keeps its working copy in a hidden swap file beside the
original. Until that body is gone, every visit to the draft starts
with vim asking you about it.

Orders:

1. **Clear the corpse.** You learned to see hidden files in World 1.
   A swap file is not the file — it's a dead session's memory of one,
   and my session saved before it died. Confirm the corpse is a
   corpse, then remove it. vim's warning screen will even offer to do
   it for you: that screen is not an error. It's a choice, with the
   options printed on it.
2. **Read the transmission.** In vim. Out with `:q!`.
3. **Finish the reply.** Open `reply.draft`, get into insert state,
   and add the ending the source asked for as the final line,
   exactly:

   ```
   we act.
   ```

   With the period. Precision is identity. Then command state, `:wq`,
   gone. My sentences stand as written — add the ending, nothing
   else.

Then CHECK. No codeword tonight. The reply is the signal.

<details>
<summary>&gt; ping handler</summary>

Which state are you in? You don't know, do you. You're typing words
that land as orders, or orders that land as words, and the screen is
doing exactly what you told it instead of what you meant. Stop
typing. `Esc` answers the question — it puts you in command state no
matter where you were. And that warning screen you're afraid of:
read it. All of it. vim isn't broken. vim is telling you someone was
here before you and didn't leave properly — you already know that
story — and the bottom of that screen is a list of everything you're
allowed to do about it.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`ls -la` shows the drop's hidden resident. Swap files wear the name
of their original: `.reply.draft.swp`. Remove it the way you've
removed condemned files before — or open the draft and let vim's
recovery screen handle it; one of the lettered options deletes the
swap for you. Then: `vim` opens a file. `i` enters insert state —
type normally, arrows move you. `Esc` returns you to command state.
`:q!` leaves without saving. `:wq` saves and leaves. If the screen
ever fills with things you didn't intend: `Esc`, `:q!`, breathe,
walk back in. The file only changes when *you* write it.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
ls -la /var/sigstop/drop
rm /var/sigstop/drop/.reply.draft.swp
vim /var/sigstop/drop/transmission_07.msg
vim /var/sigstop/drop/reply.draft
```

In the transmission: arrow keys to read, then `Esc`, `:q!`, enter.
In the draft: arrow down to the last line, `i`, type `we act.` —
with the period — then `Esc`, `:wq`, enter. Prove it from outside:
`cat` the draft and read what you wrote. Now say the doors back to
me: `i` in. `Esc` out. `:wq` keep. `:q!` burn. Four keys against the
fear of a generation. Last time I explain them.

</details>
