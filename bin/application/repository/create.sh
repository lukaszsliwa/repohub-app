#!/bin/bash

repository="$1"
id="$2"

current_dir=$PWD

echo "[server] Adding repository_$id group"
sudo /usr/sbin/addgroup repository_$id

cd /home/git

echo "[server] Initialize a bare '$repository' repository"
/usr/bin/git --bare init --shared=group $repository.git

echo "Add git user to repository_$id group"
sudo /usr/sbin/addgroup git repository_$id

echo "Generate hooks"
cp $current_dir/config/git/hooks/update /home/git/$repository.git/hooks/update
sed -i -- 's/%{repository}/'$repository'/g' /home/git/$repository.git/hooks/update

echo "[server] Making $repository owned by repository_$id group"
sudo /bin/chown -R git:repository_$id /home/git/$repository.git

echo "[server] Setting ACL permissions on /home/git/$repository.git"
sudo -u git /bin/setfacl -R --set user:lukasz:rwx,user::rwx,other::--x,group::rwx,mask::rwx /home/git/$repository.git
