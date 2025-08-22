# 📦 Applications Documentation

This document provides detailed information about all applications included in the Windows 11 Fresh Install Toolkit.

## Table of Contents
- [Default Profile Apps (19)](#default-profile-apps)
- [Minimal Profile Apps (5)](#minimal-profile-apps)
- [Developer Profile Apps](#developer-profile-apps)
- [Manual Utilities](#manual-utilities)
- [Application Categories](#application-categories)
- [Installation Methods](#installation-methods)

---

## Default Profile Apps

> [!NOTE]
> **Complete Setup:** The default profile includes 19 essential applications for a complete Windows 11 setup. These apps cover communication, productivity, development, and entertainment needs.

### Communication
| Application | Package ID | Description | Size | License |
|------------|------------|-------------|------|---------|
| **Signal** | `OpenWhisperSystems.Signal` | Privacy-focused messaging app with end-to-end encryption | ~150 MB | Open Source |
| **Discord** | `Discord.Discord` | Voice, video, and text chat for communities and friends | ~140 MB | Proprietary |

### Productivity
| Application | Package ID | Description | Size | License |
|------------|------------|-------------|------|---------|
| **Ditto** | `Ditto.Ditto` | Advanced clipboard manager that saves everything you copy | ~15 MB | Open Source |
| **PowerToys** | `Microsoft.PowerToys` | Windows system utilities to maximize productivity | ~200 MB | Open Source |
| **TreeSize Free** | `JAMSoftware.TreeSize.Free` | Disk space analyzer and cleaner | ~30 MB | Freeware |
| **PDFgear** | `PDFgear.PDFgear` | Free PDF reader, editor, and converter | ~150 MB | Freeware |

### Development
| Application | Package ID | Description | Size | License |
|------------|------------|-------------|------|---------|
| **Visual Studio Code** | `Microsoft.VisualStudioCode` | Lightweight but powerful source code editor | ~350 MB | Open Source |
| **Universal ADB Driver** | `ClockworkMod.UniversalADBDriver` | Android Debug Bridge drivers for Windows | ~8 MB | Freeware |

### Media & Entertainment
| Application | Package ID | Description | Size | License |
|------------|------------|-------------|------|---------|
| **VLC Media Player** | `VideoLAN.VLC` | Universal media player supporting all formats | ~150 MB | Open Source |
| **Spotify** | `Spotify.Spotify` | Music streaming service with millions of songs | ~140 MB | Freemium |

### Gaming
| Application | Package ID | Description | Size | License |
|------------|------------|-------------|------|---------|
| **Steam** | `Valve.Steam` | Digital distribution platform for PC gaming | ~2 GB | Proprietary |

### Utilities & Tools
| Application | Package ID | Description | Size | License |
|------------|------------|-------------|------|---------|
| **3RVX** | `MatthewMalensek.3RVX` | Volume on-screen display (OSD) | ~5 MB | Open Source |
| **f.lux** | `flux.flux` | Blue light filter for eye strain reduction | ~1 MB | Freeware |
| **FanControl** | `Rem0o.FanControl` | System fan speed controller with curves | ~10 MB | Open Source |
| **qBittorrent** | `qBittorrent.qBittorrent` | Open-source BitTorrent client | ~100 MB | Open Source |
| **IDM** | `Tonec.InternetDownloadManager` | Download accelerator and manager | ~10 MB | Shareware |

### Cloud & Remote
| Application | Package ID | Description | Size | License |
|------------|------------|-------------|------|---------|
| **Google Drive** | `Google.GoogleDrive` | Cloud storage and file synchronization | ~200 MB | Freemium |
| **Chrome Remote Desktop** | `Google.ChromeRemoteDesktopHost` | Remote desktop access tool | ~50 MB | Freeware |

### Security
| Application | Package ID | Description | Size | License |
|------------|------------|-------------|------|---------|
| **Windscribe VPN** | `Windscribe.Windscribe` | VPN service for privacy and security | ~30 MB | Freemium |

---

## Minimal Profile Apps

> [!TIP]
> **Lightweight Choice:** Essential applications only - perfect for lightweight installations, older hardware, or when you want just the bare essentials.

| Application | Package ID | Why It's Essential |
|------------|------------|-------------------|
| **Visual Studio Code** | `Microsoft.VisualStudioCode` | Universal text editor for any file type |
| **VLC Media Player** | `VideoLAN.VLC` | Plays any media format without codecs |
| **Ditto** | `Ditto.Ditto` | Essential clipboard management |
| **PowerToys** | `Microsoft.PowerToys` | Core Windows enhancements |
| **Google Drive** | `Google.GoogleDrive` | Cloud backup and sync |

---

## Developer Profile Apps

Tools and utilities for software development (coming soon).

| Application | Package ID | Purpose |
|------------|------------|---------|
| **Git** | `Git.Git` | Version control |
| **Node.js** | `OpenJS.NodeJS` | JavaScript runtime |
| **Python** | `Python.Python.3.12` | Programming language |
| **Docker Desktop** | `Docker.DockerDesktop` | Containerization |
| **Windows Terminal** | `Microsoft.WindowsTerminal` | Modern terminal |
| **Postman** | `Postman.Postman` | API testing |
| **GitHub Desktop** | `GitHub.GitHubDesktop` | Git GUI client |

---

## Manual Utilities

> [!NOTE]
> **Special Installation:** These utilities are downloaded and configured outside of winget because they require custom setup or aren't available in the Windows Package Manager.

### ADB Platform Tools
- **Source**: Google Official
- **URL**: https://dl.google.com/android/repository/platform-tools-latest-windows.zip
- **Installation Path**: `C:\Tweeks\Android\platform-tools`
- **Configuration**: Automatically added to System PATH
- **Purpose**: Android debugging, fastboot, device management

> [!CAUTION]
> **Developer Tool:** ADB Platform Tools are primarily for Android developers and power users. They're automatically configured and added to your system PATH for command-line access.
- **Components**:
  - `adb.exe` - Android Debug Bridge
  - `fastboot.exe` - Bootloader interface
  - `dmtracedump.exe` - Trace analysis
  - System libraries and drivers

### FlipIt Screensaver
- **Source**: [phaselden/FlipIt](https://github.com/phaselden/FlipIt)
- **License**: CC0-1.0 (Public Domain)
- **Installation Path**: `C:\Windows\SysWOW64\FlipIt.scr`
- **Configuration Tool**: `C:\Tweeks\FlipIt screensaver\`
- **Features**:
  - Flip clock display
  - Multi-monitor support
  - Customizable colors and size
  - 12/24 hour format
  - No Flash dependency

> [!TIP]
> **Vintage Style:** FlipIt provides a beautiful retro flip-clock screensaver reminiscent of classic digital clocks. Fully customizable and works great on multi-monitor setups.

---

## Application Categories

### 🎯 Essential (Always Recommended)
- Ditto, PowerToys, VS Code, VLC

### 💼 Productivity
- TreeSize Free, PDFgear, Google Drive

### 🎮 Entertainment
- Steam, Spotify, Discord

### 🛠️ Power User
- 3RVX, FanControl, f.lux

### 🔧 Development
- VS Code, ADB Tools, Git (developer profile)

### 🔒 Privacy & Security
- Signal, Windscribe VPN

---

## Installation Methods

### Winget (Windows Package Manager)
- **Used for**: Most applications
- **Advantages**: 
  - Automatic updates
  - Silent installation
  - No manual download needed
  - Version management
- **Command**: `winget install --id <package-id>`

### Direct Download
- **Used for**: ADB Platform Tools, FlipIt
- **Advantages**:
  - Latest version from source
  - Custom installation paths
  - Special configuration needed

### Manual Configuration
- **FlipIt**: Requires screensaver registration
- **ADB**: Requires PATH environment variable

---

## FAQ

### Can I customize which apps to install?
Yes! You can:
1. Use different profiles (minimal, developer)
2. Create your own JSON configuration
3. Fork the repository and modify `apps-default.json`

### Are these apps free?

> [!NOTE]
> **Licensing Overview:** Most apps are free or open source. Some notes:
> - **IDM**: Shareware (trial available)
> - **Windscribe**: Freemium (free tier available)  
> - **Spotify**: Freemium (free with ads)

### How do I update these apps?

> [!TIP]
> **Easy Updates:** Apps installed via winget can be updated with:
> ```powershell
> winget upgrade --all
> ```
> This command updates all installed winget packages to their latest versions.

### Can I add my own apps?
Yes! Create a custom JSON configuration with your preferred apps. See the main README for examples.

### What if an app fails to install?

> [!NOTE]
> **Failure Handling:** The script continues with other apps and provides a summary at the end. You can manually install failed apps using winget or by downloading from the official website. Common causes include network issues or app unavailability.

---

## License Information

| License Type | Applications |
|-------------|-------------|
| **Open Source** | Signal, Ditto, PowerToys, VS Code, VLC, 3RVX, FanControl, qBittorrent |
| **Freeware** | TreeSize Free, PDFgear, f.lux, Chrome Remote Desktop, FlipIt |
| **Proprietary** | Discord, Steam |
| **Freemium** | Spotify, Google Drive, Windscribe |
| **Shareware** | IDM |

---

*Last Updated: August 22, 2025*
