#!/data/data/com.termux/files/usr/bin/bash

cd ~
git clone https://github.com/Willie169/termux-sh.git
cd termux-sh
perl -i -pe 's/^DEBIANINSTALL=0/DEBIANINSTALL=1/;
s/^( *)(pkg|pip|npm|proot-distro)/$1\/entrypoint.sh $2/;
s/(\&\&|\|\|) (pkg|pip|npm|proot-distro)/$1 \/entrypoint.sh $2/;
s/pkg install (\$PKG|xfce4 -y)/pkg install $1 -s/;
s/\.\/ubuntu-debian.sh/.\/ubuntu-debian.sh --test/' termux-setup.sh
bash ~/termux-sh/termux-setup.sh
