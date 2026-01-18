#!/data/data/com.termux/files/usr/bin/bash

## CONFIG START

PKG='alsa-utils aria2 autoconf automake bash bc bison build-essential bzip2 clang cmake command-not-found curl dbus debootstrap dnsutils dpkg fastfetch fdroidcl ffmpeg file flex fontconfig-utils fontconfig freetype firefox gdb gh ghostscript git glab-cli gnucobol gnupg golang gperf grep gtkwave inkscape iproute2 iverilog jpegoptim jq libheif-progs make matplotlib maven mc nano ncurses-utils neovim net-tools ngspice ninja nodejs openjdk-17 openjdk-21 openssh-sftp-server openssh openssl-tool openssl optipng perl postgresql pulseaudio procps proot proot-distro pv python-ensurepip-wheels python-pip python-scipy python ruby rust tar termux-am-socket termux-am termux-api termux-auth termux-exec termux-keyring termux-licenses termux-tools tmux tor torsocks tree tur-repo unrar uuid-utils valgrind vim wget which xmlstarlet yarn zsh'
XFCE=1
ANDROID=1
VIMRC=1
NPM='http-server jsdom marked marked-gfm-heading-id node-html-markdown showdown @openai/codex'
PIP='jupyter matplotlib meson numpy pandas plotly pydub requests selenium setuptools sympy'
GO='github.com/danielmiessler/fabric@latest'
ANTLR=1
PLANTUML=1
TERMUX='termux'
UBUNTU='ubuntu'
UBUNTUINSTALL=1
DEBIAN='debian'
DEBIANINSTALL=0
UBUNTUBOX=''
UBUNTUBOXINSTALL=0
DEBIANBOX=''
DEBIANBOXINSTALL=0

## CONFIG END

