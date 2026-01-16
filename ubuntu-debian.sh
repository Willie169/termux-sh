cd ~

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

export DLFLAGS='-A'

. /etc/os-release
apt update
if [ "$ID" = "ubuntu" ]; then
apt install software-properties-common -y
add-apt-repository universe -y
add-apt-repository multiverse -y
add-apt-repository restricted -y
add-apt-repository ppa:zhangsongcui3371/fastfetch -y
fi
apt update
apt full-upgrade -y
apt install alsa-utils apksigner apt-transport-https aptitude aria2 autoconf automake bash bc bear bison build-essential bzip2 ca-certificates clang clang-format cmake command-not-found curl dbus default-jdk dnsutils dvipng dvisvgm fastfetch ffmpeg file flex g++ gcc gdb gfortran gh ghostscript git glab gnucobol gnupg golang gperf gpg grep gtkwave gzip info inkscape iproute2 iverilog iverilog jpegoptim jq libboost-all-dev libbz2-dev libconfig-dev libeigen3-dev libffi-dev libfuse2 libgdbm-compat-dev libgdbm-dev libgsl-dev libheif-examples libllvm19 liblzma-dev libncursesw5-dev libosmesa6 libreadline-dev libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-net-dev libsdl2-ttf-dev libsqlite3-dev libssl-dev libxml2-dev libxmlsec1-dev libzstd-dev llvm make maven mc nano ncompress neovim ngspice openjdk-21-jdk openssh-client openssh-server openssl optipng pandoc perl perl-doc pipx plantuml procps pv python3-all-dev python3-pip python3-venv rust-all sudo tar tk-dev tmux tree unzip uuid-dev uuid-runtime valgrind verilator vim wget x11-utils x11-xserver-utils xmlstarlet xz-utils zip zlib1g zlib1g-dev zsh -y
if [ "$ID" = "ubuntu" ]; then
apt install openjdk-17-jdk unrar -y
else
apt install unrar-free -y
fi
dl http://ports.ubuntu.com/pool/universe/e/elementary-xfce/elementary-xfce-icon-theme_0.19-1_all.deb
apt install ./elementary-xfce-icon-theme_0.19-1_all.deb -y
rm elementary-xfce-icon-theme_0.19-1_all.deb
apt-mark hold elementary-xfce-icon-theme
apt install dbus-x11 firefox-esr tigervnc-standalone-server xfce4 xfce4-goodies xfce4-terminal -y
cat > ~/.config/tigervnc/xstartup << 'EOF'
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
unset SESSION_MANAGER
export XDG_RUNTIME_DIR=${TMPDIR}
export XAUTHORITY="$HOME/.Xauthority"
dbus-launch --exit-with-session startxfce4
EOF
chmod +x ~/.config/tigervnc/xstartup
dl https://sourceforge.net/projects/sdl-bgi/files/SDL2_bgi-3.0.4.tar.gz/download -O SDL2_bgi-3.0.4.tar.gz
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
dl https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xvzf install-tl-unx.tar.gz
rm install-tl-unx.tar.gz
cd install-tl-*
perl install-tl --no-interaction
cd ~
rm -rf install-tl-*
mkdir -p ~/.config/fontconfig/conf.d
cat > ~/.config/fontconfig/conf.d/99-texlive.conf << 'EOF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <dir>/usr/local/texlive/2025/texmf-dist/fonts</dir>
</fontconfig>
EOF
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 22
corepack enable yarn
corepack enable pnpm
npm install -g http-server jsdom marked marked-gfm-heading-id node-html-markdown showdown @openai/codex
pipx install poetry uv
cat > ~/.bashrc << 'EOF'
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:/usr/include:/usr/include/SDL2"
export CXXFLAGS='-std=gnu++20 -O2'
export CFLAGS='-std=c17 -O2'
export GOPROXY='direct'
export GOROOT="/usr/local/go"
export GOPATH="$HOME/go:$GOPATH"
export NVM_DIR="$HOME/.nvm"
export JAVA_HOME="/usr/lib/jvm/openjdk-21"
export PATH="$PATH:/bin:/sbin:/usr/bin:/usr/sbin:$HOME/.local/bin:$GOPATH/bin:$GOROOT/bin:/usr/glibc/bin:$HOME/.cargo/bin:/usr/local/texlive/2025/bin/aarch64-linux"
export KIT="/usr/share/LaTeX-ToolKit"
export PATCH="$HOME/texmf/tex/latex/physics-patch"
export PLANTUML_JAR="$HOME/plantuml.jar"
export PULSE_SERVER='127.0.0.1'
export DLFLAGS='-A'
alias src='source'
alias sshd='/usr/sbin/sshd'
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
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

