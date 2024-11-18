apt update && apt upgrade -y && apt install automake bash build-essential bzip2 clang cmake command-not-found curl dbus file gdb gh git golang grep libboost-all-dev libssl-dev iproute2 make maven mc nano neovim nodejs openjdk-17-jdk openssh-client openssh-server openssl perl procps python3-pip python3-all-dev python3-venv rust-all tar tmux vim wget -y
python3 -m venv myenv
source myenv/bin/activate
pip3 install numpy sympy matplotlib setuptools selenium jupyter pandas meson ninja
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"