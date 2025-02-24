#!/bin/bash

# drain the docker node
DOCKER_NODE=$(docker info --format '{{.Swarm.NodeID}}')
docker node update --availability drain "$DOCKER_NODE"

JOB_NAME="rackpi_appdata"

# Close if rclone/borg running
if pgrep "borg" || pgrep "rclone" >/dev/null; then
    echo "$(date "+%m-%d-%Y %T"): Backup already running, exiting" 2>&1
    exit
fi

BORG_REPO="/home/admin/backups/$JOB_NAME"
CLOUD_DEST="onedrive-zacgg:/backups/$JOB_NAME"

BORG_CONFIG="/home/admin/.config/borgmatic/config.yaml"

borgmatic -c "$BORG_CONFIG" create --verbosity 1 --list --stats

exit_code=$?

# Execute if no errors
if [ ${exit_code} -eq 0 ]; then
    SECONDS=0
    echo "$(date "+%m-%d-%Y %T"): Rclone sync has started"
    rclone sync $BORG_REPO "$CLOUD_DEST" -P --stats 1s -v 2>&1
    echo "$(date "+%m-%d-%Y %T"): Rclone sync completed in  $((SECONDS / 3600))h:$((SECONDS % 3600 / 60))m:$((SECONDS % 60))s" 2>&1
# All other errors
else
    echo "$(date "+%m-%d-%Y %T"): Borg has errors code:" $exit_code 2>&1

    if [ -z "$DISCORD_WEBHOOK" ]; then
        echo "ERROR No DISCORD_WEBHOOK set, exiting"
        exit ${exit_code}
    fi

    JSON_DATA=$(jq -n --arg jobname "$JOB_NAME" '{
        "username": "Webhook Bot",
        "embeds": [
          {
            "title": "Borg Backup Error",
            "description": ("There was a problem backing up " + $jobname),
            "color": 16711680
          }
        ]
    }')

    curl -H "Content-Type: application/json" \
        -X POST \
        -d "$JSON_DATA" \
        "$DISCORD_WEBHOOK"
fi

# Return the docker node to active
docker node update --availability active "$DOCKER_NODE"

exit ${exit_code}
