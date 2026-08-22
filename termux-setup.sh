#!/data/data/com.termux/files/usr/bin/bash

# GitHub Action termux/termux-docker possible errors to be prevented:
# + tar -xJf file.tar.xz
# tar: Unknown option Jf (see "tar --help")
# and
# + tar -xf -
# tar: chown ...: Operation not permitted
# use
# xz -d file.tar.xz
# gzip -d file.tar.gz
# tar -xf file.tar || true

set -euxo pipefail

## CONFIG START

PKG='alsa-utils aria2 automake bash bc binutils bison broot build-essential bzip2 calcurse clang cmake command-not-found cowsay cronie curl dbus debootstrap dnsutils dpkg dust exiftool fastfetch fd ffmpeg file flex fortune fzf gdb gh ghostscript git git-sizer glab-cli glow gnupg golang gopls gperf grep gzip hyperfine inkscape iproute2 jadx jpegoptim jq lazygit lftp libheif-progs libjxl-progs libxml2 libxslt libwebp lsd luajit lzip make mandoc matplotlib maven mediainfo mesa-vulkan-icd-freedreno mesa-demos mesa-zink mplayer mpv nano netcat-openbsd net-tools ngspice ninja nmap nodejs-lts npm octave opencc-tools openjdk-21 openssh openssl-tool optipng pdftk perl plantuml poppler procs proot proot-distro pulseaudio pv pwgen python python-ensurepip-wheels python-numpy python-pandas python-pip python-scipy python-trash-cli p7zip qalc qemu-user-x86-64 qpdf ripgrep ruby rust scrcpy shellcheck shfmt socat sqlite strace stylua tar termux-am termux-am-socket termux-api termux-auth termux-exec termux-keyring termux-services termux-tools termux-x11-nightly tigervnc tmux tor torsocks tree tsocks unrar uuid-utils uv vim virglrenderer-mesa-zink wget wget2 which w3m xfce4 xmlstarlet xz-utils yazi yq zip zoxide zsh 2048-c'
IMG2PDF=1
GITLFS=1
GITDELTA=1
YTDLP=1
ANDROID=1
VIM=1
NVIM=1
RCLONEEXTRA=1
MOZLZ4=1
PHICE=1
CYBERCHEF=1
STIRLINGPDF=1
NPMGALLOW='http-server prettier'
NPMGIGNORE=''
PIP='pip-autoremove plotly pydub requests selenium==4.9.1 setuptools==81.0.0 sympy'
UV='autopep8 gallery-dl gh2md jupytext meson pylatexenc tldr xmljson yamllint'
APKTOOL=1
EFFLIST=1
TERMUX='termux'
UBUNTU='ubuntu'
UBUNTUINSTALL=1
DEBIAN='debian'
DEBIANINSTALL=0

## CONFIG END

TEST=0
FULL=0
[ "${1:-}" = '--test' ] && TEST=1
[ "${2:-}" = '--test' ] && TEST=1
[ "${1:-}" = '--full' ] && FULL=1
[ "${2:-}" = '--full' ] && FULL=1
if [ "$FULL" -eq 1 ]; then
  UBUNTUINSTALL=0
fi
if [ "$TEST" -eq 1 ] || [ "$FULL" -eq 1 ]; then
  echo 'export ANDROID_API_LEVEL=24' >~/.bashrc.overrides
fi
echo_ubuntu_debian() {
  if [ "$1" -eq 0 ]; then
    echo './ubuntu-debian.sh'
  else
    echo './ubuntu-debian.sh --test'
  fi
}
# shellcheck disable=2046,2155
PREDF=$(df $(dirname "$PREFIX") | tail -n1 | awk '{print $3}')
cd ~ || exit
pkg update
DEBIAN_FRONTEND=noninteractive pkg install x11-repo tur-repo -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
DEBIAN_FRONTEND=noninteractive pkg upgrade -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
DEBIAN_FRONTEND=noninteractive pkg install coreutils curl file git gzip jq perl proot proot-distro pulseaudio tar termux-api termux-tools wget which xz-utils zip -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
XPKG='mesa-vulkan-icd-freedreno mesa-demos mesa-zink termux-x11-nightly virglrenderer-mesa-zink xfce4'
# shellcheck disable=2086
if [ "$TEST" -eq 0 ]; then
  DEBIAN_FRONTEND=noninteractive pkg install $XPKG -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
