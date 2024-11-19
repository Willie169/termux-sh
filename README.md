# termux-sh

This repository contains setup Bash scripts and related files for automating the configuration of Termux, a terminal emulator for Android. The scripts facilitate the installation of essential tools, environment configurations, proot distributions, QEMU virtual machines, and related setups.

---

## Main Setup Workflow

The Main Setup Workflow occupies about 21GB storage space.

### **1. Main Setup**

Copy and run:
```
cd ~
termux-setup-storage
termux-change-repo
pkg update && pkg upgrade -y && apt update && apt upgrade -y && pkg install git -y
git clone https://github.com/Willie169/termux-sh.git
chmod +x ~/termux-sh/*.sh
source ~/termux-sh/termux-setup-all.sh
```
to initialize Termux with predefined configurations.

This script invokes the main setup script: **[termux-setup-all.sh](termux-setup-all.sh)**, which installs essential packages, configures shortcuts, and sets up proot environments except debian2.

### **2. Debian1 TexLive Setup:**

Run (in Termux):
```
cp ~/termux-sh/debian1-setup.sh ~/debian1/debian-fs/root && cd ~ && ./debian1.sh
```
And then run (in proot):
```
chmod +x debian1-setup.sh && ./debian1-setup.sh && rm debian1-setup.sh && exit
```

### **3. Debian2 Developer Setup:**

Run (in Termux):
```
cp ~/termux-sh/debian2-setup.sh ~/debian2/debian-fs/root && cd ~ && ./debian2.sh
```
And then run (in proot):
```
chmod +x debian2-setup.sh && ./debian2-setup.sh && rm debian2-setup.sh && exit
```

### **4. Debian3 Installation and GUI Setup:**

1. Run (in Termux):
```
cd ~ && mkdir debian3 && cd debian3 && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian-xfce.sh -O debian-xfce.sh && bash debian-xfce.sh
```
2. Follow the screen guide to configure XFCE4 (in proot). Don't exit the proot after it.
3. And then run (in proot):
```
apt update -y && apt upgrade -y && cat 'alias exit=\'vncserver-stop && trap "exit" INT TERM && exit\'' >> ~/.bashrc && source ~/.bashrc
```

### **Key features:**

