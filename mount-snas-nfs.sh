#!/bin/bash
$HOME/bin/sudo.sh ls >/dev/null 2>/dev/null
[[ ! -d /home/abraxas/mnt/snas ]] && mkdir /home/abraxas/mnt/snas >/dev/null 2>/dev/null
[[ ! -d /home/abraxas/mnt/snas/homes ]] && mkdir /home/abraxas/mnt/snas/homes >/dev/null 2>/dev/null
#[[ ! -f /home/abraxas/mnt/razer/MOUNT_CHECK ]] && sudo chown abraxas: -R /home/abraxas/mnt/razer
#sudo chmod 750 -R /home/abraxas/mnt/razer
#sshpass -p $(~/.config/ra_pw.sh) sshfs amdam_wg6r@razer: /home/abraxas/mnt/razer
#sshfs -o password_stdin amdam_wg6r@razer: /home/abraxas/mnt/razer <<< '$(age.sh --decrypt -i ~/.ssh/age-keys.txt ~/.config/razer.age)'
#timeout 5 echo '$(age.sh --decrypt -i ~/.ssh/age-keys.txt ~/.config/razer.age)' | xclip
#sshfs abraxas@100.64.7.101: /home/abraxas/mnt/razer 
#echo $(~/.config/ra_pw.sh) | sshfs -o password_stdin abraxas@razer: /home/abraxas/mnt/razer
$HOME/bin/sudo.sh mount -t nfs 100.94.192.135:volume1/homes /home/abraxas/mnt/snas/homes  
x=1
while [[ $x -lt "20" ]]; do
#  [[ $(ls  /home/abraxas/mnt/razer/MOUNT_CHECK) != *"No such file"* ]] && $RICH --print "successfully mounted" --style green && x=30 || x=$((x+1))
  [[ $(cat /home/abraxas/mnt/snas/homes/abraxas/MOUNT_CHECK) = *"snas/homes/abraxas/"* ]] && echo "SNAS is mounted ~/mnt/snas/homes" && exit
  x=$((x+1))
  sleep 1
done
