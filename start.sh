#!/bin/bash
clear
cd $HOME
echo "v0.46"
echo
[[ $(figlet -I test) != *"FIGlet Copyright"* ]] && sudo apt install figlet -y
if [[ $(which rclone) != *"/usr/bin/rclone"* ]]; then
  echo "#####################################################################"
  echo                       INSTALL RCLONE
  echo "#####################################################################"
  sleep 1
  curl https://rclone.org/install.sh | sudo bash
  echo
fi
[[ $(eval $RCLONE_PASSWORD_COMMAND | wc -l) = "0" ]] && read -p "RCLONE-PASSWORD: >> " RC_PASSWORD && export RC_PASSWORD=$RC_PASSWORD && clear || export RC_PASSWORD=$(eval $RCLONE_PASSWORD_COMMAND)

[[ $(/usr/bin/rclone listremotes --password-command="echo $RC_PASSWORD") != *"gd:"* ]] && /usr/bin/rclone config



read -p "Is this \[M]aster or \[S]lave? >> " -n 1 MY_TYPE

if [[ $MY_TYPE = "m" ]]; then
  rclone copy /home/abraxas/.config/rclone/rclone.conf df:.config/rclone -P
  rclone sync /home/abraxas/.config df:.config --max-depth 2 -P
  rclone sync /home/abraxas/.ssh df:.ssh -P
  rclone sync /home/abraxas/dotfiles df:dotfiles -P
elif [[ $MY_TYPE = "s" ]]; then
[[ $(whoami) = "root" ]] && MY_SUDO="" || MY_SUDO="sudo"
[[ ! -d $HOME/tmp ]] && mkdir $HOME/tmp
[[ $(git --version) != *"git version"* ]] && $MY_SUDO apt install -y git curl wget

