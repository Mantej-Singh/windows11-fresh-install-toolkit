# 📋 Changelog

All notable changes to the Windows 11 Fresh Install Toolkit will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [2.3.0] - 2025-08-22
### 🛡️ **PRIVACY ENHANCEMENT RELEASE**

> [!IMPORTANT]
> **Major Privacy Feature**: v2.3.0 introduces comprehensive telemetry control with 7 registry modifications to disable Windows data collection and enhance user privacy protection!

#### 🛡️ Comprehensive Telemetry Control (NEW)
**New Telemetry Category:**
- **Dedicated telemetry section** - New `telemetry` category in windowsTweaks configuration
- **7 Registry modifications** - Complete coverage of Windows telemetry systems
- **System-wide and user-specific** - Comprehensive privacy protection approach
- **Professional implementation** - Follows established `Invoke-RegistryTweak` architecture
- **Safety first** - Automatic system restore point creation before modifications

**Registry Modifications Applied:**
1. **Core Data Collection** - `HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection\AllowTelemetry = 0`
2. **Diagnostic Data** - `HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection\AllowTelemetry = 0`
3. **CEIP Program** - `HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows\CEIPEnable = 0`
4. **Error Reporting** - `HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting\Disabled = 1`
5. **App Telemetry** - `HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat\AITEnable = 0`
6. **Advertising ID** - `HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo\Enabled = 0`
7. **Feedback Notifications** - `HKCU:\Software\Microsoft\Siuf\Rules\NumberOfSIUFInPeriod = 0`

#### 🎯 Advanced Granular Control (NEW)
**Parameter Enhancements:**
- **New `-SkipTelemetry` parameter** - Individual control over telemetry modifications
- **Enhanced ValidateSet** - Added "Telemetry" to `-OnlyApply` array options
- **Backward compatibility** - All existing usage patterns continue unchanged
- **Intelligent logic** - Updated `Test-TweakShouldApply` function for telemetry category

**Usage Examples:**
```powershell
# Skip telemetry while applying other tweaks
.\Install-Windows11-Toolkit.ps1 -SkipTelemetry

# Apply only telemetry and privacy modifications
.\Install-Windows11-Toolkit.ps1 -OnlyApply "Telemetry,Privacy"

# Complete privacy setup
.\Install-Windows11-Toolkit.ps1 -OnlyApply "Telemetry,Privacy" -SkipApps
```

#### 📚 Comprehensive Documentation (NEW)
**New Documentation:**
- **`/docs/TELEMETRY.md`** - Complete telemetry control guide with detailed explanations
- **Registry reference** - All 7 registry paths with descriptions and purposes
- **Revert procedures** - Complete rollback instructions for all modifications
- **Verification commands** - PowerShell commands to verify telemetry settings
- **Safety guidance** - System restore point usage and enterprise considerations

**Enhanced GitHub Alerts:**
- **Important alerts** - Critical privacy and safety information
- **Warning alerts** - Registry modification warnings and system restore reminders
- **Caution alerts** - Enterprise environment and Group Policy considerations
- **Note alerts** - Technical details and additional information
- **Tip alerts** - Best practices and usage recommendations

#### 🔧 Technical Implementation
**Architecture Enhancements:**
- **JSON configuration** - New `telemetry` section in apps-default.json
- **PowerShell implementation** - Added telemetry control in main script after SystemEnhancements
- **Function updates** - Enhanced `Test-TweakShouldApply` with telemetry category support
- **Parameter validation** - Updated granular control logic to include SkipTelemetry
- **Help system** - Added telemetry examples to script help documentation

**Configuration Schema:**
```json
"telemetry": {
  "enabled": true,
  "settings": {
    "disableDataCollection": true,
    "disableDiagnosticData": true,
    "disableCEIP": true,
    "disableErrorReporting": true,
    "disableAppTelemetry": true,
    "disableAdvertisingId": true,
    "disableFeedbackNotifications": true
  }
}
```

