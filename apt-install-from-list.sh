#!/bin/bash
for line in $(cat apt-install.list); do
  echo; echo $line
  sudo apt install -y $line
  sleep 1
done
