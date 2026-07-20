#!/bin/bash
shopt -s expand_aliases
TEST=0
FULL=0
[ "${1:-}" = '--test' ] && TEST=1
[ "${2:-}" = '--test' ] && TEST=1
[ "${1:-}" = '--full' ] && FULL=1
[ "${2:-}" = '--full' ] && FULL=1
# shellcheck disable=2155
PREDF=$(df --output=used / | tail -n1)
cd ~ || exit
mkdir -p /usr/local/java
mkdir -p /etc/apt/keyrings
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/applications
mkdir -p ~/Desktop
mkdir -p ~/.config
tee /etc/resolv.conf >/dev/null <<'EOF'
nameserver 1.1.1.1
nameserver 1.0.0.1
nameserver 2606:4700:4700::1111
nameserver 2606:4700:4700::1001
nameserver 94.140.14.140
nameserver 94.140.14.141
nameserver 2a10:50c0::1:ff
nameserver 2a10:50c0::2:ff
EOF
source /etc/os-release
apt update
if [ "$ID" = "ubuntu" ]; then
f=/etc/apt/sources.list.d/ubuntu.sources
sed -i 's/^Types: *deb.*/Types: deb deb-src/' "$f"
DEBIAN_FRONTEND=noninteractive apt install software-properties-common -y -o Dpkg::Options::="--force-confnew"
add-apt-repository universe -y
add-apt-repository multiverse -y
add-apt-repository restricted -y
add-apt-repository ppa:git-core/ppa -y
add-apt-repository ppa:libreoffice/ppa -y
add-apt-repository ppa:longsleep/golang-backports -y
add-apt-repository ppa:openjdk-r/ppa -y
mv /etc/apt/sources.list.d/openjdk-r-ubuntu-ppa-*.sources /etc/apt/sources.list.d/openjdk-r-ubuntu-ppa-noble.sources || true
sed -i 's/^Suites: .*$/Suites: noble/' /etc/apt/sources.list.d/openjdk-r-ubuntu-ppa-noble.sources
add-apt-repository ppa:mozillateam/ppa -y
add-apt-repository ppa:zhangsongcui3371/fastfetch -y
else
f=/etc/apt/sources.list.d/debian.sources
sed -i 's/^Types: *deb.*/Types: deb deb-src/' "$f"
sed -i 's/\bmain\b.*/main contrib non-free non-free-firmware/' "$f"
fi
apt update
apt purge rustup texlive* yq -y
DEBIAN_FRONTEND=noninteractive apt install apt-transport-https bash build-essential ca-certificates coreutils cmake curl dbus openjdk-21-jdk g++ gcc git gnupg grep gzip jq locales lsb-release make ninja-build openssh-server perl perl-tk python-is-python3 python3 vim-gtk3 wget xz-utils -y -o Dpkg::Options::="--force-confnew"
DEBIAN_FRONTEND=noninteractive apt install sudo -y -o Dpkg::Options::="--force-confnew"
sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8
rm -f .bashrc
mkdir ~/.bashrc.d
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/00-env.sh -O ~/.bashrc.d/00-env.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/10-exports.sh -O ~/.bashrc.d/10-exports.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/15-color.sh -O ~/.bashrc.d/15-color.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/20-aliases.sh -O ~/.bashrc.d/20-aliases.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/21-cxx.sh -O ~/.bashrc.d/21-cxx.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/22-java.sh -O ~/.bashrc.d/22-java.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/23-vnc.sh -O ~/.bashrc.d/23-vnc.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/50-functions.sh -O ~/.bashrc.d/50-functions.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/60-completion.sh -O ~/.bashrc.d/60-completion.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/bashrc -O ~/.bashrc
cat > ~/.profile <<'EOF'
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
EOF
if [ -d "$HOME/.bashrc.d" ];  then
  for f in "$HOME/.bashrc.d/"*; do
    [ -r "$f" ] && . "$f"
  done
fi
DEBIAN_FRONTEND=noninteractive apt upgrade -y -o Dpkg::Options::="--force-confnew"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
NVM_VERSION=$(curl -fsSL "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | jq -r '.tag_name')
PROFILE=/dev/null bash -c "curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts
echo y | corepack enable npm
echo y | npm --help || true
echo y | corepack enable yarn
echo y | yarn --help || true
wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
bash Miniforge3-Linux-aarch64.sh -b -p "${HOME}/conda"
rm Miniforge3-Linux-aarch64.sh*
export MAMBA_ROOT_PREFIX="${HOME}/conda"
source "${HOME}/conda/etc/profile.d/conda.sh" 2>/dev/null
source "${HOME}/conda/etc/profile.d/mamba.sh" 2>/dev/null
conda config --set auto_activate_base false
conda config --add channels pypi
conda config --add channels pytorch
conda config --add channels conda-forge
touch /.dockerenv
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
set -x
git clone https://github.com/jusw85/mozlz4.git
cd mozlz4 || true
echo "$PATH"
which -a cc
which gcc
ls -l $(which cc)
readlink -f $(which cc) || true
namei -l $(which cc) || true
cargo build --release
cd target/release || true
mv mozlz4-bin mozlz4
mv mozlz4 ~/.local/bin/
cd ~ || true
rm -rf mozlz4
[ "$TEST" -eq 0 ] && [ "$FULL" -eq 0 ] && exit || true
