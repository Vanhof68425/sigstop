#!/bin/bash
# eps3.2 step 1 — verify: the mark went out during the sweep, and the
# sweep finished. sigstop-mark itself refuses unless the sweep is
# running, so mark.ok existing proves the concurrency.

[ -f /root/mark.ok ] || exit 1
[ -f /root/sweep.done ] || exit 1

exit 0
