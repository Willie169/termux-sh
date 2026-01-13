#!/data/data/com.termux/files/usr/bin/bash

export GOROOT="$PREFIX/lib/go"
export GOPATH="$HOME/go"
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export ANDROID_HOME="$ANDROID_SDK_ROOT"
export ANDROID_NDK_HOME="$HOME/Android/android-ndk"
export JAVA_HOME="$PREFIX/lib/jvm/java-17-openjdk"
export NVM_DIR="$HOME/.nvm"
export PATH="$PREFIX/bin:$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PREFIX/glibc/bin:$HOME/.cargo/bin:/data/data/com.termux/files/usr/lib/node_modules:$JAVA_HOME/bin:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_NDK_HOME:$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-aarch64/bin:$HOME/gradle/gradle-8.13/bin:$PATH"
export PGDATA="$PREFIX/var/lib/postgresql"
export TORPATH="$PREFIX/etc/tor"
export PDROOTFS="$PREFIX/var/lib/proot-distro/installed-rootfs"
export EMU="/storage/emulated/0"
export DOW="/storage/emulated/0/Download"
export DOC="/storage/emulated/0/Documents"
alias src=source
alias deact='deactivate'
alias g++20='g++ -std=gnu++20'
alias c++20='clang++ -std=gnu++20'
alias g++201='g++ -std=gnu++20 -O1'
alias c++201='clang++ -std=gnu++20 -O1'
alias g++202='g++ -std=gnu++20 -O2'
alias c++202='clang++ -std=gnu++20 -O2'
alias g++203='g++ -std=gnu++20 -O3'
alias c++203='clang++ -std=gnu++20 -O3'
alias cfm='clang-format'
alias cfmi='clang-format -i'
alias vnc='vncserver'
alias vnck='vncserver -kill'
alias vncl='vncserver -list'
alias httpp='http-server -p'
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
pulseaudio --start --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1
pacmd load-module module-sles-sink

__git_repo_reminder() {
    local repo_root
    repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -n "$repo_root" ]; then
        if [ "$__LAST_REPO_ROOT" != "$repo_root" ]; then
            if [ -n "$__LAST_REPO_ROOT" ]; then
                echo "Leaving Git repository: consider running 'git push'"
            fi
            echo "Entered Git repository: consider running 'git pull'"
            __LAST_REPO_ROOT="$repo_root"
        fi
    else
        if [ -n "$__LAST_REPO_ROOT" ]; then
            echo "Leaving Git repository: consider running 'git push'"
            unset __LAST_REPO_ROOT
        fi
    fi
}
PROMPT_COMMAND="__git_repo_reminder${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

actenv() {
    if [ -z "$1" ]; then
        echo "Usage: actenv <venv_path>"
        return 1
    fi
    if [ -f "$1/bin/activate" ]; then
        source "$1/bin/activate"
    else
        echo "Error: $1/bin/activate not found"
        return 1
    fi
}

xdgset() {
    export XDG_RUNTIME_DIR=/tmp/runtime-root
    mkdir -p $XDG_RUNTIME_DIR
    export DISPLAY="$1"
}

vncclean() {
  if [ $# -ne 1 ] || ! [[ $1 =~ ^[0-9]+$ ]]; then
    echo "Usage: vncclean <display_number>" >&2
    return 1
  fi

  rm -f "/tmp/.X${1}-lock"
  rm -f "/tmp/.X11-unix/.X${1}"
}

dl() {
  local out=
  local quiet=0
  local verbose=0
  local url=

  while [ $# -gt 0 ]; do
    case "$1" in
      -o|--output)
        out="$2"
        shift 2
        ;;
      --output=*)
        out="${1#*=}"
        shift
        ;;
      -q|--quiet)
        quiet=1
        shift
        ;;
      -v|--verbose)
        verbose=1
        shift
        ;;
      --)
        shift
        break
        ;;
      -*)
        echo "Usage: download [-q|--quiet] [-v|--verbose] [-o|--output FILE | --output=FILE] URL" >&2
        return 2
        ;;
      *)
        url="$1"
        shift
        ;;
    esac
  done

  [ "$quiet" -eq 1 ] && verbose=0

  if [ -z "$url" ]; then
    echo "Usage: download [-q|--quiet] [-v|--verbose] [-o|--output FILE | --output=FILE] URL" >&2
    return 2
  fi

  if command -v aria2c >/dev/null 2>&1; then
    local opts=()
    [ "$quiet" -eq 1 ] && opts+=(-q)
    [ "$verbose" -eq 1 ] && opts+=(-v)
    if [ -n "$out" ]; then
      aria2c "${opts[@]}" -c -o "$out" "$url"
    else
      aria2c "${opts[@]}" -c "$url"
    fi

  elif command -v curl >/dev/null 2>&1; then
    local opts=()
    [ "$quiet" -eq 1 ] && opts+=(-sS)
    [ "$verbose" -eq 1 ] && opts+=(-v)
    if [ -n "$out" ]; then
      curl -fL "${opts[@]}" -o "$out" "$url"
    else
      curl -fL "${opts[@]}" -O "$url"
    fi

  elif command -v wget >/dev/null 2>&1; then
    local opts=()
    [ "$quiet" -eq 1 ] && opts+=(-q)
    [ "$verbose" -eq 1 ] && opts+=(-v)
    if [ -n "$out" ]; then
      wget "${opts[@]}" -O "$out" "$url"
    else
      wget "${opts[@]}" "$url"
    fi

  else
    echo "Error: no downloader available, either aria2c, curl, or wget is required" >&2
    return 127
  fi
}

