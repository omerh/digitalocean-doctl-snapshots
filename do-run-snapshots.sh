#!/bin/bash

ROTATION=7
PREFIX="automated-snapshot"

echo "Running snapshot to all droplets"

# Get all droplets ids
IDS=$(doctl compute droplet list --no-header | awk '{print $1}')

for ID in $IDS; do
    NAME=$(doctl compute droplet list | grep $ID | awk '{print $2}')
    echo "Running snapshot to $NAME ($ID)"
    doctl compute droplet-action snapshot --snapshot-name "$PREFIX-$NAME-`date +%Y-%m-%d-%H-%M`" $ID

    # rotating snap shots
    SNAPSHOTS=$(doctl compute snapshot list --no-header | grep $PREFIX-$NAME | wc -l | xargs)
    if [ $SNAPSHOTS -gt $ROTATION ]; then
        echo "There are $SNAPSHOTS, deleting the oldest one"
        echo "Deleting snapshot:"
        doctl compute snapshot list --no-header | grep $PREFIX-$NAME | head -1
        SNAPSHOTID=$(doctl compute snapshot list --no-header | grep $PREFIX-$NAME | head -1 | awk '{print $1}')
        doctl compute snapshot delete $SNAPSHOTID --force        
    fi
done