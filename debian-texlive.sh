apt update --allow-releaseinfo-change -y && apt upgrade -y && apt install curl nano pandoc texlive-full wget -y
mkdir -p ~/.font
curl https://github.com/googlefonts/noto-cjk/raw/main/Sans/Variable/OTC/NotoSansCJK-VF.otf.ttc --output ~/.font/NotoSansCJK-VF.otf.ttc
curl https://raw.githubusercontent.com/stipub/stixfonts/master/fonts/static_otf/STIXTwoMath-Regular.otf --output ~/.font/STIXTwoMath-Regular.otf
https://github.com/$1/$2/releases/tag/$3/$4
fc-cache -fv
rm -rf .bash_profile
exit