apt update -y && apt upgrade -y && apt install build-essential cmake python3-all-dev python3-venv curl wget git nano vim iproute2 procps grep libboost-all-dev gdb tmux -y
wget -O gh_2.61.0_linux_arm64.deb "https://objects.githubusercontent.com/github-production-release-asset-2e65be/212613049/4bad0e61-5414-4557-9acb-3a859a55c74a?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20241111%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241111T072525Z&X-Amz-Expires=300&X-Amz-Signature=1a32bd741999e70f34d4a0174b647327ae6f5ac11d1e82b1c174aaef02cb4ee8&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dgh_2.61.0_linux_arm64.deb&response-content-type=application%2Foctet-stream"
dpkg -i gh_2.61.0_linux_arm64.deb
wget https://bootstrap.pypa.io/pip/3.7/get-pip.py
python3 get-pip.py
pip3 install numpy sympy matplotlib setup tools selenium jupyter pandas meson conda