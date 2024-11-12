apt update -y && apt upgrade -y && apt install automake bash build-essential bzip2 clang cmake command-not-found curl dbus gdb git golang grep libboost-all-dev libssl-dev iproute2 make maven mc nano neovim nodejs openjdk-11-jdk openssh-client openssh-server openssl perl procps python3-pip python3-all-dev python3-venv tar tmux vim wget -y
wget -O gh_2.61.0_linux_arm64.deb "https://objects.githubusercontent.com/github-production-release-asset-2e65be/212613049/4bad0e61-5414-4557-9acb-3a859a55c74a?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20241111%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241111T100051Z&X-Amz-Expires=300&X-Amz-Signature=eb65f19fcdc2aa0276816d646cb63a65bdd7e9a3cc052211f2de4b644f693d9f&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dgh_2.61.0_linux_arm64.deb&response-content-type=application%2Foctet-stream"
dpkg -i gh_2.61.0_linux_arm64.deb
rm gh_2.61.0_linux_arm64.deb
wget https://bootstrap.pypa.io/pip/3.7/get-pip.py
python3 -m venv myenv
source myenv/bin/activate
python3 get-pip.py
pip3 install numpy sympy matplotlib setuptools selenium jupyter pandas meson ninja
rm get-pip.py