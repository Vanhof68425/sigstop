A contact inside Apex left us a dead drop — a codeword, buried at the end
of a trail. Someone copied a slice of their internal file share onto this
box before it could be scrubbed. The trail starts here:

```
/var/apex-mirror
```

Each stop on the trail has a note. Each note tells you where to go next —
sometimes as an absolute path, sometimes relative. Read carefully. Move.
Confirm. Repeat.

At the end you'll find the codeword. When you have it, do what you did in
eps1.0: **create a file in your home directory named exactly the codeword.**
That's the signal that the drop is recovered.

Doctrine reminders:
- `cd <path>` moves you. `cd ..` goes up one level. `cd ~` goes home.
- `pwd` after every move. Yes, every move.

<details>
<summary>&gt; ping handler</summary>

You're somewhere in the mirror and you don't know where. That's not a
navigation problem, that's a doctrine problem — you moved without
confirming. Stand still. Ask the machine where you are and what's around
you. The note in front of you always names the next stop; the only question
is whether it's counting from the root of everything or from your own feet.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

Paths that start with `/` are absolute — feed them to `cd` exactly as
written, from anywhere. Paths that don't are relative — they only work
from the directory the note lives in, so `cd` back there first if you
wandered. `..` in a path means "the parent of where I am." Chain of tools,
every stop: `pwd`, `ls`, `cat` the note, `cd` to the next. Nothing you
haven't done before. Lost beyond saving? `cd /var/apex-mirror` restarts
the trail.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine. The full route, one stop at a time:

```
cd /var/apex-mirror
cat trailhead.txt
cd infra/staging
cat note.txt
cd ../../archive
cat note.txt
cd /var/apex-mirror/personnel/.offboarded
cat note.txt
cat deaddrop.txt
```

The last file is the codeword. Then `cd ~` and `touch <the codeword>`.
Walk it again afterward without this list — I mean it. The route isn't the
lesson. The habit is.

</details>
