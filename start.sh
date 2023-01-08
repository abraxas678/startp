#!/bin/bash
clear
cd $HOME
VERSION="v0.63"
echo "VERSION: $VERSION"
MY_MAIN_USER="abraxas"
echo "User: $USER"
echo MY_MAIN_USER="abraxas"
MY_CH="n"
echo
read -p "CHANGE? (y/n) >> " -t 10 -n 1 MY_CH
[[ $MY_CH = *"y"* ]] && read -p "MY_MAIN_USER: >> " MY_MAIN_USER
export MY_MAIN_USER=$MY_MAIN_USER
echo
echo
echo "MY_MAIN_USER=$MY_MAIN_USER"
echo
read -p BUTTON2 -t 2 me
echo
echo "sudo chown $MY_MAIN_USER: /home/$MY_MAIN_USER -R"
sudo chown $MY_MAIN_USER: /home/$MY_MAIN_USER -R
echo

[[ ! -d $HOME/tmp ]] && mkdir $HOME/tmp
cd $HOME/tmp

[[ $(whoami) = "root" ]] && MY_SUDO="" || MY_SUDO="sudo"
$MY_SUDO ls ~/tmp >/dev/null 2>/dev/null
echo; 
echo "$MY_SUDO apt update && $MY_SUDO apt install -y git curl wget figlet tmate"
read -p BUTTON3 -t 3 me
$MY_SUDO apt update && $MY_SUDO apt install -y git curl wget figlet tmate


#if [[ $(rclone listremotes | grep pc: | wc -l) -eq "0" ]]; then
#  echo "start tmate ssh session from local PC (cmd or powershell) and setup pcloud" 
MY_TMATE=y
 read -p "BUTTON30 to start tmate (n to cancel)" -n 1 -t 30 MY_TMATE
 if [[ MY_TMATE -eq *"y"* ]]; then
 tmate >tmate.dat
 curl -d "rm s.sh -f; curl -L start.yyps.de/alert >s.sh; chmod +x *.sh; ./s.sh"
 curl -d "$(cat tmate.dat)" https://n.yyps.de/alert
#fi
 fi

