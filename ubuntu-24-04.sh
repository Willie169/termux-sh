apt update && apt upgrade -y && apt install automake bash build-essential bzip2 clang cmake command-not-found curl dbus file gdb gh ghostscript git golang grep ffmpeg libboost-all-dev libeigen3-dev libgsl-dev libssl-dev iproute2 jq make maven mc mlocate nano neovim nodejs npm openjdk-17-jdk openssh-client openssh-server openssl pandoc perl perl-doc procps python3-pip python3-all-dev python3-venv rust-all sudo tar tmux vim wget zsh -y
cd ~
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xvzf install-tl-unx.tar.gz
rm install-tl-unx.tar.gz
cd install-tl-*
perl install-tl --no-interaction
cd ~
echo 'export PATH=/usr/local/texlive/2025/bin/aarch64-linux:$PATH' >> ~/.bashrc
source ~/.bashrc
rm -rf install-tl-*
mkdir -p ~/.config/fontconfig/conf.d
cat > ~/.config/fontconfig/conf.d/99-texlive.conf << EOF
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <dir>/usr/local/texlive/2025/texmf-dist/fonts</dir>
</fontconfig>
EOF
python3 -m venv .env
source .env/bin/activate
pip3 install jupyter librosa matplotlib meson ninja numpy pandas pydub scipy selenium setuptools sympy
mkdir /usr/share/fonts/opentype/xits
cd /usr/share/fonts/opentype/xits
wget https://github.com/aliftype/xits/releases/download/v1.302/XITS-1.302.zip
unzip XITS-1.302.zip
cd XITS-1.302
mv *.otf ..
cd ..
rm -rf XITS-1.302*
mkdir /usr/share/fonts/noto-cjk
cd /usr/share/fonts/noto-cjk
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Thin.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-DemiLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/TC/NotoSansTC-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Thin.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-DemiLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/SC/NotoSansSC-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Thin.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-DemiLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/HK/NotoSansHK-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Thin.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-DemiLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/JP/NotoSansJP-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Thin.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-DemiLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/SubsetOTF/KR/NotoSansKR-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-ExtraLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-SemiBold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/TC/NotoSerifTC-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-ExtraLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-SemiBold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/SC/NotoSerifSC-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-ExtraLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-SemiBold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/HK/NotoSerifHK-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-ExtraLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-SemiBold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/JP/NotoSerifJP-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-ExtraLight.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Medium.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Light.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-SemiBold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Serif/SubsetOTF/KR/NotoSerifKR-Black.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKtc-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKtc-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKsc-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKsc-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKhk-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKhk-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKjp-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKjp-Bold.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKkr-Regular.otf
wget https://raw.githubusercontent.com/notofonts/noto-cjk/main/Sans/Mono/NotoSansMonoCJKkr-Bold.otf
fc-cache -fv