echo #####################################################################
/usr/bin/figlet                       USER-CHECK
echo #####################################################################
sleep 1
curl -L https://raw.githubusercontent.com/abraxas678/startp/main/check_user.sh >$HOME/tmp/check_user.sh
chmod +x $HOME/tmp/*.sh
/bin/bash $HOME/tmp/check_user.sh

cd $HOME/tmp

echo; 
echo #####################################################################
/usr/bin/figlet                       UPDATE & UPGRADE
echo #####################################################################
sleep 1
$MY_SUDO apt update && $MY_SUDO apt upgrade -y
sudo apt install unzip -y
### uname -r | tr '[:upper:]' '[:lower:]'

echo #####################################################################
/usr/bin/figlet                       MACHINE NAME
echo #####################################################################
sleep 1
if [[ ! -f /MY_MACHINE ]]; then
UBU_VERS=$(lsb_release -a | grep Release | sed 's/Release://' | sed 's/ //g'); 
DIST=$(lsb_release -a | grep Distributor | sed 's/Distributor ID://' | sed 's/ //g');
MACHINE="$DIST$UBU_VERS"
MACHINE=$(echo $MACHINE | sed 's/ //g')
else
 MACHINE=$(cat /MY_MACHINE)
fi
echo
echo "MACHINE=  $MACHINE"
echo
sleep 1

[[ $(ls /mnt/c/MOUNT_CHECK | wc -l) = "0" ]] && WSL=0 || WSL=1
echo; echo "WSL= $WSL"
sleep 1
[[ ! -f /etc/wsl.conf ]] && sudo touch /etc/wsl.conf
#[[ $(sudo ls /etc/wsl.conf -la  | awk '{ print $5 }') = "0" ]] 
#curl -L https://raw.githubusercontent.com/abraxas678/startp/main/wsl.conf -o wsl.conf
#sudo cp wsl.conf /etc/
echo 
echo "wsl.conf:"
echo "========="
echo
echo cat /etc/wsl.conf
cat /etc/wsl.conf
echo
read -p BUTTON10 -t 10 me 
echo
echo
[[ ! -f /MY_HOSTNAME ]] && MY_HOSTNAME=$MACHINE || MY_HOSTNAME=$(cat /MY_HOSTNAME)
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
/usr/bin/figlet                       TAILSCALE
echo #####################################################################
sleep 1
  [[ $(tailscale ip | wc -l) != "2" ]] && sudo apt update && curl -fsSL https://tailscale.com/install.sh | sh
  echo
  sudo systemctl start tailscaled
  sudo systemctl enable tailscaled
  sudo tailscale up --ssh --accept-routes
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
echo #####################################################################
/usr/bin/figlet                       UNISON INSTALL
echo #####################################################################

  if [[ $(which unison | wc -l) = "0" ]]; then
    echo; echo install unison
    mkdir $HOME/tmp/unison
    cd $HOME/tmp/unison
    wget https://github.com/bcpierce00/unison/releases/download/v2.53.0/unison-v2.53.0+ocaml-4.14.0+x86_64.linux.tar.gz
    tar -xf unison-v2.53.0+ocaml-4.14.0+x86_64.linux.tar.gz
    sudo mv bin/uni* /usr/bin
  fi
  cd $HOME/tmp
echo
echo "#####################################################################"
/usr/bin/figlet                       WORMHOLE INSTALL
echo "#####################################################################"
VERS=$(/usr/bin/wormhole --version)
[[ $VERS = *"command not"* ]] && sudo apt install -y wormhole

#unison /home/abraxas/.ssh ssh://ionos2///home/abraxas/.ssh -auto -batch
#unison /home/abraxas/.config ssh://ionos2///home/abraxas/.config -auto -batch
#unison /home/abraxas/dotfiles ssh://ionos2///home/abraxas/dotfiles -auto -batch
#read -p BUTTON30 -t 30 me
#cp /home/abraxas/dotfiles/* /home/abraxas -r
#cp /home/abraxas/dotfiles/.* /home/abraxas -r

cd $HOME
echo #####################################################################
/usr/bin/figlet                       CLONE STARTP
echo #####################################################################
sleep 1
rm -rf $HOME/startp
git clone https://github.com/abraxas678/startp.git
cd /home/abraxas/startp
chmod +x *.sh
echo #####################################################################
echo                       RESILIO SETUP
echo #####################################################################
echo
sleep 2
./resilio-setup.sh
sudo cp /home/abraxas/startp/resilio-sync/* /etc/resilio-sync/ -r
sudo systemctl restart resilio-sync
/bin/bash /home/abraxas/startp/openme.sh $(hostname):8888
##/bin/bash permission-ssh-folder.sh
#kill $(ps aux | grep syncthing | grep -v grep  | awk '{ print $2 }')
#sudo apt install syncthing -y
echo
echo "#####################################################################"
/usr/bin/figlet                       PUEUE SETUP
echo "#####################################################################"
sleep 2
./pueue-setup.sh
echo
pueued -d
PUEUE=$(which pueue)
$PUEUE group add background >/dev/null 2>/dev/null
$PUEUE group add mount >/dev/null 2>/dev/null
#$PUEUE add -g background -- syncthing
#sleep 2; echo
#curl -d "$(pueue log 0 | grep GUI)" https://n.yyps.de/alert
#./apt-install.sh
cd $HOME/startp
echo "#####################################################################"
/usr/bin/figlet                       APT INSTALL
echo "#####################################################################"
sleep 1
./apt-install-from-list.sh
echo "#####################################################################"
/usr/bin/figlet                       PIP3  INSTALL
echo "#####################################################################"
sleep 1
pip3 install rich-cli   
#unison /home/abraxas/bin ssh://ionos2///home/abraxas/bin

#  git clone git@github.com/abraxas678/start.git  
#  cd $HOME/tmp/start
#  chmod +x *.s
#  ./pueue-setup.sh
#  ./install_brew_original.sh 
#  ./install_brew_original2.sh 
#  ./apt-install.sh
mkdir $HOME/.unison
cp ~/startp/*.prf ~/.unison/
cp ~/startp/white* ~/.unison/
cd  $HOME/.unison
cd /home/abraxas
#mv .ssh .sshOLD
#mv .config .configOLD
#mv bin binOLD
#mv dotfiles dotfilesOLD
#echo "execute on other PC:   cd /home/abraxas; /usr/bin/wormhole send .config;  /usr/bin/wormhole send .ssh;  /usr/bin/wormhole send dotfiles;  /usr/bin/wormhole send bin --ignore-unsendable-files"
echo
#echo "#####################################################################"
#echo                       UNISON IONOS2
#echo "#####################################################################"
#unison ionos2
#echo
#read -p "Worhmhole: >>" WH
#$WH
#fi
echo
#echo "#####################################################################"
#echo                       COPY RCLONE.CONF
#echo "#####################################################################"
#echo ssh ionos2 /usr/bin/wormhole send ~/.config/rclone/rclone.conf
#ssh ionos2 /usr/bin/wormhole send ~/.config/rclone/rclone.conf
#echo
#read -p "Worhmhole: >>" WH
#$WH
echo
#unison ~/.ssh ionos2:.ssh -batch -auto        
#read -p "RCLONE PASSWORD: " RCPW
#export RCPW=$RCPW
rclone copy df:bin/age.sh /home/abraxas/bin -P --password-command="echo $RC_PASSWORD"  --drive-acknowledge-abuse
rclone copy df:dotfiles /home/abraxas/dotfiles -P --password-command="echo $RC_PASSWORD"  --drive-acknowledge-abuse
rclone copy df:.config /home/abraxas/.config --max-depth 2 -P --password-command="echo $RC_PASSWORD"  --drive-acknowledge-abuse
rclone copy df:.ssh /home/abraxas/.ssh --max-depth 2 -P --password-command="echo $RC_PASSWORD"  --drive-acknowledge-abuse
rclone copy df:dotfiles/.zshrc ~ -P --password-command="echo $RC_PASSWORD"
sudo chown abraxas: -R /usr/share/taskwarrior
echo
cat $HOME/syncthing-start.log | grep GUI
#echo http://127.0.0.1:63310/#   ### syncthing razer
sudo /usr/bin/restic self-update
echo
read -p BUTTON120vorBREW -t 120 me
/bin/bash /home/abraxas/startp/install_brew_original.sh 
/bin/bash /home/abraxas/startp/install_brew_original2.sh
brew install ghq
cd $HOME
source ~/.zshrc
exec zsh
fi
fi
