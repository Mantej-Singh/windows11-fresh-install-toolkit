# 📋 Changelog

All notable changes to the Windows 11 Fresh Install Toolkit will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]
### Planned Features
- 🔄 Undo/Rollback functionality
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

### Version 2.0.0 (Far Far Future)
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

*Last Updated: August 14, 2025*
