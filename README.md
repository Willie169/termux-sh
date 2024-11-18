# termux-sh

This repository contains setup Bash scripts and related files for automating the configuration of Termux, a terminal emulator for Android. The scripts facilitate the installation of essential tools, environment configurations, proot distributions, QEMU virtual machines, and related setups.

---

## Main Setup Workflow

### **[get-started.sh](get-started.sh)**
   - A quick-start script for Termux. Copy and execute this script to initialize Termux with predefined configurations.  
   - This script invokes the main setup script: **[termux-setup-all.sh](termux-setup-all.sh)**.

### **[termux-setup-all.sh](termux-setup-all.sh)**
   - A comprehensive setup script that installs essential packages, configures shortcuts, and sets up all supported environments (excluding QEMU).
   - **Key features:**
     1. **Package installation**: Installs tools for development, runtime environments, and utilities for C/C++, Python, Java, Node.js, Rust, Go, Ruby, Perl, QEMU, proot, GitHub, SSL, SSH, FFMPEG, Maven, and more.
     2. **Shortcut configuration**: Copies shortcuts from **[DOTshortcuts](DOTshortcuts)** into `.shortcuts` and the home directory (`~`).
     3. **Termux property adjustments**: Enables external app access via `termux.properties`.
     4. **Termux-X11 installation**: Installs the nightly version of Termux-X11.
     5. **Audio setup**: Configures audio output using [Andronix](https://andronix.app)'s `setup-audio.sh`.
     6. **QEMU image download**: Fetches the Debian Bookworm AMD64 image.
     7. **Fabric installation**: Installs [fabric](https://github.com/danielmiessler/fabric), a modular AI framework.
     8. **Node.js library installation**: Installs `node-html-markdown`, `showdown`, and `jsdom`.
     9. **Font setup**: Downloads [msyh.ttc](https://github.com/zanjie1999/windows-fonts/raw/wine/msyh.ttc).
     10. **Proot setup**: Installs [Yonle's termux-proot](https://github.com/Yonle/termux-proot).
     11. **Andronix Debian environments**: 
         - Creates three Debian Buster ARM64 proot environments (`~/debian1`, `~/debian2`, and `~/debian3`) with respective setup scripts.
     12. **Proot-distro environments**:
         - Configures two Debian Bookworm ARM64 instances with aliases `debian` and `debian01`.
     13. **Environment setup scripts**: Executes specific configuration scripts for each proot or proot-distro instance.

---

## Shortcuts

All shortcuts are located in **[DOTshortcuts](DOTshortcuts)**, except for **[DOTbashrc](DOTbashrc)**, which is in the repository's root directory.

### Boot VM Scripts

- [`debian1.sh`](DOTshortcuts/debian1.sh), [`debian2.sh`](DOTshortcuts/debian2.sh), [`debian3.sh`](DOTshortcuts/debian3.sh): Boot respective Debian Buster ARM64 proots.
- [`proot-debian.sh`](DOTshortcuts/proot-debian.sh), [`proot-debian01.sh`](DOTshortcuts/proot-debian01.sh): Boot Debian Bookworm ARM64 proot-distros with `isolated` and `fix-low-ports` options.
- [`kali.sh`](DOTshortcuts/kali.sh): Boot the Kali Nethunter `KBDEXKMTE` proot-distro as user `kali`.
- [`termux-proot.sh`](DOTshortcuts/termux-proot.sh): Boot the Termux proot.
- [`qemu-cli.sh`](DOTshortcuts/qemu-cli.sh): Start a headless QEMU VM running Debian Bookworm AMD64, with 2GB RAM and SSH port forwarding (host: 2222 → guest: 22).
- [`qemu-gui.sh`](DOTshortcuts/qemu-gui.sh): Start a QEMU VM with GUI support via VNC, using the same Debian Bookworm image and configuration as `qemu-cli.sh`.

### Utility Scripts

- [`gitPull.sh`](DOTshortcuts/gitPull.sh): `git pull` all repositories in `~/gh`.
- [`code.sh`](DOTshortcuts/code.sh), [`download.sh`](DOTshortcuts/download.sh): `cd /storage/emulated/0/Documents/code` and `cd /storage/emulated/0/Download` respectively.
- [`xmrig.sh`](DOTshortcuts/xmrig.sh): Mine XMR to a wallet of [**the repository owner**](https://github.com/Willie169) (`48j6iQDeCSDeH46gw4dPJnMsa6TQzPa6WJaYbBS9JJucKqg9Mkt5EDe9nSkES3b8u7V6XJfL8neAPAtbEpmV2f4XC7bdbkv`) using `xmrig`, which is not installed in the [main setup workflow](#main-setup-workflow) and can be installed with [xmrig-install.sh](xmrig-install.sh).
- [shizuku.sh](DOTshortcuts/shizuku.sh): `cd shizuku` and `sh rish`. This is a shortcuts for [Shizuku](https://github.com/RikkaApps/Shizuku), which is not configured in the scripts in this repository.

### [DOTbashrc](DOTbashrc)

Customized `.bashrc` for Termux with pre-defined aliases, functions, and environment variables. Note that some of them are for tools that are not installed or configured in the scripts in this repository such as [ANTLR4](https://github.com/antlr/antlr4) and [Tor](https://www.torproject.org).

---

## Components of the Repository

Below are the explanation of each components of the repository excluding the shortcuts explained above.

### Main Setup Scripts
- **[termux-setup.sh](termux-setup.sh)**:  
  A simplified version of `termux-setup-all.sh` for Termux configuration and VM installation without VM setup.

- **[termux-setup-all.sh](termux-setup-all.sh)**:  
  Configures Termux and installs additional proot and QEMU-based environments with pre-configured setup scripts.

### Proot Setup Scripts

These scripts are invoked by [termux-setup-all.sh](termux-setup-all.sh).

- **[debian1-setup.sh](debian1-setup.sh)**:  
  Installs `texlive-full` for LaTeX typesetting in the `debian1` proot.

- **[debian2-setup.sh](debian2-setup.sh)**:  
  Configures GUI support in the `debian2` proot using XFCE and related tools.

- **[debian3-setup.sh](debian3-setup.sh)**:  
  Installs developer tools for the `debian3` proot, including development tools, runtime environments, and utilities for C/C++, Python3, Java 11, Node.js, Go, Ruby, Perl, GitHub, SSL, SSH, Maven, NumPy SymPy Matplotlib, Selenium, Jupyter Notebook, Pandas, Meson, Ninja, and more.

- **[debian-bookworm.sh](debian-bookworm.sh)**:  
  Installs developer tools for Debian Bookworm VMs, including development tools, runtime environments, and utilities for C/C++, Python3, Java 17, Node.js, Rust, Go, Ruby, Perl, GitHub, SSL, SSH, Maven, NumPy SymPy Matplotlib, Selenium, Jupyter Notebook, Pandas, Meson, Ninja, and more. It is compatible with both QEMU and Proot setups, but the [termux-setup-all.sh](termux-setup-all.sh) only sets up this for the proot-distro Debian Bookworm environment with the default alias `debian`.

- **[proot-install-debian01.sh](proot-install-debian01.sh)**:  
  Installs a proot-distro Debian Bookworm ARM64 environment with an overriden alias `debian01`.

- **[box64-wine64-winetricks.sh](box64-wine64-winetricks.sh)**:  
  Installs `box64`, `wine64`, and `winetricks` for running x86_64 Linux and Windows applications on ARM64 Linux.

### Additional Scripts and Instructions

These scripts are not called by main setup script in this repo. Run it separately if you need it.

- **[qemu-resize.md](qemu-resize.md)**:  
  Provides instructions and scripts for resizing QEMU virtual disk images.
  
- **[xmrig-install.sh](xmrig-install.sh)**:  
  Clone and compile xmrig, an open source Monero (XMR) miner.

- **[proot-install-nethunter.sh](proot-install-nethunter.sh)**:  
  Installs the Kali Nethunter ARM64 proot-distro from [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter). Enter Build ID after it, "KBDEXKMTE" for everything. The script will add a user named `kali` alongside with `root`. Boot it with `<build id> [ USER ]` or `proot-distro login <build id> [ USER ]`. Open GUI after logged in with `sudo kgui`.

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
