#!/data/data/com.termux/files/usr/bin/bash

cd ~
pkg update
pkg install git perl -y
git clone https://github.com/Willie169/termux-sh.git
cd termux-sh
perl -i -pe 's/^DEBIANINSTALL=0/DEBIANINSTALL=1/;
s/^( *)(pkg|pip|npm|proot-distro)/$1\/entrypoint.sh $2/;
s/(\&\&|\|\|) (pkg|pip|npm|proot-distro)/$1 \/entrypoint.sh $2/;
s/pkg install (\$PKG|xfce4 -y)/pkg install $1 -s/;
s/\.\/ubuntu-debian.sh/.\/ubuntu-debian.sh --test/' termux-setup.sh
./termux-setup.sh --test
exit
