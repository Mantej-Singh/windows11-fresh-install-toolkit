# 🗺️ Roadmap - Windows 11 Fresh Install Toolkit

## ✅ Completed Features

### v1.3.0 - System Enhancements (August 14, 2025)
- [x] ⚙️ **ThioJoe Registry Tweaks Integration** - COMPLETED ✅
  - [x] Verbose startup/shutdown status messages
  - [x] Disable search box suggestions for privacy
  - [x] Show seconds in system clock
  - [x] Automatic registry path creation with error handling
  - [x] Attribution to ThioJoe with YouTube video reference

### v1.2.0 - Documentation Enhancement (August 14, 2025)
- [x] 📝 **GitHub Alerts Implementation** - COMPLETED ✅
  - [x] Universal markdown compatibility across all platforms
  - [x] Enhanced visual hierarchy with colored backgrounds
  - [x] Comprehensive documentation improvements
  - [x] Fixed Docusaurus admonition rendering issues

### v1.1.0 - Power Management (August 13, 2025)
- [x] ⚡ **Power Management Optimization** - COMPLETED ✅
  - [x] Disable hibernation system-wide
  - [x] Apply High Performance power mode
  - [x] Desktop-only implementation with laptop detection
  - [x] Configure power settings for optimal desktop performance:
    - Display timeout: 1 hour when plugged in
    - Sleep timeout: Never when plugged in  
    - Hibernate timeout: Never when plugged in
    - Energy Saver: Optimized for desktops

   <img width="1146" height="1023" alt="Screenshot 2025-08-12 163029" src="https://github.com/user-attachments/assets/ce2088f1-0656-4907-9f26-cdb4ae5d225f" />

### v1.0.0 - Core Features (August 2025)
- [x] Custom app profiles (minimal, developer, default)
- [x] Winget-based application installation
- [x] Windows 11 system tweaks and optimizations
- [x] JSON-based configuration system
- [x] System restore point creation

---

## 🚧 Planned Features

### v2.0.0 - Major Refactoring & Advanced Features (August 15, 2025) ⚡
> [!IMPORTANT]
> **Major Release Planned**: Comprehensive script refactoring with advanced user-requested features.

- [ ] **🧪 Sandbox Integration**
  - [ ] One-command sandbox setup with `-Sandbox` parameter
  - [ ] Automatic ThioJoe script integration for Winget and Microsoft Store
  - [ ] Progress indication and error handling for sandbox prerequisites
  - [ ] Seamless testing environment without manual setup steps

- [ ] **⚙️ Granular Tweak Control**
  - [ ] Individual skip parameters (`-SkipFileExplorer`, `-SkipTaskbar`, `-SkipPrivacy`, etc.)
  - [ ] Inclusive array approach (`-OnlyApply "FileExplorer,Privacy,Appearance"`)
  - [ ] Both options available for maximum user flexibility
  - [ ] Intelligent conflict resolution with existing `-SkipWindowsTweaks`

- [ ] **🔧 Enhanced Error Recovery**
  - [ ] Registry rollback mechanism on partial tweak failures
  - [ ] Severity-based logging system (INFO, WARNING, ERROR)
  - [ ] Comprehensive error reporting in final installation summary
  - [ ] Graceful degradation for non-critical operations

- [ ] **🔄 Backward Compatibility Assurance**
  - [ ] Full compatibility with existing usage patterns and scripts
  - [ ] Zero breaking changes for current users
  - [ ] Smart parameter conflict resolution logic
  - [ ] Seamless upgrade path from v1.x versions

### v3.0.0 - Interactive Experience (Q2 2026) 🎮
> [!NOTE]
> **Interactive Mode**: Text-based menu system planned for enhanced user experience.

- [ ] **Interactive Mode Implementation**
  - [ ] Text-based menu system for tweak category selection
  - [ ] Simple checkbox interface for individual tweaks
  - [ ] Real-time preview of changes to be applied
  - [ ] Step-by-step guided configuration wizard

- [ ] **Advanced Configuration Interface**
  - [ ] Category-based selection menus with descriptions
  - [ ] Individual tweak enable/disable granular options
  - [ ] Save custom configurations from interactive sessions
  - [ ] Template creation from interactive user selections

### v4.0.0 - Platform Expansion (2027)
- [ ] **Cross-Platform Support**
  - [ ] Windows 10 support and full compatibility testing
  - [ ] Windows Server edition support for enterprise environments
  - [ ] Cross-architecture support (ARM64, x86) compatibility

### Future Considerations (Beyond v4.0.0)
- [ ] **Specialized Profiles**
  - [ ] Gaming profile with game launchers and performance optimization tools
  - [ ] Enterprise profile for business environments and domain management
  - [ ] Developer profile with advanced development tools and environments
  - [ ] Content Creator profile with media tools and workflow optimization

- [ ] **Advanced Features**
  - [ ] Offline installation support with local package cache management
  - [ ] Installation analytics and reporting (optional, privacy-focused)
  - [ ] Plugin system for community-contributed custom tweaks
  - [ ] Multi-PC deployment for enterprise and power users
  - [ ] AI-powered configuration recommendations based on usage patterns

> [!NOTE]
> **Interactive Mode Planning**: Based on user feedback, Interactive Mode (text-based menu/checkbox system) has been strategically planned for v3.0.0 to allow users to select individual tweaks through an intuitive interface.

---

*Last Updated: August 22, 2025*




