# LEVELMAP.md — season one

Status: `concept` → `drafted` → `built` → `playtested` → `live`

## World 1 — The Approach
*Observe without touching. SIGSTOP has been watching you.*

| Episode | Skills | Status |
|---|---|---|
| eps1.0_hellofriend.term | `whoami`, `pwd`, `ls`, `cat` | **live** |
| eps1.1_moving-target.dot | `cd`, absolute vs relative paths | **live** |
| eps1.2_read-only.log | `less`, `head`, `tail` | **live** |
| eps1.3_hidden-in-plain-sight.dot | dotfiles, `ls -la` | **live** |
| eps1.4_needle.grep | `grep` | **live** |
| eps1.5_lost-and-found.tmp | `find` | **live** |
| eps1.6_rtfm.man | `man`, `--help` | **live** |
| eps1.7_the-scavenger-hunt.root 👹 | BOSS — everything above | **live** |

## World 2 — Tradecraft
*You're handling evidence now. One careless command and it's gone forever.*

| Episode | Skills | Status |
|---|---|---|
| eps2.0_make-and-move.txt | `touch`, `mkdir`, `cp`, `mv`, `rm` | concept |
| eps2.1_rm-rf_never-again.log ⚠️ | destructive commands, `rm -i`, precision deletion | concept |
| eps2.2_nano-survival.cfg | editing with `nano` | concept |
| eps2.3_escaping-vim.swp | `i`, `Esc`, `:wq`, `:q!` — escape with the file intact | concept |
| eps2.4_plumbing.pipe | redirection, `>`, `>>`, `\|` | concept |
| eps2.5_who-owns-what.grp | users, groups, `chown` | concept |
| eps2.6_permission-denied.mod | `rwx`, `chmod` | concept |
| eps2.7_superuser.sudo | `sudo`, and why to fear it | concept |
| eps2.8_locked-out.root 👹 | BOSS — a permissions mess | concept |

## World 3 — The Runaway
*Apex systems are misbehaving. Find it. Pause it. Kill it if you have to.*

| Episode | Skills | Status |
|---|---|---|
| eps3.0_whats-running.ps | `ps`, `top` | concept |
| eps3.1_kill-signal.sig | signals, `kill`, and why we're named SIGSTOP | concept |
| eps3.2_background-noise.job | `&`, `fg`, `jobs` | concept |
| eps3.3_service-desk.svc | `systemctl` start/stop/status | concept |
| eps3.4_paper-trail.log | `journalctl`, `/var/log` | concept |
| eps3.5_clockwork.cron | `cron` | concept |
| eps3.6_the-3am-page.root 👹 | BOSS — pegged CPU, dead service, logs tell the story | concept |

## World 4 — The Wire
*Trace where the data goes. Then cut the line.*

| Episode | Skills | Status |
|---|---|---|
| eps4.0_who-am-i-online.ip | `ip addr`, `hostname` | concept |
| eps4.1_can-you-hear-me.dns | `ping`, DNS, `dig` | concept |
| eps4.2_talking-to-servers.curl | `curl` | concept |
| eps4.3_open-doors.port | `ss`, ports | concept |
| eps4.4_remote-hands.ssh | `ssh`, `scp` | concept |
| eps4.5_the-wall.fw | `ufw` | concept |
| eps4.6_unreachable.root 👹 | BOSS — layered port/firewall/service failure | concept |

## Finale
| Episode | Skills | Status |
|---|---|---|
| eps5.0_deployment-night.root 🔥 | CAPSTONE — multi-fault box, everything at once | concept |

## Season two (parking lot)
- Power User world: deeper vim, `.bashrc`, aliases, env vars, shell customization
- Git world, Docker world, CI/CD world
- Community-contributed episodes (after CONTRIBUTING.md exists)