else
  DEBIAN_FRONTEND=noninteractive pkg install $XPKG -y -s -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
fi
TERMUX=$(echo "$TERMUX" | tr ' ' '_')
UBUNTU=$(echo "$UBUNTU" | tr ' ' '_')
DEBIAN=$(echo "$DEBIAN" | tr ' ' '_')
[ -n "$TERMUX" ] && [ "$TERMUX" == "$UBUNTU" ] && UBUNTU="${UBUNTU}1"
[ -n "$TERMUX" ] && [ "$TERMUX" == "$DEBIAN" ] && DEBIAN="${DEBIAN}1"
[ -n "$UBUNTU" ] && [ "$UBUNTU" == "$DEBIAN" ] && DEBIAN="${DEBIAN}1"
ARCH=$(uname -m)
if [[ "$ARCH" != "aarch64" && "$ARCH" != "arm64" ]]; then
  UBUNTUINSTALL=0
  DEBIANINSTALL=0
fi
mkdir -p ~/.termux
cd ~/.termux || exit
rm termux.properties || true
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/termux/termux-tools/refs/heads/master/termux.properties
cd ~ || exit
sed '/allow-external-apps/s/^# //' -i ~/.termux/termux.properties
sed '/shortcut.create-session/s/^# //' -i ~/.termux/termux.properties
sed '/shortcut.next-session/s/^# //' -i ~/.termux/termux.properties
sed '/shortcut.previous-session/s/^# //' -i ~/.termux/termux.properties
sed 's/^# extra-keys-text-all-caps = true/extra-keys-text-all-caps = false/' -i ~/.termux/termux.properties
termux-reload-settings || true
sed '/^extra-keys = /{N;d;}' -i ~/.termux/termux.properties
perl -0777 -pe 's/(###############\n# Extra keys\n###############\n)/$1\nextra-keys = \[ \[ \{ key: ESC, popup: \{ macro: "CTRL t", display: "CTRL t" \} \}, \{ key: "\`", popup: \{ macro: "CTRL 1", display: "CTRL 1" \} \}, \{ key: "\`\`\`", popup: \{ macro: "CTRL 2", display: "CTRL 2" \} \}, \{ key: ":%s\/\\\\\\\\v", popup: \{ macro: "CTRL r", display: "CTRL r" \} \}, \{ key: ":%s\/", popup: ":wq\\n" \}, \{ key: "d^", popup: "d\\\$" \}, \{ key: "y^", popup: "y\\\$" \}, \{ key: "yG", popup: "dG" \} \], \[ \{ key: DRAWER, popup: "\\\!" \}, \{ key: KEYBOARD, popup: "–" \}, \{ key: "\/", popup: "±" \}, \{ key: DEL, popup: BKSP \}, \{ key: HOME, popup: ENTER \}, \{ key: UP, popup: \{ macro: "CTRL UP", display: "Up" \} \}, \{ key: END, popup: "gg=G" \}, \{ key: PGUP, popup: "\\\\\\\"_dP" \} \], \[ \{ key: TAB, popup: \{ macro: "CTRL d", display: "CTRL d" \} \}, \{ key: "~", popup: \{ macro: "CTRL \\\\\\\\", display: "CTRL \\\\\\\\" \} \}, \{ key: CTRL, popup: \{ macro: "CTRL c", display: "CTRL c" \} \}, \{ key: ALT, popup: \{ macro: "CTRL z", display: "CTRL z" \} \}, \{ key: LEFT, popup: \{ macro: "CTRL LEFT", display: "Left" \} \}, \{ key: DOWN, popup: \{ macro: "CTRL DOWN", display: "Down" \} \}, \{ key: RIGHT, popup: \{ macro: "CTRL RIGHT", display: "Right" \} \}, \{ key: PGDN, popup: "EOF\\n" \} \] \]\n/s' ~/.termux/termux.properties >~/tmp
mv ~/tmp ~/.termux/termux.properties
termux-reload-settings || true
mkdir -p ~/.shortcuts
cp ~/termux-sh/DOTshortcuts/* ~/.shortcuts
cp ~/termux-sh/DOTshortcuts/documents.sh ~
cp ~/termux-sh/DOTshortcuts/download.sh ~
cp ~/termux-sh/DOTshortcuts/scripts.sh ~
cp ~/termux-sh/DOTshortcuts/storage.sh ~
cp ~/termux-sh/DOTshortcuts/proot-*.sh ~
mkdir ~/shared
tee "$PREFIX"/etc/resolv.conf >/dev/null <<'EOF'
nameserver 1.1.1.1
nameserver 1.0.0.1
nameserver 2606:4700:4700::1111
nameserver 2606:4700:4700::1001
nameserver 94.140.14.140
nameserver 94.140.14.141
nameserver 2a10:50c0::1:ff
nameserver 2a10:50c0::2:ff
EOF
rm -rf ~/.bashrc ~/.bashrc.d
git clone --depth=1 https://github.com/Willie169/bashrc ~/.bashrc.d
ln -sf "$HOME/.bashrc.d/bashrc.d/bashrc" "$HOME/.bashrc"
source ~/.bashrc
mkdir ~/.JetBrainsMono
cd ~/.JetBrainsMono || exit
wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
unzip JetBrainsMono.zip
mv JetBrainsMonoNerdFontMono-Regular.ttf ~/.termux/font.ttf
cd ~ || exit
rm -rf .JetBrainsMono
termux-reload-settings || true
mkdir -p "$PREFIX"/local/bin
mkdir -p "$PREFIX"/local/go
mkdir -p "$PREFIX"/local/java
mkdir -p ~/.local/bin
if [ -n "$PKG" ]; then
  # shellcheck disable=2086
  if [ "$TEST" -eq 0 ]; then
    DEBIAN_FRONTEND=noninteractive pkg install $PKG -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
  else
    DEBIAN_FRONTEND=noninteractive pkg install $PKG -y -s -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
  fi
fi
command -v broot >/dev/null 2>&1 && broot --set-install-state installed && mkdir -p "$HOME/.config/broot/launcher/bash" && broot --print-shell-function bash >"$HOME/.config/broot/launcher/bash/br" && chmod +x "$HOME/.config/broot/launcher/bash/br"
[ -f "$PREFIX"/etc/ssh/sshd_config ] && sed -Ei 's/^#?Port.*/Port 8022/' "$PREFIX"/etc/ssh/sshd_config
mkdir -p ~/.ssh
cat >~/.ssh/config <<'EOF'
Host *
    ServerAliveInterval 15
    ServerAliveCountMax 8
