The scratchpad:

```
/var/apex-mirror/scratchpad/
```

Forty notes, identical names except the hash, dropped there over the
past month by someone still inside Apex feeding us scraps. Thirty-nine
are dead drops we already collected. One is fresh — the **most recently
modified file in the directory**. That one is live, and it has your
codeword.

The mtimes are shuffled and the names tell you nothing, so opening
files at random is a coin-flip marathon. `ls` can hand you the answer
instantly — sorted so the newest file is the *first* thing it prints.
I'm not telling you the flag.

`man ls`. Find it. Use it. `/` is your friend in there; try searching
for a word that means "changed."

<details>
<summary>&gt; ping handler</summary>

You're either opening notes one by one, or you ran `man ls`, saw the
wall of text, and closed it. The manual isn't a wall, it's a building —
you don't read buildings, you navigate them. You're inside less. You
know less. Search the page for the thing you care about: time.
Modification. Sort.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

In `man ls`, type `/modification` and press enter, then `n` to hop
between matches. One of them describes a single-letter flag that sorts
by modification time, newest first. Pair it with `-l` if you want to
see the timestamps prove it. The first file in that sorted listing is
your live drop.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

No.

Not tonight, and it's not a boss rule — it's the whole lesson. The
answer is one `/search` away in a document sitting on your machine.
If I type the flag for you, you leave World 1 knowing seven commands
and owning none of them. Open the manual. Find it. It's there. I've
read it. Reyes read it. Everyone you'll ever respect has read it.

</details>
