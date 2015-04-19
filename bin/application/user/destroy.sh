#!/bin/bash

echo "[server] Deleting $1 user"
sudo /usr/sbin/userdel -r -f $1