#!/data/data/com.termux/files/usr/bin/bash

export PATH="$PREFIX/bin:$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PREFIX/glibc/bin:$HOME/.cargo/bin:/data/data/com.termux/files/usr/lib/node_modules"
export NODE_PATH="/data/data/com.termux/files/usr/lib/node_modules"
export CLASSPATH="$PREFIX/lib/antlr-4.13.2-complete.jar"
export GOROOT="$PREFIX/lib/go"
export GOPATH="$HOME/go"
export TORPATH="$PREFIX/etc/tor"
export PDROOTFS="$PREFIX/var/lib/proot-distro/installed-rootfs"
export EMU="/storage/emulated/0"
export DOW="/storage/emulated/0/Download"
export DOC="/storage/emulated/0/Documents"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
alias antlr4='java -jar $PREFIX/lib/antlr-4.13.2-complete.jar'
alias grun='java org.antlr.v4.runtime.misc.TestRig'
alias src=source
alias deact='deactivate'
pulseaudio --start --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1
pacmd load-module module-sles-sink

gh-latest() {
    curl -s "https://api.github.com/repos/$1/releases/latest" | jq -r ".assets[].browser_download_url | select(test(\"$(printf '%s' "$2" | sed -e 's/\./\\\\./g' -e 's/\*/.*/g')\"))" | xargs curl -L -O
}

gpull() {
    level="${1:-0}"
    if [ "$level" -eq 0 ]; then
        repo_dir=$(git rev-parse --show-toplevel 2>/dev/null)
        if [ -n "$repo_dir" ]; then
            echo "$repo_dir"
            (cd "$repo_dir" && git pull origin)
        else
            echo "Not in a Git repo."
        fi
    else
        depth=$((level + 1))
        find . -mindepth "$depth" -maxdepth "$depth" -type d -name .git | while read -r gitdir; do
            repo_dir=$(dirname "$gitdir")
            echo "$repo_dir"
            (cd "$repo_dir" && git pull origin)
        done
    fi
}

gacp() {
    git add .
    git commit -m "$1"
    git push
}

gtr() {
    git tag -a v"$1" -m "Version $1 release"
    git push origin v"$1"
    gh release create v"$1" --title "Version $1 release" --notes ''
}

torchk() {
    battery_status=$(termux-battery-status)
    is_charging=$(echo "$battery_status" | grep -o '"status": "CHARGING"')
    if [[ $is_charging == *"CHARGING"* ]]; then
        pkill -f "^tor$"
        echo 'CHARGING'
    fi
}

updatevimrc() {
    cd ~/.vim_runtime
    git reset --hard
    git clean -d --force
    git pull --rebase
    python3 update_plugins.py
    cd
}

rand() {
    od -An -N4 -tu4 < /dev/urandom | tr -d ' ' | awk -v min=$1 -v max=$2 '{print int($1 % (max - min)) + min}';
}

mvic() {
    mv "/storage/emulated/0/Download/$1" .
}

cpic() {
    cp "/storage/emulated/0/Download/$1" .
}

cpric() {
    cp -r "/storage/emulated/0/Download/$1" .
}

mvir() {
    mv "/storage/emulated/0/Download/$1" "$2"
}

cpir() {
    cp "/storage/emulated/0/Download/$1" "$2"
}

cprir() {
    cp -r "/storage/emulated/0/Download/$1" "$2"
}