EOF
if [ "$IMG2PDF" -ne 0 ]; then
  DEBIAN_FRONTEND=noninteractive pkg install clang cmake libxml2 libxslt ninja python python-ensurepip-wheels python-pip qpdf uv -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
  if ! uv tool install img2pdf; then
    uv tool install img2pdf
  fi
fi
if [ "$GITLFS" -ne 0 ]; then
  DEBIAN_FRONTEND=noninteractive pkg install git-lfs -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
  git lfs install
fi
if [ "$GITDELTA" -ne 0 ]; then
  DEBIAN_FRONTEND=noninteractive pkg install git-delta -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
  git config --global core.pager delta
  git config --global interactive.diffFilter 'delta --color-only'
  git config --global delta.navigate true
  git config --global merge.conflictStyle zdiff3
fi
if [ "$YTDLP" -ne 0 ]; then
  DEBIAN_FRONTEND=noninteractive pkg install deno -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
  gh_release -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' yt-dlp/yt-dlp yt-dlp
  chmod +x yt-dlp
  mv yt-dlp ~/.local/bin/
fi
if [ "$ANDROID" -ne 0 ]; then
  wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/termux-android-sdk-ndk/refs/heads/main/install.sh
  chmod +x install.sh
  if [ "$TEST" -eq 1 ] || [ "$FULL" -eq 1 ]; then
    sed -Ei 's/(#!\/data\/data\/com\.termux\/files\/usr\/bin\/bash)/\1\nset -euxo pipefail/' install.sh
  fi
  PROFILE=/dev/null ./install.sh "platform-tools"
  rm install.sh
