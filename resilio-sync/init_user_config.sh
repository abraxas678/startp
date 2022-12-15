#!/bin/sh

mkdir -p $HOME/.config/resilio-sync

BTSYNC_STORAGE=$HOME/.config/btsync/storage
RESILIO_STORAGE=$HOME/.config/resilio-sync/storage

BTSYNC_CONFIG_PATH=$HOME/.config/btsync/config.json
RESILIO_CONFIG_PATH=$HOME/.config/resilio-sync/config.json

if [ -d ${BTSYNC_STORAGE} ] && [ ! -d ${RESILIO_STORAGE} ]; then
    # Copy btsync storage folder
    cp -r ${BTSYNC_STORAGE} ${RESILIO_STORAGE}
    # Copy btsync config if exist
    if [ -f ${BTSYNC_CONFIG_PATH} ] && [ ! -f ${RESILIO_CONFIG_PATH}]; then
        cp ${BTSYNC_CONFIG_PATH} ${RESILIO_CONFIG_PATH}
        sed -i 's$\.config/btsync/storage$\.config/resilio-sync/storage$g' ${RESILIO_CONFIG_PATH}
        sed -i 's$\.config/btsync/btsync\.pid$\.config/resilio-sync/sync\.pid$g' ${RESILIO_CONFIG_PATH}
    fi
else
    mkdir -p ${RESILIO_STORAGE}
fi

if [ ! -f ${RESILIO_CONFIG_PATH} ]; then
    sed -e "s|{HOME}|$HOME|g" /etc/resilio-sync/user_config.json > ${RESILIO_CONFIG_PATH}
fi