1. **Package installation**: Installs tools for development, runtime environments, and utilities for C/C++, Python, Java, Node.js, Rust, Go, Ruby, Perl, QEMU, proot, GitHub, GitLab, SSL, SSH, FFMPEG, Maven, Termux-X11, TigerVNC, XFCE4, and more.
2. **Shortcut configuration**: Copies shortcuts from **[DOTshortcuts](DOTshortcuts)** into `.shortcuts` and the home directory (`~`) and appends the [DOTbashrc](DOTbashrc) to `~/.bashrc`.
2. **Termux property adjustments**: Enables external app access via `termux.properties`.
2. **Termux proot environment**: Installs [Yonle's termux-proot](https://github.com/Yonle/termux-proot) with [termux-proot.sh](DOTshortcuts/termux-proot.sh).
2. **Audio setup**: Configures audio output using [Andronix](https://andronix.app)'s `setup-audio.sh`.
2. **Fabric installation**: Installs [fabric](https://github.com/danielmiessler/fabric), a modular AI framework.
2. **Node.js library installation**: Installs `node-html-markdown`, `showdown`, and `jsdom`.
2. **Font setup**: Downloads [msyh.ttc](https://github.com/zanjie1999/windows-fonts/raw/wine/msyh.ttc).
2. **Andronix Debian environments**: Creates three Debian Buster ARM64 proot environments (`~/debian1`, `~/debian2`, and `~/debian3`) with respective scripts from [Andronix](https://andronix.app).
2. **Proot-distro Debian environments**: Configures two Debian Bookworm ARM64 instances with aliases `debian` and `debianbox`.
2. **Environments setup scripts**: Executes specific configuration scripts for each proot or proot-distro instance.

---

## Shortcuts

All shortcuts are located in **[DOTshortcuts](DOTshortcuts)**, except for **[DOTbashrc](DOTbashrc)**, which is in the repository's root directory.

### Boot VM Scripts

- [debian1.sh](DOTshortcuts/debian1.sh), [debian2.sh](DOTshortcuts/debian2.sh), [debian3.sh](DOTshortcuts/debian3.sh): Boot respective Debian Buster ARM64 proots.
- [proot-debian.sh](DOTshortcuts/proot-debian.sh), [`proot-debianbox.sh`](DOTshortcuts/proot-debianbox.sh): Boot respective Debian Bookworm ARM64 proot-distros with `isolated` and `fix-low-ports` options.
- [kali.sh](DOTshortcuts/kali.sh): Boot the Kali Nethunter `KBDEXKMTE` proot-distro as user `kali`.
- [termux-proot.sh](DOTshortcuts/termux-proot.sh): Boot the Termux proot.
- [qemu-cli.sh](DOTshortcuts/qemu-cli.sh): Start a headless QEMU VM running Debian Bookworm AMD64, with 2GB RAM and SSH port forwarding (host: 2222 → guest: 22).
- [qemu-gui.sh](DOTshortcuts/qemu-gui.sh): Start a QEMU VM with GUI support via VNC, using the same Debian Bookworm image and configuration as [qemu-cli.sh](DOTshortcuts/qemu-cli.sh).

### Utility Scripts

- [gitPull.sh](DOTshortcuts/gitPull.sh): `git pull` all repositories in `~/gh`.
- [code.sh](DOTshortcuts/code.sh), [download.sh](DOTshortcuts/download.sh): `cd /storage/emulated/0/Documents/code` and `cd /storage/emulated/0/Download` respectively.
- [xmrig.sh](DOTshortcuts/xmrig.sh): Mine XMR to a wallet of [**the repository owner**](https://github.com/Willie169) (`48j6iQDeCSDeH46gw4dPJnMsa6TQzPa6WJaYbBS9JJucKqg9Mkt5EDe9nSkES3b8u7V6XJfL8neAPAtbEpmV2f4XC7bdbkv`) using [xmrig](https://github.com/xmrig/xmrig), which is not installed in the [main setup workflow](#main-setup-workflow) and can be installed with [xmrig-install.sh](xmrig-install.sh).
- [shizuku.sh](DOTshortcuts/shizuku.sh): `cd shizuku` and `sh rish`. This is a shortcuts for [Shizuku](https://github.com/RikkaApps/Shizuku), which is not configured in the scripts in this repository.

### [DOTbashrc](DOTbashrc)

Customized `.bashrc` for Termux with pre-defined aliases, functions, and environment variables. Note that some of them are for tools that are not installed or configured in the scripts in this repository such as [ANTLR4](https://github.com/antlr/antlr4) and [Tor](https://www.torproject.org).

---

## Proot Setup Scripts

These scripts are parts of [Main Setup Workflow](#main-setup-workflow).

- **[debian1-setup.sh](debian1-setup.sh)**: Installs `texlive-full` for LaTeX typesetting in the `debian1` proot.
- **[debian2-setup.sh](debian2-setup.sh)**: Installs developer tools for the `debian2` proot, including development tools, runtime environments, and utilities for C/C++, Python3, Java 11, Node.js, Go, Ruby, Perl, GitHub, SSL, SSH, Maven, NumPy SymPy Matplotlib, Selenium, Jupyter Notebook, Pandas, Meson, Ninja, and more.
- **[debian3-setup.sh](debian3-setup.sh)**: Configures GUI support in the `debian3` proot using XFCE and related tools.
- **[debian-bookworm.sh](debian-bookworm.sh)**: Installs developer tools for Debian Bookworm VMs, including development tools, runtime environments, and utilities for C/C++, Python3, Java 17, Node.js, Rust, Go, Ruby, Perl, GitHub, SSL, SSH, Maven, NumPy SymPy Matplotlib, Selenium, Jupyter Notebook, Pandas, Meson, Ninja, and more. It is compatible with both QEMU and Proot setups, but the [termux-setup-all.sh](termux-setup-all.sh) only sets up this for the proot-distro Debian Bookworm environment with the default alias `debian`.
- **[proot-install-debianbox.sh](proot-install-debianbox.sh)**: Installs a proot-distro Debian Bookworm ARM64 environment with an overriden alias `debianbox`.
- **[box64-wine64-winetricks.sh](box64-wine64-winetricks.sh)**: Installs `box64`, `wine64`, and `winetricks` for running x86_64 Linux and Windows applications on ARM64 Linux. Invoked by [termux-setup-all.sh](termux-setup-all.sh) to install them on the proot-distro Debian Bookworm environment with the overridden alias `debianbox`.

---

## Additional Scripts and Instructions

These scripts are not called by Main Setup Workflow. Run it separately if you need it.

- **[qemu-download.sh](qemu-download.sh)**: Fetches the QEMU Debian Bookworm AMD64 image.
- **[qemu-resize.md](qemu-resize.md)**: Provides instructions and scripts for resizing QEMU virtual disk images. 
- **[xmrig-install.sh](xmrig-install.sh)**: Clone and compile [xmrig](https://github.com/xmrig/xmrig), an open source Monero (XMR) miner.
- **[proot-install-nethunter.sh](proot-install-nethunter.sh)**: Installs the Kali Nethunter ARM64 proot-distro from [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter). Enter Build ID after it, "KBDEXKMTE" for everything. The script will add a user named `kali` alongside with `root`. Boot it with `<build id> [ USER ]` or `proot-distro login <build id> [ USER ]`. Open GUI after logged in with `sudo kgui`.

---

## References

- [https://andronix.app](https://andronix.app).
- [https://github.com/AndronixApp/AndronixOrigin](https://github.com/AndronixApp/AndronixOrigin).
- [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter).
- [https://github.com/termux/termux-app](https://github.com/termux/termux-app).
- [https://github.com/zanjie1999/windows-fonts](https://github.com/zanjie1999/windows-fonts).
- [https://ivonblog.com](https://ivonblog.com).
- [https://ryanfortner.github.io](https://ryanfortner.github.io).
- [https://wiki.termux.com](https://wiki.termux.com).
- [https://www.qemu.org](https://www.qemu.org).
