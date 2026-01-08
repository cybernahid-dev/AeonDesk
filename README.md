# 🌌 AeonDesk: Zero-Touch Linux Desktop on Android

[![Release](https://img.shields.io/github/v/release/cybernahid-dev/AeonDesk?style=for-the-badge)](https://github.com/cybernahid-dev/AeonDesk/releases)
[![License](https://img.shields.io/github/license/cybernahid-dev/AeonDesk?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android-green?style=for-the-badge&logo=android)](https://github.com/cybernahid-dev/AeonDesk)

**AeonDesk** is a next-generation Linux environment platform for Android, engineered for developers, cybersecurity researchers, and the **AeonCoreX** internal team. It provides a seamless, "zero-touch" experience to launch a full Linux GUI (XFCE/LXQt) on Android devices without manual terminal configuration or external VNC viewers.

---

## ✨ Key Features

* 🚀 **Instant Launch:** One-click from Android app to Linux Desktop.
* 🛡️ **Root-Aware Intelligence:** Automatically detects device status to switch between **Full Chroot** (Rooted) and **PRoot** (Non-Root) modes.
* 🖥️ **Embedded X11 Surface:** No need for external VNC apps; the GUI is rendered directly within the app shell.
* 📦 **Self-Contained:** Everything needed (rootfs, binaries, and scripts) is managed internally.
* 🔐 **Security Focused:** Designed as a sandboxed environment for penetration testing and secure development.
* 🛠️ **Dev-Ready:** Pre-configured with essential tools like Terminal, Browser, and File Manager.

---

## 🏗️ Architecture

AeonDesk bridges the gap between Android and Linux using a multi-layer stack:

1.  **Frontend:** Flutter-based modern UI with AeonCoreX's futuristic design language.
2.  **Engine:** Integrated `proot` and `chroot` binaries for environment isolation.
3.  **Display:** Embedded X11 server for high-performance low-latency GUI rendering.
4.  **Distribution:** Automated CI/CD via GitHub Actions for building optimized Rootfs images.

---

## 🛠️ Installation & Usage

1.  **Download:** Grab the latest `.apk` from the [Releases](https://github.com/cybernahid-dev/AeonDesk/releases) section.
2.  **Launch:** Open AeonDesk and tap **"Install Environment"**. 
3.  **Wait:** The app will automatically fetch the optimized Kali Linux/Ubuntu rootfs from our servers.
4.  **Desktop:** Once complete, tap **"Launch GUI"** to enter your Linux workspace.

---

## 🎯 Target Audience

* **Red-Teamers:** Run professional security tools on the go.
* **Developers:** Compile and test code in a native Linux environment from a smartphone.
* **Students:** Learn Linux systems and cybersecurity without needing a PC.

---

## 📜 Disclaimer

**AeonDesk** is developed for educational and professional research purposes only. Use of this tool for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state, and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program.

---

## 🤝 Contributing

We welcome contributions from the AeonCoreX team and the community!
- Report bugs via **Issues**.
- Submit features via **Pull Requests**.

## 🛡️ License

Distributed under the **MIT License**. See `LICENSE` for more information.

---
<p align="center">
Developed with ❤️ by <b>AeonCoreX Team</b>
</p>

