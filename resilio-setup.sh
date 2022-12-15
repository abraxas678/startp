#!/bin/bash
## https://help.resilio.com/hc/en-us/articles/206178924-Installing-Sync-package-on-Linux
echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list
curl -L https://linux-packages.resilio.com/resilio-sync/key.asc | sudo apt-key add
sudo apt-get update
sudo apt-get install resilio-sync -y
echo

#sudo usermod -aG user_group rslsync
sudo usermod -aG abraxas rslsync

#sudo usermod -aG rslsync user_name
sudo usermod -aG rslsync abraxas

#sudo chmod g+rw synced_folder
#sudo chmod g+rw synced_folder


sudo systemctl enable resilio-sync
sudo systemctl start resilio-sync
