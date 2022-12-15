#!/bin/bash
$HOME/bin/killandremove.sh resilio >/dev/null 2>/dev/null
DATA_FOLDER=/home/abraxas/
WEBUI_PORT=28888

#mkdir -p $DATA_FOLDER

docker run -d --name resilio \
           -p $WEBUI_PORT:8888 \
           -p 55555 \
           -v $DATA_FOLDER:/mnt/sync \
           --restart on-failure \
           resilio/sync