fi
if [ "$RCLONEEXTRA" -ne 0 ]; then
  gh_release -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' gulp79/rclone-extra rclone-android-all.zip
  unzip rclone-android-all.zip
  rm rclone-android-all.zip*
  if [[ "$ARCH" == "x86_64" ]]; then
    rm rclone-android-386
    mv rclone-android-amd64 rclone
    rm rclone-android-arm
    rm rclone-android-arm64
  elif [[ "$ARCH" =~ ^i[3-6]86$ ]]; then
    mv rclone-android-386 rclone
    rm rclone-android-amd64
    rm rclone-android-arm
    rm rclone-android-arm64
  elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
    rm rclone-android-386
    rm rclone-android-amd64
    rm rclone-android-arm
    mv rclone-android-arm64 rclone
  elif [[ "$ARCH" == arm* ]]; then
    rm rclone-android-386
    rm rclone-android-amd64
    mv rclone-android-arm rclone
    rm rclone-android-arm64
  else
    rm rclone-android-386
    rm rclone-android-amd64
    rm rclone-android-arm
    mv rm rclone-android-arm64 rclone
  fi
  mv rclone ~/.local/bin/
fi
if [ "$MOZLZ4" -ne 0 ]; then
  DEBIAN_FRONTEND=noninteractive pkg install rust -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
  git clone https://github.com/jusw85/mozlz4.git
  cd mozlz4 || exit
  cargo build --release
  cd target/release || exit
  mv mozlz4-bin mozlz4
  mv mozlz4 ~/.local/bin/
  cd ~ || exit
  rm -rf mozlz4
fi
if [ "$PHICE" -ne 0 ]; then
  DEBIAN_FRONTEND=noninteractive pkg install libxml2 libxslt python python-ensurepip-wheels python-pip rust uv -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
  git clone --depth=1 https://github.com/Willie169/phice.git
  cd phice || exit
  if ! uv sync; then
    uv sync
  fi
  cp config.example.toml config.toml
  cd ~ || exit
fi
if [ "$CYBERCHEF" -ne 0 ]; then
  proot-distro install ghcr.io/gchq/cyberchef:latest
  sed -Ei "s/(listen[ \t ]+)[0-9]*;/\18081;/" "$PREFIX"/var/lib/proot-distro/containers/cyberchef/rootfs/etc/nginx/conf.d/default.conf
fi
if [ "$STIRLINGPDF" -ne 0 ]; then
  proot-distro install stirlingtools/stirling-pdf:latest
  mkdir -p "$PREFIX"/var/lib/proot-distro/containers/stirling-pdf/rootfs/usr/share/tessdata
  cd "$PREFIX"/var/lib/proot-distro/containers/stirling-pdf/rootfs/usr/share/tessdata || exit
  rm chi_sim.traineddata || true
  wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/tesseract-ocr/tessdata/raw/refs/heads/main/chi_sim.traineddata
  rm chi_sim_vert.traineddata || true
  wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/tesseract-ocr/tessdata/raw/refs/heads/main/chi_sim_vert.traineddata
  rm chi_tra.traineddata || true
  wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/tesseract-ocr/tessdata/raw/refs/heads/main/chi_tra.traineddata
  rm chi_tra_vert.traineddata || true
  wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/tesseract-ocr/tessdata/raw/refs/heads/main/chi_tra_vert.traineddata
  rm eng.traineddata || true
  wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/tesseract-ocr/tessdata/raw/refs/heads/main/eng.traineddata
  cd ~ || exit
  echo -e 'server:\n  port: 9000' | tee "$PREFIX"/var/lib/proot-distro/containers/stirling-pdf/rootfs/configs/custom_settings.yml >/dev/null
fi
if [ "$VIM" -ne 0 ]; then
  DEBIAN_FRONTEND=noninteractive pkg install vim -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
  curl -fsSL https://raw.githubusercontent.com/Willie169/vim-config/refs/heads/main/install.sh | sh
fi
if [ "$NVIM" -ne 0 ]; then
  DEBIAN_FRONTEND=noninteractive pkg install libxml2 libxslt nodejs-lts npm python python-ensurepip-wheels python-pip rust uv -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
  curl -fsSL https://raw.githubusercontent.com/Willie169/nvim-config/refs/heads/main/full-install.sh | bash
  nvim --headless "+Lazy! install" +qa
fi
if [ -n "$NPMGALLOW" ] || [ -n "$NPMGIGNORE" ]; then
  DEBIAN_FRONTEND=noninteractive pkg install nodejs-lts npm -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
