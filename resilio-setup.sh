#!/bin/bash
## https://help.resilio.com/hc/en-us/articles/206178924-Installing-Sync-package-on-Linux
sudo systemctl disable resilio-sync
sudo systemctl stop start resilio-sync

echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list
curl -L https://linux-packages.resilio.com/resilio-sync/key.asc | sudo apt-key add
sudo apt-get update
sudo apt-get install resilio-sync -y
echo

sudo chown abraxas: /home -R

#sudo usermod -aG user_group rslsync
sudo usermod -aG abraxas rslsync

#sudo usermod -aG rslsync user_name
sudo usermod -aG rslsync abraxas

#sudo chmod g+rw synced_folder
#sudo chmod g+rw synced_folder

sudo cp /home/abraxas/startp/resilio-sync.service /usr/lib/systemd/user/
sudo chmod g+rw /home/abraxas

sudo systemctl --user enable resilio-sync
sudo systemctl --user start resilio-sync



#Synchronizing state of resilio-sync.service with SysV service script with /lib/systemd/systemd-sysv-install.
#Executing: /lib/systemd/systemd-sysv-install enable resilio-sync
