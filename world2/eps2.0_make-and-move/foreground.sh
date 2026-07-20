#!/bin/bash
while [ ! -f /tmp/setup-complete ]; do sleep 1; done
rm -f /tmp/.sigstop_motd_shown
clear; exec /bin/bash
