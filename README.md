# LunaMake

The following examples assume:

- you have test and prod environments, with a different
  subdomain for each, e.g. test.example.com, prod.example.com
- you have already cloned lunamake from github and pushed it to your own
  internal git server at ssh://git@gitea.example.com/devops/lunamake.git

You'll need to adjust the examples according to your own local practices.

## Install and configure on test machine

    git clone ssh://git@gitea.example.com/devops/lunamake.git /var/lunamake
    cd /var/lunamake
    git checkout -b test.example.com
    git branch prod.example.com

## Install on prod machine

    git clone -b prod.example.com ssh://git@gitea.example.com/devops/lunamake.git /var/lunamake

## Make some changes 

    cd /var/lunamake/local # on test machine
    vi main.conf Makefile triggers # localize
    cd stow 
    mkdir -p example.com/etc test.example.com/etc prod.example.com/etc
    # e.g. same kerberos servers everywhere
    vi example.com/etc/etc/krb5.conf  
    # e.g. different dns servers per subdomain
    vi test.example.com/etc/resolv.conf prod.example.com/etc/resolv.conf 
    cd /var/lunamake
    git add .
    git commit
    git push --all 

## Run on test machine

    /var/lunamake/bin/lunamake BOOT  # e.g.

## Release to prod 

    cd /var/lunamake/local # on prod machine
    git pull
    git merge test.example.com
    /var/lunamake/bin/lunamake BOOT  # e.g.

