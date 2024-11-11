apt update -y && apt upgrade -y && apt install build-essential cmake curl wget git nano vim iproute2 procps grep libboost-all-dev gdb tmux ninja -y
wget -O gh_2.61.0_linux_arm64.deb "https://objects.githubusercontent.com/github-production-release-asset-2e65be/212613049/4bad0e61-5414-4557-9acb-3a859a55c74a?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20241111%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241111T072525Z&X-Amz-Expires=300&X-Amz-Signature=1a32bd741999e70f34d4a0174b647327ae6f5ac11d1e82b1c174aaef02cb4ee8&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dgh_2.61.0_linux_arm64.deb&response-content-type=application%2Foctet-stream"
dpkg -i gh_2.61.0_linux_arm64.deb
wget http://ftp.debian.org/debian/pool/main/p/python3-defaults/python3-all-dev_3.12.6-1_arm64.deb
dpkg -i python3-all-dev_3.12.6-1_arm64.deb
wget http://ftp.debian.org/debian/pool/main/p/python3-defaults/python3-venv_3.12.6-1_arm64.deb
dpkg -i python3-venv_3.12.6-1_arm64.deb
wget http://ftp.debian.org/debian/pool/main/p/python-pip/python3-pip_24.3.1+dfsg-1_all.deb
dpkg -i python3-pip_24.3.1+dfsg-1_all.deb
pip3 install numpy sympy matplotlib setup tools selenium jupyter pandas meson conda