#!/data/data/com.termux/files/usr/bin/bash
PKG='alsa-utils aria2 autoconf automake bash bc bison build-essential bzip2 clang cmake command-not-found curl dbus debootstrap dnsutils dpkg fastfetch fdroidcl ffmpeg file flex fontconfig-utils fontconfig freetype firefox gdb gh ghostscript git glab-cli gnucobol gnupg golang gperf grep gtkwave inkscape iproute2 iverilog jpegoptim jq libheif-progs make matplotlib maven mc nano ncurses-utils neovim net-tools ngspice ninja nodejs openjdk-17 openjdk-21 openssh-sftp-server openssh openssl-tool openssl optipng perl postgresql pulseaudio procps proot proot-distro pv python-ensurepip-wheels python-pip python-scipy python ruby rust tar termux-am-socket termux-am termux-api termux-auth termux-exec termux-keyring termux-licenses termux-tools tmux tor torsocks tree tur-repo unrar valgrind vim wget which xmlstarlet yarn zsh'
XFCE=1
ANDROID=1
VIMRC=1
NPM='http-server jsdom marked marked-gfm-heading-id node-html-markdown showdown @openai/codex'
PIPINSTALL='jupyter meson numpy pandas pipx pydub selenium setuptools sympy'
PROOTTERMUX=1
UBUNTU='ubuntu'
UBUNTUINSTALL=1
DEBIAN='debian'
DEBIANINSTALL=0
UBUNTUBOX=''
UBUNTUBOXINSTALL=0
DEBIANBOX=''
DEBIANBOXINSTALL=0

