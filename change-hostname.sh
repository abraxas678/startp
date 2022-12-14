#!/bin/bash
echo
echo "#####################################################################"
echo "                      CHANGE HOSTNAME 0.2"
echo "#####################################################################"
echo "sudo chown abraxas: /home -R"
sudo chown abraxas: /home -R
mkidr $HOME/tmp >/dev/null 2>/dev/null
sudo apt-get install dnsutils
echo
IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
if [[ $IP = "85.215.119.137" ]]; then
  MACHINE="ionos2"
elif [[ $IP = "85.215.119.175" ]]; then
  MACHINE="ionos1"
elif [[ ! -f /home/MY_MACHINE ]]; then
  UBU_VERS=$(lsb_release -a | grep Release | sed 's/Release://' | sed 's/ //g'); 
  DIST=$(lsb_release -a | grep Distributor | sed 's/Distributor ID://' | sed 's/ //g');
  MACHINE="$DIST$UBU_VERS"
  MACHINE=$(echo $MACHINE | sed 's/ //g')
else
  MACHINE=$(cat /home/MY_MACHINE)
fi
echo
MACHINE=$(echo "$MACHINE" | awk '{print tolower($0)}')
#echo MACHINE $MACHINE
MY_HOSTNAME=$MACHINE
echo
echo MY_HOSTNAME $MY_HOSTNAME
sleep 3

#[[ $(ls /mnt/c/MOUNT_CHECK | wc -l) = "0" ]] && MY_WSL=0 || MY_WSL=1
[[ $(uname -a) = *"WSL"* ]] && MY_WSL="y" || MY_WSL="n"
echo MY_WSL $MY_WSL
sleep 3
#read -p "is this a WSL? (y/n)" MY_WSL
[[ ! $MY_HOSTNAME ]] && read -p "new hostname: >>> " MY_HOSTNAME

if [[ $MY_WSL = "y" ]]; then
# https://www.srccodes.com/change-hostname-ubuntu-microsoft-windows-subsystem-for-linux-wsl-wsl2-wsl-conf-unable-resolve-hosts-name-service-not-known-list-running-shutdown-vm-srccodes/
echo "ORIGINAL HOSTNAME: $(hostname)"
echo "$(hostname)" >$HOME/ORIGINAL_HOSTNAME
sudo touch /home/abraxas/tmp/wsl.conf
sudo echo "[network]" >>/home/abraxas/tmp/wsl.conf
sudo echo "hostname = $MY_HOSTNAME" >>/home/abraxas/tmp/wsl.conf
sudo echo "generateHosts = false" >>/home/abraxas/tmp/wsl.conf
sudo cp /home/abraxas/tmp/wsl.conf /etc/
echo; echo "sed on: /etc/hosts"; echo
sudo sed -i "s/$(cat $HOME/ORIGINAL_HOSTNAME)/$MY_HOSTNAME/g" /etc/hosts
echo
sudo cat /etc/wsl.conf
echo
sudo cat /etc/hosts
else
sudo nano /etc/hosts
fi
sudo echo $MY_HOSTNAME >/etc/hostname
echo $MY_HOSTNAME > $HOME/tmp/hostname
sudo mv $HOME/tmp/hostname /etc/

echo ">>> now reboot <<<"
read me
