#!/data/data/com.termux/files/usr/bin/bash
pkg upgrade -y && apt update && apt upgrade -y
pkg install android-tools apksigner automake bash build-essential bzip2 clang cmake command-not-found curl dbus debootstrap dpkg fdroidcl ffmpeg file fontconfig-utils fontconfig freetype gdb gh git glab-cli golang grep iproute2 jq make maven mc nano ncurses-utils neovim nodejs openjdk-17-x openjdk-17 openssh-sftp-server openssh openssl-tool openssl perl procps proot proot-distro python-ensurepip-wheels python-pip python ruby rust tar termux-am-socket termux-am termux-api termux-auth termux-exec termux-keyring termux-licenses termux-tools tmux tor torsocks vim wget which x11-repo zsh -y && pkg install termux-x11-nightly -y
apt install tigervnc xfce4 -y
cd ~ && mkdir -p .shortcuts && cp ~/termux-sh/DOTshortcuts/* ~/.shortcuts && cat ~/termux-sh/DOTbashrc >> ~/.bashrc && cp ~/termux-sh/DOTshortcuts/* ~ && cd ~ && source .bashrc && chmod +x ~/.shortcuts/*.sh && chmod +x ~/*.sh
sed '/allow-external-apps/s/^# //' -i ~/.termux/termux.properties && termux-reload-settings
echo 'termux-change-repo && pkg update && pkg upgrade -y && apt update && apt upgrade -y && exit' | bash ~/termux-proot.sh
cd ~/.termux && wget https://github.com/zanjie1999/windows-fonts/raw/wine/msyh.ttc -O font.ttc
cd ~ && wget https://andronixos.sfo2.cdn.digitaloceanspaces.com/OS-Files/setup-audio.sh && bash setup-audio.sh
cd ~ && go install github.com/danielmiessler/fabric@latest
npm install node-html-markdown && npm install showdown && npm install jsdom
mkdir ~/debian1 && cd ~/debian1 && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian.sh -O debian.sh && echo 'exit' | bash debian.sh
mkdir ~/debian2 && cd ~/debian2 && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian.sh -O debian.sh && echo 'exit' | bash debian.sh
proot-distro install debian
proot-distro install ubuntu
bash ~/termux-sh/proot-install-debianbox.sh
cat ~/termux-sh/debian-bookworm.sh <(echo -e "\nexit") | bash ~/proot-debian.sh
cat ~/termux-sh/ubuntu-24-04.sh <(echo -e "\nexit") | bash ~/proot-ubuntu.sh
cat ~/termux-sh/box64-wine64-winetricks.sh <(echo -e "\nexit") | bash ~/proot-debianbox.sh
cp ~/termux-sh/debian-dev.sh ~/debian1/debian-fs/root/.bash_profile && bash ~/debian1.sh
cp ~/termux-sh/debian-texlive.sh ~/debian2/debian-fs/root/.bash_profile && bash ~/debian2.sh
mkdir ~/debian3 && cp ~/termux-sh/debian-xfce-mod.sh ~/debian3 && cd ~/debian3 && bash debian-xfce-mod.sh --after "$(printf "apt update --allow-releaseinfo-change -y && apt --fix-broken install -y && apt upgrade -y && apt install curl -y\necho \"alias exit='vncserver-stop && trap '' INT TERM && builtin exit'\" >> ~/.bashrc && source ~/.bashrc\nrm -rf ~/.bash_profile\nvncserver-stop && trap '' INT TERM\necho 'termux-setup-all.sh finished'\ncurl parrot.live")"