#### 📊 Privacy Impact Analysis
**Data Collection Disabled:**
- **Basic telemetry** - System usage patterns and performance metrics
- **Diagnostic data** - Detailed system diagnostics and error information
- **CEIP participation** - Customer Experience Improvement Program data
- **Error reporting** - Automatic crash and error report transmission
- **App compatibility** - Application usage and compatibility telemetry
- **Advertising targeting** - Personalized advertising identifier system
- **Feedback requests** - Windows feedback notification prompts

> [!WARNING]
> **Enterprise Consideration**: Some telemetry settings may be managed by Group Policy in enterprise environments. Registry changes may not take effect if overridden by organizational policies.

> [!TIP]
> **Recommended Testing**: Use Windows Sandbox to test telemetry modifications: `.\Install-Windows11-Toolkit.ps1 -Sandbox -OnlyApply "Telemetry"`

---

## [2.2.0] - 2025-08-19
### 📱 **NEW APPLICATION & SYSTEM ENHANCEMENT RELEASE**

> [!IMPORTANT]
> **Feature Additions**: v2.2.0 adds Plex Media Server to the default profile and enables clipboard history functionality for enhanced productivity!

#### 🎬 Media Server Addition
**New Application:**
- **Plex Media Server** - Professional media streaming server
- **Category**: Media (alongside VLC Media Player)  
- **Profile**: Default profile only (optional installation)
- **ID**: `Plex.PlexMediaServer`
- **Total Apps**: Now **20+ applications** in default profile

#### 📋 Clipboard History Enhancement  
**New System Configuration:**
- **Enable Clipboard History** - Access multiple clipboard items via Win+V
- **Registry Path**: `HKCU:\Software\Microsoft\Clipboard`
- **Key**: `EnableClipboardHistory = 1` (DWORD)
- **Usage**: Press Win+V to access clipboard history panel
- **Capacity**: Up to 25 items with 4MB size limit
- **Privacy**: Local memory storage only (no cloud sync by default)

#### 📚 Documentation Updates
**Enhanced Documentation:**
- **README.md**: Updated app count to 20+, added Plex to media category
- **TWEAKS.md**: Added comprehensive clipboard history documentation
- **Technical Details**: Registry implementation, usage instructions, revert commands
- **User Education**: Clear explanation of clipboard memory vs. file storage

#### 🔧 Technical Implementation  
**System Enhancements Category:**
- Integrated with existing SystemEnhancements registry tweaks
- Follows established `Invoke-RegistryTweak` pattern
- Maintains architectural consistency with other user-specific tweaks
- Added to apps-default.json configuration with proper categorization

---

## [2.1.0] - 2025-08-16
### ⚡ **EXECUTION FLOW OPTIMIZATION RELEASE**

> [!IMPORTANT]
> **UX Revolution**: v2.1.0 transforms user experience by prioritizing **instant gratification** - Windows tweaks now run FIRST for immediate visual feedback!

#### 🚀 Major Flow Optimization
**Problem Solved:**
- App installations take 3-57 minutes, creating poor user experience
- Users had to wait long periods before seeing any changes
- Progress felt slow with 5% completion in first 5 minutes
- Risk of user abandonment during lengthy app installations

**Solution Implemented:**
- **🏃‍♂️ Windows tweaks now run FIRST** (Section 1 instead of Section 3)
- **⚡ 30-second instant gratification** - users see dark mode, taskbar changes immediately
- **📊 Better progress perception** - 20% completion in first minute
- **🎯 Psychological satisfaction** - immediate visual confirmation script is working

#### New Execution Order
```
v2.0.x Flow (Poor UX):
1. 🔄 Restore Point (30s)
2. 📦 Install 19 Apps (10-45 minutes) ← USERS WAIT FOREVER
3. ⚙️ Windows Tweaks (30s)
4. 🛠️ Utilities (2-5 minutes)

v2.1.0 Flow (Optimized UX):
1. 🔄 Restore Point (30s)
2. ⚙️ Windows Tweaks FIRST (30s) ← INSTANT GRATIFICATION! ⭐
3. 📦 Install 19 Apps (10-45 minutes)
4. 🛠️ Utilities (2-5 minutes)
```

