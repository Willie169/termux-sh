# termux-sh

This repository contains setup Shell scripts and related files for automating the configuration of Termux, a terminal emulator for Android. The scripts facilitate the installation of essential tools, environment configurations, proot distributions, QEMU virtual machines, and related setups.

---

## Main Setup Workflow

### Prerequisites

- Approximately 28GB of storage space.
- Stable internet connection for packages and scripts download and setup.

### Process completed (signal 9) - press Enter Error

You may encounter the `Process completed (signal 9) - press Enter` Error during the main setup workflow or when using Termux, especially when running VMs.

To prevent it from occuring, please read [my tutorial "Android Non Root" about it](https://willie169.github.io/#process-completed-signal-9---press-enter-error) for the fixes. 

If you want to use the ADB command line fix, i.e. `Fix for QEMs like OneUI, MiUi, Samsung, etc. and other non-stock Android 12L and beyond` in the tutorial, but don't know how to connect to ADB or want to connect to your Android device's ADB without another device, please read [another section of my tutorial about Shizuku](https://willie169.github.io/#shizuku-systemui-tuner-and-ashell-use-local-adb-of-android-device-on-terminals-such-as-termux-without-another-device-with-shizuku-leave-developer-options-off-when-doing-so-with-systemui-tuner-and-use-adb-with-features-like-autocomplete-suggestion-with-ashell). 

### Main Script

Copy and run the following script to initialize Termux with predefined settings:
```
termux-setup-storage
termux-change-repo
pkg update && pkg install git -y
cd ~ && git clone https://github.com/Willie169/termux-sh.git
bash ~/termux-sh/termux-setup-all.sh
``` 

This script invokes the main setup script: **[termux-setup-all.sh](termux-setup-all.sh)**, which calls scripts to install essential packages, configures shortcuts, and sets up proot environments.

Follow the screen guide to complete it. If you see "termux-setup-all.sh finished" on screen, pull down the notification bar, and tap `exit` on the notification of Termux. Now, you can restart Termux and enjoy it.

### Key features

1. **Package installation**: Installs tools for development, runtime environments, and utilities for C/C++, Python, Java, Node.js, Rust, Go, Ruby, Perl, QEMU, proot, GitHub, GitLab, SSL, SSH, JQ, FFMPEG, Maven, Termux-X11, TigerVNC, XFCE4, and more.
2. **Shortcut configuration**: Copies shortcuts from **[DOTshortcuts](DOTshortcuts)** into `.shortcuts` and the home directory (`~`) and appends the [DOTbashrc](DOTbashrc) to `~/.bashrc`.
2. **Termux property adjustments**: Enables external app access via `termux.properties`.
2. **Termux proot environment**: Installs [Yonle's termux-proot](https://github.com/Yonle/termux-proot) with [termux-proot.sh](DOTshortcuts/termux-proot.sh).
2. **Audio setup**: Configures audio output using [Andronix](https://andronix.app)'s `setup-audio.sh`.
2. **Fabric installation**: Installs [fabric](https://github.com/danielmiessler/fabric), a modular AI framework.
2. **Node.js library installation**: Installs `node-html-markdown`, `showdown`, and `jsdom`.
2. **Font setup**: Downloads [msyh.ttc](https://github.com/zanjie1999/windows-fonts/raw/wine/msyh.ttc) as `~/.termux/font.ttc`.
2. **Andronix Debian environments**: Creates three Debian Buster ARM64 proot environments (`~/debian1`, `~/debian2`, and `~/debian3`) with respective scripts from [Andronix](https://github.com/AndronixApp/AndronixOrigin).
2. **Proot-distro Debian environments**: Configures two Debian Bookworm ARM64 instances with default alias `debian` and overridden alias `debianbox` respectively.
2. **Proot-distro Ubuntu environments**: Configures an Ubuntu 24.04 ARM64 instance with default alias `ubuntu`.
2. **Environments setup scripts**: Executes specific configuration scripts for each proot or proot-distro instance.

---

## Shortcuts

All shortcuts are located in **[DOTshortcuts](DOTshortcuts)**, except for **[DOTbashrc](DOTbashrc)**, which is in the repository's root directory. Some of them are for things not installed or configured in the [Main Setup Workflow](#main-setup-workflow).

### Boot VM Scripts

- [debian1.sh](DOTshortcuts/debian1.sh), [debian2.sh](DOTshortcuts/debian2.sh), [debian3.sh](DOTshortcuts/debian3.sh): Boot respective Debian Buster ARM64 proots.
- [proot-debian.sh](DOTshortcuts/proot-debian.sh), [proot-debianbox.sh](DOTshortcuts/proot-debianbox.sh): Boot respective Debian Bookworm ARM64 proot-distros with `isolated` and `fix-low-ports` options.
- [kali.sh](DOTshortcuts/kali.sh): Boot the Kali Nethunter proot-distro with alias `kali-default` as user `kali`.
- [termux-proot.sh](DOTshortcuts/termux-proot.sh): Boot the Termux proot.
- [qemu-cli.sh](DOTshortcuts/qemu-cli.sh): Start a headless QEMU VM running Debian Bookworm AMD64, with 2GB RAM and SSH port forwarding (host: 2222 → guest: 22).
- [qemu-gui.sh](DOTshortcuts/qemu-gui.sh): Start a QEMU VM with GUI support via VNC, using the same Debian Bookworm image and configuration as [qemu-cli.sh](DOTshortcuts/qemu-cli.sh).

### Utility Scripts

- [gitPull.sh](DOTshortcuts/gitPull.sh): `git pull` all repositories in `~/gh`.
- [code.sh](DOTshortcuts/code.sh), [download.sh](DOTshortcuts/download.sh): `cd /storage/emulated/0/Documents/code` and `cd /storage/emulated/0/Download` respectively.
- [xmrig.sh](DOTshortcuts/xmrig.sh): Mine XMR to [the repository owner](https://github.com/Willie169)'s wallet, `48j6iQDeCSDeH46gw4dPJnMsa6TQzPa6WJaYbBS9JJucKqg9Mkt5EDe9nSkES3b8u7V6XJfL8neAPAtbEpmV2f4XC7bdbkv`, using [xmrig](https://github.com/xmrig/xmrig), which is not installed in the [main setup workflow](#main-setup-workflow) and can be installed with [xmrig-install.sh](xmrig-install.sh). Change the wallet and other configurations if you need.
- [shizuku.sh](DOTshortcuts/shizuku.sh): `cd shizuku` and `sh rish`. This is a shortcuts for [Shizuku](https://github.com/RikkaApps/Shizuku), which is not configured in the scripts in this repository.
- [termux-backup-bz2.sh](DOTshortcuts/termux-backup-bz2.sh): Creates a compressed backup with the highest compression level of BZIP2 of the Termux home and user directories, then splits the resulting archive into smaller parts, each 4000MB in size.

### [DOTbashrc](DOTbashrc)

Customized `.bashrc` for Termux with pre-defined aliases, functions, and environment variables. 

---

## Setup Scripts

These scripts are parts of [Main Setup Workflow](#main-setup-workflow).

- **[debian1-setup.sh](debian1-setup.sh)**: Installs `texlive-full` for LaTeX typesetting in the `debian1` proot.
- **[debian2-setup.sh](debian2-setup.sh)**: Installs developer tools for the `debian2` proot, including development tools, runtime environments, and utilities for C/C++, Python3, Java 11, Node.js, Go, Ruby, Perl, GitHub, SSL, SSH, JQ, Maven, NumPy SymPy Matplotlib, Selenium, Jupyter Notebook, Pandas, Meson, Ninja, and more.
- **[debian-xfce-mod.sh](debian-xfce-mod.sh)**: Modified version of [Andronix's debian-xfce.sh](https://github.com/AndronixApp/AndronixOrigin/blob/master/Installer%2FDebian%2Fdebian-xfce.sh). Install and configures Debian Buster ARM64 proot with XFCE GUI support and related tools.
- **[ubuntu-24-04.sh](ubuntu-24-04.sh)**: Installs developer tools for Ubuntu 24.04 VMs, including development tools, runtime environments, and utilities for C/C++, Python3, Java 17, Node.js, Rust, Go, Ruby, Perl, GitHub, SSL, SSH, JQ, Maven, NumPy SymPy Matplotlib, Selenium, Jupyter Notebook, Pandas, Meson, Ninja, and more. The [termux-setup-all.sh](termux-setup-all.sh) sets up this for the proot-distro Ubuntu 24.04 environment with the default alias `ubuntu`.
- **[debian-bookworm.sh](debian-bookworm.sh)**: Installs developer tools for Debian Bookworm VMs, including development tools, runtime environments, and utilities for C/C++, Python3, Java 17, Node.js, Rust, Go, Ruby, Perl, GitHub, SSL, SSH, Maven, NumPy SymPy Matplotlib, Selenium, Jupyter Notebook, Pandas, Meson, Ninja, and more. It is compatible with both QEMU and Proot setups, but the [termux-setup-all.sh](termux-setup-all.sh) only sets up this for the proot-distro Debian Bookworm environment with the default alias `debian`.
- **[proot-install-debianbox.sh](proot-install-debianbox.sh)**: Installs a proot-distro Debian Bookworm ARM64 environment with an overriden alias `debianbox`.
- **[box64-wine64-winetricks.sh](box64-wine64-winetricks.sh)**: Installs `box64`, `wine64`, and `winetricks` for running x86_64 Linux and Windows applications on ARM64 Linux. Invoked by [termux-setup-all.sh](termux-setup-all.sh) to install them on the proot-distro Debian Bookworm environment with the overridden alias `debianbox`.

---

## Additional Scripts and Instructions

These scripts are not called by Main Setup Workflow. Run it separately if you need it.

- **[qemu-download.sh](qemu-download.sh)**: Fetches the QEMU Debian Bookworm AMD64 image.
- **[qemu-resize.md](qemu-resize.md)**: Provides instructions and scripts for resizing QEMU virtual disk images. 
- **[xmrig-install.sh](xmrig-install.sh)**: Clone and compile [xmrig](https://github.com/xmrig/xmrig), an open source Monero (XMR) miner.
- **[proot-install-nethunter.sh](proot-install-nethunter.sh)**: Installs the Kali Nethunter ARM64 proot-distro from [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter). Follow the screen guide and enter Build ID (e.g. `KBDEXKMTE` for everything, which occupies about 34GB, and `KBDEXKMTD` for default, which occupies about 13GB). The script will add a user named `kali` alongside with `root`. Boot it with `<build id> [ USER ]` or `proot-distro login <build id> [ USER ]`. Open GUI after logged in with `sudo kgui`. Read [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter) for more information.

---

## TODO

- Transit to config.json to make this project more customizable.
- Make scripts more modular, e.g. [debian-xfce-mod.sh](debian-xfce-mod.sh). 
- Add Docker script support.
- Add more supported VMs and tools.

---

## References

- [https://andronix.app](https://andronix.app).
- [https://github.com/AndronixApp/AndronixOrigin](https://github.com/AndronixApp/AndronixOrigin).
- [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter).
- [https://github.com/termux/proot-distro](https://github.com/termux/proot-distro).
- [https://github.com/termux/termux-app](https://github.com/termux/termux-app).
- [https://github.com/willie169/Android-Non-Root](https://github.com/willie169/Android-Non-Root).
- [https://github.com/zanjie1999/windows-fonts](https://github.com/zanjie1999/windows-fonts).
- [https://ivonblog.com](https://ivonblog.com).
- [https://ryanfortner.github.io](https://ryanfortner.github.io).
- [https://wiki.termux.com](https://wiki.termux.com).
- [https://willie169.github.io](https://willie169.github.io).
- [https://www.qemu.org](https://www.qemu.org).
