#!/data/data/com.termux/files/usr/bin/bash
PKG='android-tools apksigner automake bash build-essential bzip2 clang cmake command-not-found curl dbus debootstrap dpkg fdroidcl ffmpeg file fontconfig-utils fontconfig freetype gdb gh ghostscript git glab-cli golang grep iproute2 jq make maven mc nano ncurses-utils neovim net-tools nodejs openjdk-17-x openjdk-17 openssh-sftp-server openssh openssl-tool openssl perl procps proot proot-distro python-ensurepip-wheels python-pip python ruby rust tar termux-am-socket termux-am termux-api termux-auth termux-exec termux-keyring termux-licenses termux-tools termux-x11-nightly tigervnc tmux tor torsocks vim wget which xfce4 zsh'
PROOTTERMUX=1
AUDIO=1
NPM='jsdom marked node-html-markdown showdown'
GO='github.com/danielmiessler/fabric@latest'
DEBIAN='debian'
DEBIANINSTALL=1
UBUNTU='UBUNTU'
UBUNTUINSTALL=0
DEBIANBOX=''
DEBIANBOXINSTALL=0
BUSTERCLI=''
BUSTERCLIINSTALL=0
BUSTERXFCE=''

cd ~ && pkg update && pkg upgrade -y && pkg install curl x11-repo -y
[ -n "$PKG" ] && pkg install $PKG -y
mkdir -p ~/.shortcuts && cp ~/termux-sh/DOTshortcuts/* ~/.shortcuts && cp ~/termux-sh/DOTshortcuts/* ~ && chmod +x ~/.shortcuts/* && chmod +x ~/*.sh && cp ~/bashrc.sh ~/.bashrc && source ~/.bashrc
[ -f ~/.termux/termux.properties ] && sed '/allow-external-apps/s/^# //' -i ~/.termux/termux.properties && termux-reload-settings
[ "$PROOTTERMUX" -eq 0 ] || echo 'termux-change-repo && pkg update && pkg upgrade -y && apt update && apt upgrade -y && exit' | bash ~/proot-termux.sh
[ "$AUDIO" -eq 0 ] || wget https://andronixos.sfo2.cdn.digitaloceanspaces.com/OS-Files/setup-audio.sh -O ~/setup-audio.sh && bash ~/setup-audio.sh
[ -n "$NPM" ] && npm install --global $NPM
[ -n "$GO" ] && go install $GO
[ -n "$DEBIAN" ] && echo "proot-distro login $DEBIAN --isolated --fix-low-ports" >> ~/proot-$DEBIAN.sh && chmod +x ~/proot-$DEBIAN.sh && cp ~/proot-$DEBIAN.sh ~/.shortcuts && proot-distro install debian --override-alias $DEBIAN && [ "$DEBIANINSTALL" -eq 0 ] || cat ~/termux-sh/debian-bookworm.sh <(echo -e "\nexit") | proot-distro login $DEBIAN --isolated --fix-low-ports
[ -n "$UBUNTU" ] && echo "proot-distro login $UBUNTU --isolated --fix-low-ports" >> ~/proot-$UBUNTU.sh && chmod +x ~/proot-$UBUNTU.sh && cp ~/proot-$UBUNTU.sh ~/.shortcuts && proot-distro install ubuntu --override-alias $UBUNTU && [ "$UBUNTUINSTALL" -eq 0 ] || cat ~/termux-sh/ubuntu-24-04.sh <(echo -e "\nexit") | proot-distro login $UBUNTU --isolated --fix-low-ports
[ -n "$DEBIANBOX" ] && echo "proot-distro login $DEBIANBOX --isolated --fix-low-ports" >> ~/proot-$DEBIANBOX.sh && chmod +x ~/proot-$DEBIANBOX.sh && cp ~/proot-$DEBIANBOX.sh ~/.shortcuts && proot-distro install debian --override-alias $DEBIANBOX && [ "$DEBIANBOXINSTALL" -eq 0 ] || cat ~/termux-sh/box64-wine64-winetricks.sh <(echo -e "\nexit") | proot-distro login $DEBIANBOX --isolated --fix-low-ports
[ -n "$BUSTERCLI" ] && mkdir ~/$BUSTERCLI && echo "bash ~/$BUSTERCLI/start-debian.sh" >> ~/$BUSTERCLI.sh && chmod +x ~/$BUSTERCLI.sh && cp ~/$BUSTERCLI.sh ~/.shortcuts && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian.sh -O ~/$BUSTERCLI/debian.sh && echo 'exit' | bash ~/$BUSTERCLI/debian.sh && [ "$BUSTERCLIINSTALL" -eq 0 ] || cp ~/termux-sh/debian-buster.sh ~/$BUSTERCLI/debian-fs/root/.bash_profile && bash ~/$BUSTERCLI.sh
if [ -n "$BUSTERXFCE" ]; then
    mkdir ~/$BUSTERXFCE && echo "bash ~/$BUSTERXFCE/start-debian.sh" >> ~/$BUSTERXFCE.sh && chmod +x ~/$BUSTERXFCE.sh && cp ~/$BUSTERXFCE.sh ~/.shortcuts && cp ~/termux-sh/debian-xfce-mod.sh ~/$BUSTERXFCE && rm -rf ~/termux-sh && bash ~/$BUSTERXFCE/debian-xfce-mod.sh --after "$(printf "apt update --allow-releaseinfo-change -y && apt --fix-broken install -y && apt upgrade -y && apt install curl -y\necho \"alias exit='vncserver-stop && trap '' INT TERM && builtin exit'\" >> ~/.bashrc && source ~/.bashrc\nrm -rf ~/.bash_profile\nvncserver-stop && trap '' INT TERM\necho 'termux-setup.sh finished'\ncurl parrot.live")"
else
    rm -rf ~/termux-sh
    echo 'termux-setup.sh finished'
    curl parrot.live
fi