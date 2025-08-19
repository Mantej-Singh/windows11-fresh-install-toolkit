# ⚙️ Windows Tweaks Documentation

This document details all Windows 11 configuration changes made by the toolkit.

## Table of Contents
- [Overview](#overview)
- [File Explorer Settings](#file-explorer-settings)
- [Taskbar Configuration](#taskbar-configuration)
- [Privacy Settings](#privacy-settings)
- [Appearance Settings](#appearance-settings)
- [Power Management Settings](#power-management-settings)
- [System Enhancements](#system-enhancements)
- [Registry Changes](#registry-changes)
- [How to Revert](#how-to-revert)
- [Manual Tweaks](#manual-tweaks)

---

## Overview

> [!NOTE]
> **Safety First:** The toolkit applies carefully selected Windows 11 tweaks to improve productivity, privacy, and user experience. All changes are:
> - ✅ **Reversible** - Can be undone manually
> - ✅ **User-specific** - Applied to current user only (except Cortana)
> - ✅ **Safe** - No system file modifications
> - ✅ **Documented** - Every change is logged

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

> [!CAUTION]
> **Advanced Users Only:** Showing system files provides full visibility but can be dangerous for inexperienced users. System files should not be modified or deleted.

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

> [!WARNING]
> **System-Wide Change:** This is the only system-wide modification made by the toolkit. It affects all users and requires Administrator privileges.

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

## Power Management Settings

> [!CAUTION]
> **🖥️ Desktop Systems Only:** These settings are automatically skipped on laptops to preserve battery life. The system automatically detects your hardware type.

### System Type Detection
- **Method**: WMI query for `Win32_SystemEnclosure.ChassisTypes`
- **Desktop Types**: 3, 4, 5, 6, 7, 15, 16 (Tower, Desktop, Mini Tower, etc.)
- **Laptop Types**: 8, 9, 10, 14, 30, 31 (Portable, Laptop, Notebook, etc.)
- **Fallback**: If detection fails, settings are applied anyway

### Disable Hibernation
- **Command**: `powercfg /hibernate off`
- **Effect**: Disables hibernation system-wide and frees up hiberfil.sys disk space
- **Typical Space Saved**: 4-32GB depending on RAM size
- **Revert**: `powercfg /hibernate on`

### High Performance Power Plan
- **Command**: `powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c`
- **Effect**: Switches to Windows built-in High Performance plan
- **Benefits**: Maximum CPU performance, no CPU throttling
- **Trade-off**: Higher power consumption (ideal for desktops)

### Display Timeout (Plugged In)
- **Setting**: 60 minutes
- **Command**: `powercfg /change monitor-timeout-ac 60`
- **Default**: Typically 10-15 minutes
- **Effect**: Screen stays on longer during work sessions

### Sleep Timeout (Plugged In)
- **Setting**: Never (0)
- **Command**: `powercfg /change standby-timeout-ac 0`
- **Default**: Typically 30 minutes
- **Effect**: System never goes to sleep when plugged in
- **Benefits**: No interruption during long tasks, downloads, or builds

### Hibernate Timeout (Plugged In)
- **Setting**: Never (0)
- **Command**: `powercfg /change hibernate-timeout-ac 0`
- **Default**: Typically 3 hours
- **Effect**: System never hibernates automatically

### Energy Saver Configuration
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings`
- **Key**: `ShowBatteryFlyout = 0`
- **Effect**: Optimizes Energy Saver behavior for desktop systems

### Benefits for Desktop Users
- ✅ **Uninterrupted Workflows**: No sleep during long compile/download tasks
- ✅ **Maximum Performance**: CPU runs at full speed
- ✅ **Disk Space**: Hibernation file removed (saves GBs)
- ✅ **Remote Access**: System stays accessible for remote connections
- ✅ **Background Tasks**: Downloads, backups, and scheduled tasks complete

### Laptop Protection
- 🔒 **Automatic Detection**: Skips power tweaks on laptops
- 🔋 **Battery Preservation**: Maintains default power-saving settings
- ⚠️ **Override**: Manual configuration possible if needed

---

## System Enhancements

> [!NOTE]
> **Enhanced User Experience:** These registry modifications improve Windows 11 user experience with better system feedback and cleaner interface elements.

> [!NOTE]
> **Attribution:** Registry keys sourced from ThioJoe - https://www.youtube.com/watch?v=V7AuHBZsOj0

### Verbose Status Messages
- **Default**: Generic "Please wait" messages during startup/shutdown
- **Modified**: Detailed status messages showing actual processes
- **Registry**: `HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`
- **Key**: `VerboseStatus = 1`
- **Scope**: System-wide (affects all users)
- **Benefit**: Better transparency of what Windows is doing during boot/shutdown processes
- **Example**: Shows "Applying user settings" instead of generic loading messages

### Disable Search Box Suggestions
- **Default**: Search suggestions enabled in Windows Search
- **Modified**: Search suggestions disabled
- **Registry**: `HKCU:\Software\Policies\Microsoft\Windows\Explorer`
- **Key**: `DisableSearchBoxSuggestions = 1`
- **Scope**: User-specific
- **Benefit**: Improved privacy and cleaner search experience without web suggestions
- **Note**: Registry path may be created if it doesn't exist

### Show Seconds in System Clock
- **Default**: Taskbar clock shows hours and minutes only
- **Modified**: Taskbar clock displays seconds
- **Registry**: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced`
- **Key**: `ShowSecondsInSystemClock = 1`
- **Scope**: User-specific
- **Benefit**: More precise time display for users who need exact timing
- **Visual Impact**: Clock changes from "10:30 AM" to "10:30:45 AM"

### Enable Clipboard History
- **Default**: Clipboard history disabled (Windows default for privacy)
- **Modified**: Clipboard history enabled for multiple clipboard items
- **Registry**: `HKCU:\Software\Microsoft\Clipboard`
- **Key**: `EnableClipboardHistory = 1`
- **Scope**: User-specific
- **Benefit**: Access multiple clipboard items with Win+V keyboard shortcut
- **Usage**: Press Win+V to open clipboard history panel
- **Capacity**: Stores up to 25 items with 4MB size limit
- **Privacy**: Data stored locally only (no cloud sync by default)
- **Note**: The clipboard isn't a file. Its contents are stored in the computer's memory. To use its contents, simply go to the program you want to use it in, click the place where you want it to be put, and press Ctrl+V (paste). [Learn more](https://learn.microsoft.com/en-us/answers/questions/2771653/where-is-clipboard-file-on-window-10-how-to-access?forum=windows-all&referrer=answers)

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
| **System Enhancements** |
| Verbose status | `HKLM:\...\Policies\System` | `VerboseStatus` | `1` | DWORD |
| No search suggestions | `HKCU:\...\Policies\...\Explorer` | `DisableSearchBoxSuggestions` | `1` | DWORD |
| Show seconds in clock | `HKCU:\...\Explorer\Advanced` | `ShowSecondsInSystemClock` | `1` | DWORD |
| Enable clipboard history | `HKCU:\Software\Microsoft\Clipboard` | `EnableClipboardHistory` | `1` | DWORD |

---

## How to Revert

> [!TIP]
> **Easy Recovery:** The safest way to revert all changes is using the System Restore Point that's automatically created before making any modifications.

### Revert All Changes
1. **Use System Restore Point (Recommended)** - Created before changes
2. Or run these PowerShell commands:

> [!NOTE]
> **Manual Revert Commands:** Run these PowerShell commands as Administrator to manually revert settings:

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

# Revert System Enhancements
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSecondsInSystemClock" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Clipboard" -Name "EnableClipboardHistory" -Value 0

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

# Enable clipboard history (Win+V)
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Clipboard" -Name "EnableClipboardHistory" -Value 1
```

---

## Safety Notes

> [!NOTE]
> **System Safety:**
> - ✅ All changes are logged in the installation log file
> - ✅ System Restore Point created before changes
> - ✅ No system files are modified
> - ✅ All changes can be reverted

> [!CAUTION]
> **Restart Requirements:**
> - ⚠️ Some changes require Explorer restart (done automatically)
> - ⚠️ Full effect may require system restart

---

## Troubleshooting

> [!NOTE]
> **Common Issues:**
> ### Changes not visible
> - Restart Windows Explorer or reboot system
> - Check if running as Administrator (required for some settings)

> [!TIP]
> **Customization:**
> ### Want different settings
> - Fork the repository
> - Modify `configs/apps-default.json`
> - Adjust the `windowsTweaks` section

> [!NOTE]
> **Windows Updates:**
> ### Settings reset after Windows Update
> - Re-run the script with `-SkipApps` flag
> - Only Windows tweaks will be reapplied

---

*Last Updated: August-19-2025*
