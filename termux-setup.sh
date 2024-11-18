#!/data/data/com.termux/files/usr/bin/bash
pkg install android-tools apksigner automake bash build-essential bzip2 clang cmake command-not-found curl dbus debootstrap dpkg fdroidcl ffmpeg file fontconfig-utils fontconfig freetype gdb gh git glab-cli golang grep iproute2 make maven mc nano ncurses-utils neovim nodejs openjdk-17-x openjdk-17 openssh-sftp-server openssh openssl-tool openssl perl procps proot proot-distro python-ensurepip-wheels python-pip python qemu-common qemu-utils ruby rust tar termux-am-socket termux-am termux-api termux-auth termux-exec termux-keyring termux-licenses termux-tools tmux tor torsocks vim wget which x11-repo -y
pkg install termux-x11-nightly -y
apt install qemu-system-x86_64 tigervnc xfce4 -y
cd ~ && mkdir -p .shortcuts && cp ~/termux-sh/DOTshortcuts/* ~/.shortcuts && cp ~/termux-sh/DOTbashrc ~/.bashrc && cp ~/termux-sh/DOTshortcuts/* ~
source .bashrc && chmod +x ~/.shortcuts/*.sh && chmod +x ~/*.sh
sed '/allow-external-apps/s/^# //' -i ~/.termux/termux.properties && termux-reload-settings        && wget 'https://github.com/termux/termux-x11/releases/download/nightly/termux-x11-nightly-1.03.01-0-all.deb' -O termux-x11-nightly-all.deb && dpkg -i termux-x11-nightly-all.deb
wget https://andronixos.sfo2.cdn.digitaloceanspaces.com/OS-Files/setup-audio.sh && chmod +x setup-audio.sh && ./setup-audio.sh
wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-nocloud-amd64.qcow2
go install github.com/danielmiessler/fabric@latest
npm install node-html-markdown && npm install showdown && npm install jsdom
mkdir -p .termux && cd ~/.termux && wget https://github.com/zanjie1999/windows-fonts/raw/wine/msyh.ttc && wget https://raw.githubusercontent.com/ButTaiwan/iansui/main/fonts%2FIansui-Regular.ttf && cd ~
curl -sLo ~/termux-proot.sh https://github.com/Yonle/termux-proot/raw/v1.0.0/termux && chmod +x ~/termux-proot.sh && echo 'exit' | ~/termux-proot.sh
cd ~ && mkdir debian1 && cd debian1 && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian.sh -O debian.sh && chmod +x debian.sh && echo 'exit' | bash debian.sh
cd ~ && mkdir debian2 && cd debian2 && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian-xfce.sh -O debian-xfce.sh && chmod +x debian-xfce.sh && echo 'exit' | bash debian-xfce.sh
cd ~ && mkdir debian3 && cd debian3 && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian.sh -O debian.sh && chmod +x debian.sh && echo 'exit' | bash debian.sh
cd ~ && cp ~/termux-sh/debian1-setup.sh ~/debian1/debian-fs/root && cp ~/termux-sh/debian2-setup.sh ~/debian2/debian-fs/root && cp ~/termux-sh/debian3-setup.sh ~/debian3/debian-fs/root
cd ~ && proot-distro install debian