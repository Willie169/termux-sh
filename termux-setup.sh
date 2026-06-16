#!/data/data/com.termux/files/usr/bin/bash

## CONFIG START

PKG='alsa-utils aria2 autoconf automake bash bc bison broot build-essential bzip2 calcurse chromium clang cmake command-not-found curl dbus debootstrap dnsutils dpkg dust fastfetch fd ffmpeg file flex fontconfig fontconfig-utils freetype fzf gdb geckodriver gh ghostscript git git-delta glab-cli glow gnupg golang gopls gperf grep gtkwave gzip hyperfine inkscape iproute2 iverilog jadx jpegoptim jq lazygit lftp libheif-progs libwebp libzmq llvm lsd luv lzip make mandoc matplotlib maven mc mesa-vulkan-icd-freedreno mesa-demos mesa-zink mpv nano ncdu ncurses-utils neovim netcat-openbsd net-tools ngspice ninja nmap nnn nodejs-lts npm octave-x openjdk-21 openssh openssh-sftp-server openssl openssl-tool optipng pdftk perl poppler procps proot proot-distro pulseaudio pv pwgen python python-ensurepip-wheels python-numpy python-pip python-scipy python-yt-dlp p7zip qemu-system-x86-64-headless qpdf ruby runit rust scrcpy shellcheck shfmt socat sqlite tar termux-am termux-am-socket termux-api termux-auth termux-exec termux-keyring termux-licenses termux-tools termux-x11-nightly tmux tor torsocks tree tree-sitter tsocks unrar uuid-utils uv valgrind vim virglrenderer-mesa-zink wget wget2 which w3m xmlstarlet yazi yq yt-dlp-ejs zip zsh'
GITDELTA=1
XFCE=1
ANDROID=1
VIMRC=1
PHICE=1
NPM='jsdom markdown-toc marked marked-gfm-heading-id node-html-markdown showdown'
NPMG='bash-language-server dockerfile-language-server-nodejs http-server pyright @linthtml/linthtml'
PIP='pandas pipx pip-autoremove plotly pydub requests selenium==4.9.1 setuptools sympy'
PIPX='cmake-language-server gallery-dl gh2md meson pylatexenc tldr yamllint'
GO=''
APKTOOL=1
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

