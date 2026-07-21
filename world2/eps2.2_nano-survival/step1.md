The config:

```
/etc/sigstop/relay.conf
```

The corrected spec, signed off by me, is at `/root/relay.spec`. Read
it first. Then open the config and make it match the spec. Three lines
are wrong. Everything else is right — which means everything else must
*stay* right. Surgery, not demolition.

> **Tonight's tools**
> `cat <file>` — print a file to the screen
> `nano <file>` — open a file in the nano editor
> Inside nano: `^W` search, `^O` save (nano calls it "Write Out"), `^X` exit. The `^` means hold Ctrl.

When the file is correct, save, exit, and hit CHECK. No codeword. The
config is the signal.

One rule tonight: use the editor. You could bend pipes and
redirections into rewriting the file — you'll learn to, later,
deliberately — but an operator who can't sit *inside* a file is a
tourist. Open it. Move through it. Change it. Leave it clean.

<details>
<summary>&gt; ping handler</summary>

You opened it and now you're staring at nano like it's a cockpit.
Look at the bottom two rows of the screen. That's not decoration —
that's the entire manual, permanently displayed. The `^` means hold
Ctrl. And you have the spec in one hand and the config in the other:
this isn't an editing problem yet, it's a *diffing* problem. Find the
three lines that disagree. The search command is on the bottom row
too.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`nano /etc/sigstop/relay.conf` opens it. Arrow keys move. `^W`, type
part of a line (like `endpoint`), enter — jumps you there. Edit like
any text box: cursor to the wrong part, backspace, type the correct
value from the spec, character for character. Then `^O` and enter to
save (nano calls it "Write Out"), `^X` to leave. If you mangle
something and panic: `^X`, answer `N` to discard, and start the file
over clean.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
cat /root/relay.spec
nano /etc/sigstop/relay.conf
```

Inside nano: `^W` `endpoint` enter — fix it to the spec's value.
`^W` `interval` enter — fix. `^W` `burn` enter — fix. Then `^O`,
enter, `^X`. Confirm your surgery from outside: `cat` the config,
read it against the spec one last time. If they match, CHECK. The
keys are on the screen the entire time — nano was never the hard
part. Reading carefully was. It always is. Last time I explain it.

</details>
