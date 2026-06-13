#!/bin/bash

shopt -s expand_aliases
cd ~
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
apt install software-properties-common -y
add-apt-repository universe -y
add-apt-repository multiverse -y
add-apt-repository restricted -y
add-apt-repository ppa:colin-king/stress-ng -y
add-apt-repository ppa:git-core/ppa -y
add-apt-repository ppa:libreoffice/ppa -y
add-apt-repository ppa:longsleep/golang-backports -y
add-apt-repository ppa:mozillateam/ppa -y
add-apt-repository ppa:neovim-ppa/unstable -y
add-apt-repository ppa:zhangsongcui3371/fastfetch -y
else
sed -i 's/\bmain\b.*/main contrib non-free non-free-firmware/' /etc/apt/sources.list
fi
apt update
apt purge texlive* yq -y
apt install wget -y
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
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/bashrc.sh -O ~/.bashrc
cat > ~/.profile <<'EOF'
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
EOF
if [ -d "$HOME/.bashrc.d"  ];  then
  for f in "$HOME/.bashrc.d/"*; do
    [ -r "$f"  ] && . "$f"
  done
fi
[ -r ~/API_KEY.sh  ] && source ~/API_KEY.sh
mkdir -p /usr/local/go
mkdir -p /usr/local/java
mkdir -p /etc/apt/keyrings
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/applications
mkdir -p ~/Desktop
sed -E -i 's/# (.*UTF-8)/\1/' /etc/locale.gen
locale-gen
update-locale LANG=en_US.UTF-8
apt upgrade -y
apt install abcde alien alsa-utils apksigner apt-transport-https aptitude audacity autoconf automake bash bc bear bindfs bison bookletimposer build-essential bzip2 calcurse ca-certificates clang clangd clang-format cmake command-not-found curl dbus debian-archive-keyring debian-keyring default-jdk dmg2img dnsutils dvisvgm fastfetch ffmpeg file flex fonts-cns11643-kai fonts-cns11643-sung fontconfig fonts-liberation fonts-noto fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji fonts-wqy-zenhei g++ gcc gdb gfortran gh ghc ghostscript git git-lfs glab gnupg gnupg2 golang-go gopls gperf gpg grep gtkwave gzip hyperfine info imagemagick inkscape iotop-c iproute2 iverilog jpegoptim jq lftp libboost-all-dev libbz2-dev libconfig-dev libeigen3-dev libffi-dev libfuse2 libgdbm-compat-dev libgdbm-dev libgsl-dev libguestfs-tools libheif-examples libhwloc-dev libhwloc-plugins libllvm19 liblzma-dev libncursesw5-dev libopenblas-dev libosmesa6 libportaudio2 libqt5svg5-dev libreadline-dev libreoffice libsqlite3-dev libssl-dev libuv1t64 libuv1-dev libxml2-dev libxmlsec1-dev libzip-dev libzstd-dev llvm lsb-release lsd lzip make maven mc mpv nano ncdu ncompress neovim netcat-openbsd ngspice ninja-build nmap nnn ntopng octave openjdk-21-jdk openssh-client openssh-server openssl optipng pandoc perl perl-doc perl-tk pipx pkg-config plantuml poppler-utils procps pv pwgen python-is-python3 python3-all-dev python3-httpx python3-jinja2 python3-neovim python3-requests python3-pip python3-venv p7zip-full qpdf qtbase5-dev qtbase5-dev-tools rustup shellcheck shfmt socat sqlite3 stress-ng sudo tar tk-dev tmux tree tree-sitter-cli tsocks ttf-mscorefonts-installer unrar unzip uuid-dev uuid-runtime valgrind verilator vim webp wget wget2 w3m x11-utils x11-xserver-utils xdotool xmlstarlet xz-utils zip zlib1g zlib1g-dev zsh zstd -y
apt install nodejs npm -y
wget --tries=100 --retry-connrefused --waitretry=5 http://ports.ubuntu.com/pool/universe/e/elementary-xfce/elementary-xfce-icon-theme_0.19-1_all.deb
apt install ./elementary-xfce-icon-theme_0.19-1_all.deb -y
rm elementary-xfce-icon-theme_0.19-1_all.deb
apt-mark hold elementary-xfce-icon-theme
apt install dbus-x11 firefox mesa-utils xfce4 xfce4-goodies xfce4-terminal xinit -y
sed -Ei 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/; s/^#?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
mkdir -p /run/sshd
chmod 755 /run/sshd
rustup update stable
curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | tee /etc/apt/sources.list.d/debian.griffo.io.list >/dev/null
apt update
apt install lazygit -y
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | tee /etc/apt/sources.list.d/gierens.list >/dev/null
chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
apt update
apt install eza -y
npm i jsdom markdown-toc marked marked-gfm-heading-id node-html-markdown showdown
npm i -g bash-language-server dockerfile-language-server-nodejs http-server opencode-ai pyright @linthtml/linthtml @openai/codex
pipx install cmake-language-server gh2md libretranslate notebook jupyterlab jupytext meson poetry pylatexenc tldr uv yamllint
uv tool install --force --python python3.12 markitdown[all]
wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
bash Miniforge3-Linux-aarch64.sh -b -p "${HOME}/conda"
rm Miniforge3-Linux-aarch64.sh
export MAMBA_ROOT_PREFIX="${HOME}/conda"
source "${HOME}/conda/etc/profile.d/conda.sh" 2>/dev/null || true
source "${HOME}/conda/etc/profile.d/mamba.sh" 2>/dev/null || true
conda config --set auto_activate_base false
conda config --add channels pypi
conda config --add channels pytorch
conda config --add channels conda-forge
conda config --remove channels defaults || true
touch /.dockerenv
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
brew install broot dust fzf gurgeous/tap/tennis procs resvg sevenzip starship xplr yazi yq zoxide
brew install ripgrep
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global merge.conflictStyle zdiff3
brew vendor-gems
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
wget --tries=100 --retry-connrefused --waitretry=5 "https://packages.microsoft.com/config/$ID/$VERSION_ID/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
apt install ./packages-microsoft-prod.deb -y
rm packages-microsoft-prod.deb
apt update
apt install dotnet-sdk-10.0 aspnetcore-runtime-10.0 -y
curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list >/dev/null
apt update
apt install glow -y
wget --tries=100 --retry-connrefused --waitretry=5 -O /usr/local/java/antlr-4.13.2-complete.jar https://www.antlr.org/download/antlr-4.13.2-complete.jar
wget --tries=100 --retry-connrefused --waitretry=5 -O /usr/local/java/plantuml.jar https://sourceforge.net/projects/plantuml/files/plantuml.jar/download
apt install postgresql-common -y
/usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y
apt install postgresql -y
mkdir -p /var/log/postgresql
chown -R postgres:postgres /var/log/postgresql
chmod 755 /var/log/postgresql
chmod 640 /var/log/postgresql/* 2>/dev/null || true
gh_latest -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' kristoff-it/superhtml aarch64-linux.tar.xz
tar -xJf aarch64-linux.tar.xz
rm aarch64-linux.tar.xz
mv superhtml ~/.local/bin
mkdir eclipse.jdt.ls
cd eclipse.jdt.ls
wget --tries=100 --retry-connrefused --waitretry=5 'https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.57.0/jdt-language-server-1.57.0-202602261110.tar.gz'
tar -xzf 'download.php?file=%2Fjdtls%2Fmilestones%2F1.57.0%2Fjdt-language-server-1.57.0-202602261110.tar.gz'
rm 'download.php?file=%2Fjdtls%2Fmilestones%2F1.57.0%2Fjdt-language-server-1.57.0-202602261110.tar.gz'
cd ~
git clone https://github.com/lightvector/KataGo.git
cd KataGo/cpp
cmake . -G Ninja -DUSE_BACKEND=EIGEN
ninja
cd ../..
mkdir katago-networks
cd katago-networks
wget --tries=100 --retry-connrefused --waitretry=5 https://media.katagotraining.org/uploaded/networks/models/kata1/kata1-b6c96-s175395328-d26788732.txt.gz
cd ~
git clone https://github.com/yzyray/lizzieyzy.git
cd lizzieyzy
mvn clean package
cd ~
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
git clone https://github.com/fairy-stockfish/Fairy-Stockfish.git
cd Fairy-Stockfish/src
ARCH=$(uname -m)
if [ "$ARCH" == "x86_64" ]; then
ARCH="x86-64"
elif [ "$ARCH" == "aarch64" ]; then
ARCH="armv8"
elif [ "$ARCH" == "arm" ]; then
ARCH="armv7"
fi
make -j ARCH="$ARCH" profile-build largeboards=yes nnue=yes
cd ~
git clone https://github.com/cutechess/cutechess.git
cd cutechess
mkdir build
cd build
cmake -G Ninja ..
ninja
cd ~
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
git clone https://github.com/hotfics/Sylvan.git
cd Sylvan
qmake
make
cd ~
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
cp ~/.local/share/applications/sylvan.desktop ~/Desktop/sylvan.desktop && chmod +x ~/Desktop/sylvan.desktop
curl --retry 100 --retry-connrefused --retry-delay 5 -fsSL https://raw.githubusercontent.com/AlexsJones/llmfit/main/install.sh | sh
mkdir -p ~/dev/llm
cd ~/dev/llm
git clone https://github.com/ggml-org/llama.cpp && cd llama.cpp
cmake -B build
cmake --build build --config Release -j$(nproc)
cd ~
git clone https://github.com/wimpysworld/deb-get.git
cd deb-get/docs/
make install
cd ~
deb-get install bat bottom fd git-delta
wget --tries=100 --retry-connrefused --waitretry=5 https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz
rm install-tl-unx.tar.gz
cd install-tl-*
perl ./install-tl --no-interaction
cd ~
rm -rf install-tl-*
/usr/local/texlive/2026/bin/aarch64-linux/tlmgr update --all --self --reinstall-forcibly-removed
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
fc-cache -fv
cd /usr/share
git clone https://github.com/Willie169/LaTeX-ToolKit
cd ~
mkdir -p texmf
cd texmf
mkdir -p tex
cd tex
mkdir -p latex
cd latex
git clone https://github.com/Willie169/physics-patch
cd physics-patch
git checkout dev
cd ~
apt update
apt install -f -y
apt upgrade -y
apt autoremove --purge -y
apt clean
rm ubuntu-debian.sh || true
exit
