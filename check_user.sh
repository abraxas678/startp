#!/bin/bash
USER=$(whoami)
echo "#####################################################################"
echo "                      CHECKING USER DETAILS                          "
echo "#####################################################################"
echo "CURRENT USER: $USER"
read -t 1 me
#echo  >/home/abraxas/mysudo
### && [[ ! $(id -u abraxas) ]]
if [[ $USER != "abraxas" ]]; then
  adduser abraxas 
  passwd abraxas 
  usermod -aG sudo  abraxas 
  su abraxas
fi
#[[ $USER != "abraxas" ]] && su abraxas
[[ $USER != "abraxas" ]] && echo BUTTON && read me || read -t 1 me

