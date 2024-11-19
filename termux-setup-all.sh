#!/data/data/com.termux/files/usr/bin/bash
pkg update
pkg install android-tools apksigner automake bash build-essential bzip2 clang cmake command-not-found curl dbus debootstrap dpkg fdroidcl ffmpeg file fontconfig-utils fontconfig freetype gdb gh git glab-cli golang grep iproute2 make maven mc nano ncurses-utils neovim nodejs openjdk-17-x openjdk-17 openssh-sftp-server openssh openssl-tool openssl perl procps proot proot-distro python-ensurepip-wheels python-pip python qemu-common qemu-utils ruby rust tar termux-am-socket termux-am termux-api termux-auth termux-exec termux-keyring termux-licenses termux-tools tmux tor torsocks vim wget which x11-repo -y && pkg install termux-x11-nightly -y
apt install qemu-system-x86_64 tigervnc xfce4 -y
cd ~ && mkdir -p .shortcuts && cp ~/termux-sh/DOTshortcuts/* ~/.shortcuts && cat ~/termux-sh/DOTbashrc >> ~/.bashrc && cp ~/termux-sh/DOTshortcuts/* ~ && cd ~ && source .bashrc && chmod +x ~/.shortcuts/*.sh && chmod +x ~/*.sh
sed '/allow-external-apps/s/^# //' -i ~/.termux/termux.properties && termux-reload-settings
cd ~ && echo 'termux-change-repo && pkg update && pkg upgrade -y && apt update && apt upgrade -y && exit' | ./termux-proot.sh
cd ~ && wget https://andronixos.sfo2.cdn.digitaloceanspaces.com/OS-Files/setup-audio.sh && chmod +x setup-audio.sh && ./setup-audio.sh
cd ~ && go install github.com/danielmiessler/fabric@latest
npm install node-html-markdown && npm install showdown && npm install jsdom
mkdir -p .termux && cd ~/.termux && wget https://github.com/zanjie1999/windows-fonts/raw/wine/msyh.ttc
cd ~ && mkdir debian1 && cd debian1 && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian.sh -O debian.sh && chmod +x debian.sh && echo 'exit' | bash debian.sh
cd ~ && mkdir debian2 && cd debian2 && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian-xfce.sh -O debian-xfce.sh && chmod +x debian-xfce.sh && bash debian-xfce.sh
cd ~ && mkdir debian3 && cd debian3 && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian.sh -O debian.sh && chmod +x debian.sh && echo 'exit' | bash debian.sh
cd ~ && cp ~/termux-sh/debian1-setup.sh ~/debian1/debian-fs/root && cp ~/termux-sh/debian2-setup.sh ~/debian2/debian-fs/root && cp ~/termux-sh/debian3-setup.sh ~/debian3/debian-fs/root
cd ~ && proot-distro install debian
cd ~ && ./termux-sh/proot-install-debian01.sh
cd ~ && cd debian1 && echo 'chmod +x debian1-setup.sh && ./debian1-setup.sh && rm debian1-setup.sh && exit' | ./start-debian.sh
cd ~ && cd debian2 && echo 'chmod +x debian2-setup.sh && ./debian2-setup.sh && rm debian2-setup.sh && exit' | ./start-debian.sh
cd ~ && cd debian3 && echo 'chmod +x debian3-setup.sh && ./debian3-setup.sh && rm debian3-setup.sh && exit' | ./start-debian.sh
cd ~ && cat ~/termux-sh/debian-bookworm.sh ~/termux-sh/box64-wine64-winetricks.sh <(echo 'exit') | ./proot-debian.sh
cd ~ && echo 'apt update && apt upgrade -y' | ./proot-debian01.sh
cd ~