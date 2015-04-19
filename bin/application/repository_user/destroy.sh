#!/bin/bash

login="$1"
repository="$2"
id="$3"

echo "[server] Removing $login/$repository symlink"
sudo -u $login /bin/rm /home/$login/$repository.git
echo "[server] Removing $login user from repository_$id group"
sudo /usr/sbin/delgroup $login repository_$id
