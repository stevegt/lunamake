
# Configure

git clone repo 
cd lunamake
git checkout -b local
vi main.conf # and localize it
vi Makefile # and localize it
mkdir stow # and populate it 
vi triggers # and localize 
git add .
git commit
git push --all

# Install

git clone repo /var/lunamake
cd /var/lunamake
git checkout local

# Run

/var/lunamake/lunamake BOOT  # e.g.

