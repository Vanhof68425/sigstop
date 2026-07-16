#!/bin/bash
# eps1.1_moving-target — verify
# Outcome, not commands: the codeword file exists in home.
# Proves the whole chain — walked the trail, read the drop, acted.
# Any navigation route that got them there counts.

if [ -e /root/silhouette ]; then
  exit 0
fi

exit 1
