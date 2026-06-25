#!/data/data/com.termux/files/usr/bin/bash

## CONFIG START

PKG='alsa-utils aria2 automake bash bc bison broot build-essential bzip2 calcurse clang cmake command-not-found cronie curl dbus debootstrap dnsutils dpkg dust fastfetch fd ffmpeg file flex fzf gdb gh ghostscript git git-delta glab-cli glow gnupg golang gopls gperf grep gzip hyperfine inkscape iproute2 jadx jpegoptim jq lazygit lftp libheif-progs libwebp lsd lzip make mandoc matplotlib maven mesa-vulkan-icd-freedreno mesa-demos mesa-zink mpv nano neovim netcat-openbsd net-tools ngspice ninja nmap nodejs-lts npm octave openjdk-21 openssh openssl-tool optipng pdftk perl poppler procs proot proot-distro pulseaudio pv pwgen python python-ensurepip-wheels python-numpy python-pip python-scipy python-yt-dlp p7zip qpdf ruby rust scrcpy shellcheck shfmt socat sqlite tar termux-am termux-am-socket termux-api termux-auth termux-exec termux-keyring termux-services termux-tools termux-x11-nightly tmux tor torsocks tree tree-sitter tsocks unrar uuid-utils uv vim virglrenderer-mesa-zink wget wget2 which w3m xmlstarlet yazi yq yt-dlp-ejs zip zoxide zsh'
GITDELTA=1
YTDLP=1
XFCE=1
ANDROID=1
VIMRC=1
RCLONEEXTRA=1
PHICE=1
CYBERCHEF=1
STIRLINGPDF=1
NPMG='bash-language-server dockerfile-language-server-nodejs http-server pyright @linthtml/linthtml'
PIP='pandas pipx pip-autoremove plotly pydub requests selenium==4.9.1 setuptools sympy'
PIPX='cmake-language-server gallery-dl gh2md meson pylatexenc tldr yamllint'
GO=''
APKTOOL=1
ANTLR=1
PLANTUML=1
EFFLIST=1
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