pkg upgrade -y
pkg install build-essential clang cmake coreutils curl git gzip make ninja nodejs-lts npm perl proot proot-distro python python-ensurepip-wheels tar wget zip x11-repo tur-repo -y
TERMUX=$(echo "$TERMUX" | tr ' ' '_')
UBUNTU=$(echo "$UBUNTU" | tr ' ' '_')
DEBIAN=$(echo "$DEBIAN" | tr ' ' '_')
UBUNTUBOX=$(echo "$UBUNTUBOX" | tr ' ' '_')
DEBIANBOX=$(echo "$DEBIANBOX" | tr ' ' '_')
[ -n "$TERMUX" ] && [ "$TERMUX" == "$UBUNTU" ] && UBUNTU="${UBUNTU}1"
[ -n "$TERMUX" ] && [ "$TERMUX" == "$DEBIAN" ] && DEBIAN="${DEBIAN}1"
[ -n "$TERMUX" ] && [ "$TERMUX" == "$UBUNTUBOX" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ -n "$TERMUX" ] && [ "$TERMUX" == "$DEBIANBOX" ] && DEBIANBOX="${DEBIANBOX}1"
[ -n "$UBUNTU" ] && [ "$UBUNTU" == "$DEBIAN" ] && DEBIAN="${DEBIAN}1"
[ -n "$UBUNTU" ] && [ "$UBUNTU" == "$UBUNTUBOX" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ -n "$UBUNTU" ] && [ "$UBUNTU" == "$DEBIANBOX" ] && DEBIANBOX="${DEBIANBOX}1"
[ -n "$DEBIAN" ] && [ "$DEBIAN" == "$UBUNTUBOX" ] && UBUNTUBOX="${UBUNTUBOX}1"
[ -n "$DEBIAN" ] && [ "$DEBIAN" == "$DEBIANBOX" ] && DEBIANBOX="${DEBIANBOX}1"
[ -n "$UBUNTUBOX" ] && [ "$UBUNTUBOX" == "$DEBIANBOX" ] && DEBIANBOX="${DEBIANBOX}1"
cd ~ || exit
mkdir -p ~/.termux && touch ~/.termux/termux.properties
sed '/allow-external-apps/s/^# //' -i ~/.termux/termux.properties
sed '/shortcut.create-session/s/^# //' -i ~/.termux/termux.properties
sed '/shortcut.next-session/s/^# //' -i ~/.termux/termux.properties
sed '/shortcut.previous-session/s/^# //' -i ~/.termux/termux.properties
sed 's/^# extra-keys-text-all-caps = true/extra-keys-text-all-caps = false/' -i ~/.termux/termux.properties
termux-reload-settings
sed '/^extra-keys = /{N;d;}' -i ~/.termux/termux.properties
perl -0777 -pe 's/(###############\n# Extra keys\n###############\n)/$1\nextra-keys = \[ \[ \{ key: ESC, popup: \{ macro: "ALT s", display: "ALT s" \} \}, \{ key: "\`", popup: "\`\`\`" \}, \{ key: "Z", popup: ":wq\\n" \}, \{ key: "Zp", popup: ":q\\n" \}, \{ key: ":%s\/", popup: \{ macro: "CTRL t", display: "CTRL t" \} \}, \{ key: "d\\\$", popup: \{ macro: "CTRL 1", display: "CTRL 1" \} \}, \{ key: "y\\\$", popup: \{ macro: "CTRL 2", display: "CTRL 2" \} \}, \{ key: "yG", popup: \{ macro: "CTRL r", display: "CTRL r" \} \} \], \[ \{ key: DRAWER, popup: \{ macro: "ALT h", display: "ALT h" \} \}, \{ key: KEYBOARD, popup: "–" \}, \{ key: "\/", popup: \{ macro: "CTRL d", display: "CTRL d" \} \}, \{ key: DEL, popup: BKSP \}, \{ key: HOME, popup: "clear" \}, \{ key: UP, popup: \{ macro: "CTRL UP", display: "Up" \} \}, \{ key: END, popup: ENTER \}, \{ key: PGUP, popup: "±" \} \], \[ \{ key: TAB, popup: \{ macro: "ALT b", display: "ALT b" \} \}, \{ key: "~", popup: \{ macro: "CTRL \\\\\\\\", display: "CTRL \\\\\\\\" \} \}, \{ key: CTRL, popup: \{ macro: "CTRL c", display: "CTRL c" \} \}, \{ key: ALT, popup: \{ macro: "CTRL z", display: "CTRL z" \} \}, \{ key: LEFT, popup: \{ macro: "CTRL LEFT", display: "Left" \} \}, \{ key: DOWN, popup: \{ macro: "CTRL DOWN", display: "Down" \} \}, \{ key: RIGHT, popup: \{ macro: "CTRL RIGHT", display: "Right" \} \}, \{ key: PGDN, popup: "EOF" \} \] \]\n/s' ~/.termux/termux.properties > ~/tmp
mv ~/tmp ~/.termux/termux.properties
termux-reload-settings
mkdir -p ~/.shortcuts
cp ~/termux-sh/DOTshortcuts/* ~/.shortcuts
cp ~/termux-sh/DOTshortcuts/documents.sh ~
cp ~/termux-sh/DOTshortcuts/download.sh ~
cp ~/termux-sh/DOTshortcuts/scripts.sh ~
cp ~/termux-sh/DOTshortcuts/storage.sh ~
cp ~/termux-sh/DOTshortcuts/proot-*.sh ~
mkdir ~/shared
tee $PREFIX/etc/resolv.conf >/dev/null <<'EOF'
nameserver 1.1.1.1
nameserver 1.0.0.1
nameserver 2606:4700:4700::1111
nameserver 2606:4700:4700::1001
nameserver 94.140.14.140
nameserver 94.140.14.141
nameserver 2a10:50c0::1:ff
nameserver 2a10:50c0::2:ff
EOF
rm -f .bashrc
mkdir .bashrc.d
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/00-env.sh -O ~/.bashrc.d/00-env.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/10-exports.sh -O ~/.bashrc.d/10-exports.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/15-color.sh -O ~/.bashrc.d/15-color.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/20-aliases.sh -O ~/.bashrc.d/20-aliases.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/21-cxx.sh -O ~/.bashrc.d/21-cxx.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/22-java.sh -O ~/.bashrc.d/22-java.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/23-vnc.sh -O ~/.bashrc.d/23-vnc.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/50-functions.sh -O ~/.bashrc.d/50-functions.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/60-completion.sh -O ~/.bashrc.d/60-completion.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/bashrc.sh -O ~/.bashrc
if [ -d "$HOME/.bashrc.d"  ];  then
  for f in "$HOME/.bashrc.d/"*; do
    [ -r "$f"  ] && . "$f"
  done
fi
mkdir ~/.JetBrainsMono
cd ~/.JetBrainsMono || exit
wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
unzip JetBrainsMono.zip
mv JetBrainsMonoNerdFontMono-Regular.ttf ~/.termux/font.ttf
cd ~ || exit
rm -rf .JetBrainsMono
termux-reload-settings
mkdir -p $PREFIX/local/bin
mkdir -p $PREFIX/local/go
mkdir -p $PREFIX/local/java
mkdir -p ~/.local/bin
[ -n "$PKG" ] && pkg install $PKG -y
[ -f $PREFIX/etc/ssh/sshd_config ] && sed -Ei 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/; s/^#?Port.*/Port 8022/' $PREFIX/etc/ssh/sshd_config
mkdir -p ~/.ssh
cat > ~/.ssh/config <<'EOF'
Host *
    ServerAliveInterval 15
    ServerAliveCountMax 3
