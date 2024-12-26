apt update --allow-releaseinfo-change -y && apt upgrade -y && apt install curl nano pandoc texlive-full -y
mkdir -p ~/.fonts
curl https://github.com/googlefonts/noto-cjk/raw/main/Sans/Variable/OTC/NotoSansCJK-VF.otf.ttc --output ~/.fonts/NotoSansCJK-VF.otf.ttc
curl https://github.com/googlefonts/noto-cjk/raw/main/Sans/Variable/OTC/NotoSansMonoCJK-VF.otf.ttc --output ~/.fonts/NotoSansMonoCJK-VF.otf.ttc
curl https://raw.githubusercontent.com/stipub/stixfonts/master/fonts/static_otf/STIXTwoMath-Regular.otf --output ~/.fonts/STIXTwoMath-Regular.otf
fc-cache -fv
export alias src='source'
export FONTCONFIG_PATH=$HOME/.font
source .bashrc
rm -rf .bash_profile
exit