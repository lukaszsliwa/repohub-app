#!/bin/bash

repository="$1"
id="$2"

cd /home/git
echo "[server] Removing /home/git/$repository.git"
sudo -u git /bin/rm -rf /home/git/$repository.git
echo "[server] Deleting repository_$id group"
sudo /usr/sbin/delgroup repository_$id