#### User Experience Transformation
**Before v2.1.0:**
```
[Pre-Setup] Creating System Restore Point...
[Step 1] Installing Applications via Winget
  [1/19] Installing Signal... (hangs for minutes)
  [User gets impatient, considers canceling]
```

**After v2.1.0:**
```
[Pre-Setup] Creating System Restore Point...
[Step 1] ⚡ Configuring Windows Settings (Quick Wins!)
  Configuring File Explorer... ✅
  Configuring Taskbar... ✅
  Configuring Appearance... ✅ (Dark mode applied instantly!)
  Configuring Privacy... ✅
[User sees immediate changes, stays engaged]
[Step 2] Installing Applications via Winget...
```

#### Benefits Delivered
- **🎯 Instant Visual Feedback**: Users see dark mode, taskbar changes within 60 seconds
- **📊 Better Progress Perception**: 20% completion shown in first minute vs 5%
- **🔒 Reduced User Abandonment**: Quick wins keep users engaged during long app installs
- **⚡ Psychological Satisfaction**: Immediate confirmation that script is working
- **🛡️ Risk Mitigation**: If app installations fail, users still get system improvements

#### Technical Implementation
- **Section Reordering**: Moved Windows tweaks from Section 3 to Section 1
- **Updated Progress Indicators**: All step numbers updated to reflect new flow
- **Enhanced User Messaging**: Added "Quick Wins!" and lightning bolt indicators
- **Maintained Functionality**: Zero changes to actual tweak functionality

---

## [2.0.2] - 2025-08-16
### ⏰ **INSTALLATION TIMEOUT & PROGRESS RELEASE**

> [!IMPORTANT]
> **Bulletproof Installations**: v2.0.2 eliminates hanging installations with smart timeout protection and real-time progress monitoring!

#### Added
- ⏰ **Installation Timeout Protection**
  - **3-minute timeout per app**: Prevents infinite hangs that require manual intervention
  - **Background job processing**: Uses PowerShell jobs for non-blocking winget execution
  - **Automatic cleanup**: Gracefully stops and removes stuck installation jobs
  - **Smart continuation**: Script automatically proceeds to next app after timeout

- 📊 **Real-Time Progress Monitoring**
  - **Live progress updates**: Shows remaining time every 10 seconds during installation
  - **Installation timing**: Records and displays how long each app took to install
  - **Visual feedback**: Clear progress indicators with countdown timers
  - **Performance metrics**: Comprehensive logging of installation times and timeouts

- 🛡️ **Enhanced Error Handling**
  - **Timeout vs Failure differentiation**: Different messages and colors for different error types
  - **Helpful user guidance**: Suggests manual installation commands for failed apps
  - **Graceful degradation**: Installation continues smoothly even when apps fail or timeout
  - **Comprehensive logging**: Records timeout events and installation performance metrics

#### Technical Implementation
- **New Function**: `Invoke-WingetWithTimeout()` - Handles background installation with timeout monitoring
- **Background Job Management**: Uses PowerShell Start-Job for asynchronous execution
- **Smart Monitoring Loop**: Checks job status every 2 seconds, reports progress every 10 seconds
- **Resource Management**: Proper cleanup of background jobs and processes

#### User Experience Improvements
```
Before v2.0.2:
- Apps could hang indefinitely (manual Ctrl+C required)
- No visibility into installation progress
- Script could get stuck on problematic apps

After v2.0.2:
⏱️ Installing... (120s remaining)
⏱️ Installing... (110s remaining)
✅ Signal installed successfully (completed in 45 seconds)
```

#### Benefits
- **No More Hangs**: Maximum 3 minutes per app before automatic timeout
- **Better User Experience**: Live progress updates eliminate uncertainty
- **Improved Reliability**: Script always completes, even with problematic apps
- **Performance Insights**: Installation timing helps identify slow apps

#### Enhanced Sandbox Detection
- **Multiple Detection Methods**: Uses WDAGUtilityAccount directory, username, and profile checks
- **Robust Fallbacks**: Multiple detection methods ensure reliability across environments
- **Improved Logging**: Detailed detection method logging for troubleshooting

