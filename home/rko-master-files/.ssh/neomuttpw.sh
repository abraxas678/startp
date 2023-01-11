#!/bin/bash
$HOME/bin/secmount.sh "od:" "/home/abraxas/mnt/od/" 30 &
while [[ ! -f /home/abraxas/mnt/od/mykeys3.old.kdbx ]]; do 
sleep 1
done
age --decrypt -i ~/.ssh/age-keys.txt ~/.ssh/MPW.age | keepassxc-cli show -k ~/.ssh/mykeys3.keyx -s /home/abraxas/mnt/od/mykeys3.old.kdbx neomutt | sed -n 3p | cut -c11- | tail -n -1
