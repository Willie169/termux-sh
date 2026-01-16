#!/data/data/com.termux/files/usr/bin/bash

export GOPROXY='direct'
export GOROOT="$PREFIX/local/go"
export GOPATH="$GOPATH:$HOME/go"
export NVM_DIR="$HOME/.nvm"
export JAVA_HOME="$PREFIX/lib/jvm/java-17-openjdk"
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export ANDROID_HOME="$ANDROID_SDK_ROOT"
export ANDROID_NDK_HOME="$HOME/Android/Sdk/ndk/android-ndk-r29"
export ANDROID_NDK_TOOLCHAINS="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-aarch64"
export PATH="$PREFIX/bin:$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PREFIX/glibc/bin:$HOME/.cargo/bin:/data/data/com.termux/files/usr/lib/node_modules:$JAVA_HOME/bin:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_NDK_HOME:$ANDROID_NDK_TOOLCHAINS/bin:$PATH"
export PGDATA="$PREFIX/var/lib/postgresql"
export TORPATH="$PREFIX/etc/tor"
export PDROOTFS="$PREFIX/var/lib/proot-distro/installed-rootfs"
export EMU="/storage/emulated/0"
export DOW="/storage/emulated/0/Download"
export DOC="/storage/emulated/0/Documents"
alias src='source'
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
alias deact='deactivate'

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
  local has_option=0
  local out=
  local quiet=0
  local verbose=0
  local url=
  local to_stdout=0
  local no_fallback=0
  local use_aria2=1
  local use_curl=1
  local use_wget=1
  local tmp_file
  tmp_file=$(mktemp "$TMPDIR/dl.XXXXXXXXXX") || return 1
  local old_exit old_int old_term
  old_exit=$(trap -p EXIT)
  old_int=$(trap -p INT)
  old_term=$(trap -p TERM)

  set -- ${DLFLAGS:-} "$@"

  while [ $# -gt 0 ]; do
    case "$1" in
      -o|--output)
        out="$2"
        shift 2
        ;;
      -O|--stdout)
        to_stdout=1
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
      -a|--aria2)
        use_aria2=1; use_curl=0; use_wget=0
        shift
        ;;
      -A|--no-aria2)
        use_aria2=0
        shift
        ;;
      -c|--curl)
        use_curl=1; use_aria2=0; use_wget=0
        shift
        ;;
      -C|--no-curl)
        use_curl=0
        shift
        ;;
      -w|--wget)
        use_wget=1; use_aria2=0; use_curl=0
        shift
        ;;
      -W|--no-wget)
        use_wget=0
        shift
        ;;
      --no-fallback)
        no_fallback=1
        shift
        ;;
      --)
        shift
        break
        ;;
      -*)
        echo "Unknown option: $1" >&2
        echo "Usage: dl [-o|--output FILE] [-q|--quiet] [-v|--verbose] [-a|--aria2] [-A|--no-aria2] [-c|--curl] [-C|--no-curl] [-w|--wget] [-W|--no-wget] [--no-fallback] URL" >&2
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
    echo "Usage: dl [-o|--output FILE] [-q|--quiet] [-v|--verbose] [-a|--aria2] [-A|--no-aria2] [-c|--curl] [-C|--no-curl] [-w|--wget] [-W|--no-wget] [--no-fallback] URL" >&2
    return 2
  fi

  if [ -n "$out" ] && [ "$to_stdout" -eq 0 ]; then
    mkdir -p "$(dirname "$out")" || return 1
  fi

  cleanup() {
    [ -n "$tmp_file" ] && rm -f "$tmp_file"
  }

  if [ "$to_stdout" -eq 1 ] && [ "$use_aria2" -eq 1 ]; then
    trap cleanup EXIT INT TERM
  fi

  try_aria2() {
    command -v aria2c >/dev/null 2>&1 || return 127
    local opts=()
    [ "$quiet" -eq 1 ] && opts+=(-q)
    [ "$verbose" -eq 1 ] && opts+=(-v)

    if [ "$to_stdout" -eq 1 ]; then
      aria2c "${opts[@]}" -c -o "$tmp_file" "$url"
    elif [ -n "$out" ]; then
      aria2c "${opts[@]}" -c -o "$out" "$url"
    else
      aria2c "${opts[@]}" -c "$url"
    fi
  }

  try_curl() {
    command -v curl >/dev/null 2>&1 || return 127
    local opts=(-fL)
    [ "$quiet" -eq 1 ] && opts+=(-sS)
    [ "$verbose" -eq 1 ] && opts+=(-v)

    if [ "$to_stdout" -eq 1 ]; then
      curl "${opts[@]}" "$url"
    elif [ -n "$out" ]; then
      curl "${opts[@]}" -o "$out" "$url"
    else
      curl "${opts[@]}" -O "$url"
    fi
  }

  try_wget() {
    command -v wget >/dev/null 2>&1 || return 127
    local opts=()
    [ "$quiet" -eq 1 ] && opts+=(-q)
    [ "$verbose" -eq 1 ] && opts+=(-v)

    if [ "$to_stdout" -eq 1 ]; then
      wget "${opts[@]}" -O - "$url"
    elif [ -n "$out" ]; then
      wget "${opts[@]}" -O "$out" "$url"
    else
      wget "${opts[@]}" "$url"
    fi
  }

  local rc=1

  if [ "$use_aria2" -eq 1 ]; then
    if try_aria2; then
      if [ "$to_stdout" -eq 1 ]; then
        cat "$tmp_file" || return 1
      fi
      [ "$verbose" -eq 1 ] && echo "aria2 used"
      return 0
    fi
    rc=$?
    rm -f "$tmp_file"
    trap - EXIT INT TERM
    [ -n "$old_exit" ] && eval "$old_exit"
    [ -n "$old_int" ]  && eval "$old_int"
    [ -n "$old_term" ] && eval "$old_term"
    [ "$no_fallback" -eq 1 ] && return "$rc"
  fi

  if [ "$use_curl" -eq 1 ]; then
    if try_curl; then
      [ "$verbose" -eq 1 ] && echo "curl used"
      return 0
    fi
    rc=$?
    [ "$no_fallback" -eq 1 ] && return "$rc"
  fi

  if [ "$use_wget" -eq 1 ]; then
    if try_wget; then
      [ "$verbose" -eq 1 ] && echo "wget used"
      return 0
    fi
    rc=$?
    [ "$no_fallback" -eq 1 ] && return "$rc"
  fi

  echo "Error: all enabled downloaders failed" >&2
  return "$rc"
}

