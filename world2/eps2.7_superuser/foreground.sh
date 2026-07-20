#!/bin/bash
# SIGSTOP foreground gate — KillerCoda opens the terminal before the
# background setup.sh finishes, so a bare shell would read .bashrc
# before the theming block exists. Hold here until the box is staged,
# then re-exec bash so the shell reads the themed .bashrc.
printf '[SIGSTOP] establishing channel'
while [ ! -f /tmp/setup-complete ]; do
  printf '.'
  sleep 1
done
clear
echo "[SIGSTOP] channel established."
exec /bin/bash
