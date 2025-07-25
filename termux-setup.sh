#!/data/data/com.termux/files/usr/bin/bash
PKG='android-tools apksigner automake bash build-essential bzip2 clang cmake command-not-found curl dbus debootstrap dpkg fdroidcl ffmpeg file fontconfig-utils fontconfig freetype gdb gh ghostscript git glab-cli golang grep iproute2 jq make maven mc nano ncurses-utils neovim net-tools nodejs openjdk-17 openjdk-21 openssh-sftp-server openssh openssl-tool openssl perl procps proot proot-distro python-ensurepip-wheels python-pip python ruby rust tar termux-am-socket termux-am termux-api termux-auth termux-exec termux-keyring termux-licenses termux-tools termux-x11-nightly tigervnc tmux tor torsocks vim wget which xfce4 zsh'
PROOTTERMUX=1
AUDIO=1
NPM='jsdom marked marked-gfm-heading-id node-html-markdown markdown-toc showdown'
DEBIAN='debian'
DEBIANINSTALL=1
UBUNTU='ubuntu'
UBUNTUINSTALL=0
DEBIANBOX=''
DEBIANBOXINSTALL=0
BUSTERCLI=''
BUSTERCLIINSTALL=0
BUSTERXFCE=''

DEBIAN=$(echo "$DEBIAN" | tr ' ' '_')
UBUNTU=$(echo "$UBUNTU" | tr ' ' '_')
DEBIANBOX=$(echo "$DEBIANBOX" | tr ' ' '_')
BUSTERCLI=$(echo "$BUSTERCLI" | tr ' ' '_')
BUSTERXFCE=$(echo "$BUSTERXFCE" | tr ' ' '_')
[ "$DEBIAN" == "adelie" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "alpine" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "archlinux" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "artix" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "chimera" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "deepin" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "fedora" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "manjaro" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "openkylin" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "opensuse" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "pardus" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "rockylinux" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "ubuntu" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "void" ] && DEBIAN="${DEBIAN}1"
[ "$UBUNTU" == "adelie" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "alpine" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "archlinux" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "artix" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "chimera" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "debian" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "deepin" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "fedora" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "manjaro" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "openkylin" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "opensuse" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "pardus" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "rockylinux" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "void" ] && UBUNTU="${UBUNTU}1"
[ "$DEBIANBOX" == "adelie" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "alpine" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "archlinux" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "artix" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "chimera" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "deepin" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "fedora" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "manjaro" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "openkylin" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "opensuse" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "pardus" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "rockylinux" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "ubuntu" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "void" ] && DEBIANBOX="${DEBIANBOX}1"
cd ~ && pkg update && pkg upgrade -y && pkg install curl x11-repo -y
[ -n "$PKG" ] && pkg install $PKG -y
mkdir -p ~/.shortcuts && chmod +x ~/termux-sh/DOTshortcuts/*.sh && cp ~/termux-sh/DOTshortcuts/* ~/.shortcuts && cp ~/termux-sh/DOTshortcuts/* ~ && mv ~/bashrc.sh ~/.bashrc && source ~/.bashrc && mv ~/vimrc ~/.vimrc
[ -f ~/.termux/termux.properties ] && sed '/allow-external-apps/s/^# //' -i ~/.termux/termux.properties && termux-reload-settings
[ "$PROOTTERMUX" -eq 0 ] || echo 'termux-change-repo && pkg update && pkg upgrade -y && apt update && apt upgrade -y && exit' | bash ~/proot-termux.sh
[ "$AUDIO" -eq 0 ] || wget https://andronixos.sfo2.cdn.digitaloceanspaces.com/OS-Files/setup-audio.sh -O ~/setup-audio.sh && bash ~/setup-audio.sh
[ -n "$NPM" ] && npm install --global $NPM
go install github.com/danielmiessler/fabric/cmd/fabric@latest
[ -n "$DEBIAN" ] && [ $DEBIAN != debian ] && echo "proot-distro login $DEBIAN --isolated --fix-low-ports" >> ~/proot-$DEBIAN.sh && chmod +x ~/proot-$DEBIAN.sh && cp ~/proot-$DEBIAN.sh ~/.shortcuts && proot-distro install debian --override-alias $DEBIAN
[ $DEBIAN == debian ] && echo "proot-distro login $DEBIAN --isolated --fix-low-ports" >> ~/proot-$DEBIAN.sh && chmod +x ~/proot-$DEBIAN.sh && cp ~/proot-$DEBIAN.sh ~/.shortcuts && proot-distro install debian
[ -n "$DEBIAN" ] && [ "$DEBIANINSTALL" -eq 0 ] || cat ~/termux-sh/debian-bookworm.sh <(echo -e "\nexit") | proot-distro login $DEBIAN --isolated --fix-low-ports
[ -n "$UBUNTU" ] && [ "$UBUNTU" == "$DEBIAN" ] && UBUNTU="${UBUNTU}1"
[ -n "$UBUNTU" ] && [ $UBUNTU != ubuntu ] && echo "proot-distro login $UBUNTU --isolated --fix-low-ports" >> ~/proot-$UBUNTU.sh && chmod +x ~/proot-$UBUNTU.sh && cp ~/proot-$UBUNTU.sh ~/.shortcuts && proot-distro install ubuntu --override-alias $UBUNTU
[ $UBUNTU == ubuntu ] && echo "proot-distro login $UBUNTU --isolated --fix-low-ports" >> ~/proot-$UBUNTU.sh && chmod +x ~/proot-$UBUNTU.sh && cp ~/proot-$UBUNTU.sh ~/.shortcuts && proot-distro install ubuntu
[ -n "$UBUNTU" ] && [ "$UBUNTUINSTALL" -eq 0 ] || cat ~/termux-sh/ubuntu-24-04.sh <(echo -e "\nexit") | proot-distro login $UBUNTU --isolated --fix-low-ports
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOX" == "$DEBIAN" ] && DEBIANBOX="${DEBIANBOX}1"
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOX" == "$UBUNTU" ] && DEBIANBOX="${DEBIANBOX}1" && [ "$DEBIANBOX" == "$DEBIAN" ] && DEBIANBOX="${DEBIANBOX}1"
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOX" != debian ] && echo "proot-distro login $DEBIANBOX --isolated --fix-low-ports" >> ~/proot-$DEBIANBOX.sh && chmod +x ~/proot-$DEBIANBOX.sh && cp ~/proot-$DEBIANBOX.sh ~/.shortcuts && proot-distro install debian --override-alias $DEBIANBOX
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOX" == debian ] && echo "proot-distro login $DEBIANBOX --isolated --fix-low-ports" >> ~/proot-$DEBIANBOX.sh && chmod +x ~/proot-$DEBIANBOX.sh && cp ~/proot-$DEBIANBOX.sh ~/.shortcuts && proot-distro install debian
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOXINSTALL" -eq 0 ] || cat ~/termux-sh/box64-wine64-winetricks.sh <(echo -e "\nexit") | proot-distro login $DEBIANBOX --isolated --fix-low-ports
[ -n "$BUSTERCLI" ] && mkdir ~/$BUSTERCLI && echo "bash ~/$BUSTERCLI/start-debian.sh" >> ~/$BUSTERCLI.sh && chmod +x ~/$BUSTERCLI.sh && cp ~/$BUSTERCLI.sh ~/.shortcuts && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian.sh -O ~/$BUSTERCLI/debian.sh && echo 'exit' | bash ~/$BUSTERCLI/debian.sh && [ "$BUSTERCLIINSTALL" -eq 0 ] || cp ~/termux-sh/debian-buster.sh ~/$BUSTERCLI/debian-fs/root/.bash_profile && bash ~/$BUSTERCLI.sh
[ -n "$BUSTERXFCE" ] && [ "$BUSTERXFCE" == "$BUSTERCLI" ] && BUSTERXFCE="${BUSTERXFCE}1"
if [ -n "$BUSTERXFCE" ]; then
    mkdir ~/$BUSTERXFCE && echo "bash ~/$BUSTERXFCE/start-debian.sh" >> ~/$BUSTERXFCE.sh && chmod +x ~/$BUSTERXFCE.sh && cp ~/$BUSTERXFCE.sh ~/.shortcuts && cp ~/termux-sh/debian-xfce-mod.sh ~/$BUSTERXFCE && rm -rf ~/termux-sh && bash ~/$BUSTERXFCE/debian-xfce-mod.sh --after "$(printf "apt update --allow-releaseinfo-change -y && apt --fix-broken install -y && apt upgrade -y && apt install curl -y\necho \"alias exit='vncserver-stop && trap '' INT TERM && builtin exit'\" >> ~/.bashrc && source ~/.bashrc\nrm -rf ~/.bash_profile\nvncserver-stop && trap '' INT TERM\ncurl parrot.live")"
else
    rm -rf ~/termux-sh
    curl parrot.live
fi