---

## [2.0.1] - 2025-08-16
### 🤖 **SANDBOX AUTO-DETECTION RELEASE**

> [!IMPORTANT]
> **Ultimate User Experience**: v2.0.1 achieves the holy grail of sandbox integration - **true one-line installation** with intelligent auto-detection!

#### Added
- 🤖 **Automatic Sandbox Detection**
  - **Smart Environment Detection**: Automatically recognizes Windows Sandbox environments
  - **User Confirmation Dialog**: Prompts user with clear explanation before enabling sandbox features
  - **True One-Line Experience**: Standard `irm | iex` command now works perfectly in sandbox
  - **Zero Configuration Required**: No parameters needed - just use the regular installation command
  - **Graceful Fallback**: If user declines, continues with standard installation

- 🎯 **Enhanced User Experience**
  - **Clear Confirmation Prompt**: Explains what sandbox mode does before enabling
  - **Visual Feedback**: Shows whether sandbox mode was enabled or declined
  - **Comprehensive Logging**: Logs auto-detection events and user choices
  - **Backward Compatibility**: Manual `-Sandbox` parameter still works as before

#### Technical Implementation
- **New Function**: `Confirm-SandboxMode()` - Provides user-friendly confirmation dialog
- **Auto-Detection Logic**: Checks for sandbox environment early in execution flow
- **Dynamic Parameter Setting**: Sets `$Sandbox = $true` based on user confirmation
- **Enhanced Logging**: Records auto-detection events and user decisions

#### User Experience Flow
```
User runs: irm https://raw.githubusercontent.com/.../Install-Windows11-Toolkit.ps1 | iex

🧪 Windows Sandbox Environment Detected!
   
   This toolkit can automatically configure sandbox prerequisites:
   • Install Winget via ThioJoe's scripts  
   • Install Microsoft Store via ThioJoe's scripts
   • Continue with enhanced sandbox mode
   
   Would you like to enable Sandbox Mode? [Y/N]: Y
   ✅ Sandbox Mode enabled
```

#### Benefits
- **Simplified Installation**: No need to remember special commands for sandbox
- **Reduced User Error**: Eliminates confusion about sandbox-specific parameters  
- **Better Adoption**: Makes sandbox testing more accessible to all users
- **Maintains Choice**: Users can still decline sandbox features if desired

---

## [2.0.0] - 2025-08-15
### 🚀 **MAJOR REFACTORING RELEASE**

> [!IMPORTANT]
> **Breaking Changes**: None! This is a major refactoring with full backward compatibility. All existing scripts and usage patterns continue to work unchanged.

#### Added
- 🧪 **Sandbox Integration** (`-Sandbox` Parameter)
  - One-command sandbox setup replacing 4 separate manual steps
  - Automatic ThioJoe script integration for Winget and Microsoft Store
  - Direct `irm` calls with proper attribution and progress indication
  - Continues execution on script failures (non-blocking approach)
  - Perfect for testing configurations safely before production use

- ⚙️ **Granular Tweak Control System**
  - **Individual Skip Flags**: `-SkipFileExplorer`, `-SkipTaskbar`, `-SkipPrivacy`, `-SkipAppearance`, `-SkipPowerManagement`, `-SkipSystemEnhancements`
  - **Inclusive Array Approach**: `-OnlyApply "FileExplorer,Privacy,Appearance"`
  - **Smart Conflict Resolution**: New granular parameters override legacy `-SkipWindowsTweaks` when both are used
  - **Maximum User Flexibility**: Both approaches available simultaneously

- 🔧 **Enhanced Error Recovery & Logging**
  - **Registry Rollback Mechanism**: Automatic backup and restore on partial failures
  - **Severity-Based Logging**: INFO, WARNING, ERROR levels with color-coded output
  - **Comprehensive Error Reporting**: Detailed summary with component-specific failure tracking
  - **Registry Backup Tracking**: Complete backup of all modified registry values

