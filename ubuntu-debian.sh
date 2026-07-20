#!/bin/bash
set -euxo pipefail
shopt -s expand_aliases
TEST=0
FULL=0
[ "${1:-}" = '--test' ] && TEST=1
[ "${2:-}" = '--test' ] && TEST=1
[ "${1:-}" = '--full' ] && FULL=1
[ "${2:-}" = '--full' ] && FULL=1
# shellcheck disable=2155
PREDF=$(df --output=used / | tail -n1)
cd ~ || exit
mkdir -p /usr/local/java
mkdir -p /etc/apt/keyrings
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/applications
mkdir -p ~/Desktop
mkdir -p ~/.config
tee /etc/resolv.conf >/dev/null <<'EOF'
nameserver 1.1.1.1
nameserver 1.0.0.1
nameserver 2606:4700:4700::1111
nameserver 2606:4700:4700::1001
nameserver 94.140.14.140
nameserver 94.140.14.141
nameserver 2a10:50c0::1:ff
nameserver 2a10:50c0::2:ff
EOF
source /etc/os-release
apt update
if [ "$ID" = "ubuntu" ]; then
f=/etc/apt/sources.list.d/ubuntu.sources
sed -i 's/^Types: *deb.*/Types: deb deb-src/' "$f"
DEBIAN_FRONTEND=noninteractive apt install software-properties-common -y -o Dpkg::Options::="--force-confnew"
add-apt-repository universe -y
add-apt-repository multiverse -y
add-apt-repository restricted -y
add-apt-repository ppa:git-core/ppa -y
add-apt-repository ppa:libreoffice/ppa -y
add-apt-repository ppa:longsleep/golang-backports -y
add-apt-repository ppa:openjdk-r/ppa -y
mv /etc/apt/sources.list.d/openjdk-r-ubuntu-ppa-*.sources /etc/apt/sources.list.d/openjdk-r-ubuntu-ppa-noble.sources || true
sed -i 's/^Suites: .*$/Suites: noble/' /etc/apt/sources.list.d/openjdk-r-ubuntu-ppa-noble.sources
add-apt-repository ppa:mozillateam/ppa -y
add-apt-repository ppa:zhangsongcui3371/fastfetch -y
else
f=/etc/apt/sources.list.d/debian.sources
sed -i 's/^Types: *deb.*/Types: deb deb-src/' "$f"
sed -i 's/\bmain\b.*/main contrib non-free non-free-firmware/' "$f"
fi
apt update
apt purge rustup texlive* yq -y
DEBIAN_FRONTEND=noninteractive apt install apt-transport-https bash build-essential ca-certificates coreutils cmake curl dbus openjdk-21-jdk g++ gcc git gnupg grep gzip jq locales lsb-release make ninja-build openssh-server perl perl-tk python-is-python3 python3 vim-gtk3 wget xz-utils -y -o Dpkg::Options::="--force-confnew"
DEBIAN_FRONTEND=noninteractive apt install sudo -y -o Dpkg::Options::="--force-confnew"
sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8
rm -f .bashrc
mkdir ~/.bashrc.d
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/00-env.sh -O ~/.bashrc.d/00-env.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/10-exports.sh -O ~/.bashrc.d/10-exports.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/15-color.sh -O ~/.bashrc.d/15-color.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/20-aliases.sh -O ~/.bashrc.d/20-aliases.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/21-cxx.sh -O ~/.bashrc.d/21-cxx.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/22-java.sh -O ~/.bashrc.d/22-java.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/23-vnc.sh -O ~/.bashrc.d/23-vnc.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/50-functions.sh -O ~/.bashrc.d/50-functions.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/60-completion.sh -O ~/.bashrc.d/60-completion.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/bashrc -O ~/.bashrc
cat > ~/.profile <<'EOF'
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
EOF
if [ -d "$HOME/.bashrc.d" ];  then
  for f in "$HOME/.bashrc.d/"*; do
    [ -r "$f" ] && . "$f"
  done
