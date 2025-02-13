apt update && apt upgrade -y && apt install automake bash build-essential bzip2 clang cmake command-not-found curl dbus file gdb gh git golang grep libboost-all-dev libeigen3-dev libssl-dev iproute2 jq make maven mc nano neovim nodejs npm openjdk-17-jdk openssh-client openssh-server openssl perl procps python3-pip python3-all-dev python3-venv rust-all tar tmux vim wget zsh -y
python3 -m venv myenv
source myenv/bin/activate
pip3 install numpy sympy matplotlib setuptools selenium jupyter pandas meson ninja