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

## [1.0.0] - 2025-01-10
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
| 1.0.0 | 2025-01-10 | Initial release with 19 apps and Windows tweaks |

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
- FlipIt Screensaver by [phaselden](https://github.com/phaselden/FlipIt)
- ADB Platform Tools by Google
- Windows Package Manager team at Microsoft
- The open-source community for various tools and utilities

---

## License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.

---

*For more information, visit the [project homepage](https://github.com/Mantej-Singh/windows11-fresh-install-toolkit).*
