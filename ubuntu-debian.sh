#!/usr/bin/env bash

set -euxo pipefail
TEST=0
FULL=0
[ "${1:-}" = '--test' ] && TEST=1
[ "${2:-}" = '--test' ] && TEST=1
[ "${1:-}" = '--full' ] && FULL=1
[ "${2:-}" = '--full' ] && FULL=1
# shellcheck disable=2155
PREDF=$(df --output=used / | tail -n1)
cd ~ || exit
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
  DEBIAN_FRONTEND=noninteractive apt install software-properties-common -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
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
DEBIAN_FRONTEND=noninteractive apt purge neovim rustup texlive* tree-sitter-cli yq -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
DEBIAN_FRONTEND=noninteractive apt install apt-transport-https bash build-essential ca-certificates coreutils cmake curl dbus openjdk-21-jdk g++ gcc git gnupg grep gzip jq locales lsb-release make ninja-build openssh-server perl perl-tk python-is-python3 python3 vim-gtk3 wget xz-utils -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
DEBIAN_FRONTEND=noninteractive apt install sudo -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8
rm -rf ~/.bashrc ~/.bashrc.d
git clone --depth=1 https://github.com/Willie169/bashrc ~/.bashrc.d
ln -sf "$HOME/.bashrc.d/bashrc.d/bashrc" "$HOME/.bashrc"
source ~/.bashrc
source /etc/os-release
cat >~/.profile <<'EOF'
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
EOF
DEBIAN_FRONTEND=noninteractive apt upgrade -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
PKG='2048 alsa-utils apksigner apt-transport-https aptitude audacity automake bash bc bear bindfs bison bookletimposer build-essential bzip2 ca-certificates calcurse checkinstall clang clang-format cmake command-not-found cowsay cronie curl dbus dbus-x11 debconf-utils diffoscope distro-info dnsutils dvisvgm fastfetch file flex fontconfig fonts-cns11643-kai fonts-cns11643-sung fonts-liberation fonts-noto fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji fonts-wqy-zenhei fortune-mod g++ gcc gdb gh ghostscript git git-sizer glab gnupg gnupg2 golang-go gperf grep gzip hwinfo hyperfine iftop imagemagick info inkscape inxi iotop-c iproute2 jpegoptim jq lftp libheif-examples libimage-exiftool-perl libjxl-tools libreoffice lsb-release lsd lshw luajit lzip make maven mediainfo mesa-utils mplayer mpv nano ncdu net-tools netcat-openbsd nethogs ngspice ninja-build nmap ocrmypdf octave openjdk-21-jdk openssh-client openssh-server openssl optipng p7zip-full pandoc perl perl-tk pkg-config plantuml poppler-utils procps pv pwgen python-is-python3 python3-all-dev python3-argcomplete python3-httpx python3-jinja2 python3-pip python3-requests python3-venv qalc qpdf shellcheck shfmt socat sqlite3 strace sudo tar tesseract-ocr tesseract-ocr-chi-sim tesseract-ocr-chi-sim-vert tesseract-ocr-chi-tra tesseract-ocr-chi-tra-vert tesseract-ocr-eng tesseract-ocr-jpn tesseract-ocr-jpn-vert tmux trash-cli tree tsocks unrar unzip uuid-runtime verilator vim-gtk3 w3m webp wget wget2 xdotool xmlstarlet xz-utils zip zsh zstd'
# shellcheck disable=2086
if [ "$TEST" -eq 0 ]; then
  DEBIAN_FRONTEND=noninteractive apt install $PKG -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
else
  DEBIAN_FRONTEND=noninteractive apt install $PKG -y -s -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
