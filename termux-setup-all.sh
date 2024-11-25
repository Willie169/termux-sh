#!/data/data/com.termux/files/usr/bin/bash
pkg update && pkg install curl wget proot tar tmux -y
tmux new-session -d -s 'termux-setup-all'
tmux split-window -h
tmux send-keys -t 0 'bash ~/termux-sh/termux-setup.sh' C-m
tmux send-keys -t 1 'bash ~/termux-sh/debian-xfce-setup.sh' C-m
tmux attach -t 'termux-setup-all'