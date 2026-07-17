# eps2.2_nano-survival.cfg

You've been wondering something since the beacons. You haven't asked,
because you're learning not to ask questions I'm about to answer, but
it's been sitting there: *how did Apex find the staging cache?*

Nobody talked. Nobody was followed. Nothing was intercepted.

A config file did it.

Our relay — the little service that syncs the cache — shipped with a
default endpoint in its config. The default was a public test server.
The public test server sits behind infrastructure that Apex, like half
the internet, quietly monitors. One line, never edited, phoning a
stranger on a schedule, for weeks. That's the whole breach. No
brilliance on their side. Just a file on ours that nobody opened.

Configuration is where systems keep their intentions, and the ability
to open a file, change a line, and leave without breaking anything is
not clerical work. It's surgery, and tonight you learn the scalpel.

`nano`. The humble one. Real engineers will sneer that it's a toy —
the same engineers whose configs phone test servers. It opens, it
edits, it saves, it leaves, and every command it has is printed at the
bottom of the screen where the `^` means Ctrl. `^O` writes. `^X`
exits. `^W` searches. That's survival. That's tonight.

The relay config is still wrong, by the way. It's *been* wrong since
the breach, because the only operator I'd trust to fix it couldn't
open an editor yet.

Now you can. Click **START**.
