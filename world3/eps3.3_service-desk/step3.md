`prom-evald` is stopped. But look at its **Loaded** line again: it
still says `enabled`. Stopped means "not running now." Enabled means
"start it at every boot." If this node reboots before the wipe, the
manager will start it again, first thing, on its own.

Two different switches. Now you turn off the second one.

Then we leave something of our own behind. `sigstop-listen` is a
small service I installed on this node. It watches `prom-evald`, and
if anything ever starts it again, the listener writes it down. It's
installed, but it isn't enabled or running yet.

> **Tonight's tools**
> `systemctl disable <name>` — don't start this service at boot
> `systemctl enable <name>` — do start this service at boot
> `systemctl start <name>` — start it now (step 2)
> Remember: enable/disable is about *boot*. start/stop is about *now*. They are separate.

**Worked example first.** Look at both switches on the metronome:

```
systemctl is-enabled metronome
systemctl is-active metronome
```

`enabled` and `active`: it starts at boot, and it's running now. You
don't need to change it. Just see that the two answers are separate
questions.

**This step: close the door, then set a watch.**

1. `systemctl disable prom-evald`
2. `systemctl enable sigstop-listen`
3. `systemctl start sigstop-listen`
4. Check all four answers:
   - `systemctl is-enabled prom-evald` must say `disabled`
   - `systemctl is-active prom-evald` must say `inactive`
   - `systemctl is-enabled sigstop-listen` must say `enabled`
   - `systemctl is-active sigstop-listen` must say `active`

Then CHECK.

<details>
<summary>&gt; ping handler</summary>

You stopped it last step, so you think it's handled. Apex thinks like
that too. "It's off." Off until when? A stopped service is a sleeping
one. The manager wakes everything that's enabled the next time the
machine starts. You turned off the light. You didn't take out the
bulb.

</details>

<details>
<summary>&gt;&gt; ping again</summary>

`disable` removes `prom-evald` from the boot list. `enable` adds
`sigstop-listen` to the boot list, but doesn't start it. That's why
you also need `start`. The four `is-enabled` / `is-active` checks are
your receipt. If `sigstop-listen` says `inactive`, you enabled it but
never started it.

</details>

<details>
<summary>&gt;&gt;&gt; just tell me</summary>

Fine.

```
systemctl disable prom-evald
systemctl enable sigstop-listen
systemctl start sigstop-listen
systemctl is-enabled prom-evald
systemctl is-active prom-evald
systemctl is-enabled sigstop-listen
systemctl is-active sigstop-listen
```

`disabled`, `inactive`, `enabled`, `active`. Say it back:
enable/disable is boot, start/stop is now, and a service you really
want gone needs both. Last time I explain it.

</details>
