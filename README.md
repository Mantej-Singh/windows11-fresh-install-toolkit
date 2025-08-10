# 🚀 Windows 11 Fresh Install Toolkit
A comprehensive PowerShell automation toolkit for Windows 11 fresh installations. Born from the frustration of repeated SSD failures, this toolkit automatically installs essential applications via winget, configures Windows settings (File Explorer, Taskbar, Dark Mode), sets up development tools (ADB), and applies privacy tweaks. Features one-click installation of 19+ applications including Signal, Discord, VS Code, Steam, and more. Includes system optimizations like showing file extensions, disabling Cortana, and enabling dark mode. Perfect for quickly recovering from hardware failures or setting up new PCs with consistent configurations.

🎯 Use Cases: Fresh Windows installs | SSD failures | New PC setup | System recovery | Consistent multi-PC configuration

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue.svg)](https://github.com/PowerShell/PowerShell)
[![Windows 11](https://img.shields.io/badge/Windows-11-0078D4.svg)](https://www.microsoft.com/windows/windows-11)


## ✨ Features

- 🎯 **One-Click Installation** - Run one script to set up everything
- 📦 **19+ Essential Apps** - Signal, Discord, VS Code, Steam, VLC, and more
- ⚙️ **System Configuration** - File Explorer, Taskbar, Dark Mode
- 🔒 **Privacy Tweaks** - Disable Cortana and telemetry
- 🛠️ **Developer Tools** - ADB setup with PATH configuration
- 💾 **System Restore Point** - Creates backup before changes




## 🚀 Quick Start

### Option 1: One-Line Install (Recommended)
Run in **Administrator PowerShell**:
```powershell
irm https://raw.githubusercontent.com/Mantej-Singh/windows11-fresh-install-toolkit/main/Install-Windows11-Toolkit.ps1 | iex
```

### Option 2: Download and Run
1. Download `Install-Windows11-Toolkit.ps1`
2. Right-click → Run with PowerShell (Admin)

## 📦 Installed Applications

| Category | Applications |
|----------|-------------|
| **Communication** | Signal, Discord |
| **Development** | VS Code, PowerToys, ADB Tools |
| **Productivity** | Ditto, TreeSize Free, IDM |
| **Media** | VLC, Spotify, f.lux |
| **Gaming** | Steam |
| **Utilities** | 7-Zip, FanControl, qBittorrent |
| **Cloud** | Google Drive, Chrome Remote Desktop |
| **Security** | Windscribe VPN |
| **Customization** | 3RVX, FlipIt Screensaver |

[Full application list with details →](docs/APPS.md)

## ⚙️ System Configurations

- ✅ File Explorer opens to "This PC"
- ✅ Show file extensions and hidden files
- ✅ Enable Dark Mode system-wide
- ✅ Remove Search, Widgets, Chat from Taskbar
- ✅ Enable "End Task" in taskbar context menu
- ✅ Disable Cortana and web search
- ✅ Configure ADB Platform Tools PATH

[Full tweaks list →](docs/TWEAKS.md)

## 📋 Requirements

- Windows 11 (Windows 10 may work with modifications)
- Administrator privileges
- Internet connection
- ~5GB free space for applications

## 🎯 Usage

### Basic Usage
```powershell
.\Install-Windows11-Toolkit.ps1
```

### Advanced Options
```powershell
# Skip Windows tweaks
.\Install-Windows11-Toolkit.ps1 -SkipWindowsTweaks

# Skip utility installations (ADB, FlipIt)
.\Install-Windows11-Toolkit.ps1 -SkipUtilities

# Dry run (test without installing)
.\Install-Windows11-Toolkit.ps1 -DryRun
```

### Usage Examples for Users:

```powershell
# See available profiles
.\Install-Windows11-Toolkit.ps1 -ListProfiles

# Use minimal profile (fewer apps)
.\Install-Windows11-Toolkit.ps1 -Profile minimal

# Use developer profile (dev tools)
.\Install-Windows11-Toolkit.ps1 -Profile developer

# Use custom configuration
.\Install-Windows11-Toolkit.ps1 -Profile custom -CustomConfigUrl "https://mysite.com/config.json"
```

## 📦 Windows Sandbox Testing

### Before Installation
<img width="987" height="1375" alt="image" src="https://github.com/user-attachments/assets/df9420b4-809f-4c4e-b2af-635c72bcdda1" />

### After Installation
<img width="993" height="1372" alt="image" src="https://github.com/user-attachments/assets/cd21ed03-bde9-4507-8919-6b68be7fb667" />


## 🗺️ Roadmap

- [x] Custom app profiles (minimal, developer, defualt(My favorites))
- [ ] add winget from [ThioJoe Script](https://github.com/ThioJoe/Windows-Sandbox-Tools/tree/main/Installer%20Scripts)
- [ ] Backup current settings before changes
- [ ] Undo/Rollback functionality  
- [ ] GUI version
- [ ] Windows 10 support
- [ ] Export/Import configurations

## 🙏 Credits & Attribution

- **FlipIt Screensaver** - [phaselden/FlipIt](https://github.com/phaselden/FlipIt) (CC0-1.0 License)
- **ADB Platform Tools** - [Google](https://developer.android.com/tools/releases/platform-tools)
- Inspired by frustration with Samsung 980 Pro SSD failures 😅

## Attribution

### FlipIt Screensaver
- **Original Author:** Phil Haselden (phaselden)
- **Source:** https://github.com/phaselden/FlipIt
- **License:** CC0-1.0 (Public Domain)
- **Version:** 1.3
- **Modifications:** None - Using original release

The FlipIt screensaver is included in this toolkit for user convenience. 
Full credit goes to the original author.

Only change I made to this is, I added my own city, Mumbai 💕


## 📄 License

MIT License - See [LICENSE](LICENSE) file


## Support

- **Issues**: [GitHub Issues](https://github.com/Mantej-Singh/windows11-fresh-install-toolkit/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Mantej-Singh/windows11-fresh-install-toolkit/discussions)

## ⚠️ Disclaimer

Always create backups before running system modifications. Test in a VM if unsure.

---

**Created by:** Mantej Singh Dhanjal 

**Motivation:** Two Samsung 980 Pro SSD failures in a row 💀 and [ThioJoe/Windows-Sandbox-Tools](https://github.com/ThioJoe/Windows-Sandbox-Tools )

**Assistance:** ChatGPT5 for troubleshooting. Claude Opus 4.1 for technical guidance, grammar check, and editing.
