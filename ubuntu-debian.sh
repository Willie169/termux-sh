#!/bin/bash

cd ~
apt update
if [ "$ID" = "ubuntu" ]; then
apt install software-properties-common -y
add-apt-repository universe -y
add-apt-repository multiverse -y
add-apt-repository restricted -y
add-apt-repository ppa:zhangsongcui3371/fastfetch -y
else
sed -i 's/\bmain\b.*/main contrib non-free non-free-firmware/' /etc/apt/sources.list
fi
apt update
apt purge texlive* -y
apt install wget -y
rm -f .bashrc
mkdir ~/.bashrc.d
wget https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/00-env.sh -O ~/.bashrc.d/00-env.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/10-exports.sh -O ~/.bashrc.d/10-exports.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/15-color.sh -O ~/.bashrc.d/15-color.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/20-aliases.sh -O ~/.bashrc.d/20-aliases.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/21-cxx.sh -O ~/.bashrc.d/21-cxx.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/22-java.sh -O ~/.bashrc.d/22-java.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/23-vnc.sh -O ~/.bashrc.d/23-vnc.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/24-flatpak.sh -O ~/.bashrc.d/24-flatpak.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/50-functions.sh -O ~/.bashrc.d/50-functions.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/60-completion.sh -O ~/.bashrc.d/60-completion.sh
wget https://raw.githubusercontent.com/Willie169/bashrc/main/ubuntu-debian-arm-proot/bashrc.d/bashrc.sh -O ~/.bashrc
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
apt upgrade -y
apt install aisleriot alsa-utils apksigner apt-transport-https aptitude aria2 autoconf automake bash bc bear bison build-essential bzip2 ca-certificates clang clang-format cmake command-not-found curl dbus default-jdk dnsutils dvipng dvisvgm fastfetch ffmpeg file flex g++ gcc gdb gfortran gh ghc ghostscript git glab gnucobol gnugo gnupg golang gperf gpg grep gtkwave gzip info inkscape iproute2 iverilog iverilog jpegoptim jq libboost-all-dev libbz2-dev libconfig-dev libeigen3-dev libffi-dev libfuse2 libgdbm-compat-dev libgdbm-dev libgsl-dev libheif-examples libllvm19 liblzma-dev libncursesw5-dev libopenblas-dev libosmesa6 libportaudio2 libreadline-dev libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-net-dev libsdl2-ttf-dev libsqlite3-dev libssl-dev libxml2-dev libxmlsec1-dev libzip-dev libzstd-dev llvm make maven mc nano ncompress neovim ngspice ninja-build openjdk-21-jdk openssh-client openssh-server openssl optipng pandoc perl perl-doc perl-tk pipx plantuml poppler-utils procps pv python3-all-dev python3-pip python3-venv rust-all sudo tar tk-dev tmux tree unrar unzip uuid-dev uuid-runtime valgrind verilator vim wget wget2 x11-utils x11-xserver-utils xmlstarlet xz-utils zip zlib1g zlib1g-dev zsh -y
wget http://ports.ubuntu.com/pool/universe/e/elementary-xfce/elementary-xfce-icon-theme_0.19-1_all.deb
apt install ./elementary-xfce-icon-theme_0.19-1_all.deb -y
rm elementary-xfce-icon-theme_0.19-1_all.deb
apt-mark hold elementary-xfce-icon-theme
apt install dbus-x11 firefox-esr tigervnc-standalone-server xfce4 xfce4-goodies xfce4-terminal -y
cat > ~/.config/tigervnc/xstartup << 'EOF'
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset SESSION_MANAGER
export XDG_RUNTIME_DIR=/tmp
export XAUTHORITY="$HOME/.Xauthority"
dbus-launch --exit-with-session startxfce4
EOF
chmod +x ~/.config/tigervnc/xstartup
wget -O SDL2_bgi-3.0.4.tar.gz https://sourceforge.net/projects/sdl-bgi/files/SDL2_bgi-3.0.4.tar.gz/download
tar -xzf SDL2_bgi-3.0.4.tar.gz
cd SDL2_bgi-3.0.4
./mkpkg.sh
cd build
apt install ./sdl2_bgi_3.0.4-1_arm64.deb
cd ../..
rm -rf SDL2_bgi-3.0.4 SDL2_bgi-3.0.4.tar.gz
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/; s/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
mkdir -p /run/sshd
chmod 755 /run/sshd
PROFILE=/dev/null bash -c 'curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install 24
corepack enable yarn
corepack enable pnpm
npm install jsdom markdown-toc marked marked-gfm-heading-id node-html-markdown showdown
npm install -g http-server @openai/codex
pipx install poetry uv
uv tool install --force --python python3.12 --with pip aider-chat@latest --with playwright
uv tool run playwright install --with-deps chromium
curl -fsSL https://bun.com/install | bash
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
bash Miniforge3-Linux-aarch64.sh -b -p ${HOME}/conda
source .bashrc
conda config --set auto_activate_base false
conda config --add channels bioconda
conda config --add channels pypi
conda config --add channels pytorch
conda config --add channels microsoft
conda config --add channels defaults
conda config --add channels conda-forge
rm Miniforge3-Linux-aarch64.sh
git clone --depth=1 https://github.com/Willie169/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
mkdir -p ~/.config/nvim
echo 'set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
' | tee ~/.config/nvim/init.vim > /dev/null
wget "https://packages.microsoft.com/config/$ID/$VERSION_ID/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
apt install ./packages-microsoft-prod.deb -y
rm packages-microsoft-prod.deb
apt update
apt install dotnet-sdk-10.0 aspnetcore-runtime-10.0 -y
wget -O /usr/local/java/antlr-4.13.2-complete.jar https://www.antlr.org/download/antlr-4.13.2-complete.jar
It is recommended to check `Active By Default` to use it by default.
wget -O /usr/local/java/plantuml.jar https://sourceforge.net/projects/plantuml/files/plantuml.jar/download
apt install postgresql-common postgresql-17 -y
git clone https://github.com/lightvector/KataGo.git
cd KataGo/cpp
cmake . -G Ninja -DUSE_BACKEND=EIGEN
ninja
cd ../..
mkdir kata-models
cd kata-models
wget https://media.katagotraining.org/uploaded/networks/models/kata1/kata1-b6c96-s175395328-d26788732.txt.gz
cd ..
git clone https://github.com/yzyray/lizzieyzy.git
cd lizzieyzy
git checkout 2.5.3
mvn clean package
cd ..
mkdir .lizzieyzy
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/lizzieyzy.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=LizzieYzy
Comment=LizzieYzy - GUI for Game of Go
Exec=sh -c 'cd $HOME/.lizzieyzy && java -jar "$HOME/lizzieyzy/target/lizzie-yzy2.5.3-shaded.jar"'
Icon=/root/lizzieyzy/src/main/resources/assets/logo.png
Terminal=false
Categories=Game;
StartupWMClass=featurecat-lizzie-Lizzie
EOF
mkdir -p Desktop
cp ~/.local/share/applications/lizzieyzy.desktop ~/Desktop/lizzieyzy.desktop
cat > ~/.lizzieyzy/config.txt <<'EOF'
{
  "leelaz": {
    "limit-max-suggestion": 10,
    "analyze-update-interval-centisec": 10,
    "enable-lizzie-cache": true,
    "limit-branch-length": 0,
    "max-analyze-time-seconds": 600,
    "max-game-thinking-time-seconds": 2,
    "engine-settings-list": [{
      "ip": "",
      "initialCommand": "",
      "userName": "",
      "preload": false,
      "command": "/root/KataGo/cpp/katago gtp -model /root/kata-models/kata1-b6c96-s175395328-d26788732.txt.gz -config /root/KataGo/cpp/configs/gtp_example.cfg",
      "komi": 7.5,
      "isDefault": true,
      "password": "",
      "port": "",
      "name": "kata1-b6c96-s175395328-d26788732",
      "width": 19,
      "useJavaSSH": false,
      "useKeyGen": false,
      "keyGenPath": "",
      "height": 19
    }]
  },
  "ui": {
    "comment-font-size": 0,
    "shadow-size": 85,
    "autosave-interval-seconds": -1,
    "no-refresh-on-sub": true,
    "win-rate-always-black": false,
    "autoload-last": false,
    "is-ctrl-opened": false,
    "show-move-number": false,
    "winrate-stroke-width": 1.7,
    "show-next-moves": true,
    "show-comment": true,
    "show-leelaz-variation": true,
    "autoload-empty": false,
    "resume-previous-game": false,
    "use-language": 2,
    "use-java-looks": true,
    "show-coordinates": true,
    "shadows-enabled": true,
    "exit-auto-analyze-tip": true,
    "autoload-default": true,
    "show-variation-graph": true,
    "show-dynamic-komi": false,
    "minimum-blunder-bar-width": 1,
    "confirm-exit": false,
    "show-replace-file-hint": true,
    "norefresh-onmouse-move": true,
    "show-best-moves": true,
    "append-winrate-to-comment": true,
    "limit-playout": false,
    "show-captured": true,
    "replay-branch-interval-seconds": 0.9,
    "weighted-blunder-bar-height": false,
    "first-load-katago": true,
    "show-winrate-graph": true,
    "large-winrate-graph": false,
    "theme": "default",
    "show-winrate-in-suggestion": true,
    "show-scoremean-in-suggestion": true,
    "new-move-number-in-branch": true,
    "blunder-node-colors": [
      [
        155,
        25,
        150
      ],
      [
        208,
        16,
        19
      ],
      [
        200,
        140,
        50
      ],
      [
        180,
        180,
        0
      ],
      [
        140,
        202,
        34
      ],
      [
        0,
        220,
        0
      ],
      [
        0,
        230,
        230
      ]
    ],
    "limit-time": true,
    "show-playouts-in-suggestion": true,
    "blunder-winrate-thresholds": [
      -24,
      -12,
      -6,
      -3,
      -1,
      3,
      100
    ],
    "host-name": "localhost",
    "show-blunder-bar": true,
    "only-last-move-number": 1,
    "show-status": true,
    "handicap-instead-of-winrate": false,
    "large-subboard": false,
    "first-time-load": false,
    "allow-close-comment-control-hint": true,
    "show-katago-score-lead-with-komi": false,
    "show-subboard": true,
    "limit-playouts": 100000,
    "board-size": 19
  }
}
EOF
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz --no-check-certificate
tar -xzf install-tl-unx.tar.gz
rm install-tl-unx.tar.gz
cd install-tl-*
perl install-tl --no-interaction
cd ~
rm -rf install-tl-*
/usr/local/texlive/2025/bin/aarch64-linux/tlmgr update --all --self --reinstall-forcibly-removed
mkdir -p ~/.config/fontconfig/conf.d
cat > ~/.config/fontconfig/conf.d/99-texlive.conf << 'EOF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <dir>/usr/local/texlive/2025/texmf-dist/fonts</dir>
</fontconfig>
EOF
mkdir -p /usr/share/fonts/opentype/xits
cd /usr/share/fonts/opentype/xits
wget https://github.com/aliftype/xits/releases/download/v1.302/XITS-1.302.zip
unzip XITS-1.302.zip
cd XITS-1.302
mv *.otf ..
cd ..
rm -rf XITS-1.302*
mkdir -p /usr/share/fonts/noto-cjk
cd /usr/share/fonts/noto-cjk
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Thin.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-DemiLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Thin.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-DemiLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Thin.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-DemiLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Thin.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-DemiLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Thin.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-DemiLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-ExtraLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-SemiBold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-ExtraLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-SemiBold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-ExtraLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-SemiBold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-ExtraLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-SemiBold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-ExtraLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-SemiBold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKtc-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKtc-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKsc-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKsc-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKhk-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKhk-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKjp-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKjp-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKkr-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKkr-Bold.otf
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
apt install -f -y
apt upgrade -y
apt autoremove --purge -y
apt clean
exit
