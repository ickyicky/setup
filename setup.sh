#! /bin/bash
#

. ./scripts/load_env.sh

for SCRIPT in ./scripts/*.sh; do
    . $SCRIPT
done
