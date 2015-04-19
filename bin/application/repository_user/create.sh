#!/bin/bash

login="$1"
repository="$2"
id="$3"

echo "[server] Adding $login/$repository symlink"
sudo -u $login /bin/ln -s /home/git/$repository.git /home/$login/$repository.git
echo "[server] Adding $login user to repository_$id group"
sudo /usr/sbin/addgroup $login repository_$id