gh-latest() {
  local repo=""
  local pattern=""
  local quiet=0
  local verbose=0

  while [ $# -gt 0 ]; do
    case "$1" in
      -q|--quiet)
        quiet=1
        shift
        ;;
      -v|--verbose)
        verbose=1
        shift
        ;;
      -*)
        echo "Usage: gh-latest [-q|--quiet] [-v|--verbose] <repo> [pattern]" >&2
        echo "Example: gh-latest cli/cli '*.deb'" >&2
        return 1
        ;;
      *)
        if [ -z "$repo" ]; then
          repo="$1"
        else
          pattern="$1"
        fi
        shift
        ;;
    esac
  done

  [ "$quiet" -eq 1 ] && verbose=0

  if [ -z "$repo" ]; then
    echo "Usage: gh-latest [-q|--quiet] [-v|--verbose] <repo> [pattern]" >&2
    echo "Example: gh-latest cli/cli '*.deb'" >&2
    return 1
  fi

  if [ "$quiet" -eq 0 ]; then
    echo "Fetching latest release for $repo..." >&2
  fi

  local curl_opts=()
  if [ "$quiet" -eq 1 ]; then
    curl_opts+=(-sS)
  fi

  local urls
  urls=$(curl -fsSL "${curl_opts[@]}" "https://api.github.com/repos/$repo/releases/latest" | \
    jq -r ".assets[].browser_download_url" 2>/dev/null)

  if [ -z "$urls" ]; then
    echo "Error: failed to get release information or no assets found" >&2
    return 1
  fi

  if [ -n "$pattern" ]; then
    local regex
    regex=$(printf '%s' "$pattern" | sed -e 's/\./\\./g' -e 's/\*/.*/g' -e 's/\?/./g')
    urls=$(echo "$urls" | grep -E "$regex")
  fi

  if [ -z "$urls" ]; then
    echo "Error: no matching assets found" >&2
    return 1
  fi

  local count
  count=$(echo "$urls" | grep -cve '^\s*$')

  if [ "$quiet" -eq 0 ] && [ "$count" -gt 1 ]; then
    echo "Found $count matching assets. Downloading all" >&2
    if [ "$verbose" -eq 1 ]; then
      echo "$urls" | sed 's/^/  /' >&2
    fi
  elif [ "$quiet" -eq 0 ] && [ "$verbose" -eq 1 ]; then
    echo "Found $count matching asset(s)" >&2
    echo "$urls" | sed 's/^/  /' >&2
  fi

  local dl_opts=()
  if [ "$quiet" -eq 1 ]; then
    dl_opts+=(-q)
  elif [ "$verbose" -eq 1 ]; then
    dl_opts+=(-v)
  fi

  local success=true
  local downloaded=0
  while IFS= read -r url; do
    if [ -n "$url" ]; then
      downloaded=$((downloaded + 1))
      if [ "$quiet" -eq 0 ]; then
        echo "[$downloaded/$count] Downloading: $(basename "$url")" >&2
      fi
      if ! dl "${dl_opts[@]}" "$url"; then
        echo "Error: failed to download $url" >&2
        success=false
      fi
    fi
  done <<< "$urls"

  if [ "$success" = false ]; then
    return 1
  elif [ "$quiet" -eq 0 ]; then
    echo "Download completed successfully" >&2
  fi
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

git-upstream-pr() {
  if [ -z "$1" ]; then
    echo "Usage: git-upstream-pr <PR_NUMBER>"
    return 1
  fi
  git fetch upstream pull/$1/head:pr-$1 || { echo "Fetch failed"; return 1; }
  git merge pr-$1 || { echo "Merge conflict! Resolve manually."; return 1; }
  git push || { echo "Push failed"; return 1; }
  git branch -D pr-$1
}

pdssh() {
    ssh -p 2022 root@"$1" -L 3300:localhost:3000 -L 5500:localhost:5000 -L 5901:localhost:5901 -L 5902:localhost:5902
}

pdsftp() {
    sftp -p 2022 root@"$1"
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

bzip-single() {
  tar -cf - "$1" \
  | pv \
  | bzip2 -9 \
  | pv \
  > "$2.tar.bz2"
}

bzip-split() {
  tar -cf - "$1" \
  | pv \
  | bzip2 -9 \
  | pv \
  | split -b 4000M -d -a 3 - "$2.tar.bz2.part."
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
