#!/bin/bash

echo "[server] Adding $1 user"
sudo /usr/sbin/useradd -m -s /usr/bin/git-shell -b /home/$1 -c "Repohub $1" -d /home/$1 $1
