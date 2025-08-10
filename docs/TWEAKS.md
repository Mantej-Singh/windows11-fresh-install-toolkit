# ⚙️ Windows Tweaks Documentation

This document details all Windows 11 configuration changes made by the toolkit.

## Table of Contents
- [Overview](#overview)
- [File Explorer Settings](#file-explorer-settings)
- [Taskbar Configuration](#taskbar-configuration)
- [Privacy Settings](#privacy-settings)
- [Appearance Settings](#appearance-settings)
- [Registry Changes](#registry-changes)
- [How to Revert](#how-to-revert)
- [Manual Tweaks](#manual-tweaks)

---

## Overview

The toolkit applies carefully selected Windows 11 tweaks to improve productivity, privacy, and user experience. All changes are:
- ✅ **Reversible** - Can be undone manually
- ✅ **User-specific** - Applied to current user only (except Cortana)
- ✅ **Safe** - No system file modifications
- ✅ **Documented** - Every change is logged

---

## File Explorer Settings

### Open to This PC
- **Default**: Opens to Quick Access
- **Modified**: Opens to This PC
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced`
- **Key**: `LaunchTo = 1`
- **Benefit**: Direct access to drives and system folders

### Show File Extensions
- **Default**: Hidden for known file types
- **Modified**: Always visible
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced`
- **Key**: `HideFileExt = 0`
- **Benefit**: Identify file types, avoid malware disguised as documents

### Show Hidden Files
- **Default**: Hidden files not visible
- **Modified**: Hidden files visible (semi-transparent)
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced`
- **Key**: `Hidden = 1`
- **Benefit**: Access to app data, configuration files

### Show Protected System Files
- **Default**: System files hidden
- **Modified**: System files visible
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced`
- **Key**: `ShowSuperHidden = 1`
- **Benefit**: Full system visibility for power users

### Show Drive Letters First
- **Default**: Drive letters after labels
- **Modified**: Drive letters shown first
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer`
- **Key**: `ShowDriveLettersFirst = 4`
- **Benefit**: Easier drive identification

### Show Encrypted/Compressed Files in Color
- **Default**: No color differentiation
- **Modified**: Blue for compressed, green for encrypted
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced`
- **Key**: `ShowEncryptCompressedColor = 1`
- **Benefit**: Visual identification of file states

### Disable Recent Files in Quick Access
- **Default**: Shows recent files
- **Modified**: Recent files hidden
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer`
- **Key**: `ShowRecent = 0`
- **Benefit**: Privacy, cleaner Quick Access

### Disable Frequent Folders in Quick Access
- **Default**: Shows frequently used folders
- **Modified**: Frequent folders hidden
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer`
- **Key**: `ShowFrequent = 0`
- **Benefit**: Privacy, manual Quick Access control

---

## Taskbar Configuration

### Remove Search Box
- **Default**: Large search box on taskbar
- **Modified**: Search removed (Win+S still works)
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Search`
- **Key**: `SearchboxTaskbarMode = 0`
- **Values**:
  - `0` = Hidden
  - `1` = Show icon only
  - `2` = Show search box

### Remove Widgets Button
- **Default**: Weather/news widgets button
- **Modified**: Widgets button hidden
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced`
- **Key**: `TaskbarDa = 0`
- **Benefit**: Cleaner taskbar, no distractions

### Remove Chat Button
- **Default**: Teams Chat integration
- **Modified**: Chat button hidden
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced`
- **Key**: `TaskbarMn = 0`
- **Benefit**: Remove unused feature

### Enable End Task in Context Menu
- **Default**: Not available
- **Modified**: Right-click shows "End Task"
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings`
- **Key**: `TaskbarEndTask = 1`
- **Benefit**: Quick process termination without Task Manager

### Taskbar Alignment (Not Modified)
- **Default**: Center aligned (Windows 11 style)
- **Note**: Script preserves user preference
- **To Change**: `TaskbarAl = 0` for left alignment

---

## Privacy Settings

### Disable Cortana
- **Default**: Cortana enabled
- **Modified**: Cortana completely disabled
- **Registry**: `HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search`
- **Key**: `AllowCortana = 0`
- **Scope**: System-wide (requires admin)
- **Benefit**: Privacy, resource savings

### Disable Web Search in Start Menu
- **Default**: Shows web results
- **Modified**: Local results only
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Search`
- **Keys**:
  - `BingSearchEnabled = 0`
  - `CortanaConsent = 0`
- **Benefit**: Faster search, privacy

---

## Appearance Settings

### Enable Dark Mode (System)
- **Default**: Light theme
- **Modified**: Dark theme for Windows
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize`
- **Key**: `SystemUsesLightTheme = 0`
- **Affects**: Taskbar, Start Menu, Action Center

### Enable Dark Mode (Apps)
- **Default**: Light theme
- **Modified**: Dark theme for apps
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize`
- **Key**: `AppsUseLightTheme = 0`
- **Affects**: Settings, File Explorer, supported apps

---

## Registry Changes

### Summary of All Registry Modifications

| Component | Registry Path | Key | Value | Type |
|-----------|--------------|-----|-------|------|
| **File Explorer** |
| Launch to This PC | `HKCU:\...\Explorer\Advanced` | `LaunchTo` | `1` | DWORD |
| Show extensions | `HKCU:\...\Explorer\Advanced` | `HideFileExt` | `0` | DWORD |
| Show hidden files | `HKCU:\...\Explorer\Advanced` | `Hidden` | `1` | DWORD |
| Show system files | `HKCU:\...\Explorer\Advanced` | `ShowSuperHidden` | `1` | DWORD |
| **Taskbar** |
| Remove search | `HKCU:\...\Search` | `SearchboxTaskbarMode` | `0` | DWORD |
| Remove widgets | `HKCU:\...\Explorer\Advanced` | `TaskbarDa` | `0` | DWORD |
| Remove chat | `HKCU:\...\Explorer\Advanced` | `TaskbarMn` | `0` | DWORD |
| End task menu | `HKCU:\...\TaskbarDeveloperSettings` | `TaskbarEndTask` | `1` | DWORD |
| **Privacy** |
| Disable Cortana | `HKLM:\...\Windows Search` | `AllowCortana` | `0` | DWORD |
| No Bing search | `HKCU:\...\Search` | `BingSearchEnabled` | `0` | DWORD |
| **Appearance** |
| Dark mode system | `HKCU:\...\Themes\Personalize` | `SystemUsesLightTheme` | `0` | DWORD |
| Dark mode apps | `HKCU:\...\Themes\Personalize` | `AppsUseLightTheme` | `0` | DWORD |

---

## How to Revert

### Revert All Changes
1. Use System Restore Point (created before changes)
2. Or run these PowerShell commands:

```powershell
# Revert File Explorer
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 2
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 2
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 0

# Revert Taskbar
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 2
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Value 1

# Revert Dark Mode
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 1

# Restart Explorer
Stop-Process -Name explorer -Force
```

### Revert Specific Changes
Each setting can be reverted individually by changing the registry value back to its default (shown in each section above).

---

## Manual Tweaks

Additional tweaks you might want to apply manually:

### Performance
```powershell
# Disable animations (faster UI)
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0

# Disable transparency
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0
```

### Privacy
```powershell
# Disable telemetry
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0

# Disable activity history
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0
```

### Taskbar
```powershell
# Move taskbar to left (Windows 10 style)
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 0

# Show seconds in clock
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSecondsInSystemClock" -Value 1
```

---

## Safety Notes

- ✅ All changes are logged in the installation log file
- ✅ System Restore Point created before changes
- ✅ No system files are modified
- ✅ All changes can be reverted
- ⚠️ Some changes require Explorer restart (done automatically)
- ⚠️ Full effect may require system restart

---

## Troubleshooting

### Changes not visible
- Restart Windows Explorer or reboot system
- Check if running as Administrator (required for some settings)

### Want different settings
- Fork the repository
- Modify `configs/apps-default.json`
- Adjust the `windowsTweaks` section

### Settings reset after Windows Update
- Re-run the script with `-SkipApps` flag
- Only Windows tweaks will be reapplied

---

*Last Updated: August-10-2025*
