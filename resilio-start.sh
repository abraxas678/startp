#!/bin/bash
echo
echo v .1
echo
echo "====="
echo "MKDIR"
echo "====="
mkdir /home/abraxas/docker >/dev/null 2>/dev/null
mkdir /home/abraxas/docker/resilio >/dev/null 2>/dev/null
mkdir /home/abraxas/docker/resilio/data >/dev/null 2>/dev/null
mkdir /home/abraxas/resilio-moved/ >/dev/null 2>/dev/null
echo
echo "=============="
echo "INSTALL DOCKER"
echo "=============="
sudo apt install docker.io -y
sudo apt install docker-compose -y
echo
echo "==================="
echo "DOCKER WITHOUT SUDO"
echo "==================="
sudo groupadd docker
sudo usermod -aG docker $USER &
newgrp docker &

echo
echo "==========================="
echo "MOVE RESILIO TARGET FOLDERS"
echo "==========================="

x=1
while [[ $x = "1" ]]; do
  read -p "move folder? (y/n) >> " MOVE
  echo "MOVE: $MOVE"
  echo
  [[ $MOVE = "n" ]] && x=0
  if [[ $MOVE = "y" ]]; then
  x=0
    for line in $(cat resilio-folder.dat); do
      echo; echo "moving $line:"
      mv /home/abraxas/$line /home/abraxas/resilio-moved/
    done
  else
    [[ $MOVE = *"n"* ]]  && x=0 | sleep 1 
  fi
done
echo
echo "====================="
echo "CREATE DOCKER-COMPOSE"
echo "====================="

echo "version: '3.3'" >docker-compose.yaml
echo "services:" >>docker-compose.yaml
echo "    sync:" >>docker-compose.yaml
echo "        container_name: resilio" >>docker-compose.yaml
echo "        ports:" >>docker-compose.yaml
echo "            - '0.0.0.0:8888:8888'" >>docker-compose.yaml
echo "            - 55555" >>docker-compose.yaml
echo "        volumes:" >>docker-compose.yaml
echo "            - '/home/abraxas/docker/resilio/data:/mnt/sync'" >>docker-compose.yaml
echo "            - '/home/abraxas:/mnt/mounted_folders/home/abraxas'" >>docker-compose.yaml
echo "        restart: on-failure" >>docker-compose.yaml
echo "        image: resilio/sync" >>docker-compose.yaml

echo
echo "===================="
echo "START DOCKER-COMPOSE"
echo "===================="

sudo docker-compose up -d

echo
echo "==========="
echo "GET IP ADDR"
echo "==========="

sudo apt-get install dnsutils 
echo
echo "your ip:"
dig +short myip.opendns.com @resolver1.opendns.com  
echo
echo now cf tunnel to here to access gui	 
echo
echo "/mnt/mounted_folders/home/abraxas"
exit
/usr/bin/docker run -d --name resilio \
           -p 0.0.0.0:8888:8888 \
           -p 55555 \
           -v /home/abraxas/docker/resilio/data:/mnt/sync \
           -v /home/abraxas:/mnt/mounted_folders/home/abraxas \
           --restart on-failure \
           resilio/sync