gh-latest() {
  local dl_args=()
  local quiet=0
  local verbose=0
  local repo=""
  local file=""
  local name=""
  local tag=""
  local index=""

  while [ $# -gt 0 ]; do
    case "$1" in
      -q|--quiet)
        quiet=1
        dl_args+=("$1")
        shift
        ;;
      -v|--verbose)
        verbose=1
        dl_args+=("$1")
        shift
        ;;
      -n|--name)
        name="$2"
        shift 2
        ;;
      -t|--tag)
        tag="$2"
        shift 2
        ;;
      -i|--index)
        index="$2"
        shift 2
        ;;
      -o|--output|--stdout|-a|--aria2|-A|--no-aria2|-c|--curl|-C|--no-curl|-w|--wget|-W|--no-wget|--no-fallback)
        dl_args+=("$1")
        if [[ "$1" == -o || "$1" == --output ]]; then
          dl_args+=("$2")
          shift
        fi
        shift
        ;;
      -*)
        echo "Unknown option: $1" >&2
        echo "Usage: gh-latest [-n|--name NAME] [-t|--tag TAG_NAME] [-i|--index N] [-o|--output FILE] [-q|--quiet] [-v|--verbose] [-a|--aria2] [-A|--no-aria2] [-c|--curl] [-C|--no-curl] [-w|--wget] [-W|--no-wget] [--no-fallback] <repo> [file-pattern]" >&2
        echo "Example: gh-latest cli/cli *.deb" >&2
        echo "Example: gh-latest https://github.com/cli/cli/ gh_*_linux_amd64.deb" >&2
        echo "Example: gh-latest github.com/cli/cli -n '*CLI 2.85.0*' gh_*_linux_amd64.deb" >&2
        echo "Example: gh-latest cli/cli -i 0" >&2
        return 1
        ;;
      *)
        if [ -z "$repo" ]; then
          repo="$1"
        else
          file="$1"
        fi
        shift
        ;;
    esac
  done

  [ "$quiet" -eq 1 ] && verbose=0

  repo="${repo#https://}"
  repo="${repo#http://}"
  repo="${repo#github.com/}"
  repo="${repo%.git}"
  repo="${repo%/}"

  if ! echo "$repo" | grep -Eq '^[a-zA-Z0-9_.-]+/[a-zA-Z0-9_.-]+$'; then
    echo "Error: invalid repo format. Expected 'user/repo' or URL" >&2
    echo "Usage: gh-latest [-n|--name NAME] [-t|--tag TAG_NAME] [-i|--index N] [-q|--quiet] [-v|--verbose] [dl-options] <repo> [file-pattern]" >&2
    echo "Example: gh-latest cli/cli *.deb" >&2
    echo "Example: gh-latest https://github.com/cli/cli/ gh_*_linux_amd64.deb" >&2
    echo "Example: gh-latest github.com/cli/cli -n '*CLI 2.85.0*' gh_*_linux_amd64.deb" >&2
    echo "Example: gh-latest cli/cli -i 0" >&2
    return 1
  fi

  if [ -z "$repo" ]; then
    echo "Error: invalid repo format. Expected 'user/repo' or URL" >&2
    echo "Usage: gh-latest [-n|--name NAME] [-t|--tag TAG_NAME] [-i|--index N] [-q|--quiet] [-v|--verbose] [dl-options] <repo> [file-pattern]" >&2
    echo "Example: gh-latest cli/cli *.deb" >&2
    echo "Example: gh-latest https://github.com/cli/cli/ gh_*_linux_amd64.deb" >&2
    echo "Example: gh-latest github.com/cli/cli -n '*CLI 2.85.0*' gh_*_linux_amd64.deb" >&2
    echo "Example: gh-latest cli/cli -i 0" >&2
    return 1
  fi

  [ "$quiet" -eq 0 ] && echo "Fetching latest release for $repo..." >&2

  local file_regex=""
  if [ -n "$file" ]; then
    file_regex=$(printf '%s' "$file" | sed '
      s/\\/\\\\\\\\/g
      s/\[/\\\\[/g
      s/\]/\\\\]/g
      s/\./[.]/g
      s/\*/.*/g
      s/\?/./g
      s/(/\\\\(/g
      s/)/\\\\)/g
      s/|/\\\\|/g
      s/+/\\\\+/g
      s/\$/\\\\$/g
      s/\^/\\\\^/g
    ')
    file_regex="^${file_regex}\$"
  fi

  local release_json
  if [ -n "$name" ] || [ -n "$tag" ]; then
    release_json=$(curl -fsSL "https://api.github.com/repos/$repo/releases" 2>/dev/null)
    if [ -z "$release_json" ]; then
      echo "Error: failed to fetch releases or repo not found" >&2
      return 1
    fi
  else
    release_json=$(curl -fsSL "https://api.github.com/repos/$repo/releases/latest" 2>/dev/null)
    if [ -z "$release_json" ] || [ "$release_json" = "null" ]; then
      echo "Error: no releases found or repo not found" >&2
      return 1
    fi
  fi

  if [ -n "$name" ]; then
    local name_regex
    name_regex=$(printf '%s' "^$name\$" | sed '
      s/\\/\\\\\\\\/g
      s/\[/\\\\[/g
      s/\]/\\\\]/g
      s/\./[.]/g
      s/\*/.*/g
      s/\?/./g
      s/(/\\\\(/g
      s/)/\\\\)/g
      s/|/\\\\|/g
      s/+/\\\\+/g
      s/\$/\\\\$/g
      s/\^/\\\\^/g
    ')
    name_regex="^${name_regex}\$"

    release_json=$(echo "$release_json" | jq -r --arg NAME "$name_regex" '
      map(select(
        .name != null and
        (.name | test($NAME))
      ))
      | max_by(.published_at)
    ')

    if [ "$release_json" = "null" ] || [ -z "$release_json" ]; then
      echo "Error: no release found with name matching: $name" >&2
      return 1
    fi
  fi

  if [ -n "$tag" ]; then
    local tag_regex
    tag_regex=$(printf '%s' "^$tag\$" | sed '
      s/\\/\\\\\\\\/g
      s/\[/\\\\[/g
      s/\]/\\\\]/g
      s/\./[.]/g
      s/\*/.*/g
      s/\?/./g
      s/(/\\\\(/g
      s/)/\\\\)/g
      s/|/\\\\|/g
      s/+/\\\\+/g
      s/\$/\\\\$/g
      s/\^/\\\\^/g
    ')
    tag_regex="^${tag_regex}\$"

    release_json=$(echo "$release_json" | jq -r --arg TAG "$tag_regex" '
      map(select(
        .tag_name != null and
        (.tag_name | test($TAG))
      ))
      | max_by(.published_at)
    ')

    if [ "$release_json" = "null" ] || [ -z "$release_json" ]; then
      echo "Error: no release found with tag name matching: $tag" >&2
      return 1
    fi
  fi

  local urls
  urls=$(echo "$release_json" | jq -r --arg FILE "$file_regex" --arg INDEX "$index" '
    if .assets then
      .assets
      | map(select(
          .name != null and
          ($FILE == "" or (.name | test($FILE)))
        ))
      | if $INDEX != "" then
          [.[($INDEX|tonumber)]?]
        else
          .
        end
      | .[]
      | .browser_download_url
    else
      empty
    end
  ')

  if [ -z "$urls" ]; then
    echo "Error: no matching assets found" >&2
    return 1
  fi

  local count
  count=$(echo "$urls" | grep -cve '^\s*$')

  if [ "$quiet" -eq 0 ]; then
    local release_name=$(echo "$release_json" | jq -r '.name // .tag_name')
    echo "Release: $release_name" >&2

    if [ "$count" -gt 1 ]; then
      echo "Found $count matching assets. Downloading all" >&2
      if [ "$verbose" -eq 1 ]; then
        echo "$urls" | nl -w2 -s': ' | sed 's/^/  /' >&2
      fi
    elif [ "$verbose" -eq 1 ]; then
      echo "Found 1 matching asset:" >&2
      echo "$urls" | sed 's/^/  /' >&2
    fi
  fi

  local success=true
  local downloaded=0
  while IFS= read -r url; do
    [ -z "$url" ] && continue

    downloaded=$((downloaded + 1))
    [ "$quiet" -eq 0 ] && echo "[$downloaded/$count] Downloading: $(basename "$url")" >&2

    if ! dl "${dl_args[@]}" "$url"; then
      echo "Error: failed to download $url" >&2
      success=false
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
    if [ $# -lt 1 ]; then
        echo "Usage: gtr <version> [-n|--notes 'notes'] [files...]"
        return 1
    fi
    local version="$1"
    shift
    local notes=""
    local files=()

    while [ $# -gt 0 ]; do
        case "$1" in
            -n|--notes)
                shift
                if [ $# -eq 0 ]; then
                    echo "Error: Missing notes after -n|--notes"
                    return 1
                fi
                notes="$1"
                ;;
            *)
                files+=("$1")
                ;;
        esac
        shift
    done

    git tag -a "v$version" -m "Version $version release"
    git push origin "v$version"

    if [ -n "$notes" ]; then
        gh release create "v$version" --title "Version $version release" --notes "$notes" "${files[@]}"
    else
        gh release create "v$version" --title "Version $version release" --notes "" "${files[@]}"
    fi
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