fi
DEBIAN_FRONTEND=noninteractive apt upgrade -y -o Dpkg::Options::="--force-confnew"
PKG='alsa-utils apksigner apt-transport-https aptitude audacity automake bash bc bear bindfs bison bookletimposer build-essential bzip2 ca-certificates calcurse clang clang-format clangd cmake command-not-found cronie curl dbus dbus-x11 debconf-utils distro-info dnsutils dvisvgm fastfetch ffmpeg file flex fontconfig fonts-cns11643-kai fonts-cns11643-sung fonts-liberation fonts-noto fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji fonts-wqy-zenhei g++ gcc gdb gh ghostscript git glab gnupg gnupg2 golang-go gopls gperf grep gzip hyperfine iftop imagemagick info inkscape iotop-c iproute2 jpegoptim jq lftp libheif-examples libreoffice lsb-release lsd lzip make maven mesa-utils mpv nano ncdu neovim netcat-openbsd nethogs net-tools ngspice ninja-build nmap ocrmypdf octave openjdk-21-jdk openssh-client openssh-server openssl optipng p7zip-full pandoc perl perl-tk pkg-config poppler-utils procps pv pwgen python-is-python3 python3-all-dev python3-argcomplete python3-httpx python3-jinja2 python3-neovim python3-pip python3-requests python3-venv qpdf shellcheck shfmt socat sqlite3 sudo tar tesseract-ocr tesseract-ocr-chi-sim tesseract-ocr-chi-sim-vert tesseract-ocr-chi-tra tesseract-ocr-chi-tra-vert tesseract-ocr-eng tesseract-ocr-jpn tesseract-ocr-jpn-vert tmux tree tree-sitter-cli tsocks unrar unzip uuid-runtime verilator vim-gtk3 w3m webp wget wget2 xdotool xmlstarlet xz-utils zip zsh zstd'
# shellcheck disable=2086
if [ "$TEST" -eq 0 ]; then
DEBIAN_FRONTEND=noninteractive apt install $PKG -y -o Dpkg::Options::="--force-confnew"
else
DEBIAN_FRONTEND=noninteractive apt install $PKG -y -s -o Dpkg::Options::="--force-confnew"
fi
wget --tries=100 --retry-connrefused --waitretry=5 http://ports.ubuntu.com/pool/universe/e/elementary-xfce/elementary-xfce-icon-theme_0.19-1_all.deb
DEBIAN_FRONTEND=noninteractive apt install ./elementary-xfce-icon-theme_0.19-1_all.deb -y -o Dpkg::Options::="--force-confnew"
rm elementary-xfce-icon-theme_0.19-1_all.deb*
apt-mark hold elementary-xfce-icon-theme
DEBIAN_FRONTEND=noninteractive apt install xfce4 xfce4-goodies xinit -y -o Dpkg::Options::="--force-confnew"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
chmod +x apktool
mv apktool /usr/local/bin/
gh_latest -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' iBotPeaches/Apktool 'apktool_*.jar'
chmod +x apktool_*.jar
mv apktool_*.jar /usr/local/bin/
mkdir jadx
cd jadx || exit
gh_latest_r -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' skylot/jadx 'jadx-[0-9\.]*\.zip'
unzip jadx*.zip
rm jadx*.zip*
chmod +x bin/jadx
chmod +x bin/jadx-gui
cd ~ || exit
NVM_VERSION=$(curl -fsSL "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | jq -r '.tag_name')
PROFILE=/dev/null bash -c "curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts
echo y | corepack enable npm
echo y | npm --help || true
echo y | corepack enable yarn
echo y | yarn --help || true
npm i -g --allow-scripts=opencode-ai bash-language-server deno dockerfile-language-server-nodejs http-server opencode-ai pyright @linthtml/linthtml @openai/codex
gh_latest -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' yt-dlp/yt-dlp yt-dlp
chmod +x yt-dlp
mv yt-dlp ~/.local/bin/
curl -LsSf https://astral.sh/uv/install.sh | sh
for pkg in cmake-language-server gallery-dl gh2md img2pdf jupyterlab jupytext libretranslate meson notebook pylatexenc tldr xmljson yamllint; do
uv tool install "$pkg"
done
wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
bash Miniforge3-Linux-aarch64.sh -b -p "${HOME}/conda"
rm Miniforge3-Linux-aarch64.sh*
export MAMBA_ROOT_PREFIX="${HOME}/conda"
source "${HOME}/conda/etc/profile.d/conda.sh" 2>/dev/null
source "${HOME}/conda/etc/profile.d/mamba.sh" 2>/dev/null
conda config --set auto_activate_base false
conda config --add channels pypi
conda config --add channels pytorch
conda config --add channels conda-forge
touch /.dockerenv
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
BREW='bat bottom broot dust fd fzf git-delta lazygit procs resvg ripgrep sevenzip yazi yq zoxide'
# shellcheck disable=2086
if [ "$TEST" -eq 0 ]; then
echo y | brew install $BREW || true
echo y | brew install $BREW
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global merge.conflictStyle zdiff3
else
echo y | brew install $BREW --dry-run
fi
brew cleanup
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
curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list >/dev/null
apt update
DEBIAN_FRONTEND=noninteractive apt install glow -y -o Dpkg::Options::="--force-confnew"
wget --tries=100 --retry-connrefused --waitretry=5 -O /usr/local/java/antlr-4.13.2-complete.jar https://www.antlr.org/download/antlr-4.13.2-complete.jar
wget --tries=100 --retry-connrefused --waitretry=5 -O /usr/local/java/plantuml.jar https://sourceforge.net/projects/plantuml/files/plantuml.jar/download
gh_latest -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' kristoff-it/superhtml aarch64-linux.tar.xz
tar -xJf aarch64-linux.tar.xz
rm aarch64-linux.tar.xz*
mv superhtml ~/.local/bin/
DEBIAN_FRONTEND=noninteractive apt install libeigen3-dev libzip-dev zlib1g-dev -y -o Dpkg::Options::="--force-confnew"
git clone --depth=1 https://github.com/lightvector/KataGo.git
cd KataGo/cpp || exit
cmake . -G Ninja -DUSE_BACKEND=EIGEN
ninja
cd ../.. || exit
mkdir katago-networks
cd katago-networks || exit
wget --tries=100 --retry-connrefused --waitretry=5 https://media.katagotraining.org/uploaded/networks/models/kata1/kata1-b6c96-s175395328-d26788732.txt.gz
cd ~ || exit
DEBIAN_FRONTEND=noninteractive apt install maven -y -o Dpkg::Options::="--force-confnew"
git clone --depth=1 https://github.com/yzyray/lizzieyzy.git
cd lizzieyzy || exit
mvn clean package
cd ~ || exit
rm -rf ~/.m2/repository
cat > ~/.local/share/applications/lizzieyzy.desktop <<EOF
[Desktop Entry]
Type=Application
Name=LizzieYzy
Comment=LizzieYzy - GUI for Game of Go
Exec=sh -c 'cd $HOME/.lizzieyzy && java -jar "$HOME/lizzieyzy/target/lizzie-yzy2.5.3-shaded.jar"'
Icon=$HOME/lizzieyzy/src/main/resources/assets/logo.png
Terminal=false
Categories=Game;
StartupWMClass=featurecat-lizzie-Lizzie
EOF
update_lizzieyzy_config
cp ~/.local/share/applications/lizzieyzy.desktop ~/Desktop/lizzieyzy.desktop && chmod +x ~/Desktop/lizzieyzy.desktop
git clone --depth=1 https://github.com/fairy-stockfish/Fairy-Stockfish.git
cd Fairy-Stockfish/src || exit
ARCH=$(uname -m)
if [ "$ARCH" == "x86_64" ]; then
ARCH="x86-64"
elif [ "$ARCH" == "aarch64" ]; then
ARCH="armv8"
elif [ "$ARCH" == "arm" ]; then
ARCH="armv7"
fi
make -j ARCH="$ARCH" profile-build largeboards=yes nnue=yes
cd ~ || exit
DEBIAN_FRONTEND=noninteractive apt install qt6-base-dev qt6-base-dev-tools qt6-svg-dev qt6-5compat-dev -y -o Dpkg::Options::="--force-confnew"
git clone --depth=1 https://github.com/cutechess/cutechess.git
cd cutechess || exit
mkdir build
cd build || exit
cmake -G Ninja ..
ninja
cd ~ || exit
cat > ~/.local/share/applications/cutechess.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Cute Chess
Comment=Cute Chess - GUI for Playing Chess
Exec=$HOME/cutechess/build/cutechess
Icon=$HOME/cutechess/projects/gui/res/icons/cutechess_128x128.png
Terminal=false
Categories=Game;
EOF
update_cutechess_config
cp ~/.local/share/applications/cutechess.desktop ~/Desktop/cutechess.desktop && chmod +x ~/Desktop/cutechess.desktop
DEBIAN_FRONTEND=noninteractive apt install libqt5svg5-dev qt5-qmake qtbase5-dev qtbase5-dev-tools -y -o Dpkg::Options::="--force-confnew"
git clone --depth=1 https://github.com/hotfics/Sylvan.git
cd Sylvan || exit
qmake
make
cd ~ || exit
cat > ~/.local/share/applications/sylvan.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Sylvan
Comment=Sylvan - GUI for Playing Xiangqi
Exec=$HOME/Sylvan/projects/gui/sylvan
Icon=$HOME/Sylvan/projects/gui/res/icons/app.ico
Terminal=false
Categories=Game;
EOF
update_sylvan_config
git clone https://github.com/jusw85/mozlz4.git
cd mozlz4 || true
cargo build --release
cd target/release || true
mv mozlz4-bin mozlz4
mv mozlz4 ~/.local/bin/
cd ~ || true
rm -rf mozlz4
cp ~/.local/share/applications/sylvan.desktop ~/Desktop/sylvan.desktop && chmod +x ~/Desktop/sylvan.desktop
curl --retry 100 --retry-connrefused --retry-delay 5 -fsSL https://raw.githubusercontent.com/AlexsJones/llmfit/main/install.sh | sh
gh_latest -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' gulp79/rclone-extra rclone-linux-arm64.zip
unzip rclone-linux-arm64.zip
rm rclone-linux-arm64.zip*
mv rclone ~/.local/bin/
wget --tries=100 --retry-connrefused --waitretry=5 https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt -O ~/.eff_large_wordlist.txt
if [ "$TEST" -eq 0 ]; then
wget --tries=100 --retry-connrefused --waitretry=5 --no-check-certificate https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz
rm install-tl-unx.tar.gz*
cd install-tl-* || exit
perl ./install-tl --no-interaction
cd ~ || exit
rm -rf install-tl-*
/usr/local/texlive/2026/bin/aarch64-linux/tlmgr update --all --self --reinstall-forcibly-removed
fi
mkdir -p ~/.config/fontconfig/conf.d
cat > ~/.config/fontconfig/conf.d/00-noto.conf <<'EOF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
<match target="pattern">
  <test name="family">
    <string>system-ui</string>
  </test>
  <edit name="family" mode="prepend" binding="strong">
    <string>sans-serif</string>
  </edit>
</match>
<match target="pattern">
  <test name="family">
    <string>sans-serif</string>
  </test>
  <edit name="family" mode="prepend" binding="strong">
    <string>Noto Sans</string>
    <string>Noto Sans CJK TC</string>
    <string>Noto Sans CJK SC</string>
    <string>Noto Sans CJK JP</string>
    <string>Noto Sans CJK KR</string>
    <string>Noto Sans CJK HK</string>
    <string>Noto Color Emoji</string>
  </edit>
</match>
<match target="pattern">
  <test name="family">
    <string>serif</string>
  </test>
  <edit name="family" mode="prepend" binding="strong">
    <string>Noto Serif</string>
    <string>Noto Serif CJK TC</string>
    <string>Noto Serif CJK SC</string>
    <string>Noto Serif CJK JP</string>
    <string>Noto Serif CJK KR</string>
    <string>Noto Serif CJK HK</string>
    <string>Noto Color Emoji</string>
  </edit>
</match>
<match target="pattern">
  <test name="family">
    <string>monospace</string>
  </test>
  <edit name="family" mode="prepend" binding="strong">
    <string>Noto Sans Mono</string>
    <string>Noto Sans Mono CJK TC</string>
    <string>Noto Sans Mono CJK SC</string>
    <string>Noto Sans Mono CJK JP</string>
    <string>Noto Sans Mono CJK KR</string>
    <string>Noto Sans Mono CJK HK</string>
    <string>Noto Color Emoji</string>
  </edit>
</match>
</fontconfig>
EOF
cat > ~/.config/fontconfig/conf.d/01-replace.conf <<'EOF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
<match target="pattern">
  <test name="family">
    <string>DFKai-SB</string>
  </test>
  <edit name="family" mode="prepend" binding="strong">
    <string>TW-Kai</string>
  </edit>
</match>
<match target="pattern">
  <test name="family">
    <string>MingLiu</string>
  </test>
  <edit name="family" mode="prepend" binding="strong">
    <string>TW-Sung</string>
  </edit>
</match>
<match target="pattern">
  <test name="family">
    <string>PMingLiu</string>
  </test>
  <edit name="family" mode="prepend" binding="strong">
    <string>TW-Sung</string>
  </edit>
</match>
<match target="pattern">
  <test name="family">
    <string>Microsoft JhengHei</string>
  </test>
  <edit name="family" mode="prepend" binding="strong">
    <string>WenQuanYi Zen Hei</string>
  </edit>
</match>
</fontconfig>
EOF
cat > ~/.config/fontconfig/conf.d/99-texlive.conf << 'EOF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <dir>/usr/local/texlive/2026/texmf-dist/fonts</dir>
</fontconfig>
EOF
[ "$TEST" -eq 0 ] && fc-cache -fv
cd /usr/share || exit
git clone https://github.com/Willie169/LaTeX-ToolKit
cd ~ || exit
mkdir -p texmf
cd texmf || exit
mkdir -p tex
cd tex || exit
mkdir -p latex
cd latex || exit
git clone https://github.com/Willie169/physics-patch
cd physics-patch || exit
git checkout dev
cd ~ || exit
DEBIAN_FRONTEND=noninteractive apt install -f -y -o Dpkg::Options::="--force-confnew"
DEBIAN_FRONTEND=noninteractive apt upgrade -y -o Dpkg::Options::="--force-confnew"
DEBIAN_FRONTEND=noninteractive apt autoremove --purge -y -o Dpkg::Options::="--force-confnew"
apt clean
rm ubuntu-debian.sh || true
# shellcheck disable=2155
POSTDF=$(df --output=used / | tail -n1)
echo "PREDF: $PREDF"
echo "POSTDF: $POSTDF"
[ "$TEST" -eq 0 ] && [ "$FULL" -eq 0 ] && exit || true
