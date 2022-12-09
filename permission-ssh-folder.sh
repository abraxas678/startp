#!/bin/bash
chmod go-w /home/$USER
chmod 700 /home/$USER/.ssh
chmod 644 /home/$USER/.ssh/authorized_keys
chown $USER: /home/$USER/.ssh/authorized_keys
chown $USER: /home/$USER/.ssh
sudo service ssh restart
chmod 644 /home/$USER/.ssh/*.pub
chmod 600 /home/$USER/.ssh/id*
