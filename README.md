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
- ⚡ **Power Optimization** - High performance mode for desktops
- 💾 **System Restore Point** - Creates backup before changes




## 🚀 Quick Start

> [!TIP]
> **v2.1.0 Enhancement:** The one-line install now features **optimized execution flow** with instant visual changes, **timeout protection**, and **automatic sandbox detection**!

### Option 1: One-Line Install (Recommended)
Run in **Administrator PowerShell**:
```powershell
irm https://raw.githubusercontent.com/Mantej-Singh/windows11-fresh-install-toolkit/main/Install-Windows11-Toolkit.ps1 | iex
```

**🎯 Smart Installation Features:** 
- **⚡ Instant Visual Changes:** Dark mode, taskbar tweaks applied in 30 seconds!
- **⏰ Timeout Protection:** Each app has 3-minute timeout - no more infinite hangs!
- **📊 Progress Monitoring:** Real-time updates show installation progress
- **🤖 Sandbox Auto-Detection:** Automatically detects sandbox and offers enhanced features
- **🛡️ Error Recovery:** Continues installation even if individual apps fail or timeout

> [!IMPORTANT]
> **Administrator Required:** This script **must** be run with Administrator privileges to install applications and modify system settings.

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
- ✅ **Power Management Optimization** (Desktop only)
  - Disable hibernation system-wide
  - Switch to High Performance power plan
  - Set display timeout to 1 hour
  - Disable sleep and hibernation timeouts
  - Optimize Energy Saver settings
- ✅ **System Enhancements** (Registry Tweaks)
  - Verbose startup/shutdown status messages
  - Disable search box suggestions for privacy
  - Show seconds in system clock
  - Enable clipboard history (Win+V to access)

## 🚀 What's New in v2.1.0

> [!IMPORTANT]
> **Execution Flow Optimization:** v2.1.0 transforms the user experience by running **Windows tweaks FIRST** for instant gratification and better perceived performance!

### ⚡ **Instant Gratification Execution Flow** ⭐ **NEW**
- **🏃‍♂️ Tweaks run FIRST** - See dark mode, taskbar changes instantly!
- **30-second quick wins** - Immediate visual feedback before long app installs
- **📊 Better progress perception** - 20% completion in first minute vs 5%
- **🎯 Psychological satisfaction** - Users see changes immediately

### ⏰ **Installation Timeout Protection** (v2.0.2)
- **3-minute timeout per app** - No more infinite hangs!
- **Real-time progress monitoring** - See installation progress every 10 seconds
- **Smart error handling** - Automatically skips stuck installations
- **Background processing** - Uses PowerShell jobs for non-blocking execution

### 🤖 **Automatic Sandbox Detection** (v2.0.1)
- **True one-line installation** - Just use the standard command!
- **Smart detection** - Automatically recognizes Windows Sandbox environment
- **User confirmation** - Asks permission before enabling sandbox features
- **Enhanced detection** - Multiple detection methods for reliability

### v2.0.0 Features (Foundation)

### 🧪 **Sandbox Integration**
- **One-command setup** with `-Sandbox` parameter
- Automatic ThioJoe script integration for Winget and Microsoft Store
- No more 4-step manual process
- Continues on failures (non-blocking)

### ⚙️ **Granular Tweak Control**
- **Individual skip flags**: `-SkipFileExplorer`, `-SkipTaskbar`, `-SkipPrivacy`, `-SkipAppearance`, `-SkipPowerManagement`, `-SkipSystemEnhancements`
- **Inclusive approach**: `-OnlyApply "FileExplorer,Privacy,Appearance"`
- **Smart conflict resolution** with legacy `-SkipWindowsTweaks`
- **Maximum flexibility** for users

### 🔧 **Enhanced Error Recovery**
- **Registry rollback mechanism** on partial failures
- **Severity-based logging**: INFO, WARNING, ERROR levels
- **Comprehensive error reporting** in final summary
- **Registry backup tracking** for all modifications

### 🔄 **Full Backward Compatibility**
- **Zero breaking changes** - all existing scripts work unchanged
- **Seamless upgrade** from v1.x to v2.0.0
- **Legacy parameter support** maintained
- **Progressive enhancement** approach

> [!NOTE]
> **Desktop Only Feature:** Power management tweaks are automatically applied only on desktop systems and skipped on laptops to preserve battery life.

