cd ~/gh
for dir in */ ; do
    if [ -d "$dir/.git" ]; then
        cd "$dir" || continue
        git pull
        cd ..
    fi
done
