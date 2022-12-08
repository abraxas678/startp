#!/bin/bash
clear
echo "v0.22"
[[ $(whoami) = "root" ]] && MY_SUDO="" || MY_SUDO="sudo"
[[ ! -d $HOME/tmp ]] && mkdir $HOME/tmp
[[ $(git --version) != *"git version"* ]] && $MY_SUDO apt install -y git curl wget

echo "### USER-CHECK"
sleep 1
curl -L https://raw.githubusercontent.com/abraxas678/startp/main/check_user.sh >$HOME/tmp/check_user.sh
chmod +x $HOME/tmp/*.sh
/bin/bash $HOME/tmp/check_user.sh

cd $HOME/tmp
#rm $HOME/tmp/start-b.sh* -f
#curl -L https://raw.githubusercontent.com/abraxas678/start/master/start-b.sh >start-b.sh

echo; echo "update & upgrade"
$MY_SUDO apt update && $MY_SUDO apt upgrade -y
sudo apt install unzip -y
### uname -r | tr '[:upper:]' '[:lower:]'

UBU_VERS=$(lsb_release -a | grep Release | sed 's/Release://' | sed 's/ //g'); 
DIST=$(lsb_release -a | grep Distributor | sed 's/Distributor ID://' | sed 's/ //g');
MACHINE="$DIST$UBU_VERS"
MACHINE=$(echo $MACHINE | sed 's/ //g')
echo
echo MACHINE $MACHINE
echo
sleep 3

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
read -p BUTTON30 -t 30 me 
echo
echo
MY_HOSTNAME=$MACHINE
#read -p "enter hostname: >> " MY_HOSTNAME
  echo MY_HOSTNAME $MY_HOSTNAME
  echo "current hostname: $(hostname)"
  echo
  sleep 2
if [[ $(hostname) != *"$MY_HOSTNAME"* ]]; then
    curl -L  https://raw.githubusercontent.com/abraxas678/startp/master/change-hostname.sh >$HOME/tmp/change-hostname.sh
    chmod +x *.sh
    /bin/bash $HOME/tmp/change-hostname.sh
fi 

if [[ $(whoami) = "abraxas" ]]; then
echo #####################################################################
echo                       TAILSCALE
echo #####################################################################
  [[ $(tailscale ip | wc -l) != "2" ]] && sudo apt update && curl -fsSL https://tailscale.com/install.sh | sh
  echo
  sudo tailscale up --ssh
  echo
  tailscale ip
  tailscale status
  echo
  echo https://login.tailscale.com/admin/machines #modify name
  echo
  MY_Y="y"
  while [[ $MY_Y != *"y"* ]]; do
    read -p "'y' to continue" MY_Y
  done
  read -p BUTTON30 -t 30 me
  if [[ $(which unison | wc -l) = "0" ]]; then
    echo; echo install unison
    mkdir $HOME/tmp/unison
    cd $HOME/tmp/unison
    wget https://github.com/bcpierce00/unison/releases/download/v2.53.0/unison-v2.53.0+ocaml-4.14.0+x86_64.linux.tar.gz
    tar -xf unison-v2.53.0+ocaml-4.14.0+x86_64.linux.tar.gz
    sudo mv bin/uni* /usr/bin
  fi
  cd $HOME/tmp
echo #####################################################################
echo                       WORMHOLE
echo #####################################################################
VERS=$(/usr/bin/wormhole --version)
[[ $VERS = *"command not"* ]] && sudo apt install -y wormhole
#unison /home/abraxas/.ssh ssh://ionos2///home/abraxas/.ssh -auto -batch
#unison /home/abraxas/.config ssh://ionos2///home/abraxas/.config -auto -batch
#unison /home/abraxas/dotfiles ssh://ionos2///home/abraxas/dotfiles -auto -batch
read -p BUTTON30 -t 30 me
cp /home/abraxas/dotfiles/* /home/abraxas -r
cp /home/abraxas/dotfiles/.* /home/abraxas -r
source /home/abraxas/.zshrc
curl https://rclone.org/install.sh | sudo bash
rclone copy df:bin/age.sh /home/abraxas/bin -P
rclone copy df:.zshrc /home/abraxas/ -P

cd $HOME
echo #####################################################################
echo                       CLONE STARTP
echo #####################################################################
rm -rf $HOME/startp
git clone https://github.com/abraxas678/startp.git
cd startp
./apt-install.sh
./pueue-setup.sh
./install_brew_original.sh 
./install_brew_original2.sh 
./rich_cli-install.sh
#unison /home/abraxas/bin ssh://ionos2///home/abraxas/bin

#  git clone git@github.com/abraxas678/start.git  
#  cd $HOME/tmp/start
#  chmod +x *.s
#  ./pueue-setup.sh
#  ./install_brew_original.sh 
#  ./install_brew_original2.sh 
#  ./apt-install.sh
mkdir $HOME/.unison
cd  $HOME/.unison
cd /home/abraxas
#mv .ssh .sshOLD
#mv .config .configOLD
#mv bin binOLD
#mv dotfiles dotfilesOLD
echo "execute on other PC:   cd /home/abraxas; /usr/bin/wormhole send .config;  /usr/bin/wormhole send .ssh;  /usr/bin/wormhole send dotfiles;  /usr/bin/wormhole send bin --ignore-unsendable-files"
cp ~/startp/*.prf ~/.unison/
cp ~/startp/white* ~/.unison/
unison ionos2
fi
pueued -d
pueue add syncthing
pueue
sudo chown abraxas: -R /usr/share/taskwarrior
echo http://127.0.0.1:63310/#   ### syncthing razer
