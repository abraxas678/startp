#!/bin/bash
cd $HOME
echo #####################################################################
/usr/bin/figlet                       MACHINE NAME
echo #####################################################################
echo "                                                      machine_name.sh"
echo
echo
[[ $(ls /mnt/c/MOUNT_CHECK | wc -l) = "0" ]] && WSL=0 || WSL=1
echo; echo "WSL= $WSL"
sleep 1
if [[ ! -f /home/MY_MACHINE ]]; then 
  read -p "/home/MY_MACHINE does not exit. Create it? (y/n)" -n 1 MACH 
  if [[ $MACH = "y" ]]; then
    read -p "machine name: >> " MY_MACHINE && echo $MY_MACHINE >/home/MY_MACHINE
  fi
fi

sleep 1
if [[ ! -f /home/MY_MACHINE ]]; then
  UBU_VERS=$(lsb_release -a | grep Release | sed 's/Release://' | sed 's/ //g'); 
  DIST=$(lsb_release -a | grep Distributor | sed 's/Distributor ID://' | sed 's/ //g');
  MACHINE="$DIST$UBU_VERS"
  MACHINE=$(echo $MACHINE | sed 's/ //g')
else
   MACHINE=$(cat /home/MY_MACHINE)
fi
MY_HOSTNAME=$MACHINE
echo
echo "SOLL-NAME MACHINE=  $MACHINE"
echo
sleep 2

if [[ $WSL = "1" ]]; then
if [[ ! -f /etc/wsl.conf ]]; then
  [[ -d $HOME/tmp ]] && mkdir $HOME/tmp
  cd $HOME/tmp
  sudo touch /etc/wsl.conf
  curl -L https://raw.githubusercontent.com/abraxas678/startp/main/wsl.conf -o wsl.conf
  sudo cp wsl.conf /etc/
  echo 
  echo "wsl.conf:"
  echo "========="
  echo
  echo cat /etc/wsl.conf
  sudo cat /etc/wsl.conf
  echo
#  read -p BUTTON15 -t 15 me 
fi
fi
echo
[[ *"$MACHINE"* != *"$(sudo cat /etc/hostname)"* ]] && sudo echo $MACHINE >/etc/hostname
echo
echo /etc/hostname
cat /etc/hostname
echo
#read -p BUTTON15 -t 15 me
echo
echo MY_HOSTNAME $MY_HOSTNAME
echo "current hostname: $(hostname)"
echo
read -p BUTTON15 -t 15 me 
#if [[ $(hostname) != *"$MY_HOSTNAME"* ]]; then
#    curl -L  https://raw.githubusercontent.com/abraxas678/startp/master/change-hostname.sh >$HOME/tmp/change-hostname.sh
#    chmod +x *.sh
#    /bin/bash $HOME/tmp/change-hostname.sh
#fi 

