BUSTERCLI='buster'

[ -n "$BUSTERCLI" ] && mkdir ~/$BUSTERCLI && echo "bash ~/$BUSTERCLI/start-debian.sh" >> ~/$BUSTERCLI.sh && chmod +x ~/$BUSTERCLI.sh && cp ~/$BUSTERCLI.sh ~/.shortcuts && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian.sh -O ~/$BUSTERCLI/debian.sh && echo 'exit' | bash ~/$BUSTERCLI/debian.sh
