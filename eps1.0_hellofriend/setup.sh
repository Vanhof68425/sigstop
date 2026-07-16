#!/bin/bash
# eps1.0_hellofriend — setup
# Stages the box. Runs once on scenario boot.

set -e

OPERATOR_HOME="/root"   # KillerCoda ubuntu image drops you in as root at /root
ARTIFACT="$OPERATOR_HOME/readme_operator.txt"

cat > "$ARTIFACT" << 'EOF'
------------------------------------------------------------
 [SIGSTOP // transmission fragment 001]
------------------------------------------------------------

 You ran the commands. Good. Now you know two things the
 average Apex engineer never checks: who they are, and
 where they are. You'd be surprised how many incidents
 start with someone typing the right command on the
 wrong machine.

 Prove you read this. Create a file called

     awake

 in this same directory. Empty is fine. It's not for me.
 It's so *you* remember you chose this.

 (You already know a command that creates things by
 touching them.)

 We don't stop the future. We make sure it has brakes.

                                        -- SIGSTOP
------------------------------------------------------------
EOF

# Breadcrumb for later episodes: a locked directory the player
# can see but not enter yet. Pure atmosphere in eps1.0.
mkdir -p /opt/apex
chmod 000 /opt/apex

# Clean slate for the story
history -c 2>/dev/null || true

echo "done" > /tmp/setup-complete
