apt update && apt upgrade -y && apt install automake bash build-essential bzip2 clang cmake command-not-found curl dbus file gdb gh git golang grep libboost-all-dev libssl-dev iproute2 jq make maven mc nano neovim nodejs openjdk-17-jdk openssh-client openssh-server openssl pandoc perl procps python3-pip python3-all-dev python3-venv rust-all tar texlive-full tmux vim wget zsh -y
echo 'alias src="source"
export FONTCONFIG_PATH="/usr/share/fonts"' >> ~/.bashrc
source ~/.bashrc
python3 -m venv .env
source .env/bin/activate
pip3 install numpy sympy matplotlib setuptools selenium jupyter pandas meson ninja
mkdir -p /usr/share/fonts/opentype/stix
curl https://raw.githubusercontent.com/stipub/stixfonts/master/fonts/static_otf/STIXTwoMath-Regular.otf --output /usr/share/fonts/opentype/stix/STIXTwoMath-Regular.otf
mkdir -p /usr/share/fonts/truetype/noto
curl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/OTC/NotoSansCJK-Thin.ttc --output /usr/share/fonts/truetype/noto/NotoSansCJK-Thin.ttc
curl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/OTC/NotoSansCJK-DemiLight.ttc --output /usr/share/fonts/truetype/noto/NotoSansCJK-DemiLight.ttc
curl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/OTC/NotoSansCJK-Light.ttc --output /usr/share/fonts/truetype/noto/NotoSansCJK-Light.ttc
curl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/OTC/NotoSansCJK-Regular.ttc --output /usr/share/fonts/truetype/noto/NotoSansCJK-Regular.ttc
curl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/OTC/NotoSansCJK-Medium.ttc --output /usr/share/fonts/truetype/noto/NotoSansCJK-Medium.ttc
curl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/OTC/NotoSansCJK-Bold.ttc --output /usr/share/fonts/truetype/noto/NotoSansCJK-Bold.ttc
curl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/OTC/NotoSansCJK-Black.ttc --output /usr/share/fonts/truetype/noto/NotoSansCJK-Black.ttc
curl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/OTC/NotoSerifCJK-ExtraLight.ttc --output /usr/share/fonts/truetype/noto/NotoSerifCJK-ExtraLight.ttc
curl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/OTC/NotoSerifCJK-Light.ttc --output /usr/share/fonts/truetype/noto/NotoSerifCJK-Light.ttc
curl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/OTC/NotoSerifCJK-Regular.ttc --output /usr/share/fonts/truetype/noto/NotoSerifCJK-Regular.ttc
curl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/OTC/NotoSerifCJK-Medium.ttc --output /usr/share/fonts/truetype/noto/NotoSerifCJK-Medium.ttc
curl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/OTC/NotoSerifCJK-SemiBold.ttc --output /usr/share/fonts/truetype/noto/NotoSerifCJK-SemiBold.ttc
curl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/OTC/NotoSerifCJK-Bold.ttc --output /usr/share/fonts/truetype/noto/NotoSerifCJK-Bold.ttc
curl https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/OTC/NotoSerifCJK-Black.ttc --output /usr/share/fonts/truetype/noto/NotoSerifCJK-Black.ttc
mkdir -p /usr/share/fonts/opentype/noto
curl https://raw.githubusercontent.com/notofonts/noto-cjk/tree/main/Sans/Mono/NotoSansMonoCJKtc-Regular.otf --output /usr/share/fonts/opentype/noto/NotoSansMonoCJKtc-Regular.otf
curl https://raw.githubusercontent.com/notofonts/noto-cjk/tree/main/Sans/Mono/NotoSansMonoCJKtc-Bold.otf --output /usr/share/fonts/opentype/noto/NotoSansMonoCJKtc-Bold.otf
curl https://raw.githubusercontent.com/notofonts/noto-cjk/tree/main/Sans/Mono/NotoSansMonoCJKsc-Regular.otf --output /usr/share/fonts/opentype/noto/NotoSansMonoCJKsc-Regular.otf
curl https://raw.githubusercontent.com/notofonts/noto-cjk/tree/main/Sans/Mono/NotoSansMonoCJKsc-Bold.otf --output /usr/share/fonts/opentype/noto/NotoSansMonoCJKsc-Bold.otf
curl https://raw.githubusercontent.com/notofonts/noto-cjk/tree/main/Sans/Mono/NotoSansMonoCJKjp-Regular.otf --output /usr/share/fonts/opentype/noto/NotoSansMonoCJKjp-Regular.otf
curl https://raw.githubusercontent.com/notofonts/noto-cjk/tree/main/Sans/Mono/NotoSansMonoCJKjp-Bold.otf --output /usr/share/fonts/opentype/noto/NotoSansMonoCJKjp-Bold.otf
curl https://raw.githubusercontent.com/notofonts/noto-cjk/tree/main/Sans/Mono/NotoSansMonoCJKkr-Regular.otf --output /usr/share/fonts/opentype/noto/NotoSansMonoCJKkr-Regular.otf
curl https://raw.githubusercontent.com/notofonts/noto-cjk/tree/main/Sans/Mono/NotoSansMonoCJKkr-Bold.otf --output /usr/share/fonts/opentype/noto/NotoSansMonoCJKkr-Bold.otf
curl https://raw.githubusercontent.com/notofonts/noto-cjk/tree/main/Sans/Mono/NotoSansMonoCJKhk-Regular.otf --output /usr/share/fonts/opentype/noto/NotoSansMonoCJKhk-Regular.otf
curl https://raw.githubusercontent.com/notofonts/noto-cjk/tree/main/Sans/Mono/NotoSansMonoCJKhk-Bold.otf --output /usr/share/fonts/opentype/noto/NotoSansMonoCJKhk-Bold.otf
fc-cache -fv
fc-list | grep "STIX Two Math"
fc-list | grep "Noto Sans CJK"
fc-list | grep "Noto Serif CJK"