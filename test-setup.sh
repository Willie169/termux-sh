#!/data/data/com.termux/files/usr/bin/bash
set -euxo pipefail
shopt -s expand_aliases

## CONFIG START

MOZLZ4=1
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
pkg update
DEBIAN_FRONTEND=noninteractive pkg install x11-repo tur-repo -y -o Dpkg::Options::="--force-confnew"
DEBIAN_FRONTEND=noninteractive pkg upgrade -y -o Dpkg::Options::="--force-confnew"
DEBIAN_FRONTEND=noninteractive pkg install coreutils curl file git gzip jq nodejs-lts npm perl proot proot-distro python python-ensurepip-wheels python-pip tar termux-api termux-tools wget which zip xz-utils -y -o Dpkg::Options::="--force-confnew"
DEBIAN_FRONTEND=noninteractive pkg install pulseaudio -y -o Dpkg::Options::="--force-confnew"
DEBIAN_FRONTEND=noninteractive pkg install mesa-vulkan-icd-freedreno mesa-demos mesa-zink termux-x11-nightly virglrenderer-mesa-zink xfce4 -y -o Dpkg::Options::="--force-confnew"
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
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/termux/termux-tools/refs/heads/master/termux.properties
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
mkdir ~/.bashrc.d
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/00-env.sh -O ~/.bashrc.d/00-env.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/10-exports.sh -O ~/.bashrc.d/10-exports.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/15-color.sh -O ~/.bashrc.d/15-color.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/20-aliases.sh -O ~/.bashrc.d/20-aliases.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/21-cxx.sh -O ~/.bashrc.d/21-cxx.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/22-java.sh -O ~/.bashrc.d/22-java.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/23-vnc.sh -O ~/.bashrc.d/23-vnc.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/50-functions.sh -O ~/.bashrc.d/50-functions.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/51-extra-functions.sh -O ~/.bashrc.d/51-extra-functions.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/60-completion.sh -O ~/.bashrc.d/60-completion.sh
wget --tries=100 --retry-connrefused --waitretry=5 https://raw.githubusercontent.com/Willie169/bashrc/main/termux/bashrc.d/bashrc -O ~/.bashrc
if [ -d "$HOME/.bashrc.d" ];  then
  for f in "$HOME/.bashrc.d/"*; do
    [ -r "$f" ] && . "$f"
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
[ -f "$PREFIX"/etc/ssh/sshd_config ] && sed -Ei 's/^#?Port.*/Port 8022/' "$PREFIX"/etc/ssh/sshd_config
mkdir -p ~/.ssh
cat > ~/.ssh/config <<'EOF'
Host *
    ServerAliveInterval 15
    ServerAliveCountMax 8
EOF
if [ "$MOZLZ4" -ne 0 ]; then
git clone https://github.com/jusw85/mozlz4.git
cd mozlz4 || true
cargo build --release
cd target/release || true
mv mozlz4-bin mozlz4
mv mozlz4 ~/.local/bin/
cd ~ || true
rm -rf mozlz4
fi
[ -n "$TERMUX" ] && proot-distro install termux/termux-docker --name "$TERMUX"
[ -n "$UBUNTU" ] && proot-distro install ubuntu:latest --name "$UBUNTU"
[ -n "$UBUNTU" ] && [ "$UBUNTUINSTALL" -ne 0 ] && cp ~/termux-sh/test.sh "$PRF/$UBUNTU/rootfs/root/" && echo './test.sh' | bash <(proot-distro login "$UBUNTU" --redirect-ports --shared-tmp --isolated --get-proot-cmd)
[ -n "$DEBIAN" ] && proot-distro install debian:latest --name "$DEBIAN"
[ -n "$DEBIAN" ] && [ "$DEBIANINSTALL" -ne 0 ] && cp ~/termux-sh/test.sh "$PRF/$DEBIAN/rootfs/root/" && echo './test.sh' | bash <(proot-distro login "$DEBIAN" --redirect-ports --shared-tmp --isolated --get-proot-cmd)
[ -n "$UBUNTUBOX" ] && proot-distro install ubuntu:latest --name "$UBUNTUBOX"
[ -n "$UBUNTUBOX" ] && [ "$UBUNTUBOXINSTALL" -ne 0 ] && cp ~/termux-sh/box64-wine64-winetricks.sh "$PRF/$UBUNTUBOX/rootfs/root/" && echo './box64-wine64-winetricks.sh' | bash <(proot-distro login "$UBUNTUBOX" --redirect-ports --shared-tmp --isolated --get-proot-cmd)
[ -n "$DEBIANBOX" ] && proot-distro install debian:latest --name "$DEBIANBOX"
[ -n "$DEBIANBOX" ] && [ "$DEBIANBOXINSTALL" -ne 0 ] && cp ~/termux-sh/box64-wine64-winetricks.sh "$PRF/$DEBIANBOX/rootfs/root/" && echo './box64-wine64-winetricks.sh' | bash <(proot-distro login "$DEBIANBOX" --redirect-ports --shared-tmp --isolated --get-proot-cmd)
rm -f ~/.bashrc.d/11-proot.sh
cat > ~/.bashrc.d/11-proot.sh <<EOF
#!/data/data/com.termux/files/usr/bin/bash

EOF
[ -n "$TERMUX" ] && echo -e "export TERMUX=$TERMUX\nexport TERMUX_HOME=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$TERMUX/rootfs/data/data/com.termux/files/home\"" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
[ -n "$UBUNTU" ] && echo -e "export UBUNTU=$UBUNTU\nexport UBUNTU_ROOT=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$UBUNTU/rootfs/root\"" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
[ -n "$DEBIAN" ] && echo -e "export DEBIAN=$DEBIAN\nexport DEBIAN_ROOT=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$DEBIAN/rootfs/root\"" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
[ -n "$UBUNTUBOX" ] && echo -e "export UBUNTUBOX=$UBUNTUBOX\nexport UBUNTUBOX_ROOT=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$UBUNTUBOX/rootfs/root\"" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
[ -n "$DEBIANBOX" ] && echo -e "export DEBIANBOX=$DEBIANBOX\nexport DEBIANBOX_ROOT=\"/data/data/com.termux/files/usr/var/lib/proot-distro/containers/\$DEBIANBOX/rootfs/root\"" | tee -a ~/.bashrc.d/11-proot.sh >/dev/null
DEBIAN_FRONTEND=noninteractive apt install -f -y -o Dpkg::Options::="--force-confnew"
DEBIAN_FRONTEND=noninteractive apt upgrade -y -o Dpkg::Options::="--force-confnew"
DEBIAN_FRONTEND=noninteractive apt autoremove --purge -y -o Dpkg::Options::="--force-confnew"
apt clean
# shellcheck disable=2046,2155
POSTDF=$(df $(dirname "$PREFIX") | tail -n1 | awk '{print $3}')
echo "PREDF: $PREDF"
echo "POSTDF: $POSTDF"
exit
