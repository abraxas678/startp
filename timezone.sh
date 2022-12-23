#!/bin/bash
sudo dpkg-reconfigure tzdata
sleep 1; printf "your time now: "; sudo hwclock --show