gccSDL2() {
    gcc "$@" -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf -lSDL2_net -lm -lstdc++
}

gccSDL2bgi() {
    gcc "$@" -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf -lSDL2_net -lSDL2_bgi -lm -lstdc++
}

g++SDL2() {
    g++ "$@" -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf -lSDL2_net
}

g++SDL2bgi() {
    g++ "$@" -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf -lSDL2_net -lSDL2_bgi
}

g++20SDL2() {
    g++ -std=gnu++20 "$@" -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf -lSDL2_net
}

g++20SDL2bgi() {
    g++ -std=gnu++20 "$@" -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf -lSDL2_net -lSDL2_bgi
}

g++201SDL2() {
    g++ -std=gnu++20 -O1 "$@" -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf -lSDL2_net
}

g++201SDL2bgi() {
    g++ -std=gnu++20 -O1 "$@" -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf -lSDL2_net -lSDL2_bgi
}

g++202SDL2() {
    g++ -std=gnu++20 -O2 "$@" -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf -lSDL2_net
}

g++202SDL2bgi() {
    g++ -std=gnu++20 -O2 "$@" -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf -lSDL2_net -lSDL2_bgi
}

g++203SDL2() {
    g++ -std=gnu++20 -O3 "$@" -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf -lSDL2_net
}

g++203SDL2bgi() {
    g++ -std=gnu++20 -O3 "$@" -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf -lSDL2_net -lSDL2_bgi
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

updatetex() {
    cd /usr/share/LaTeX-ToolKit
    git pull
    cd ~/texmf/tex/latex/physics-patch
    git pull
    cd
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
EOF
source ~/.bashrc
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
bash Miniforge3-Linux-aarch64.sh -b -p ${HOME}/miniforge3
source "${HOME}/miniforge3/etc/profile.d/conda.sh"
source "${HOME}/miniforge3/etc/profile.d/mamba.sh"
conda init
exec bash
rm Miniforge3-Linux-aarch64.sh
mkdir -p /usr/local/lib
sudo curl -fsSL -o /usr/local/lib/antlr-4.13.2-complete.jar https://www.antlr.org/download/antlr-4.13.2-complete.jar
git clone --depth=1 https://github.com/Willie169/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
if [ "$ID" = "ubuntu" ]; then
add-apt-repository ppa:dotnet/backports -y
apt update
apt install dotnet-sdk-10.0 aspnetcore-runtime-10.0 -y
fi
dl -o plantuml.jar https://sourceforge.net/projects/plantuml/files/plantuml.jar/download
apt install postgresql-common postgresql-17 -y
mkdir -p /usr/share/fonts/opentype/xits
cd /usr/share/fonts/opentype/xits
dl https://github.com/aliftype/xits/releases/download/v1.302/XITS-1.302.zip
unzip XITS-1.302.zip
cd XITS-1.302
mv *.otf ..
cd ..
rm -rf XITS-1.302*
mkdir -p /usr/share/fonts/noto-cjk
cd /usr/share/fonts/noto-cjk
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Thin.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Medium.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Light.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-DemiLight.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Bold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Black.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Thin.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Medium.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Light.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-DemiLight.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Bold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Black.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Thin.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Medium.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Light.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-DemiLight.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Bold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Black.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Thin.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Medium.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Light.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-DemiLight.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Bold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Black.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Thin.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Medium.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Light.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-DemiLight.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Bold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Black.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-ExtraLight.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Medium.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Light.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-SemiBold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Bold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Black.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-ExtraLight.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Medium.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Light.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-SemiBold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Bold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Black.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-ExtraLight.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Medium.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Light.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-SemiBold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Bold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Black.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-ExtraLight.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Medium.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Light.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-SemiBold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Bold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Black.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-ExtraLight.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Medium.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Light.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-SemiBold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Bold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Black.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKtc-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKtc-Bold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKsc-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKsc-Bold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKhk-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKhk-Bold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKjp-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKjp-Bold.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKkr-Regular.otf
dl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKkr-Bold.otf
fc-cache -fv
cd /usr/share
rm -rf LaTeX-ToolKit
git clone https://github.com/Willie169/LaTeX-ToolKit
cd ~
mkdir -p texmf
cd texmf
mkdir -p tex
cd tex
mkdir -p latex
cd latex
rm -rf physics-patch
git clone https://github.com/Willie169/physics-patch
cd ~
