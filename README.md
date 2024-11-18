## termux-sh

This repository contains setup bash scripts and related files for automating the configuration of Termux, a terminal emulator for Android. The scripts facilitate the installation of essential tools, environment configurations, proot distributions, QEMU virtual machines, and related setups.

### 1. **[get-started.sh](get-started.sh)**
   - A quick-start script for Termux. Simply copy and execute this script to initialize Termux with basic configurations.  
   - It calls the main setup script: **[termux-setup-all.sh](termux-setup-all.sh)**.

### 2. **[termux-setup-all.sh](termux-setup-all.sh)**
   - A comprehensive Termux setup script that installs essential packages, configures shortcuts, and sets up various environments (except the QEMU image).  
   - **Key actions performed (in order):**
     1. **Install packages**: Includes development tools (e.g., `clang`, `git`, `rust`), runtime environments (e.g., `nodejs`, `openjdk`), and utilities (e.g., `termux-api`, `tmux`, `qemu-utils`).
     2. **Setup Termux shortcuts**: Copies the shortcuts from **[DOTshortcuts](DOTshortcuts)** into `.shortcuts` and the home directory (`~`).
     3. **Configure Termux properties**: Enables external apps access in `termux.properties` and reloads settings.
     4. **Install Termux-X11**: Install the nightly version for GUI support.
     5. **Audio configuration**: Downloads and executes [Andronix](https://andronix.app)'s `setup-audio.sh` to enable audio output.
     6. **Download QEMU image**: Fetches the Debian Bookworm AMD64 image.
     7. **Install Node.js tools**: Installs node-html-markdown, showdown, and jsdom.
     8. **Font setup**: Downloads [msyh.ttc]() for Termux.
     9. **Install Termux proot**: Sets up Termux proot using [Yonle's termux-proot](https://github.com/Yonle/termux-proot).
     10. **Install Andronix Debian environments**: 
         - Creates three Debian Buster ARM64 proot environments (`debian1`, `debian2`, `debian3`).
         - Copies the respective setup scripts: **[debian1-setup.sh](debian1-setup.sh)**, **[debian2-setup.sh](debian2-setup.sh)**, and **[debian3-setup.sh](debian3-setup.sh)** to each proot's root directory.
     11. **Install proot-distro Debian Bookworm environments**:
         - Sets up two ARM64 instances: one with the default alias `debian` and another with a custom alias `debian01`.
     12. **Execute setup scripts**: Runs the specific configuration scripts for each proot or proot-distro instance.

---

## Components of the Repository

### Main Setup Scripts
- **[termux-setup.sh](termux-setup.sh)**:  
  A simplified version of `termux-setup-all.sh` for basic Termux configuration without detailed VM setup.

- **[termux-setup-all.sh](termux-setup-all.sh)**:  
  Configures Termux and installs additional proot and QEMU-based environments with pre-configured setup scripts.

### Proot Setup Scripts
- **[debian1-setup.sh](debian1-setup.sh)**:  
  Installs `texlive-full` for LaTeX typesetting in the `debian1` proot.

- **[debian2-setup.sh](debian2-setup.sh)**:  
  Configures GUI support in the `debian2` proot using XFCE and related tools.

- **[debian3-setup.sh](debian3-setup.sh)**:  
  Installs developer tools for the `debian3` proot, targeting general software development needs.

- **[debian-bookworm.sh](debian-bookworm.sh)**:  
  Installs developer tools in external Debian Bookworm environments, compatible with both QEMU and proot-distro setups.

- **[proot-install-debian01.sh](proot-install-debian01.sh)**:  
  Installs a proot-distro Debian Bookworm ARM64 environment with a custom alias (`debian01`).

- **[box64-wine64-winetricks.sh](box64-wine64-winetricks.sh)**:  
  Installs `box64`, `wine64`, and `winetricks` for running x86_64 Windows applications on ARM64 devices.

### QEMU Setup
- **[qemu-resize.md](qemu-resize.md)**:  
  Provides instructions and scripts for resizing QEMU virtual disk images.

### Additional Scripts

These scripts are not called by main setup script in this repo. Run it separately if you need it.

- **[xmrig-install.sh](xmrig-install.sh)**:  
  Clone and compile xmrig, an open source Monero (XMR) miner.

- **[proot-install-nethunter.sh](proot-install-nethunter.sh)**:  
  Installs the Kali Nethunter ARM64 proot-distro from [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter). Enter Build ID after it, "KBDEXKMTE" for everything. The script will add a user named `kali` alongside with `root`. Boot it with `<build id> [ USER ]` or `proot-distro login <build id> [ USER ]`. Open GUI after logged in with `sudo kgui`.

### Shortcuts

- **[DOTshortcuts](DOTshortcuts)**:  
  - `debian1.sh`, `debian2.sh`, `debian3.sh`: Boot respective Debian Buster ARM64 proots.
  - `debian.sh`, `debian01.sh`: Boot respective Debian Bookworm ARM64 proot-distros.
  - `kali.sh`: Boot Kali Nethunter proot-distro.
  - `termux-proot.sh`: Boot Termux proot.
  - `gitPull.sh`: Update all repositories in `~/gh`.

- **[DOTbashrc](DOTbashrc)**:  
  Customized `.bashrc` for Termux with pre-defined aliases, functions, and environment variables.

---

### References

- [https://andronix.app](https://andronix.app).
- [https://github.com/AndronixApp/AndronixOrigin](https://github.com/AndronixApp/AndronixOrigin).
- [https://github.com/sagar040/proot-distro-nethunter](https://github.com/sagar040/proot-distro-nethunter).
- [https://github.com/termux/termux-app](https://github.com/termux/termux-app).
- [https://ivonblog.com](https://ivonblog.com).
- [https://ryanfortner.github.io](https://ryanfortner.github.io).
- [https://wiki.termux.com](https://wiki.termux.com).
- [https://www.qemu.org](https://www.qemu.org).