- 📊 **Advanced Progress & Reporting**
  - **Enhanced Progress Indicators**: ETA calculations and detailed step tracking
  - **Granular Summary Reports**: Shows applied/skipped/failed tweaks by category
  - **Component-Specific Logging**: Separate tracking for Registry, Sandbox, PowerMgmt, etc.
  - **Error Count Tracking**: Statistics for Info/Warning/Error levels

#### Changed
- 🏗️ **Architecture Refactoring**
  - **Helper Functions Extraction**: `Write-Log`, `Invoke-RegistryTweak`, `Test-SandboxEnvironment`, `Install-SandboxPrerequisites`, `New-RestorePointSafely`, `Invoke-TweakRollback`, `Test-TweakShouldApply`
  - **Modular Design**: Each function focused on single responsibility
  - **Enhanced Script Variables**: Added tracking for logs, registry backups, error counts, applied/failed tweaks

- 🎯 **Windows Tweaks Refactoring**
  - All registry modifications now use `Invoke-RegistryTweak` helper function
  - Automatic registry path creation with `-CreatePath` switch
  - Enhanced error handling with detailed component logging
  - Granular control logic integrated into each tweak category

- 📝 **User Interface Enhancements**
  - **Enhanced Banner**: v2.0.0 branding with build date and feature highlights
  - **Detailed Help System**: `-ListProfiles` now shows v2.0.0 features and examples
  - **Color-Coded Feedback**: Improved visual hierarchy with meaningful colors
  - **Progress Transparency**: Clear indication of what will be applied/skipped

#### Technical Details
- **Full Backward Compatibility**: 100% compatible with all existing v1.x usage patterns
- **Zero Breaking Changes**: Legacy parameters and workflows unchanged
- **Progressive Enhancement**: New features don't interfere with existing functionality
- **Robust Error Handling**: Graceful degradation for non-critical failures
- **Memory Efficient**: Optimized variable usage and cleanup procedures
- **Attribution Compliance**: Proper ThioJoe script attribution throughout

#### Usage Examples
```powershell
# Legacy usage (unchanged)
.\Install-Windows11-Toolkit.ps1
.\Install-Windows11-Toolkit.ps1 -SkipWindowsTweaks

# New sandbox integration
.\Install-Windows11-Toolkit.ps1 -Sandbox
.\Install-Windows11-Toolkit.ps1 -Sandbox -Profile minimal

# New granular control
.\Install-Windows11-Toolkit.ps1 -SkipPowerManagement -SkipSystemEnhancements
.\Install-Windows11-Toolkit.ps1 -OnlyApply "FileExplorer,Privacy,Appearance"

# Advanced combinations
.\Install-Windows11-Toolkit.ps1 -Sandbox -Profile developer -SkipUtilities -OnlyApply "Privacy,Taskbar"
```

#### Migration Guide
- **From v1.x to v2.0.0**: No changes required! Existing scripts work unchanged
- **New Feature Adoption**: Add new parameters gradually as needed
- **Conflict Resolution**: New granular flags take precedence over `-SkipWindowsTweaks`
- **Error Recovery**: Registry rollback activates automatically on failures

---

## [Unreleased]
### Planned Features for v3.0.0
- 🎮 **Interactive Mode** with text-based menu system
- ☑️ **Checkbox-style tweak selection** interface
- 🧙 **Advanced configuration wizard**
- 🎯 **Enhanced user experience** improvements
- 🔄 Undo/Rollback functionality (enhanced beyond v2.0.0 rollback)
- 💾 Backup current settings before applying tweaks
- 🖥️ GUI version using Windows Forms
- 🎮 Gaming profile with game launchers and tools
- 🏢 Enterprise profile for business environments
- 📱 Windows 10 compatibility
- 🌐 Offline installation support
- 📊 Installation statistics and analytics (optional)

---

## [1.3.0] - 2025-08-14
### 🎉 System Enhancements Update

#### Added
- ⚙️ **ThioJoe Registry Tweaks Integration**
  - Based on ThioJoe's "7 Windows Registry Tweaks to Make Your Life Easier" video (Aug 13, 2025)
  - Implemented 3 personally selected tweaks out of 7 available
  - Full attribution to ThioJoe with YouTube video reference
  - URL: https://www.youtube.com/watch?v=V7AuHBZsOj0

