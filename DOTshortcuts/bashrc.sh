#!/data/data/com.termux/files/usr/bin/bash

export PATH="$PREFIX/bin:$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PREFIX/glibc/bin:$HOME/.cargo/bin:/data/data/com.termux/files/usr/lib/node_modules"
export CLASSPATH="$PREFIX/lib/antlr-4.13.2-complete.jar"
export GOROOT="$PREFIX/lib/go"
export GOPATH="$HOME/go"
export TORPATH="$PREFIX/etc/tor"
export PDROOTFS="$PREFIX/var/lib/proot-distro/installed-rootfs"
alias antlr4='java -jar $PREFIX/lib/antlr-4.13.2-complete.jar'
alias grun='java org.antlr.v4.runtime.misc.TestRig'
alias src=source

gitPull() {
    for dir in */ ; do
        if [ -d "$dir/.git" ]; then
            cd "$dir" || continue
            git pull
            cd ..
        fi
    done
}

gacp() {
    git add .
    git commit -m "$1"
    git push origin "$2"
}

torchk() {
    battery_status=$(termux-battery-status)
    is_charging=$(echo "$battery_status" | grep -o '"status": "CHARGING"')
    if [[ $is_charging == *"CHARGING"* ]]; then
        pkill -f "^tor$"
        echo 'CHARGING'
    fi
}

torchr() {
    battery_status=$(termux-battery-status)
    is_charging=$(echo "$battery_status" | grep -o '"status": "CHARGING"')
    if [[ $is_charging == *"CHARGING"* ]]; then
        echo 'CHARGING'
    else
        tor &
    fi
}

torch() {
    battery_status=$(termux-battery-status)
    is_charging=$(echo "$battery_status" | grep -o '"status": "CHARGING"')
    if [[ $is_charging == *"CHARGING"* ]]; then
        pkill -f "^tor$"
        echo 'CHARGING'
    else
        tor &
    fi
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

mvoc() {
    mv "$1" "/storage/emulated/0/Download"
}

cpoc() {
    cp "$1" "/storage/emulated/0/Download"
}

cproc() {
    cp -r "$1" "/storage/emulated/0/Download"
}

mvid() {
    mv "/storage/emulated/0/Download/$2" "/data/data/com.termux/files/home/debian$1/debian-fs/root/"
}

cpid() {
    cp "/storage/emulated/0/Download/$2" "/data/data/com.termux/files/home/debian$1/debian-fs/root/"
}

cprid() {
    cp -r "/storage/emulated/0/Download/$2" "/data/data/com.termux/files/home/debian$1/debian-fs/root/"
}

mvod() {
    mv "/data/data/com.termux/files/home/debian$1/debian-fs/root/$2" "/storage/emulated/0/Download/"
}

cpod() {
    cp "/data/data/com.termux/files/home/debian$1/debian-fs/root/$2" "/storage/emulated/0/Download/"
}

cprod() {
    cp -r "/data/data/com.termux/files/home/debian$1/debian-fs/root/$2" "/storage/emulated/0/Download/"
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

mvopdb() {
    mvop debianbox "$1"
}

cpopdb() {
    cpop debianbox "$1"
}

cpropdb() {
    cprop debianbox "$1"
}