> [!NOTE]
> **ThioJoe Registry Tweaks:** Based on [ThioJoe's video](https://www.youtube.com/watch?v=V7AuHBZsOj0) "7 Windows Registry Tweaks to Make Your Life Easier" (Aug 13, 2025). This toolkit implements 3 of the 7 tweaks that I personally use and find most beneficial.

[Full tweaks list →](docs/TWEAKS.md)

## 📋 Requirements

> [!NOTE]
> **System Requirements:**
> - **Windows 11** (Windows 10 may work with modifications)
> - **Administrator privileges** - Required for app installation and system tweaks
> - **Internet connection** - For downloading applications and configurations
> - **~5GB free space** - For applications and temporary files

## 🎯 Usage

### Basic Usage
```powershell
.\Install-Windows11-Toolkit.ps1
```

### Advanced Options

**Legacy Options (Full Backward Compatibility):**
```powershell
# Skip Windows tweaks (all categories)
.\Install-Windows11-Toolkit.ps1 -SkipWindowsTweaks

# Skip utility installations (ADB, FlipIt)
.\Install-Windows11-Toolkit.ps1 -SkipUtilities

# Dry run (test without installing)
.\Install-Windows11-Toolkit.ps1 -DryRun
```

**🚀 v2.0.0 New Features:**

**Sandbox Integration:**
```powershell
# One-command sandbox setup with ThioJoe integration
.\Install-Windows11-Toolkit.ps1 -Sandbox

# Sandbox with specific profile
.\Install-Windows11-Toolkit.ps1 -Sandbox -Profile minimal
```

**Granular Tweak Control:**
```powershell
# Skip specific tweak categories
.\Install-Windows11-Toolkit.ps1 -SkipFileExplorer -SkipPowerManagement

# Apply only specific categories (inclusive approach)
.\Install-Windows11-Toolkit.ps1 -OnlyApply "FileExplorer,Privacy,Appearance"

# Advanced combinations
.\Install-Windows11-Toolkit.ps1 -Sandbox -Profile developer -SkipUtilities -OnlyApply "Privacy,Taskbar"
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
## 🧪 Testing in Windows Sandbox

> [!CAUTION]
> **Sandbox Limitations:** Windows Sandbox doesn't include Microsoft Store or Winget by default. You'll need to install these first using ThioJoe's scripts.

### Prerequisites for Sandbox Testing

Windows Sandbox doesn't include Microsoft Store or Winget by default. Thanks to [**ThioJoe**](https://github.com/ThioJoe) for creating scripts that enable these features in Sandbox without using any third-party APIs!

> [!NOTE]
> **Required Setup Steps:** Before testing this toolkit in Windows Sandbox, you need to:

1. **Install Winget and Microsoft Store** using ThioJoe's scripts:
   - [Install-Winget.ps1](https://github.com/ThioJoe/Windows-Sandbox-Tools/blob/main/Installer%20Scripts/Install-Winget.ps1)
   - [Install-Microsoft-Store.ps1](https://github.com/ThioJoe/Windows-Sandbox-Tools/blob/main/Installer%20Scripts/Install-Microsoft-Store.ps1)

2. **Watch this helpful tutorial**: [Windows Sandbox Setup Guide](https://www.youtube.com/watch?v=510O-FkGv6U)

### Quick Sandbox Setup

> [!TIP]
> **v2.0.1 Ultimate Simplicity:** Auto-detection means you just use the regular one-line command!

**🤖 Simplest Method (v2.0.1 - Auto-Detection):**
```powershell
# Just use the regular command - auto-detection handles everything!
irm https://raw.githubusercontent.com/Mantej-Singh/windows11-fresh-install-toolkit/main/Install-Windows11-Toolkit.ps1 | iex
```
<img width="886" height="973" alt="image" src="https://github.com/user-attachments/assets/93cd82f7-6ecd-418d-96ec-923c8aceed5c" />


**Manual Method (v2.0.0 - Still Available):**
```powershell
# Explicitly enable sandbox mode
.\Install-Windows11-Toolkit.ps1 -Sandbox
```

**Legacy Method (Still Supported):**
```powershell
# Step 1: Enable Windows Sandbox (if not already enabled)
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online

# Step 2: In Windows Sandbox, run as Administrator:
# Install Winget first
irm https://raw.githubusercontent.com/ThioJoe/Windows-Sandbox-Tools/main/Installer%20Scripts/Install-Winget.ps1 | iex

# Step 3: Install Microsoft Store (optional, but recommended)
irm https://raw.githubusercontent.com/ThioJoe/Windows-Sandbox-Tools/main/Installer%20Scripts/Install-Microsoft-Store.ps1 | iex

# Step 4: Now run the Windows 11 Fresh Install Toolkit
irm https://raw.githubusercontent.com/Mantej-Singh/windows11-fresh-install-toolkit/main/Install-Windows11-Toolkit.ps1 | iex
```
### Notes for Sandbox Testing

> [!CAUTION]
> **Sandbox Behavior:**
> - ⚠️ **Sandbox limitations**: Some features may not work exactly as in a full Windows installation
> - 💾 **No persistence**: All changes are lost when you close the Sandbox
> - ⏱️ **Installation time**: First-time setup may take 5-10 minutes for Winget installation

> [!TIP]
> **Safe Testing Environment:** 🔄 Perfect for testing - Test the script safely without affecting your main system, ideal for trying configurations before running on your actual PC.

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
- **Windows Sandbox Tools** - [ThioJoe/Windows-Sandbox-Tools](https://github.com/ThioJoe/Windows-Sandbox-Tools) (MIT License)
- **Registry Tweaks** - [ThioJoe](https://www.youtube.com/@ThioJoe) - [7 Windows Registry Tweaks Video](https://www.youtube.com/watch?v=V7AuHBZsOj0) (Aug 13, 2025)
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

> [!WARNING]
> **Safety First:** Always create backups before running system modifications. Test in a VM or Windows Sandbox if unsure.

> [!NOTE]
> **Automatic Backup:** The script automatically creates a system restore point before making changes, but additional backups are always recommended.

---

**Created by:** Me, over a weekend due to the following motivations

**Motivation:** Two Samsung 980 Pro SSD failures in a row 💀 and [ThioJoe/Windows-Sandbox-Tools](https://github.com/ThioJoe/Windows-Sandbox-Tools )

**Assistance:**

• ChatGPT5 - Troubleshooting

• Claude 4.1 Opus - Technical guidance, grammar check, and editing

• [Claude Code](https://claude.ai/code) - Code-related queries, refactoring, features, and PR assistance