# shellcheck disable=2046,2155
PREDF=$(df $(dirname "$PREFIX") | tail -n1 | awk '{print $3}')
cd ~ || exit
pkg update || true
pkg upgrade -y || true
pkg install coreutils curl git gzip nodejs-lts npm perl proot proot-distro python python-ensurepip-wheels tar termux-api wget which zip xz-utils x11-repo tur-repo -y || true
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
ARCH=$(uname -m)
if [[ "$ARCH" != "aarch64" && "$ARCH" != "arm64" ]]; then
UBUNTUINSTALL=0
DEBIANINSTALL=0
UBUNTUBOXINSTALL=0
DEBIANBOXINSTALL=0
fi
mkdir -p ~/.termux
cd ~/.termux || exit
rm termux.properties || true
wget https://raw.githubusercontent.com/termux/termux-tools/refs/heads/master/termux.properties
cd ~ || exit
sed '/allow-external-apps/s/^# //' -i ~/.termux/termux.properties
sed '/shortcut.create-session/s/^# //' -i ~/.termux/termux.properties
sed '/shortcut.next-session/s/^# //' -i ~/.termux/termux.properties
sed '/shortcut.previous-session/s/^# //' -i ~/.termux/termux.properties
sed 's/^# extra-keys-text-all-caps = true/extra-keys-text-all-caps = false/' -i ~/.termux/termux.properties
termux-reload-settings || true
sed '/^extra-keys = /{N;d;}' -i ~/.termux/termux.properties
perl -0777 -pe 's/(###############\n# Extra keys\n###############\n)/$1\nextra-keys = \[ \[ \{ key: ESC, popup: \{ macro: "ALT s", display: "ALT s" \} \}, \{ key: "\`", popup: "\`\`\`" \}, \{ key: "Z", popup: ":wq\\n" \}, \{ key: "Zp", popup: ":q\\n" \}, \{ key: ":%s\/", popup: \{ macro: "CTRL t", display: "CTRL t" \} \}, \{ key: "d\\\$", popup: \{ macro: "CTRL 1", display: "CTRL 1" \} \}, \{ key: "y\\\$", popup: \{ macro: "CTRL 2", display: "CTRL 2" \} \}, \{ key: "yG", popup: \{ macro: "CTRL r", display: "CTRL r" \} \} \], \[ \{ key: DRAWER, popup: \{ macro: "ALT h", display: "ALT h" \} \}, \{ key: KEYBOARD, popup: "–" \}, \{ key: "\/", popup: \{ macro: "CTRL d", display: "CTRL d" \} \}, \{ key: DEL, popup: BKSP \}, \{ key: HOME, popup: "clear" \}, \{ key: UP, popup: \{ macro: "CTRL UP", display: "Up" \} \}, \{ key: END, popup: ENTER \}, \{ key: PGUP, popup: "±" \} \], \[ \{ key: TAB, popup: \{ macro: "ALT b", display: "ALT b" \} \}, \{ key: "~", popup: \{ macro: "CTRL \\\\\\\\", display: "CTRL \\\\\\\\" \} \}, \{ key: CTRL, popup: \{ macro: "CTRL c", display: "CTRL c" \} \}, \{ key: ALT, popup: \{ macro: "CTRL z", display: "CTRL z" \} \}, \{ key: LEFT, popup: \{ macro: "CTRL LEFT", display: "Left" \} \}, \{ key: DOWN, popup: \{ macro: "CTRL DOWN", display: "Down" \} \}, \{ key: RIGHT, popup: \{ macro: "CTRL RIGHT", display: "Right" \} \}, \{ key: PGDN, popup: "EOF" \} \] \]\n/s' ~/.termux/termux.properties > ~/tmp
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
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/bashrc -O ~/.bashrc
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
termux-reload-settings || true
mkdir -p "$PREFIX"/local/bin
mkdir -p "$PREFIX"/local/go
mkdir -p "$PREFIX"/local/java
mkdir -p ~/.local/bin
# shellcheck disable=2086
[ -n "$PKG" ] && pkg install $PKG -y || true
[ -f "$PREFIX"/etc/ssh/sshd_config ] && sed -Ei 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/; s/^#?Port.*/Port 8022/' "$PREFIX"/etc/ssh/sshd_config
mkdir -p ~/.ssh
cat > ~/.ssh/config <<'EOF'
Host *
    ServerAliveInterval 15
    ServerAliveCountMax 8
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
pkg install git-delta -y || true
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global merge.conflictStyle zdiff3
fi
if [ "$YTDLP" -ne 0 ]; then
npm i -g deno
gh_latest -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' yt-dlp/yt-dlp yt-dlp
chmod +x yt-dlp
mv yt-dlp ~/.local/bin/
fi
[ "$XFCE" -eq 0 ] || pkg install xfce4 -y || true
if [ "$ANDROID" -ne 0 ]; then
wget --tries=100 --retry-connrefused --waitretry=5 https://github.com/Willie169/termux-android-sdk-ndk/blob/main/install.sh
PROFILE=/dev/null ./install.sh "platform-tools"
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
if [ "$RCLONEEXTRA" -ne 0 ]; then
gh_latest -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' gulp79/rclone-extra rclone-android-all.zip
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
if [ "$PHICE" -ne 0 ]; then
pkg install uv -y || true
git clone --depth=1 https://codeberg.org/c4ffe14e/phice.git
cd phice || exit
uv sync
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
# shellcheck disable=2086
[ -n "$NPMG" ] && npm i -g $NPMG
if [ -n "$PIP" ]; then
# shellcheck disable=2086
pip3 install $PIP || true
# shellcheck disable=2086
pip3 install $PIP || true
fi
if [ -n "$PIPX" ]; then
pip3 install pipx
# shellcheck disable=2086
pipx install $PIPX
fi
# shellcheck disable=2086
[ -n "$GO" ] && go install $GO
if [ "$APKTOOL" -ne 0 ]; then
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
chmod +x apktool
mv apktool "$PREFIX"/local/bin/
gh_latest -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' iBotPeaches/Apktool 'apktool_*.jar'
chmod +x apktool_*.jar
mv apktool_*.jar "$PREFIX"/local/bin/
fi
[ "$ANTLR" -eq 0 ] || wget --tries=100 --retry-connrefused --waitretry=5 -O "$PREFIX"/local/java/antlr-4.13.2-complete.jar https://www.antlr.org/download/antlr-4.13.2-complete.jar
[ "$PLANTUML" -eq 0 ] || wget --tries=100 --retry-connrefused --waitretry=5 -O "$PREFIX"/local/java/plantuml.jar https://sourceforge.net/projects/plantuml/files/plantuml.jar/download
[ "$EFFLIST" -eq 0 ] || wget --tries=100 --retry-connrefused --waitretry=5 https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt -O ~/.eff_large_wordlist.txt
[ -n "$TERMUX" ] && proot-distro install termux/termux-docker --name "$TERMUX"
[ -n "$UBUNTU" ] && proot-distro install ubuntu:latest --name "$UBUNTU"
[ -n "$UBUNTU" ] && [ "$UBUNTUINSTALL" -ne 0 ] && cp ~/termux-sh/ubuntu-debian.sh "$PRF/$UBUNTU/rootfs/root/" && echo './ubuntu-debian.sh' | bash <(proot-distro login "$UBUNTU" --redirect-ports --shared-tmp --isolated --get-proot-cmd)
[ -n "$DEBIAN" ] && proot-distro install debian:latest --name "$DEBIAN"
[ -n "$DEBIAN" ] && [ "$DEBIANINSTALL" -ne 0 ] && cp ~/termux-sh/ubuntu-debian.sh "$PRF/$DEBIAN/rootfs/root/" && echo './ubuntu-debian.sh' | bash <(proot-distro login "$DEBIAN" --redirect-ports --shared-tmp --isolated --get-proot-cmd)
[ -n "$UBUNTUBOX" ] && proot-distro install ubuntu:latest --name "$UBUNTUBOX"
[ -n "$UBUNTUBOX" ] && [ "$UBUNTUBOXINSTALL" -ne 0 ] && cp ~/termux-sh/box64-wine64-winetricks.sh "$PRF/$UBUNTUBOX/rootfs/root/" && echo './box64-wine64-winetricks.sh' | bash <(proot-distro login "$UBUNTUBOX" --redirect-ports --shared-tmp --isolated --get-proot-cmd)
[ -n "$DEBIANBOX" ] && proot-distro install debian:latest --name "$DEBIANBOX"
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOXINSTALL" -ne 0 ] && cp ~/termux-sh/box64-wine64-winetricks.sh "$PRF/$DEBIANBOX/rootfs/root/" && echo './box64-wine64-winetricks.sh' | bash <(proot-distro login "$DEBIANBOX" --redirect-ports --shared-tmp --isolated --get-proot-cmd)
rm -f ~/.bashrc.d/11-proot.sh
cat > ~/.bashrc.d/11-proot.sh <<EOF
#!/data/data/com.termux/files/usr/bin/bash

EOF
[ -n "$TERMUX" ] && echo -e "export TERMUX=$TERMUX\nexport TERMUX_HOME=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$TERMUX/rootfs/data/data/com.termux/files/home\"" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
[ -n "$UBUNTU"  ] && echo -e "export UBUNTU=$UBUNTU\nexport UBUNTU_ROOT=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$UBUNTU/rootfs/root\"" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
[ -n "$DEBIAN"  ] && echo -e "export DEBIAN=$DEBIAN\nexport DEBIAN_ROOT=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$DEBIAN/rootfs/root\"" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
[ -n "$UBUNTUBOX"  ] && echo -e "export UBUNTUBOX=$UBUNTUBOX\nexport UBUNTUBOX_ROOT=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$UBUNTUBOX/rootfs/root\"" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
[ -n "$DEBIANBOX"  ] && echo -e "export DEBIANBOX=$DEBIANBOX\nexport DEBIANBOX_ROOT=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$DEBIANBOX/rootfs/root\"" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
rm -rf ~/termux-sh
# shellcheck disable=2046,2155
POSTDF=$(df $(dirname "$PREFIX") | tail -n1 | awk '{print $3}')
echo "PREDF: $PREDF"
echo "POSTDF: $POSTDF"
exit
