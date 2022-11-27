#!/bin/bash
clear
echo "v0.12a"
[[ $(whoami) = "root" ]] && MY_SUDO="" || MY_SUDO="sudo"
[[ ! -d $HOME/tmp ]] && mkdir $HOME/tmp
[[ $(git --version) != *"git version"* ]] && $MY_SUDO apt install -y git curl wget
cd $HOME/tmp
#rm $HOME/tmp/start-b.sh* -f
#curl -L https://raw.githubusercontent.com/abraxas678/start/master/start-b.sh >start-b.sh
$MY_SUDO apt update && $MY_SUDO apt upgrade -y
[[ $(ls /mnt/c/MOUNT_CHECK | wc -l) = "0" ]] && WSL=0 || WSL=1
[[ ! -f /etc/wsl.conf ]] && sudo touch /etc/wsl.conf
#[[ $(sudo ls /etc/wsl.conf -la  | awk '{ print $5 }') = "0" ]] 
curl -L https://raw.githubusercontent.com/abraxas678/startp/main/wsl.conf -o wsl.conf
sudo cp wsl.conf /etc/
echo 
echo "wsl.conf:"
echo "========="
echo
echo cat /etc/wsl.conf
cat /etc/wsl.conf
echo
read -p BUTTON me 
echo
echo ### USER-CHECK
sleep 1
curl -L https://raw.githubusercontent.com/abraxas678/startp/main/check_user.sh >$HOME/tmp/check_user.sh
chmod +x $HOME/tmp/*.sh
/bin/bash $HOME/tmp/check_user.sh

if [[ $(whoami) = "abraxas" ]]; then
  sudo apt update && curl -fsSL https://tailscale.com/install.sh | sh
  echo
  sudo tailscale up --ssh
  echo
  tailscale ip
  tailscale status
  echo
  echo https://login.tailscale.com/admin/machines #modify name
  echo
  MY_Y="0"
  while [[ $MY_Y != *"y"* ]]; do
    read -p "'y' to continue" MY_Y
  done
  echo
  read -p "enter hostname: >> " MY_HOSTNAME
  echo MY_HOSTNAME $MY_HOSTNAME
  echo "current hostname: $(hostname)"
  echo
  if [[ $(hostname) != *"$MY_HOSTNAME"* ]]; then
    curl -L  https://raw.githubusercontent.com/abraxas678/start/master/change-hostname.sh >$HOME/tmp/change-hostname.sh
    chmod +x $HOME/start/*.sh
    $HOME/tmp/change-hostname.sh
  fi 
  if [[ $(which unison | wc -l) = "0" ]]; then
    mkdir $HOME/tmp/unison
    cd $HOME/tmp/unison
    wget https://github.com/bcpierce00/unison/releases/download/v2.52.1/unison-v2.52.1+ocaml-4.04.2+x86_64.linux.tar.gz  
    sudo mv bin/uni* /usr/bin
  fi
  cd $HOME/tmp
  git clone https://github.com/abraxas678/start.git  
  cd $HOME/tmp/start
  chmod +x *.s
  ./pueue-setup.sh
  ./install_brew_original.sh 
  ./install_brew_original2.sh 
  ./apt-install.sh

fi