mvaic() {
    mv "/storage/emulated/0/Download/$1" .
    cp -r "$1"/* .
    rm -r "$1"
}

cpaic() {
    cp -r "/storage/emulated/0/Download/$1" .
    cp -r "$1"/* .
    rm -r "$1"
}

mvoc() {
    mv "$1" "/storage/emulated/0/Download"
}

cpoc() {
    cp "$1" "/storage/emulated/0/Download"
}

cproc() {
    cp -r "$1" "/storage/emulated/0/Download"
}

mvip() {
    mv "/storage/emulated/0/Download/$2" "$PREFIX/var/lib/proot-distro/installed-rootfs/$1/root"
}

cpip() {
    cp "/storage/emulated/0/Download/$2" "$PREFIX/var/lib/proot-distro/installed-rootfs/$1/root"
}

cprip() {
    cp -r "/storage/emulated/0/Download/$2" "$PREFIX/var/lib/proot-distro/installed-rootfs/$1/root"
}

mvaip() {
    mv "/storage/emulated/0/Download/$2" "$PREFIX/var/lib/proot-distro/installed-rootfs/$1/root"
    cp -r "$PREFIX/var/lib/proot-distro/installed-rootfs/$1/root/$2/*" "$PREFIX/var/lib/proot-distro/installed-rootfs/$1/root"
    rm -r "$PREFIX/var/lib/proot-distro/installed-rootfs/$1/root/$2"
}

cpaip() {
    cp -r "/storage/emulated/0/Download/$2" "$PREFIX/var/lib/proot-distro/installed-rootfs/$1/root"
    cp -r "$PREFIX/var/lib/proot-distro/installed-rootfs/$1/root/$2/*" "$PREFIX/var/lib/proot-distro/installed-rootfs/$1/root"
    rm -r "$PREFIX/var/lib/proot-distro/installed-rootfs/$1/root/$2"
}

mvop() {
    mv "$PREFIX/var/lib/proot-distro/installed-rootfs/$1/root/$2" "/storage/emulated/0/Download/"
}

cpop() {
    cp "$PREFIX/var/lib/proot-distro/installed-rootfs/$1/root/$2" "/storage/emulated/0/Download/"
}

cprop() {
    cp -r "$PREFIX/var/lib/proot-distro/installed-rootfs/$1/root/$2" "/storage/emulated/0/Download/"
}

mvipd() {
    mvip debian "$1"
}

cpipd() {
    cpip debian "$1"
}

cpripd() {
    cprip debian "$1"
}

mvaipd() {
    mvaip debian "$1"
}

cpaipd() {
    cpaip debian "$1"
}

mvopd() {
    mvop debian "$1"
}

cpopd() {
    cpop debian "$1"
}

cpropd() {
    cprop debian "$1"
}

mvipu() {
    mvip ubuntu "$1"
}

cpipu() {
    cpip ubuntu "$1"
}

cpripu() {
    cprip ubuntu "$1"
}

mvaipu() {
    mvaip ubuntu "$1"
}

cpaipu() {
    cpaip ubuntu "$1"
}

mvopu() {
    mvop ubuntu "$1"
}

cpopu() {
    cpop ubuntu "$1"
}

cpropu() {
    cprop ubuntu "$1"
}

mvipdb() {
    mvip debianbox "$1"
}

cpipdb() {
    cpip debianbox "$1"
}

cpripdb() {
    cprip debianbox "$1"
}

mvaipdb() {
    mvaip debianbox "$1"
}

cpaipdb() {
    cpaip debianbox "$1"
}

mvopdb() {
    mvop debianbox "$1"
}

cpopdb() {
    cpop debianbox "$1"
}

cpropdb() {
    cprop debianbox "$1"
}

rmmva() {
    rm -rf *
    mvaic "$1"
}

rmcpa() {
    rm -rf *
    cpaic "$1"
}

grm() {
    git rm -rf "${1:-*}"
}

grmmva() {
    grm *
    mvaic "$1"
}

grmcpa() {
    grm *
    cpaic "$1"
}

mvagcp() {
    mvaic "$1"
    gacp "$2"
}

cpagcp() {
    cpaic "$1"
    gacp "$2"
}

rmmvagcp() {
    rm -rf *
    mvaic "$1"
    gacp "$2"
}

rmcpagcp() {
    rm -rf *
    cpaic "$1"
    gacp "$2"
}

grmmvagcp() {
    grm *
    mvaic "$1"
    gacp "$2"
}

grmcpagcp() {
    grm *
    cpaic "$1"
    gacp "$2"
}
