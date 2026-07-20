#!/bin/bash
mkdir -p ~/.local/bin >/dev/null
apt update >/dev/null
add-apt-repository universe -y >/dev/null
add-apt-repository multiverse -y >/dev/null
add-apt-repository restricted -y >/dev/null
apt purge rustup -y >/dev/null
DEBIAN_FRONTEND=noninteractive apt install apt-transport-https bash build-essential ca-certificates coreutils cmake curl dbus g++ gcc git gnupg grep gzip jq locales lsb-release make ninja-build perl perl-tk wget xz-utils -y -o Dpkg::Options::="--force-confnew" >/dev/null
sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen >/dev/null
locale-gen en_US.UTF-8 >/dev/null
update-locale LANG=en_US.UTF-8 >/dev/null
rm -f .bashrc >/dev/null
mkdir ~/.bashrc.d >/dev/null
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/00-env.sh -O ~/.bashrc.d/00-env.sh >/dev/null
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/10-exports.sh -O ~/.bashrc.d/10-exports.sh >/dev/null
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/15-color.sh -O ~/.bashrc.d/15-color.sh >/dev/null
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/20-aliases.sh -O ~/.bashrc.d/20-aliases.sh >/dev/null
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/21-cxx.sh -O ~/.bashrc.d/21-cxx.sh >/dev/null
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/22-java.sh -O ~/.bashrc.d/22-java.sh >/dev/null
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/23-vnc.sh -O ~/.bashrc.d/23-vnc.sh >/dev/null
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/50-functions.sh -O ~/.bashrc.d/50-functions.sh >/dev/null
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/60-completion.sh -O ~/.bashrc.d/60-completion.sh >/dev/null
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/bashrc -O ~/.bashrc >/dev/null
cat > ~/.profile <<'EOF'
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
EOF
if [ -d "$HOME/.bashrc.d" ];  then
  for f in "$HOME/.bashrc.d/"*; do
    [ -r "$f" ] && . "$f" >/dev/null
  done
fi
DEBIAN_FRONTEND=noninteractive apt upgrade -y -o Dpkg::Options::="--force-confnew" >/dev/null
set -x
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
. ${HOME}/.cargo/env
touch /.dockerenv
git clone https://github.com/jusw85/mozlz4.git
cd mozlz4 || true

echo "$PATH"

which -a cc
which gcc

ls -l $(which cc)

readlink -f $(which cc) || true

namei -l $(which cc) || true

env | grep -E '^(CC|CXX|AR|LD|RUSTFLAGS|CARGO_)'

cargo rustc -vV

find .cargo -type f -print -exec cat {} \; || true

cat ~/.cargo/config.toml 2>/dev/null || true

cat ~/.cargo/config 2>/dev/null || true

env | grep '^CC='
env | grep '^CXX='
env | grep '^RUSTFLAGS='
env | grep '^CARGO'

type -a cc
command -V cc
command -v cc

find /usr /usr/local /root/.cargo -name cc -type l -ls
find /usr /usr/local /root/.cargo -name cc -type f -ls

ls -l /usr/bin/cc
ls -l /bin/cc
ls -l /usr/local/bin/cc
ls -l /root/.cargo/bin/cc

strace -f -e execve cargo build 2>&1 | grep execve

strace -f -e execve /root/.rustup/toolchains/stable-aarch64-unknown-linux-gnu/bin/rustc ...

ls -l /etc/alternatives/cc
readlink /etc/alternatives/cc
readlink -f /etc/alternatives/cc || true
namei -l /usr/bin/cc

stat /etc/alternatives/cc

ls -l /usr/bin/gcc
readlink /usr/bin/gcc
readlink -f /usr/bin/gcc

namei -l /usr/bin/cc

echo "$PATH"

for d in $(echo "$PATH" | tr ':' ' '); do
echo "$d"
ls "$d/cc" 2>/dev/null
done

/usr/bin/cc --version
/usr/bin/gcc --version
cc --version
gcc --version

realpath /usr/bin/cc
realpath /usr/bin/gcc

stat /usr/bin/aarch64-linux-gnu-gcc-15

file /usr/bin/aarch64-linux-gnu-gcc-15

readelf -l /usr/bin/aarch64-linux-gnu-gcc-15 | grep interpreter

realpath /lib/ld-linux-aarch64.so.1
ls -l /lib/ld-linux-aarch64.so.1

/usr/bin/aarch64-linux-gnu-gcc-15 --version

cargo build -vv

#cargo build --release
#cd target/release || true
#mv mozlz4-bin mozlz4
#mv mozlz4 ~/.local/bin/
#cd ~ || true
#rm -rf mozlz4
exit
