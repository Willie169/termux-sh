apt update --allow-releaseinfo-change -y && apt upgrade -y && apt install automake bash build-essential bzip2 clang cmake command-not-found curl dbus file gdb git golang grep libboost-all-dev libeigen3-dev libgsl-dev libssl-dev iproute2 jq make maven mc mlocate nano neovim nodejs npm openjdk-11-jdk openssh-client openssh-server openssl perl perl-doc procps python3-all-dev python3-venv ruby sudo tar tmux vim wget zsh -y
wget 'https://github.com/cli/cli/releases/download/v2.61.0/gh_2.61.0_linux_arm64.deb' -O gh_2.61.0_linux_arm64.deb
dpkg -i gh_2.61.0_linux_arm64.deb
rm gh_2.61.0_linux_arm64.deb
wget https://bootstrap.pypa.io/pip/3.7/get-pip.py
python3 -m venv myenv
source myenv/bin/activate
python3 get-pip.py
rm get-pip.py
pip3 install numpy sympy matplotlib setup tools selenium jupyter pandas meson ninja
rm -rf .bash_profile
exit