#!/bin/bash
mkdir -p ~/.local/bin >/dev/null 2>&1
apt update >/dev/null 2>&1
add-apt-repository universe -y >/dev/null 2>&1
add-apt-repository multiverse -y >/dev/null 2>&1
add-apt-repository restricted -y >/dev/null 2>&1
apt purge rustup -y >/dev/null 2>&1
DEBIAN_FRONTEND=noninteractive apt install apt-transport-https bash build-essential ca-certificates coreutils cmake curl dbus g++ gcc git gnupg grep gzip jq locales lsb-release make ninja-build perl perl-tk wget xz-utils -y -o Dpkg::Options::="--force-confnew" >/dev/null 2>&1
sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen >/dev/null 2>&1
locale-gen en_US.UTF-8 >/dev/null 2>&1
update-locale LANG=en_US.UTF-8 >/dev/null 2>&1
rm -f .bashrc >/dev/null 2>&1
mkdir ~/.bashrc.d >/dev/null 2>&1
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/00-env.sh -O ~/.bashrc.d/00-env.sh >/dev/null 2>&1
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/10-exports.sh -O ~/.bashrc.d/10-exports.sh >/dev/null 2>&1
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/15-color.sh -O ~/.bashrc.d/15-color.sh >/dev/null 2>&1
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/20-aliases.sh -O ~/.bashrc.d/20-aliases.sh >/dev/null 2>&1
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/21-cxx.sh -O ~/.bashrc.d/21-cxx.sh >/dev/null 2>&1
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/22-java.sh -O ~/.bashrc.d/22-java.sh >/dev/null 2>&1
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/23-vnc.sh -O ~/.bashrc.d/23-vnc.sh >/dev/null 2>&1
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/50-functions.sh -O ~/.bashrc.d/50-functions.sh >/dev/null 2>&1
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/60-completion.sh -O ~/.bashrc.d/60-completion.sh >/dev/null 2>&1
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/bashrc -O ~/.bashrc >/dev/null 2>&1
if [ -d "$HOME/.bashrc.d" ];  then
  for f in "$HOME/.bashrc.d/"*; do
    [ -r "$f" ] && . "$f" >/dev/null 2>&1
  done
fi
set -x
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y >/dev/null 2>&1
. ${HOME}/.cargo/env >/dev/null 2>&1
ls -li /usr/bin/cc
ls -li /etc/alternatives/cc
ls -li /usr/bin/gcc
ls -li /usr/bin/gcc-15
ls -li /usr/bin/aarch64-linux-gnu-gcc-15
#touch /.dockerenv
#git clone https://github.com/jusw85/mozlz4.git
#cd mozlz4 || true
#cargo build --release
#cd target/release || true
#mv mozlz4-bin mozlz4
#mv mozlz4 ~/.local/bin/
#cd ~ || true
#rm -rf mozlz4
exit