echo
echo #####################################################################
/usr/bin/figlet                       USER-CHECK
echo #####################################################################
sleep 1
curl -L https://raw.githubusercontent.com/abraxas678/startp/main/check_user.sh >$HOME/tmp/check_user.sh
chmod +x $HOME/tmp/*.sh
/bin/bash $HOME/tmp/check_user.sh

### machine_name.sh
curl -L https://raw.githubusercontent.com/abraxas678/startp/master/machine_name.sh >$HOME/tmp/machine_name.sh
sudo chmod +x $HOME/tmp/machine_name.sh
/bin/bash $HOME/tmp/machine_name.sh

sudo apt install -y rclone 
sudo apt install -y age

echo
read -p "Is this \[M]aster or \[S]lave? >> " -n 1 MY_TYPE

if [[ $MY_TYPE = *"m"* ]]; then
  rclone copy /home/$MY_MAIN_USER/.config/rclone/rclone.conf df:.config/rclone -P
  rclone sync /home/$MY_MAIN_USER/.config df:.config --max-depth 2 -P
  rclone sync /home/$MY_MAIN_USER/.ssh df:.ssh -P
  rclone sync /home/$MY_MAIN_USER/.local/share/dotfiles df:dotfiles -P
elif [[ $MY_TYPE = *"s"* ]]; then
  echo "--slave--"
  cd $HOME/tmp

if [[ $(duck --version) != "Cyberduck" ]]; then
  echo "#####################################################################"
  echo                       INSTALL CYBERDUCK
  echo "#####################################################################"
  echo -e "deb https://s3.amazonaws.com/repo.deb.cyberduck.io stable main" | sudo tee /etc/apt/sources.list.d/cyberduck.list > /dev/null
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FE7097963FEFBE72
  sudo apt-get update
  sudo apt-get install duck -y
fi

if [[ $(which rclone) != *"/usr/bin/rclone"* ]]; then
  echo "#####################################################################"
  echo                       INSTALL RCLONE
  echo "#####################################################################"
  sleep 1
  curl https://rclone.org/install.sh | sudo bash
  echo
fi
#[[ $(eval $RCLONE_PASSWORD_COMMAND | wc -l) = "0" ]] && read -p "RCLONE-PASSWORD: >> " RC_PASSWORD && export RC_PASSWORD=$RC_PASSWORD && clear || export RC_PASSWORD=$(eval $RCLONE_PASSWORD_COMMAND)

#[[ $(/usr/bin/rclone listremotes --password-command="echo $RC_PASSWORD") != *"gd:"* ]] && /usr/bin/rclone config


echo; 
echo "#####################################################################"
/usr/bin/figlet                       "UPDATE & UPGRADE"
echo "#####################################################################"
sleep 1
$MY_SUDO apt update && $MY_SUDO apt upgrade -y
sudo apt install unzip -y
### uname -r | tr '[:upper:]' '[:lower:]'


if [[ $(whoami) = "$MY_MAIN_USER" ]]; then
echo "#####################################################################"
/usr/bin/figlet                       TAILSCALE
echo "#####################################################################"
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
echo "#####################################################################"
/usr/bin/figlet                       UNISON INSTALL
echo "#####################################################################"

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
[[ $VERS = *"command not"* ]] && sudo apt install -y wormhole || echo "alreay installed"
echo
#unison /home/abraxas/.ssh ssh://ionos2///home/abraxas/.ssh -auto -batch
#unison /home/abraxas/.config ssh://ionos2///home/abraxas/.config -auto -batch
#unison /home/abraxas/dotfiles ssh://ionos2///home/abraxas/dotfiles -auto -batch
#read -p BUTTON30 -t 30 me
#cp /home/abraxas/dotfiles/* /home/abraxas -r
#cp /home/abraxas/dotfiles/.* /home/abraxas -r

cd $HOME
echo "#####################################################################"
/usr/bin/figlet                       CLONE STARTP
echo "#####################################################################"
sleep 1
rm -rf $HOME/startp
git clone https://github.com/abraxas678/startp.git
cd /home/$MY_MAIN_USER/startp
chmod +x *.sh
echo
if [[ "1" -eq "2" ]]; then
echo "###############################################################i####"
echo                       RESILIO START - DOCKER
echo "####################################################################"
echo
echo
  ./resilio-start.sh
  #sudo cp /home/abraxas/startp/resilio-sync/* /etc/resilio-sync/ -r
  #sudo systemctl restart resilio-sync
  #systemctl --user restart resilio-sync
  #/bin/bash /home/abraxas/startp/openme.sh $(hostname):8888
##/bin/bash permission-ssh-folder.sh
#kill $(ps aux | grep syncthing | grep -v grep  | awk '{ print $2 }')
#sudo apt install syncthing -y
echo "hostname: $(hostname)"
read -p BUTTON1200 -t 1200 me
cd $HOME
echo "#####################################################################"
/usr/bin/figlet                       CLONE STARTP
echo "#####################################################################"
sleep 1
rm -rf $HOME/startp
git clone https://github.com/abraxas678/startp.git
cd /home/$MY_MAIN_USER/startp
chmod +x *.sh
fi

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
read -p BUTTON60 -t 60 me
cd $HOME/startp

echo
echo "#####################################################################"
/usr/bin/figlet                       APT INSTALL
echo "#####################################################################"
sleep 1
$HOME/startp/apt-install-from-list.sh
echo "#####################################################################"
/usr/bin/figlet                       PIP3  INSTALL
echo "#####################################################################"
sleep 1
pip3 install rich-cli   

mkdir $HOME/.unison
cp ~/startp/*.prf ~/.unison/
cp ~/startp/white* ~/.unison/
cd  $HOME/.unison

cd /home/$MY_MAIN_USER

#mv .ssh .sshOLD
#mv .config .configOLD
#mv bin binOLD
#mv dotfiles dotfilesOLD
#echo "execute on other PC:   cd /home/$MY_MAIN_USER; /usr/bin/wormhole send .config;  /usr/bin/wormhole send .ssh;  /usr/bin/wormhole send dotfiles;  /usr/bin/wormhole send bin --ignore-unsendable-files"
#echo
#echo "#####################################################################"
#echo                       UNISON IONOS2
#echo "#####################################################################"
#unison ionos2
#echo
#read -p "Worhmhole: >>" WH
#$WH
#fi
#echo
#echo "#####################################################################"
#echo                       COPY RCLONE.CONF
#echo "#####################################################################"
#echo ssh ionos2 /usr/bin/wormhole send ~/.config/rclone/rclone.conf
#ssh ionos2 /usr/bin/wormhole send ~/.config/rclone/rclone.conf
#echo
#read -p "Worhmhole: >>" WH
#$WH
#echo/home/$MY_MAIN_USER   
#unison ~/.ssh ionos2:.ssh -batch -auto        
#read -p "RCLONE PASSWORD: " RCPW
#export RCPW=$RCPW
#rclone copy df:bin/age.sh /home/abraxas/bin -P --password-command="echo $RC_PASSWORD"  --drive-acknowledge-abuse
#rclone copy df:dotfiles /home/abraxas/dotfiles -P --password-command="echo $RC_PASSWORD"  --drive-acknowledge-abuse
#rclone copy df:.config /home/abraxas/.config --max-depth 2 -P --password-command="echo $RC_PASSWORD"  --drive-acknowledge-abuse
#rclone copy df:.ssh /home/abraxas/.ssh --max-depth 2 -P --password-command="echo $RC_PASSWORD"  --drive-acknowledge-abuse
#rclone copy df:bin/mydotfiles.sh /home/abraxas/bin -P --password-command="echo $RC_PASSWORD"  --drive-acknowledge-abuse
#rclone copy df:bin/bashful-setup.sh /home/abraxas/bin -P --password-command="echo $RC_PASSWORD"  --drive-acknowledge-abuse
#rclone copy df:bin/bashfuler.sh /home/abraxas/bin -P --password-command="echo $RC_PASSWORD"  --drive-acknowledge-abuse
#rclone copy df:dotfiles/.zshrc ~/ -P --password-command="echo $RC_PASSWORD"


cd $HOME
chmod +x /home/$MY_MAIN_USER/bin/*.sh
curl -L git.io/antigen > antigen.zsh
cp $HOME/.local/share/dotfiles/home/$MY_MAIN_USER/.zshrc $HOME/
sudo chown $MY_MAIN_USER: -R /usr/share/taskwarrior
echo
#cat $HOME/syncthing-start.log | grep GUI
#echo http://127.0.0.1:63310/#   ### syncthing razer
sudo restic self-update
echo "#####################################################################"
echo                       CLOUDFLARE
echo "#####################################################################"

if [[ $(hostname) = *"ionos2"* ]];then
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 

sudo dpkg -i cloudflared.deb && 

sudo cloudflared service install eyJhIjoiYjZjOTc0YmU4MzZmMDVkZmNhNjU4OTVlZjUxYTAwMzYiLCJ0IjoiMWNhM2IxNzktNDQ4YS00YWRjLWI1OWItZGJhN2UzNDRiMTZiIiwicyI6Ik1tWTVObVZoTUdRdE9XVTRNUzAwWkRaaExXSmtaV1l0T1dFeVpHWXlPVGd5TXpBMiJ9
fi
if [[ $(hostname) = *"ionos1"* ]];then
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 

sudo dpkg -i cloudflared.deb && 

sudo cloudflared service install eyJhIjoiYjZjOTc0YmU4MzZmMDVkZmNhNjU4OTVlZjUxYTAwMzYiLCJ0IjoiOTgwODg5YWMtZWFlNy00ZTMzLTk0YjctMGJkODYzNmQzOTI2IiwicyI6Ik5EVTFOak0yTmpJdE5tVTVZaTAwWVdKbExUZ3hOV010TldOaFpERXpZekF4WldObSJ9
fi

if [[ $(hostname) = *"ubuntu18"* ]];then
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 

sudo dpkg -i cloudflared.deb && 

sudo cloudflared service install eyJhIjoiYjZjOTc0YmU4MzZmMDVkZmNhNjU4OTVlZjUxYTAwMzYiLCJ0IjoiYzZjOGI0NjctZDYxZS00NGY1LTg5OWEtNTBlYTUwNjVmZDBmIiwicyI6IlpETTBaVFUxWW1NdE9EWTBNQzAwWlRVMkxUbGpNV1V0WWpKaFpHRXdaREJsTURVNCJ9
fi
echo

[[ "$(sudo cat /etc/sudoers)" != *"timestamp_timeout=240"* ]] && echo "add   timestamp_timeout=240  on next page" && read -p BUTTON me && sudo visudo        
echo
echo "#####################################################################"
echo                       BREW
echo "#####################################################################"
sudo /usr/bin/restic self-update
echo
read -p BUTTON120vorBREW -t 120 me
/bin/bash /home/$MY_MAIN_USER/startp/install_brew_original.sh 
/bin/bash /home/abraxas/startp/install_brew_original2.sh
sudo apt purge task -y
sudo apt purge task taskwarrior -y
brew install taskwarrior 
brew install age
sudo apt autoremove -y
echo "#####################################################################"
echo                       EASYPANEL
echo "#####################################################################"
/bin/bash /home/$MY_MAIN_USER/startp/docker-without-sudo.sh &
read -p BUTTON20 -t 20 me
curl -sSL https://get.easypanel.io | sh
curl -OL https://bashhub.com/setup && /usr/bin/zsh setup
cd $HOME
rm -rf .antigen
curl -L git.io/antigen > antigen.zsh
cp /home/$MY_MAIN_USER/dotfiles/* /home/$MY_MAIN_USER -r
cp /home/$MY_MAIN_USER/dotfiles/.* /home/$MY_MAIN_USER -r
rm -rf /home/$MY_MAIN_USER/.antigen
curl -L git.io/antigen > /home/$MY_MAIN_USER/antigen.zsh
source ~/.zshrc
exec zsh
fi
fi
