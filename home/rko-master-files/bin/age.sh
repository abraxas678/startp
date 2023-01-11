#!/bin/bash
#echo age.sh $(hostname)
if [[ $(hostname) = "snas" ]]
then
  echo "--> [processing via docker container] "
sleep 2
#  echo "[-v /volume1/homes/abraxas678/:/home/abraxas/]"
   sudo docker run -it -v /volume1/homes/abraxas678/:/home/abraxas/ abraxas678/age age $@
else
  myage="$(which age)"
  $myage "$@"
 # [[ -f /usr/local/bin/age ]] &&  /usr/local/bin/age $@ || /usr/bin/age $@
fi