set -eu
UBUNTU=$(echo "$UBUNTU" | tr ' ' '_')
DEBIAN=$(echo "$DEBIAN" | tr ' ' '_')
UBUNTUBOX=$(echo "$UBUNTUBOX" | tr ' ' '_')
DEBIANBOX=$(echo "$DEBIANBOX" | tr ' ' '_')
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
[ "$UBUNTUBOX" == "adelie" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "alpine" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "archlinux" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "artix" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "chimera" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "debian" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "deepin" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "fedora" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "manjaro" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "openkylin" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "opensuse" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "pardus" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "rockylinux" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "void" ] && UBUNTUBOX="${UBUNTUBOX}1"
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
[ -n "$UBUNTU" ] && [ "$UBUNTU" == "$DEBIAN" ] && DEBIAN="${DEBIAN}1"
[ -n "$UBUNTU" ] && [ "$UBUNTU" == "$UBUNTUBOX" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ -n "$UBUNTU" ] && [ "$UBUNTU" == "$DEBIANBOX" ] && DEBIANBOX="${DEBIANBOX}1"
[ -n "$DEBIAN" ] && [ "$DEBIAN" == "$UBUNTUBOX" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ -n "$DEBIAN" ] && [ "$DEBIAN" == "$DEBIANBOX" ] && DEBIANBOX="${DEBIANBOX}1"
[ -n "$UBUNTUBOX" ] && [ "$UBUNTUBOX" == "$DEBIANBOX" ] && DEBIANBOX="${DEBIANBOX}1"
cd ~
[ -f ~/.termux/termux.properties ] && sed '/allow-external-apps/s/^# //' -i ~/.termux/termux.properties && termux-reload-settings
mkdir -p ~/.shortcuts
cp ~/termux-sh/DOTshortcuts/* ~/.shortcuts
cp ~/termux-sh/DOTshortcuts/* ~
mv ~/bashrc.sh ~/.bashrc
source ~/.bashrc
pkg update && pkg upgrade -y && pkg install curl git x11-repo -y && pkg update
[ -n "$PKG" ] && pkg install $PKG -y
[ "$XFCE" -eq 0 ] || pkg install firefox tigervnc xfce4 -y && mkdir -p ~/.vnc && cat > ~/.vnc/xstartup << 'EOF'
#!/data/data/com.termux/files/usr/bin/sh
xfce4-session &
EOF
if [ "$ANDROID" -ne 0 ]; then
pkg install aapt aapt2 aidl android-tools apksigner aria2 curl d8 jq openjdk-17 unzip -y
cd $HOME
aria2c https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
unzip commandlinetools-linux-13114758_latest.zip
rm commandlinetools-linux-13114758_latest.zip
mkdir Android
cd Android
mkdir Sdk
cd Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
mkdir cmdline-tools
cd cmdline-tools
mkdir latest
cd latest
mv $HOME/cmdline-tools/* .
rm -r $HOME/cmdline-tools
cd bin
echo y | ./sdkmanager "platform-tools" "platforms;android-36"
cd $HOME
aria2c https://github.com/lzhiyong/termux-ndk/releases/download/android-ndk/android-ndk-r29-aarch64.7z
7z x android-ndk-r29.7z -o$HOME/Android/Sdk/ndk
rm android-ndk-r29.7z
fi
[ "$VIMRC" -eq 0 ] || git clone --depth=1 https://github.com/Willie169/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
[ -n "$NPM" ] && npm install $NPM
[ -n "$PIPINSTALL" ] && pip install $PIPINSTALL
[ "$PROOTTERMUX" -eq 0 ] || echo 'pkg update && pkg upgrade -y && exit' | bash ~/proot-termux.sh
[ -n "$UBUNTU" ] && [ $UBUNTU != ubuntu ] && echo "proot-distro login $UBUNTU --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$UBUNTU.sh && chmod +x ~/proot-$UBUNTU.sh && cp ~/proot-$UBUNTU.sh ~/.shortcuts && proot-distro install ubuntu --override-alias $UBUNTU
[ $UBUNTU == ubuntu ] && echo "proot-distro login $UBUNTU --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$UBUNTU.sh && chmod +x ~/proot-$UBUNTU.sh && cp ~/proot-$UBUNTU.sh ~/.shortcuts && proot-distro install ubuntu
[ -n "$UBUNTU" ] && [ "$UBUNTUINSTALL" -eq 0 ] || cat ~/termux-sh/ubuntu-debian.sh <(echo -e "\nexit") | proot-distro login $UBUNTU --isolated --fix-low-ports --shared-tmp --no-arch-warning
[ -n "$DEBIAN" ] && [ $DEBIAN != debian ] && echo "proot-distro login $DEBIAN --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$DEBIAN.sh && chmod +x ~/proot-$DEBIAN.sh && cp ~/proot-$DEBIAN.sh ~/.shortcuts && proot-distro install debian --override-alias $DEBIAN
[ $DEBIAN == debian ] && echo "proot-distro login $DEBIAN --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$DEBIAN.sh && chmod +x ~/proot-$DEBIAN.sh && cp ~/proot-$DEBIAN.sh ~/.shortcuts && proot-distro install debian
[ -n "$DEBIAN" ] && [ "$DEBIANINSTALL" -eq 0 ] || cat ~/termux-sh/ubuntu-debian.sh <(echo -e "\nexit") | proot-distro login $DEBIAN --isolated --fix-low-ports --shared-tmp --no-arch-warning
[ -n "$UBUNTUBOX" ] && [ "$UBUNTUBOX" != ubuntu ] && echo "proot-distro login $UBUNTUBOX --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$UBUNTUBOX.sh && chmod +x ~/proot-$UBUNTUBOX.sh && cp ~/proot-$UBUNTUBOX.sh ~/.shortcuts && proot-distro install ubuntu --override-alias $UBUNTUBOX
[ -n "$UBUNTUBOX" ] && [ "$UBUNTUBOX" == ubuntu ] && echo "proot-distro login $UBUNTUBOX --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$UBUNTUBOX.sh && chmod +x ~/proot-$UBUNTUBOX.sh && cp ~/proot-$UBUNTUBOX.sh ~/.shortcuts && proot-distro install ubuntu
[ -n "$UBUNTUBOX" ] && [ "$UBUNTUBOXINSTALL" -eq 0 ] || cat ~/termux-sh/box64-wine64-winetricks.sh <(echo -e "\nexit") | proot-distro login $UBUNTUBOX --isolated --fix-low-ports --shared-tmp --no-arch-warning
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOX" != debian ] && echo "proot-distro login $DEBIANBOX --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$DEBIANBOX.sh && chmod +x ~/proot-$DEBIANBOX.sh && cp ~/proot-$DEBIANBOX.sh ~/.shortcuts && proot-distro install debian --override-alias $DEBIANBOX
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOX" == debian ] && echo "proot-distro login $DEBIANBOX --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$DEBIANBOX.sh && chmod +x ~/proot-$DEBIANBOX.sh && cp ~/proot-$DEBIANBOX.sh ~/.shortcuts && proot-distro install debian
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOXINSTALL" -eq 0 ] || cat ~/termux-sh/box64-wine64-winetricks.sh <(echo -e "\nexit") | proot-distro login $DEBIANBOX --isolated --fix-low-ports --shared-tmp --no-arch-warning
rm -rf ~/termux-sh
exit
