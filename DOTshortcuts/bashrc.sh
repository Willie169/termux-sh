#!/data/data/com.termux/files/usr/bin/bash

export PATH="/data/data/com.termux/files/usr/bin:$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PREFIX/glibc/bin:/data/data/com.termux/files/home/.cargo/bin"
export CLASSPATH=".:/data/data/com.termux/files/usr/lib/antlr-4.13.2-complete.jar:$CLASSPATH"
export GOROOT=/data/data/com.termux/files/usr/lib/go
export GOPATH=~/go
export TORPATH='cp ~/.torrc_file/charging/torrc $PREFIX/etc/tor'
export PDROOTFS='$PREFIX/var/lib/proot-distro/installed-rootfs'
alias antlr4='java -jar /data/data/com.termux/files/usr/lib/antlr-4.13.2-complete.jar'
alias grun='java org.antlr.v4.runtime.misc.TestRig'
alias src=source
alias gacp='gitacp'

torch() {
    battery_status=$(termux-battery-status)
    is_charging=$(echo "$battery_status" | grep -o '"status": "CHARGING"')
    pkill -f "^tor$"
    echo -e "Is charging: $is_charging\n"

    if [[ $is_charging == *"CHARGING"* ]]; then
        cptorcc
    else
        cptorncc
    fi
}

torr() {
    if pgrep -x "tor" > /dev/null; then
        echo -e "Tor is already running.\n"
    else
        echo -e "Running torch and tor.\n"
        torch &
        tmux new-session -d -s tor_session "tor"
    fi
}

torc() {
    pkill -f "^tor$"
    cptorcc
    tmux new-session -d -s tor_session "tor"
}

alias tors='torsocks'

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

mvod() {
    mv "/data/data/com.termux/files/home/debian$1/debian-fs/root/$2" "/storage/emulated/0/Download/"
}

cpod() {
    cp "/data/data/com.termux/files/home/debian$1/debian-fs/root/$2" "/storage/emulated/0/Download/"
}

cprod() {
    cp -r "/data/data/com.termux/files/home/debian$1/debian-fs/root/$2" "/storage/emulated/0/Download/"
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

gitacp() {
    git add .
    git commit -m "$1"
    git push origin "$2"
}