fi
wget --tries=100 --retry-connrefused --waitretry=5 http://ports.ubuntu.com/pool/universe/e/elementary-xfce/elementary-xfce-icon-theme_0.19-1_all.deb
DEBIAN_FRONTEND=noninteractive apt install ./elementary-xfce-icon-theme_0.19-1_all.deb -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
rm elementary-xfce-icon-theme_0.19-1_all.deb*
apt-mark hold elementary-xfce-icon-theme
DEBIAN_FRONTEND=noninteractive apt install xclip xfce4 xfce4-goodies xinit -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
. "$HOME/.cargo/env"
cargo install stylua
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
DEBIAN_FRONTEND=noninteractive apt install git-lfs -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
git lfs install
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
chmod +x apktool
mv apktool /usr/local/bin/
gh_release -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' iBotPeaches/Apktool 'apktool_*.jar'
chmod +x apktool_*.jar
mv apktool_*.jar /usr/local/bin/
mkdir jadx
cd jadx || exit
gh_release -r -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' skylot/jadx 'jadx-[0-9\.]*\.zip'
unzip jadx*.zip
rm jadx*.zip*
chmod +x bin/jadx
chmod +x bin/jadx-gui
cd ~ || exit
NVM_VERSION=$(curl -fsSL "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | jq -r '.tag_name')
PROFILE=/dev/null bash -c "curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
nvm install --lts
echo y | corepack enable npm
echo y | npm --help || true
echo y | corepack enable yarn
echo y | yarn --help || true
NPMGALLOW='deno http-server prettier'
# shellcheck disable=2086
if [ "$TEST" -eq 0 ]; then
  npmig $NPMGALLOW
else
  npmig -o --dry-run $NPMGALLOW
fi
gh_release -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' yt-dlp/yt-dlp yt-dlp
chmod +x yt-dlp
mv yt-dlp ~/.local/bin/
curl -LsSf https://astral.sh/uv/install.sh | sh
for pkg in autopep8 gallery-dl gh2md img2pdf jupyterlab jupytext libretranslate meson notebook pylatexenc tldr xmljson yamllint; do
  uv tool install "$pkg"
done
wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
bash Miniforge3-Linux-aarch64.sh -b -p "$HOME/conda"
rm Miniforge3-Linux-aarch64.sh*
export MAMBA_ROOT_PREFIX="$HOME/conda"
source "$HOME/conda/etc/profile.d/conda.sh" 2>/dev/null
source "$HOME/conda/etc/profile.d/mamba.sh" 2>/dev/null
conda config --set auto_activate_base false
conda config --add channels pypi
conda config --add channels pytorch
conda config --add channels conda-forge
git config --global pull.rebase true
git config --global init.defaultBranch main
touch /.dockerenv
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
BREW='bat bottom broot dust fd ffmpeg-full fzf git-delta hugo lazygit procs resvg ripgrep sevenzip vgmstream yazi yq zoxide'
if [ "$TEST" -eq 0 ]; then
  # shellcheck disable=2086
  if ! echo y | brew install $BREW; then
    echo y | brew install $BREW
  fi
  git config --global core.pager delta
  git config --global interactive.diffFilter 'delta --color-only'
  git config --global delta.navigate true
  git config --global merge.conflictStyle zdiff3
  broot --set-install-state installed && mkdir -p "$HOME/.config/broot/launcher/bash" && broot --print-shell-function bash >"$HOME/.config/broot/launcher/bash/br" && chmod +x "$HOME/.config/broot/launcher/bash/br"
else
  # shellcheck disable=2086
  echo y | brew install $BREW --dry-run
fi
brew cleanup
curl -fsSL https://raw.githubusercontent.com/Willie169/vim-config/refs/heads/main/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/Willie169/nvim-config/refs/heads/main/full-install.sh | bash
nvim --headless "+Lazy! install" +qa
curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list >/dev/null
apt update
DEBIAN_FRONTEND=noninteractive apt install glow -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
DEBIAN_FRONTEND=noninteractive apt install libeigen3-dev libzip-dev zlib1g-dev -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
git clone --depth=1 https://github.com/lightvector/KataGo.git
cd KataGo/cpp || exit
cmake . -G Ninja -DUSE_BACKEND=EIGEN
ninja
cd ../.. || exit
mkdir katago-networks
cd katago-networks || exit
wget --tries=100 --retry-connrefused --waitretry=5 https://media.katagotraining.org/uploaded/networks/models/kata1/kata1-b6c96-s175395328-d26788732.txt.gz
cd ~ || exit
DEBIAN_FRONTEND=noninteractive apt install maven -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
mkdir ~/.local/share/lizzieyzy
git clone --depth=1 https://github.com/yzyray/lizzieyzy.git
cd lizzieyzy || exit
mvn clean package
cd target || exit
mv lizzie-yzy*-shaded.jar lizzie-yzy.jar
mv lizzie-yzy.jar ~/.local/share/lizzieyzy/
cd ~ || exit
mv ~/lizzieyzy/src/main/resources/assets/logo.png ~/.local/share/lizzieyzy/
rm -rf ~/.m2/repository
rm -rf ~/lizzieyzy
cat >~/.local/share/applications/lizzieyzy.desktop <<EOF
[Desktop Entry]
Type=Application
Name=LizzieYzy
Comment=LizzieYzy - GUI for Game of Go
Exec=sh -c 'cd $HOME/.local/share/lizzieyzy && java -jar lizzie-yzy.jar'
Icon=$HOME/.local/share/lizzieyzy/logo.png
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
mv stockfish ~/.local/bin/
cd ~ || exit
rm -rf Fairy-Stockfish
DEBIAN_FRONTEND=noninteractive apt install qt6-base-dev qt6-base-dev-tools qt6-svg-dev qt6-5compat-dev -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
mkdir ~/.config/cutechess
git clone --depth=1 https://github.com/cutechess/cutechess.git
cd cutechess || exit
mkdir build
cd build || exit
cmake -G Ninja ..
ninja
mv cutechess ~/.local/bin/
mv cutechess-cli ~/.local/bin/
cd ..
mv projects/gui/res/icons/cutechess_128x128.png ~/.config/cutechess/
cd ~ || exit
rm -rf cutechess
cat >~/.local/share/applications/cutechess.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Cute Chess
Comment=Cute Chess - GUI for Playing Chess
Exec=$HOME/.local/bin/cutechess
Icon=$HOME/.config/cutechess/cutechess_128x128.png
Terminal=false
Categories=Game;
EOF
update_cutechess_config
cp ~/.local/share/applications/cutechess.desktop ~/Desktop/cutechess.desktop && chmod +x ~/Desktop/cutechess.desktop
DEBIAN_FRONTEND=noninteractive apt install libqt5svg5-dev qt5-qmake qtbase5-dev qtbase5-dev-tools -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
git clone --depth=1 https://github.com/hotfics/Sylvan.git
cd Sylvan || exit
qmake
make
cd ~ || exit
cat >~/.local/share/applications/sylvan.desktop <<EOF
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
cp ~/.local/share/applications/sylvan.desktop ~/Desktop/sylvan.desktop && chmod +x ~/Desktop/sylvan.desktop
git clone https://github.com/jusw85/mozlz4.git
cd mozlz4 || exit
cargo build --release
cd target/release || exit
mv mozlz4-bin mozlz4
mv mozlz4 ~/.local/bin/
cd ~ || exit
rm -rf mozlz4
gh_release -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' gulp79/rclone-extra rclone-linux-arm64.zip
unzip rclone-linux-arm64.zip
rm rclone-linux-arm64.zip*
mv rclone ~/.local/bin/
gh_release -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' Willie169/bnkextr bnkextr-linux-glibc-aarch64.zip
unzip bnkextr-linux-glibc-aarch64.zip
rm bnkextr-linux-glibc-aarch64.zip*
mv bnkextr ~/.local/bin/
wget --tries=100 --retry-connrefused --waitretry=5 https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt -O ~/.eff_large_wordlist.txt
DEBIAN_FRONTEND=noninteractive apt install gawk git make python3 lld bison clang flex libffi-dev libfl-dev libreadline-dev pkg-config tcl-dev zlib1g-dev graphviz xdot -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
git clone --depth=1 https://github.com/YosysHQ/yosys.git
cd yosys || exit
git submodule update --init --depth=1
cmake -B build . -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release --parallel "$(nproc)"
cmake --install build --strip
cd ~ || exit
rm -rf yosys
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
cat >~/.config/fontconfig/conf.d/00-noto.conf <<'EOF'
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
cat >~/.config/fontconfig/conf.d/01-replace.conf <<'EOF'
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
cat >~/.config/fontconfig/conf.d/99-texlive.conf <<'EOF'
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
DEBIAN_FRONTEND=noninteractive apt install -f -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
DEBIAN_FRONTEND=noninteractive apt upgrade -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
DEBIAN_FRONTEND=noninteractive apt autoremove --purge -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
apt clean
rm ubuntu-debian.sh || true
# shellcheck disable=2155
POSTDF=$(df --output=used / | tail -n1)
echo "PREDF: $PREDF"
echo "POSTDF: $POSTDF"
[ "$TEST" -eq 0 ] && [ "$FULL" -eq 0 ] && exit || true
