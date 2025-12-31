#!/data/data/com.termux/files/usr/bin/bash
PKG='alsa-utils android-tools apksigner autoconf automake bash bc bison build-essential bzip2 clang cmake command-not-found curl dbus debootstrap dnsutils dpkg fdroidcl ffmpeg file flex fontconfig-utils fontconfig freetype gdb gh ghostscript git glab-cli gnucobol gnupg golang gperf grep gtkwave inkscape iproute2 iverilog jpegoptim jq libheif-progs make matplotlib maven mc nano ncurses-utils neovim net-tools ninja nodejs openjdk-17 openjdk-21 openssh-sftp-server openssh openssl-tool openssl optipng perl pulseaudio procps proot proot-distro pv python-ensurepip-wheels python-pip python-scipy python ruby rust tar termux-am-socket termux-am termux-api termux-auth termux-exec termux-keyring termux-licenses termux-tools termux-x11-nightly tigervnc tmux tor torsocks tree unrar valgrind vim wget which xfce4 xmlstarlet yarn zsh'
NPM='http-server jsdom marked marked-gfm-heading-id node-html-markdown showdown'
VIMRC=1
PIPINSTALL='jupyter meson numpy pandas pipx pydub selenium setuptools sympy'
PROOTTERMUX=1
DEBIAN='debian'
DEBIANINSTALL=1
UBUNTU='ubuntu'
UBUNTUINSTALL=0
DEBIANBOX=''
DEBIANBOXINSTALL=0

DEBIAN=$(echo "$DEBIAN" | tr ' ' '_')
UBUNTU=$(echo "$UBUNTU" | tr ' ' '_')
DEBIANBOX=$(echo "$DEBIANBOX" | tr ' ' '_')
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
cd ~ && pkg update && pkg upgrade -y && pkg install curl git x11-repo -y
[ -n "$PKG" ] && pkg install $PKG -y
mkdir -p ~/.shortcuts
chmod +x ~/termux-sh/DOTshortcuts/*.sh
cp ~/termux-sh/DOTshortcuts/* ~/.shortcuts
cp ~/termux-sh/DOTshortcuts/* ~
mv ~/bashrc.sh ~/.bashrc
source ~/.bashrc
[ "$VIMRC" -eq 0 ] || git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh && echo "set mouse=a
set signcolumn=no
set foldcolumn=0
set nolinebreak

nnoremap <leader>k :if &mouse ==# 'a' \| set mouse= \| else \| set mouse=a \| endif<CR>

let g:copilot_enabled = v:false
" | tee ~/.vim_runtime/my_configs.vim > /dev/null
[ "$VIMRC" -eq 0 ] || mkdir -p ~/.config/nvim && echo 'set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
' | tee ~/.config/nvim/init.vim > /dev/null
[ -n "$PIPINSTALL" ] && pip install $PIPINSTALL
[ -f ~/.termux/termux.properties ] && sed '/allow-external-apps/s/^# //' -i ~/.termux/termux.properties && termux-reload-settings
[ "$PROOTTERMUX" -eq 0 ] || echo 'pkg update && pkg upgrade -y && exit' | bash ~/proot-termux.sh
[ -n "$NPM" ] && npm install -g $NPM
[ -n "$DEBIAN" ] && [ $DEBIAN != debian ] && echo "proot-distro login $DEBIAN --isolated --fix-low-ports" >> ~/proot-$DEBIAN.sh && chmod +x ~/proot-$DEBIAN.sh && cp ~/proot-$DEBIAN.sh ~/.shortcuts && proot-distro install debian --override-alias $DEBIAN
[ $DEBIAN == debian ] && echo "proot-distro login $DEBIAN --isolated --fix-low-ports" >> ~/proot-$DEBIAN.sh && chmod +x ~/proot-$DEBIAN.sh && cp ~/proot-$DEBIAN.sh ~/.shortcuts && proot-distro install debian
[ -n "$DEBIAN" ] && [ "$DEBIANINSTALL" -eq 0 ] || cat ~/termux-sh/debian.sh <(echo -e "\nexit") | proot-distro login $DEBIAN --isolated --fix-low-ports
[ -n "$UBUNTU" ] && [ "$UBUNTU" == "$DEBIAN" ] && UBUNTU="${UBUNTU}1"
[ -n "$UBUNTU" ] && [ $UBUNTU != ubuntu ] && echo "proot-distro login $UBUNTU --isolated --fix-low-ports" >> ~/proot-$UBUNTU.sh && chmod +x ~/proot-$UBUNTU.sh && cp ~/proot-$UBUNTU.sh ~/.shortcuts && proot-distro install ubuntu --override-alias $UBUNTU
[ $UBUNTU == ubuntu ] && echo "proot-distro login $UBUNTU --isolated --fix-low-ports" >> ~/proot-$UBUNTU.sh && chmod +x ~/proot-$UBUNTU.sh && cp ~/proot-$UBUNTU.sh ~/.shortcuts && proot-distro install ubuntu
[ -n "$UBUNTU" ] && [ "$UBUNTUINSTALL" -eq 0 ] || cat ~/termux-sh/ubuntu.sh <(echo -e "\nexit") | proot-distro login $UBUNTU --isolated --fix-low-ports
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOX" == "$DEBIAN" ] && DEBIANBOX="${DEBIANBOX}1"
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOX" == "$UBUNTU" ] && DEBIANBOX="${DEBIANBOX}1" && [ "$DEBIANBOX" == "$DEBIAN" ] && DEBIANBOX="${DEBIANBOX}1"
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOX" != debian ] && echo "proot-distro login $DEBIANBOX --isolated --fix-low-ports" >> ~/proot-$DEBIANBOX.sh && chmod +x ~/proot-$DEBIANBOX.sh && cp ~/proot-$DEBIANBOX.sh ~/.shortcuts && proot-distro install debian --override-alias $DEBIANBOX
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOX" == debian ] && echo "proot-distro login $DEBIANBOX --isolated --fix-low-ports" >> ~/proot-$DEBIANBOX.sh && chmod +x ~/proot-$DEBIANBOX.sh && cp ~/proot-$DEBIANBOX.sh ~/.shortcuts && proot-distro install debian
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOXINSTALL" -eq 0 ] || cat ~/termux-sh/box64-wine64-winetricks.sh <(echo -e "\nexit") | proot-distro login $DEBIANBOX --isolated --fix-low-ports
rm -rf ~/termux-sh
exit
