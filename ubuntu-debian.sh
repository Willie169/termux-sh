#!/bin/bash

shopt -s expand_aliases
cd ~
source /etc/os-release
apt update
if [ "$ID" = "ubuntu" ]; then
apt install software-properties-common -y </dev/null
add-apt-repository universe -y
add-apt-repository multiverse -y
add-apt-repository restricted -y
add-apt-repository ppa:longsleep/golang-backports -y
add-apt-repository ppa:mozillateam/ppa -y
add-apt-repository ppa:neovim-ppa/unstable -y
add-apt-repository ppa:zhangsongcui3371/fastfetch -y
else
sed -i 's/\bmain\b.*/main contrib non-free non-free-firmware/' /etc/apt/sources.list
fi
apt update
apt purge texlive* -y </dev/null
apt install wget -y </dev/null
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
mkdir -p /usr/local/go
mkdir -p /usr/local/java
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/applications
mkdir -p ~/Desktop
apt upgrade -y </dev/null
apt install aisleriot alien alsa-utils apksigner apt-transport-https aptitude autoconf automake bash bc bear bison build-essential bzip2 caneda ca-certificates clang clangd clang-format cmake command-not-found curl dbus default-jdk dmg2img dnsutils dvisvgm fastfetch ffmpeg file flex g++ gcc gdb gfortran gh ghc ghostscript git glab gnupg golang-go gopls gperf gpg grep gtkwave gzip info imagemagick inkscape iproute2 iverilog jpegoptim jq libboost-all-dev libbz2-dev libconfig-dev libeigen3-dev libffi-dev libfuse2 libgdbm-compat-dev libgdbm-dev libgsl-dev libguestfs-tools libheif-examples libhwloc-dev libhwloc-plugins libllvm19 liblzma-dev libncursesw5-dev libopenblas-dev libosmesa6 libportaudio2 libqt5svg5-dev libreadline-dev libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-net-dev libsdl2-ttf-dev libsqlite3-dev libssl-dev libuv1t64 libuv1-dev libxml2-dev libxmlsec1-dev libzip-dev libzstd-dev llvm make maven mc nano ncompress neovim netcat-openbsd ngspice ninja-build nmap openjdk-21-jdk openssh-client openssh-server openssl optipng pandoc pcregrep perl perl-doc perl-tk pipx plantuml poppler-utils procps pv python-is-python3 python3-all-dev python3-neovim python3-pip python3-venv qtbase5-dev qtbase5-dev-tools rust-all socat sqlite3 sudo tar tk-dev tmux tree unrar unzip uuid-dev uuid-runtime valgrind verilator vim webp wget wget2 x11-utils x11-xserver-utils xdotool xmlstarlet xz-utils zip zlib1g zlib1g-dev zsh zstd -y </dev/null
wget --tries=100 --retry-connrefused --waitretry=5 http://ports.ubuntu.com/pool/universe/e/elementary-xfce/elementary-xfce-icon-theme_0.19-1_all.deb
apt install ./elementary-xfce-icon-theme_0.19-1_all.deb -y </dev/null
rm elementary-xfce-icon-theme_0.19-1_all.deb
apt-mark hold elementary-xfce-icon-theme
apt install dbus-x11 firefox mesa-utils xfce4 xfce4-goodies xfce4-terminal xinit -y </dev/null
wget --tries=100 --retry-connrefused --waitretry=5 -O SDL2_bgi-3.0.4.tar.gz https://sourceforge.net/projects/sdl-bgi/files/SDL2_bgi-3.0.4.tar.gz/download
tar -xzf SDL2_bgi-3.0.4.tar.gz
cd SDL2_bgi-3.0.4
./mkpkg.sh
cd build
apt install ./sdl2_bgi_3.0.4-1_arm64.deb -y </dev/null
cd ../..
rm -rf SDL2_bgi-3.0.4 SDL2_bgi-3.0.4.tar.gz
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/; s/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
mkdir -p /run/sshd
chmod 755 /run/sshd
PROFILE=/dev/null bash -c 'curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install 25
corepack enable yarn
corepack enable pnpm
npm install jsdom markdown-toc marked marked-gfm-heading-id node-html-markdown showdown
npm install -g bash-language-server dockerfile-language-server-nodejs http-server pyright tree-sitter-cli @google/gemini-cli @openai/codex
pipx install uv notebook jupyterlab jupytext meson pylatexenc
uv tool install --force --python python3.12 --with pip aider-chat@latest --with playwright
uv tool run playwright install --with-deps chromium
curl --retry 100 --retry-connrefused --retry-delay 5 -fsSL https://bun.com/install | bash
wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
bash Miniforge3-Linux-aarch64.sh -b -p ${HOME}/conda
rm Miniforge3-Linux-aarch64.sh
export MAMBA_ROOT_PREFIX="${HOME}/conda"
source "${HOME}/conda/etc/profile.d/conda.sh" 2>/dev/null || true
source "${HOME}/conda/etc/profile.d/mamba.sh" 2>/dev/null || true
conda config --set auto_activate_base false
conda config --add channels bioconda
conda config --add channels pypi
conda config --add channels pytorch
conda config --add channels microsoft
conda config --add channels defaults
conda config --add channels conda-forge
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
apt install ./packages-microsoft-prod.deb -y </dev/null
rm packages-microsoft-prod.deb
apt update
apt install dotnet-sdk-10.0 aspnetcore-runtime-10.0 -y </dev/null
wget --tries=100 --retry-connrefused --waitretry=5 -O /usr/local/java/antlr-4.13.2-complete.jar https://www.antlr.org/download/antlr-4.13.2-complete.jar
wget --tries=100 --retry-connrefused --waitretry=5 -O /usr/local/java/plantuml.jar https://sourceforge.net/projects/plantuml/files/plantuml.jar/download
apt install postgresql-common postgresql-17 -y </dev/null
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
curl --retry 100 --retry-connrefused --retry-delay 5 -fsSL https://ollama.com/install.sh | sh
curl --retry 100 --retry-connrefused --retry-delay 5 -fsSL https://opencode.ai/install | bash
curl --retry 100 --retry-connrefused --retry-delay 5 -fsSL https://claude.ai/install.sh | bash
curl --retry 100 --retry-connrefused --retry-delay 5 -fsSL https://raw.githubusercontent.com/AlexsJones/llmfit/main/install.sh | sh
mkdir -p ~/dev/llm
cd ~/dev/llm
git clone https://github.com/ggml-org/llama.cpp && cd llama.cpp
cmake -B build
cmake --build build --config Release -j$(nproc)
cd ~
wget --tries=100 --retry-connrefused --waitretry=5 https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
zcat < install-tl-unx.tar.gz | tar xf -
rm install-tl-unx.tar.gz
cd install-tl-*
perl ./install-tl --no-interaction
cd ~
rm -rf install-tl-*
/usr/local/texlive/2026/bin/aarch64-linux/tlmgr update --all --self --reinstall-forcibly-removed
mkdir -p ~/.config/fontconfig/conf.d
cat > ~/.config/fontconfig/conf.d/99-texlive.conf << 'EOF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <dir>/usr/local/texlive/2026/texmf-dist/fonts</dir>
</fontconfig>
EOF
mkdir -p /usr/share/fonts/opentype/xits
cd /usr/share/fonts/opentype/xits
wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/aliftype/xits/releases/download/v1.302/XITS-1.302.zip
unzip XITS-1.302.zip
cd XITS-1.302
mv *.otf ..
cd ..
rm -rf XITS-1.302*
mkdir -p /usr/share/fonts/noto-cjk
cd /usr/share/fonts/noto-cjk
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Thin.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Medium.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Light.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-DemiLight.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Bold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Black.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Thin.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Medium.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Light.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-DemiLight.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Bold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Black.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Thin.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Medium.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Light.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-DemiLight.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Bold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Black.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Thin.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Medium.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Light.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-DemiLight.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Bold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Black.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Thin.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Medium.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Light.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-DemiLight.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Bold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Black.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-ExtraLight.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Medium.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Light.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-SemiBold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Bold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Black.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-ExtraLight.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Medium.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Light.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-SemiBold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Bold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Black.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-ExtraLight.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Medium.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Light.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-SemiBold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Bold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Black.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-ExtraLight.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Medium.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Light.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-SemiBold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Bold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Black.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-ExtraLight.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Medium.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Light.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-SemiBold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Bold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Black.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKtc-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKtc-Bold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKsc-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKsc-Bold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKhk-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKhk-Bold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKjp-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKjp-Bold.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKkr-Regular.otf
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKkr-Bold.otf
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
cd ~
apt update
apt install -f -y </dev/null
apt upgrade -y </dev/null
apt autoremove --purge -y </dev/null
apt clean
rm ubuntu-debian.sh || true
exit
