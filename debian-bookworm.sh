apt update && apt upgrade -y && apt install automake bash build-essential bzip2 clang cmake command-not-found curl dbus file gdb gh git golang grep libboost-all-dev libssl-dev iproute2 jq make maven mc nano neovim nodejs openjdk-17-jdk openssh-client openssh-server openssl pandoc perl procps python3-pip python3-all-dev python3-venv rust-all tar texlive-full tmux vim wget zsh -y
python3 -m venv .env
source .env/bin/activate
pip3 install numpy sympy matplotlib setuptools selenium jupyter pandas meson ninja
export alias src='source'
export FONTCONFIG_PATH=$HOME/.font
source .bashrc
mkdir -p ~/.fonts
curl https://github.com/googlefonts/noto-cjk/raw/main/Sans/Variable/OTC/NotoSansCJK-VF.otf.ttc --output ~/.fonts/NotoSansCJK-VF.otf.ttc
curl https://github.com/googlefonts/noto-cjk/raw/main/Sans/Variable/OTC/NotoSansMonoCJK-VF.otf.ttc --output ~/.fonts/NotoSansMonoCJK-VF.otf.ttc
curl https://raw.githubusercontent.com/stipub/stixfonts/master/fonts/static_otf/STIXTwoMath-Regular.otf --output ~/.fonts/STIXTwoMath-Regular.otf
fc-cache -fv