- 🔧 **New Registry Modifications**
  - **Verbose Status Messages**: Shows detailed startup/shutdown processes instead of generic "Please wait"
    - Registry: `HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\VerboseStatus = 1`
    - Scope: System-wide modification
    - Benefit: Better transparency of system operations
  - **Disable Search Box Suggestions**: Removes web search suggestions for improved privacy
    - Registry: `HKCU:\Software\Policies\Microsoft\Windows\Explorer\DisableSearchBoxSuggestions = 1`
    - Scope: User-specific modification
    - Benefit: Enhanced privacy and cleaner search experience
  - **Show Seconds in System Clock**: Displays precise time with seconds in taskbar
    - Registry: `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSecondsInSystemClock = 1`
    - Scope: User-specific modification
    - Benefit: More precise timing display (e.g., "10:30:45 AM")

#### Changed
- 📝 **Configuration Updates**
  - Added `systemEnhancements` section to apps-default.json
  - Updated lastUpdated date to 2025-08-14
  - Included ThioJoe attribution in JSON configuration

- 🛠️ **PowerShell Script Enhancements**
  - Implemented robust registry handling with try-catch error blocks
  - Added automatic registry path creation for missing keys
  - Integrated system enhancements with existing Windows tweaks workflow
  - Added system enhancements to summary reporting section

- 📚 **Documentation Updates**
  - Updated README.md with System Enhancements section and ThioJoe credits
  - Enhanced TWEAKS.md with comprehensive registry modification details
  - Added revert instructions for all new registry keys
  - Updated registry changes summary table
  - Updated session.md and CLAUDE.md with v1.3.0 implementation context

#### Technical Details
- Uses robust error handling to prevent script failure on registry access issues
- Automatically creates missing registry paths (e.g., Policies\Microsoft\Windows\Explorer)
- Maintains compatibility with existing restore point and logging systems
- All registry modifications include proper DWORD type specification
- Implements both system-wide (HKLM) and user-specific (HKCU) registry changes

---

## [1.2.0] - 2025-08-14
### 🎉 Documentation Enhancement Update

#### Added
- 📝 **GitHub Alerts Implementation**
  - Converted Docusaurus admonitions to GitHub's native alert system
  - Universal compatibility across browsers, GitHub, and markdown processors
  - Enhanced visual hierarchy with colored backgrounds and icons

#### Changed
- 📚 **Documentation Improvements**
  - README.md: Added 7 strategic alerts for user guidance and safety
  - TWEAKS.md: Added 9 alerts focusing on technical safety warnings
  - APPS.md: Added 8 alerts for installation guidance
  - Used `> [!TYPE]` syntax for universal markdown compatibility

#### Fixed
- 🔧 **Compatibility Issues**
  - Resolved Docusaurus admonitions not rendering in browsers
  - Fixed raw markdown syntax display instead of formatted alerts
  - Ensured proper formatting across all viewing contexts

#### Technical Details
- GitHub Alerts render with appropriate colors and icons
- Compatible with GitHub, documentation sites, and most markdown renderers
- Maintained existing emoji formatting alongside new alert system
- Alert types used: WARNING, CAUTION, NOTE, TIP, IMPORTANT

---

## [1.1.0] - 2025-08-13
### 🎉 Power Management Update

#### Added
- ⚡ **Power Management Optimization** (Desktop only)
  - Automatic system type detection (desktop vs laptop)
  - Hibernation disabled system-wide to free disk space
  - High Performance power plan activation
  - Display timeout set to 1 hour when plugged in
  - Sleep and hibernation timeouts disabled for uninterrupted workflows
  - Energy Saver optimization for desktop systems
  - Smart laptop protection - skips power tweaks on portable systems

#### Changed
- 📝 **Documentation Updates**
  - Added comprehensive power management section to TWEAKS.md
  - Updated README.md with new power optimization features
  - Enhanced CLAUDE.md with power management commands

