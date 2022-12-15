#!/bin/bash
$HOME/bin/sudo.sh ls >/dev/null 2>/dev/null
#[[ -f /home/abraxas/mnt/razer/MOUNT_CHECK ]] && sudo umount /home/abraxas/mnt/razer >/dev/null 2>/dev/null
[[ ! -d /home/abraxas/mnt/razer ]] && mkdir /home/abraxas/mnt/razer >/dev/null 2>/dev/null
#[[ ! -f /home/abraxas/mnt/razer/MOUNT_CHECK ]] && sudo chown abraxas: -R /home/abraxas/mnt/razer
#sudo chmod 750 -R /home/abraxas/mnt/razer
#sshpass -p $(~/.config/ra_pw.sh) sshfs amdam_wg6r@razer: /home/abraxas/mnt/razer
#sshfs -o password_stdin amdam_wg6r@razer: /home/abraxas/mnt/razer <<< '$(age.sh --decrypt -i ~/.ssh/age-keys.txt ~/.config/razer.age)'
#timeout 5 echo '$(age.sh --decrypt -i ~/.ssh/age-keys.txt ~/.config/razer.age)' | xclip
#sshfs abraxas@100.64.7.101: /home/abraxas/mnt/razer 
echo $(~/.config/ra_pw.sh) | sshfs -o password_stdin abraxas@razer: /home/abraxas/mnt/razer
x=1
while [[ $x -lt "20" ]]; do
#  [[ $(ls  /home/abraxas/mnt/razer/MOUNT_CHECK) != *"No such file"* ]] && $RICH --print "successfully mounted" --style green && x=30 || x=$((x+1))
  [[ $(cat /home/abraxas/mnt/razer/MOUNT_CHECK) = *"razer"* ]] && echo "RAZER is mounted ~/mnt/razer" && exit
  x=$((x+1))
  sleep 1
done