EOF
gh_latest -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' kristoff-it/superhtml aarch64-linux.tar.xz
tar -xJf aarch64-linux.tar.xz
rm aarch64-linux.tar.xz
mv superhtml ~/.local/bin
mkdir eclipse.jdt.ls
cd eclipse.jdt.ls || exit
wget --tries=100 --retry-connrefused --waitretry=5 'https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.57.0/jdt-language-server-1.57.0-202602261110.tar.gz'
tar -xzf 'download.php?file=%2Fjdtls%2Fmilestones%2F1.57.0%2Fjdt-language-server-1.57.0-202602261110.tar.gz'
rm 'download.php?file=%2Fjdtls%2Fmilestones%2F1.57.0%2Fjdt-language-server-1.57.0-202602261110.tar.gz'
cd ~ || exit
if [ "$GITDELTA" -ne 0 ]; then
pkg install git-delta -y
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global merge.conflictStyle zdiff3
fi
[ "$XFCE" -eq 0 ] || pkg install xfce4 -y
if [ "$ANDROID" -ne 0 ]; then
pkg install aapt aapt2 aidl android-tools apksigner curl d8 jq openjdk-17 p7zip unzip -y
cd ~ || exit
wget --tries=100 --retry-connrefused --waitretry=5 https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
unzip commandlinetools-linux-13114758_latest.zip
rm commandlinetools-linux-13114758_latest.zip
mkdir Android
cd Android || exit
mkdir Sdk
cd Sdk || exit
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
mkdir cmdline-tools
cd cmdline-tools || exit
mkdir latest
cd latest || exit
mv $HOME/cmdline-tools/* .
rm -r $HOME/cmdline-tools
cd bin || exit
echo y | ./sdkmanager "build-tools;30.0.3" "platform-tools" "platforms;android-33" "sources;android-33"
cd ~ || exit
wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/lzhiyong/termux-ndk/releases/download/android-ndk/android-ndk-r29-aarch64.7z
7z x android-ndk-r29-aarch64.7z -o$HOME/Android/Sdk/ndk
rm android-ndk-r29-aarch64.7z
mkdir -p ~/.gradle
cat > ~/.gradle/gradle.properties << 'EOF'
android.aapt2FromMavenOverride=/data/data/com.termux/files/usr/bin/aapt2
EOF
fi
if [ "$VIMRC" -ne 0 ]; then
git clone --depth=1 https://github.com/Willie169/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
mkdir -p ~/.config/nvim/lua/config
mkdir -p ~/.config/nvim/lua/plugins
cat > ~/.config/nvim/init.lua <<'EOF'
vim.cmd("set runtimepath^=~/.vim runtimepath+=~/.vim/after")
vim.cmd("let &packpath = &runtimepath")
vim.cmd("source ~/.vimrc")
require("config.lazy")
EOF
cat > ~/.config/nvim/lua/config/lazy.lua <<'EOF'
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
EOF
curl --retry 100 --retry-connrefused --retry-delay 5 -fsSL https://raw.githubusercontent.com/Willie169/bashrc/main/nvim.sh | bash
fi
if [ "$PHICE" -ne 0 ]; then
pkg install uv -y
git clone https://codeberg.org/c4ffe14e/phice.git
cd phice || exit
uv sync
cp config.example.toml config.toml
cd ~ || exit
fi
[ -n "$NPM" ] && npm i $NPM
[ -n "$NPMG" ] && npm i -g $NPMG
if [ -n "$PIP" ]; then
pip3 install $PIP || true
pip3 install $PIP
fi
if [ -n "$PIPX" ]; then
pip3 install pipx
pipx install $PIPX
fi
[ -n "$GO" ] && go install $GO
if [ "$APKTOOL" -ne 0 ]; then
wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
chmod +x apktool
mv apktool $PREFIX/local/bin/
gh_latest -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' iBotPeaches/Apktool apktool_*.jar
chmod +x apktool_*.jar
mv apktool_*.jar $PREFIX/local/bin/
fi
[ "$ANTLR" -eq 0 ] || wget -O $PREFIX/local/java/antlr-4.13.2-complete.jar https://www.antlr.org/download/antlr-4.13.2-complete.jar
[ "$PLANTUML" -eq 0 ] || wget -O $PREFIX/local/java/plantuml.jar https://sourceforge.net/projects/plantuml/files/plantuml.jar/download
[ -n "$TERMUX" ] && proot-distro install termux/termux-docker:aarch64 --name $TERMUX
[ -n "$UBUNTU" ] && proot-distro install ubuntu:rolling --name $UBUNTU
[ -n "$UBUNTU" ] && [ "$UBUNTUINSTALL" -ne 0 ] && cp ~/termux-sh/ubuntu-debian.sh "$PDROOTFS/$UBUNTU/rootfs/root/" && echo './ubuntu-debian.sh' | proot-distro login $UBUNTU --redirect-ports --shared-tmp --isolated
[ -n "$DEBIAN" ] && proot-distro install debian:stable --name $DEBIAN
[ -n "$DEBIAN" ] && [ "$DEBIANINSTALL" -ne 0 ] && cp ~/termux-sh/ubuntu-debian.sh "$PDROOTFS/$DEBIAN/rootfs/root/" && echo './ubuntu-debian.sh' | proot-distro login $DEBIAN --redirect-ports --shared-tmp --isolated
[ -n "$UBUNTUBOX" ] && proot-distro install ubuntu:rolling --name $UBUNTUBOX
[ -n "$UBUNTUBOX" ] && [ "$UBUNTUBOXINSTALL" -ne 0 ] && cp ~/termux-sh/box64-wine64-winetricks.sh "$PDROOTFS/$UBUNTUBOX/rootfs/root/" && echo './box64-wine64-winetricks.sh' | proot-distro login $UBUNTUBOX --redirect-ports --shared-tmp --isolated
[ -n "$DEBIANBOX" ] && proot-distro install debian:stable --name $DEBIANBOX
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOXINSTALL" -ne 0 ] && cp ~/termux-sh/box64-wine64-winetricks.sh "$PDROOTFS/$DEBIANBOX/rootfs/root/" && echo './box64-wine64-winetricks.sh' | proot-distro login $DEBIANBOX --redirect-ports --shared-tmp --isolated
rm -f ~/.bashrc.d/11-proot.sh
cat > ~/.bashrc.d/11-proot.sh <<EOF
#!/data/data/com.termux/files/usr/bin/bash

EOF
[ -n "$TERMUX" ] && echo "export TERMUX=$TERMUX" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
[ -n "$UBUNTU"  ] && echo "export UBUNTU=$UBUNTU" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
[ -n "$DEBIAN"  ] && echo "export DEBIAN=$DEBIAN" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
[ -n "$UBUNTUBOX"  ] && echo "export UBUNTUBOX=$UBUNTUBOX" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
[ -n "$DEBIANBOX"  ] && echo "export DEBIANBOX=$DEBIANBOX" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
rm -rf ~/termux-sh
exit