TERMUX=$(echo "$TERMUX" | tr ' ' '_')
UBUNTU=$(echo "$UBUNTU" | tr ' ' '_')
DEBIAN=$(echo "$DEBIAN" | tr ' ' '_')
UBUNTUBOX=$(echo "$UBUNTUBOX" | tr ' ' '_')
DEBIANBOX=$(echo "$DEBIANBOX" | tr ' ' '_')
[ "$TERMUX" == "adelie" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "almalinux" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "alpine" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "archlinux" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "artix" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "chimera" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "debian" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "deepin" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "fedora" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "manjaro" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "opensuse" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "oracle" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "pardus" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "rockylinux" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "trisquel" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "ubuntu" ] && TERMUX="${TERMUX}1"
[ "$TERMUX" == "void" ] && TERMUX="${TERMUX}1"
[ "$UBUNTU" == "adelie" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "almalinux" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "alpine" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "archlinux" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "artix" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "chimera" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "debian" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "deepin" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "fedora" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "manjaro" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "opensuse" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "oracle" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "pardus" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "rockylinux" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "termux" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "trisquel" ] && UBUNTU="${UBUNTU}1"
[ "$UBUNTU" == "void" ] && UBUNTU="${UBUNTU}1"
[ "$DEBIAN" == "adelie" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "almalinux" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "alpine" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "archlinux" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "artix" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "chimera" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "deepin" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "fedora" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "manjaro" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "opensuse" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "oracle" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "pardus" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "rockylinux" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "termux" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "trisquel" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "ubuntu" ] && DEBIAN="${DEBIAN}1"
[ "$DEBIAN" == "void" ] && DEBIAN="${DEBIAN}1"
[ "$UBUNTUBOX" == "adelie" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "almalinux" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "alpine" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "archlinux" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "artix" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "chimera" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "debian" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "deepin" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "fedora" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "manjaro" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "opensuse" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "oracle" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "pardus" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "rockylinux" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "termux" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "trisquel" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$UBUNTUBOX" == "void" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ "$DEBIANBOX" == "adelie" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "almalinux" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "alpine" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "archlinux" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "artix" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "chimera" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "deepin" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "fedora" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "manjaro" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "opensuse" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "oracle" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "pardus" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "rockylinux" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "termux" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "trisquel" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "ubuntu" ] && DEBIANBOX="${DEBIANBOX}1"
[ "$DEBIANBOX" == "void" ] && DEBIANBOX="${DEBIANBOX}1"
[ -n "$TERMUX" ] && [ "$TERMUX" == "$UBUNTU" ] && UBUNTU="${UBUNTU}1"
[ -n "$TERMUX" ] && [ "$TERMUX" == "$DEBIAN" ] && DEBIAN="${DEBIAN}1"
[ -n "$TERMUX" ] && [ "$TERMUX" == "$TERMUXBOX" ] && TERMUXBOX="${TERMUXBOX}1"
[ -n "$TERMUX" ] && [ "$TERMUX" == "$DEBIANBOX" ] && DEBIANBOX="${DEBIANBOX}1"
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
cp ~/termux-sh/DOTshortcuts/Documents.sh ~
cp ~/termux-sh/DOTshortcuts/Download.sh ~
cp ~/termux-sh/DOTshortcuts/Storage.sh ~
pkg update
pkg upgrade -y
pkg install curl git wget x11-repo -y
pkg update
rm -f .bashrc
mkdir .bashrc.d
wget https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/00-env.sh -O ~/.bashrc.d/00-env.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/10-exports.sh -O ~/.bashrc.d/10-exports.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/15-color.sh -O ~/.bashrc.d/15-color.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/20-aliases.sh -O ~/.bashrc.d/20-aliases.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/21-cxx.sh -O ~/.bashrc.d/21-cxx.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/22-java.sh -O ~/.bashrc.d/22-java.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/23-vnc.sh -O ~/.bashrc.d/23-vnc.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/50-functions.sh -O ~/.bashrc.d/50-functions.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/60-completion.sh -O ~/.bashrc.d/60-completion.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/bashrc.sh -O ~/.bashrc
source ~/.bashrc
mkdir $PREFIX/local/go
mkdir $PREFIX/local/java
[ -n "$PKG" ] && pkg install $PKG -y
[ "$XFCE" -eq 0 ] || pkg install firefox tigervnc xfce4 -y && mkdir -p ~/.vnc && cat > ~/.vnc/xstartup << 'EOF'
#!/data/data/com.termux/files/usr/bin/sh
xfce4-session &
EOF
if [ "$ANDROID" -ne 0 ]; then
pkg install aapt aapt2 aidl android-tools apksigner curl d8 jq openjdk-17 unzip -y
cd $HOME
wget https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
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
echo y | ./sdkmanager "build-tools;30.0.3" "platform-tools" "platforms;android-33"
cd $HOME
wget https://github.com/lzhiyong/termux-ndk/releases/download/android-ndk/android-ndk-r29-aarch64.7z
7z x android-ndk-r29.7z -o$HOME/Android/Sdk/ndk
rm android-ndk-r29.7z
mkdir -p ~/.gradle
cat > ~/.gradle/gradle.properties << 'EOF'
android.aapt2FromMavenOverride=/data/data/com.termux/files/usr/bin/aapt2
EOF
fi
if [ "$VIMRC" -ne 0 ]; then
git clone --depth=1 https://github.com/Willie169/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
mkdir -p ~/.config/nvim
echo 'set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
' | tee ~/.config/nvim/init.vim > /dev/null
fi
[ -n "$NPM" ] && npm install $NPM
[ -n "$PIP" ] && pip install $PIP
[ -n "$GO" ] && go install $GO
[ "$ANTLR" -eq 0 ] || wget -O $PREFIX/local/java/antlr-4.13.2-complete.jar https://www.antlr.org/download/antlr-4.13.2-complete.jar
[ "$PLANTUML" -eq 0 ] || wget -O $PREFIX/local/java/plantuml.jar https://sourceforge.net/projects/plantuml/files/plantuml.jar/download
[ -n "$TERMUX" ] && [ $TERMUX != termux ] && echo "proot-distro login $TERMUX --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$TERMUX.sh && chmod +x ~/proot-$TERMUX.sh && cp ~/proot-$TERMUX.sh ~/.shortcuts && proot-distro install termux --override-alias $TERMUX
[ $TERMUX == termux ] && echo "proot-distro login $TERMUX --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$TERMUX.sh && chmod +x ~/proot-$TERMUX.sh && cp ~/proot-$TERMUX.sh ~/.shortcuts && proot-distro install termux
[ -n "$UBUNTU" ] && [ $UBUNTU != ubuntu ] && echo "proot-distro login $UBUNTU --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$UBUNTU.sh && chmod +x ~/proot-$UBUNTU.sh && cp ~/proot-$UBUNTU.sh ~/.shortcuts && proot-distro install ubuntu --override-alias $UBUNTU
[ $UBUNTU == ubuntu ] && echo "proot-distro login $UBUNTU --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$UBUNTU.sh && chmod +x ~/proot-$UBUNTU.sh && cp ~/proot-$UBUNTU.sh ~/.shortcuts && proot-distro install ubuntu
[ -n "$UBUNTU" ] && [ "$UBUNTUINSTALL" -eq 0 ] || cat ~/termux-sh/ubuntu-debian.sh | proot-distro login $UBUNTU --isolated --fix-low-ports --shared-tmp --no-arch-warning
[ -n "$DEBIAN" ] && [ $DEBIAN != debian ] && echo "proot-distro login $DEBIAN --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$DEBIAN.sh && chmod +x ~/proot-$DEBIAN.sh && cp ~/proot-$DEBIAN.sh ~/.shortcuts && proot-distro install debian --override-alias $DEBIAN
[ $DEBIAN == debian ] && echo "proot-distro login $DEBIAN --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$DEBIAN.sh && chmod +x ~/proot-$DEBIAN.sh && cp ~/proot-$DEBIAN.sh ~/.shortcuts && proot-distro install debian
[ -n "$DEBIAN" ] && [ "$DEBIANINSTALL" -eq 0 ] || cat ~/termux-sh/ubuntu-debian.sh | proot-distro login $DEBIAN --isolated --fix-low-ports --shared-tmp --no-arch-warning
[ -n "$UBUNTUBOX" ] && [ "$UBUNTUBOX" != ubuntu ] && echo "proot-distro login $UBUNTUBOX --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$UBUNTUBOX.sh && chmod +x ~/proot-$UBUNTUBOX.sh && cp ~/proot-$UBUNTUBOX.sh ~/.shortcuts && proot-distro install ubuntu --override-alias $UBUNTUBOX
[ -n "$UBUNTUBOX" ] && [ "$UBUNTUBOX" == ubuntu ] && echo "proot-distro login $UBUNTUBOX --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$UBUNTUBOX.sh && chmod +x ~/proot-$UBUNTUBOX.sh && cp ~/proot-$UBUNTUBOX.sh ~/.shortcuts && proot-distro install ubuntu
[ -n "$UBUNTUBOX" ] && [ "$UBUNTUBOXINSTALL" -eq 0 ] || cat ~/termux-sh/box64-wine64-winetricks.sh | proot-distro login $UBUNTUBOX --isolated --fix-low-ports --shared-tmp --no-arch-warning
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOX" != debian ] && echo "proot-distro login $DEBIANBOX --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$DEBIANBOX.sh && chmod +x ~/proot-$DEBIANBOX.sh && cp ~/proot-$DEBIANBOX.sh ~/.shortcuts && proot-distro install debian --override-alias $DEBIANBOX
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOX" == debian ] && echo "proot-distro login $DEBIANBOX --isolated --fix-low-ports --shared-tmp --no-arch-warning" >> ~/proot-$DEBIANBOX.sh && chmod +x ~/proot-$DEBIANBOX.sh && cp ~/proot-$DEBIANBOX.sh ~/.shortcuts && proot-distro install debian
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOXINSTALL" -eq 0 ] || cat ~/termux-sh/box64-wine64-winetricks.sh | proot-distro login $DEBIANBOX --isolated --fix-low-ports --shared-tmp --no-arch-warning
rm -f ~/.bashrc.d/11-proot.sh
[ -n "$TERMUX" ] || TERMUX="termux"
[ -n "$UBUNTU" ] || UBUNTU="ubuntu"
[ -n "$DEBIAN" ] || DEBIAN="debian"
[ -n "$UBUNTUBOX" ] || UBUNTUBOX="ubuntubox"
[ -n "$DEBIANBOX" ] || DEBIANBOX="debianbox"
cat > ~/.bashrc.d/11-proot.sh <<EOF
#!/data/data/com.termux/files/usr/bin/bash

export TERMUX="$TERMUX"
export UBUNTU="$UBUNTU"
export DEBIAN="$DEBIAN"
export UBUNTUBOX="$UBUNTUBOX"
export DEBIANBOX="$DEBIANBOX"
EOF
rm -rf ~/termux-sh
exit
