cd ~/xmrig/build
rm -r .tor 2>/dev/null || true
mkdir .tor
cat > .tor/torrc <<'EOF'
SocksPort 9054
DataDirectory $HOME/xmrig/build/.tor
EOF
tor -f .tor/torrc &
TORPID=$!
trap 'kill $TORPID; rm -r ~/xmrig/build/.tor' EXIT
until echo > /dev/tcp/127.0.0.1/9054 2>/dev/null; do sleep 1; done
./xmrig -o pool.supportxmr.com:3333 -u 48j6iQDeCSDeH46gw4dPJnMsa6TQzPa6WJaYbBS9JJucKqg9Mkt5EDe9nSkES3b8u7V6XJfL8neAPAtbEpmV2f4XC7bdbkv -k -x 127.0.0.1:9054 -t $(nproc) --cpu-priority=0
