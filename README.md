# LunaMake

## Configure

git clone repo_from_github
cd lunamake
git checkout -b some_local_name  # suggest e.g. prod.example.com
vi main.conf # localize 
vi Makefile # localize 
mkdir stow # populate  
vi triggers # localize 
git add .
git commit
git push --all local_server

## Install

git clone repo_from_local_server /var/lunamake
cd /var/lunamake
git checkout some_local_name

## Run

/var/lunamake/lunamake BOOT  # e.g.