fi
if [ -n "$NPMGALLOW" ]; then
  # shellcheck disable=2086
  if [ "$TEST" -eq 0 ]; then
    npmig $NPMGALLOW
  else
    npmig -o --dry-run $NPMGALLOW
  fi
fi
if [ -n "$NPMGIGNORE" ]; then
  # shellcheck disable=2086
  if [ "$TEST" -eq 0 ]; then
    npm i -g --ignore-scripts $NPMGIGNORE
  else
    npm i -g --ignore-scripts --dry-run $NPMGIGNORE
  fi
fi
if [ -n "$PIP" ]; then
  DEBIAN_FRONTEND=noninteractive pkg install python python-ensurepip-wheels python-pip -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
  # shellcheck disable=2086
  if ! pip3 install $PIP; then
    pip3 install $PIP
  fi
fi
if [ -n "$UV" ]; then
  DEBIAN_FRONTEND=noninteractive pkg install libxml2 libxslt python python-ensurepip-wheels python-pip uv -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
  # shellcheck disable=2086
  for pkg in $UV; do
    if ! uv tool install "$pkg"; then
      uv tool install "$pkg"
    fi
  done
fi
if [ "$APKTOOL" -ne 0 ]; then
  wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
  chmod +x apktool
  mv apktool "$PREFIX"/local/bin/
  gh_release -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' iBotPeaches/Apktool 'apktool_*.jar'
  chmod +x apktool_*.jar
  mv apktool_*.jar "$PREFIX"/local/bin/
fi
[ "$EFFLIST" -eq 0 ] || wget --tries=100 --retry-connrefused --waitretry=5 https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt -O ~/.eff_large_wordlist.txt
[ -n "$TERMUX" ] && proot-distro install termux/termux-docker --name "$TERMUX"
[ -n "$UBUNTU" ] && proot-distro install ubuntu:latest --name "$UBUNTU"
[ -n "$UBUNTU" ] && [ "$UBUNTUINSTALL" -ne 0 ] && cp ~/termux-sh/ubuntu-debian.sh "${PREFIX}/var/lib/proot-distro/containers/$UBUNTU/rootfs/root/" && echo_ubuntu_debian "$TEST" | bash <(proot-distro login "$UBUNTU" --redirect-ports --isolated --get-proot-cmd)
[ -n "$DEBIAN" ] && proot-distro install debian:latest --name "$DEBIAN"
[ -n "$DEBIAN" ] && [ "$DEBIANINSTALL" -ne 0 ] && cp ~/termux-sh/ubuntu-debian.sh "${PREFIX}/var/lib/proot-distro/containers/$DEBIAN/rootfs/root/" && echo_ubuntu_debian "$TEST" | bash <(proot-distro login "$DEBIAN" --redirect-ports --isolated --get-proot-cmd)
echo $'#!/data/data/com.termux/files/usr/bin/bash\n' >~/.bashrc.proot
[ -n "$TERMUX" ] && echo -e "export PROOT_TERMUX=\"$TERMUX\"\nexport PROOT_TERMUX_ROOT=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$TERMUX/rootfs/data/data/com.termux/files\"\nexport PROOT_TERMUX_HOME=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$TERMUX/rootfs/data/data/com.termux/files/home\"\nexport PROOT_TERMUX_PREFIX=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$TERMUX/rootfs/data/data/com.termux/files/usr\"" >>~/.bashrc.proot
[ -n "$UBUNTU" ] && echo -e "export PROOT_UBUNTU=\"$UBUNTU\"\nexport PROOT_UBUNTU_ROOT=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$UBUNTU/rootfs/root\"" >>~/.bashrc.proot
[ -n "$DEBIAN" ] && echo -e "export PROOT_DEBIAN=\"$DEBIAN\"\nexport PROOT_DEBIAN_ROOT=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$DEBIAN/rootfs/root\"" >>~/.bashrc.proot
DEBIAN_FRONTEND=noninteractive apt install -f -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
DEBIAN_FRONTEND=noninteractive apt upgrade -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
DEBIAN_FRONTEND=noninteractive apt autoremove --purge -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
apt clean
# shellcheck disable=2046,2155
POSTDF=$(df $(dirname "$PREFIX") | tail -n1 | awk '{print $3}')
echo "PREDF: $PREDF"
echo "POSTDF: $POSTDF"
exit