#### Technical Details
- Uses WMI chassis type detection for system identification
- Employs powercfg commands for power plan management
- Includes proper error handling and user feedback
- Integrates seamlessly with existing Windows tweaks workflow

---

## [1.0.0] - 2025-08-11
### 🎉 Initial Release

#### Added
- ✨ **Core Features**
  - One-click automated installation script
  - JSON-based configuration system
  - Multiple installation profiles (default, minimal, developer)
  - Custom profile support via URL
  - Dry run mode for testing
  - Comprehensive logging with timestamps
  - System Restore Point creation
  - Progress indicators during installation

- 📦 **Application Installation**
  - 19 essential applications via winget
  - Detection of already installed apps
  - Automatic silent installation
  - Installation summary with success/failure tracking
  - Categories: Communication, Productivity, Development, Media, Gaming, Utilities

- ⚙️ **Windows 11 Tweaks**
  - File Explorer configuration (8 settings)
  - Taskbar customization (4 settings)
  - Dark Mode enablement
  - Privacy enhancements (Cortana, Web Search)
  - Explorer restart for immediate effect

- 🛠️ **Manual Utilities**
  - ADB Platform Tools installation from Google
  - Automatic PATH configuration for ADB
  - FlipIt screensaver installation
  - FlipIt configuration tool extraction

- 📚 **Documentation**
  - Comprehensive README with quick start guide
  - Detailed application documentation (APPS.md)
  - Windows tweaks explanation (TWEAKS.md)
  - Attribution for third-party tools
  - License information (MIT)

#### Technical Details
- **Platform**: Windows 11 (Build 22000+)
- **Requirements**: PowerShell 5.1+, Administrator privileges
- **Dependencies**: Windows Package Manager (winget)
- **Size**: ~10 MB (repository), ~5 GB (installed apps)

---

## Version History

| Version | Date | Description |
|---------|------|-------------|
| **2.0.0** | **2025-08-15** | **Major refactoring with sandbox integration and granular control** |
| 1.3.0 | 2025-08-14 | ThioJoe registry tweaks integration (system enhancements) |
| 1.2.0 | 2025-08-14 | Documentation enhancement with GitHub Alerts |
| 1.1.0 | 2025-08-13 | Power management optimization (desktop only) |
| 1.0.0 | 2025-08-11 | Initial release with 19 apps and Windows tweaks |

---

## Roadmap

### Version 1.1.0 (idk-maybe Q1 2026)
- [ ] Undo/Rollback functionality
- [ ] Backup current settings feature
- [ ] Additional app profiles
- [ ] Windows 10 compatibility

### Version 1.2.0 (Near Future)
- [ ] GUI interface
- [ ] Offline installation support
- [ ] Custom theme support
- [ ] Export/Import settings

### Version 3.0.0 (Interactive Mode Release)
- [ ] Interactive Mode with text-based menu system
- [ ] Checkbox-style tweak selection interface  
- [ ] Advanced configuration wizard
- [ ] Enhanced user experience improvements

### Version 4.0.0 (Future Enterprise)
- [ ] Cloud sync for configurations
- [ ] Multi-PC deployment
- [ ] Enterprise features
- [ ] Automated updates

---

## Contributing

We welcome contributions!

### How to Contribute
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## Support

- **Issues**: [GitHub Issues](https://github.com/Mantej-Singh/windows11-fresh-install-toolkit/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Mantej-Singh/windows11-fresh-install-toolkit/discussions)

---

## Acknowledgments

- Inspired by the frustration of Samsung 980 Pro SSD failures
- Registry tweaks inspired by [ThioJoe](https://www.youtube.com/@ThioJoe) - [7 Windows Registry Tweaks Video](https://www.youtube.com/watch?v=V7AuHBZsOj0)
- FlipIt Screensaver by [phaselden](https://github.com/phaselden/FlipIt)
- ADB Platform Tools by Google
- Windows Package Manager team at Microsoft
- The open-source community for various tools and utilities

---

## License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.

---

*For more information, visit the [project homepage](https://github.com/Mantej-Singh/windows11-fresh-install-toolkit).*

---

*Last Updated: August 19, 2025*
