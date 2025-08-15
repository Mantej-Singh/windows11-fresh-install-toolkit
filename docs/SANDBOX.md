# 🧪 Windows Sandbox Integration Guide

*Last Updated: August 15, 2025*

This guide covers the Windows 11 Fresh Install Toolkit's integrated sandbox support, introduced in v2.0.0. The sandbox integration provides a safe testing environment with automatic setup of prerequisites.

---

## 🚀 Quick Start (v2.0.0)

> [!TIP]
> **One-Command Experience:** The new `-Sandbox` parameter automatically handles all setup!

### Simplest Method
```powershell
# One command does everything automatically
.\Install-Windows11-Toolkit.ps1 -Sandbox
```

### With Profile Selection
```powershell
# Test with minimal profile
.\Install-Windows11-Toolkit.ps1 -Sandbox -Profile minimal

# Test with developer profile
.\Install-Windows11-Toolkit.ps1 -Sandbox -Profile developer
```

### Advanced Combinations
```powershell
# Sandbox with granular control
.\Install-Windows11-Toolkit.ps1 -Sandbox -SkipPowerManagement -OnlyApply "Privacy,Appearance"

# Remote execution with sandbox
irm https://raw.githubusercontent.com/Mantej-Singh/windows11-fresh-install-toolkit/main/Install-Windows11-Toolkit.ps1 | iex -ArgumentList '-Sandbox'
```

---

## 🎯 What the `-Sandbox` Parameter Does

The sandbox integration automatically performs these steps:

1. **Environment Detection**: Checks if running in Windows Sandbox
2. **ThioJoe Script Integration**: 
   - Downloads and executes Install-Winget.ps1
   - Downloads and executes Install-Microsoft-Store.ps1
3. **Progress Tracking**: Shows progress and attribution for each step
4. **Error Resilience**: Continues execution even if prerequisites fail
5. **Attribution**: Proper crediting to ThioJoe throughout the process

---

## 🔧 Technical Implementation

### Prerequisites Installed
The sandbox mode automatically installs:

| Component | Source | Purpose |
|-----------|---------|---------|
| **Windows Package Manager (winget)** | [ThioJoe's Install-Winget.ps1](https://github.com/ThioJoe/Windows-Sandbox-Tools/blob/main/Installer%20Scripts/Install-Winget.ps1) | Application installation via winget |
| **Microsoft Store** | [ThioJoe's Install-Microsoft-Store.ps1](https://github.com/ThioJoe/Windows-Sandbox-Tools/blob/main/Installer%20Scripts/Install-Microsoft-Store.ps1) | Store app dependencies (optional) |

### Execution Flow
```mermaid
graph TD
    A["-Sandbox Parameter"] --> B["Environment Detection"]
    B --> C["Install Winget via ThioJoe Script"]
    C --> D["Install Microsoft Store via ThioJoe Script"]
    D --> E["Continue with Toolkit Installation"]
    C --> |"Failure"| F["Log Warning & Continue"]
    D --> |"Failure"| F
    F --> E
```

### Attribution & Credits
- **ThioJoe**: Original Windows Sandbox Tools creator
- **Repository**: [Windows-Sandbox-Tools](https://github.com/ThioJoe/Windows-Sandbox-Tools)
- **License**: MIT License
- **Video Tutorial**: [Windows Sandbox Setup Guide](https://www.youtube.com/watch?v=510O-FkGv6U)

---

## 🛡️ Safety & Limitations

### ✅ Advantages of Sandbox Testing
- **Complete Isolation**: Changes don't affect your main system
- **Risk-Free Testing**: Perfect for trying new configurations
- **Clean Environment**: Fresh Windows installation every time
- **No Persistence**: All changes discarded when sandbox closes
- **Quick Reset**: Simply restart sandbox for clean slate

### ⚠️ Sandbox Limitations

> [!CAUTION]
> **Important Limitations to Consider:**

- **No Persistence**: All changes are lost when sandbox closes
- **Performance Impact**: May run slower than native installation
- **Memory Requirements**: Requires sufficient RAM for sandbox VM
- **Network Restrictions**: Some network features may be limited
- **Hardware Access**: Limited access to hardware features

### 🔍 Troubleshooting

> [!NOTE]
> **Common Issues and Solutions:**

| Issue | Solution |
|-------|----------|
| **winget not found** | The script automatically installs it - wait for completion |
| **Microsoft Store missing** | Optional component - installation continues without it |
| **Slow downloads** | Sandbox environment may have slower network access |
| **Script execution errors** | The toolkit continues execution - check final summary |

---

## 🏗️ Manual Setup (Legacy Method)

> [!NOTE]
> **Legacy Support:** The manual method is still supported for users who prefer step-by-step control.

### Step-by-Step Process
```powershell
# Step 1: Enable Windows Sandbox (if not already enabled)
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online

# Step 2: In Windows Sandbox, install prerequisites
irm https://raw.githubusercontent.com/ThioJoe/Windows-Sandbox-Tools/main/Installer%20Scripts/Install-Winget.ps1 | iex
irm https://raw.githubusercontent.com/ThioJoe/Windows-Sandbox-Tools/main/Installer%20Scripts/Install-Microsoft-Store.ps1 | iex

# Step 3: Run the toolkit
irm https://raw.githubusercontent.com/Mantej-Singh/windows11-fresh-install-toolkit/main/Install-Windows11-Toolkit.ps1 | iex
```

---

## 📊 Comparison: v2.0.0 vs Legacy

| Aspect | v2.0.0 Sandbox Mode | Legacy Manual Method |
|--------|-------------------|-------------------|
| **Commands Required** | 1 | 4 |
| **Error Handling** | Automatic | Manual |
| **Progress Tracking** | Built-in | None |
| **Attribution** | Automatic | User responsibility |
| **Complexity** | Simple | Complex |
| **Flexibility** | High (combined with other params) | Limited |

---

## 🎯 Use Cases

### 👨‍💻 **Developer Testing**
```powershell
# Test development profile safely
.\Install-Windows11-Toolkit.ps1 -Sandbox -Profile developer
```

### 🔧 **Configuration Validation**
```powershell
# Test specific tweak combinations
.\Install-Windows11-Toolkit.ps1 -Sandbox -OnlyApply "Privacy,Security"
```

### 📝 **Documentation & Demos**
```powershell
# Create clean demo environment
.\Install-Windows11-Toolkit.ps1 -Sandbox -Profile minimal
```

### 🧪 **Experimental Features**
```powershell
# Test with custom configuration
.\Install-Windows11-Toolkit.ps1 -Sandbox -Profile custom -CustomConfigUrl "https://example.com/test-config.json"
```

---

## 🚀 Best Practices

### ✅ Recommended Approach
1. **Test First**: Always test configurations in sandbox before production use
2. **Profile Selection**: Use appropriate profiles for different scenarios
3. **Granular Testing**: Test individual tweak categories separately
4. **Documentation**: Document working configurations for later use

### 🎯 Optimization Tips
1. **Memory Allocation**: Ensure sufficient RAM for smooth sandbox operation
2. **Network Speed**: Consider network speed for large downloads
3. **Profile Choice**: Use minimal profile for faster testing
4. **Batch Testing**: Test multiple configurations in sequence

---

## 🔗 Related Resources

### 📚 Documentation
- [Main README](../README.md) - Complete project overview
- [TWEAKS.md](TWEAKS.md) - Windows tweaks documentation
- [APPS.md](APPS.md) - Application installation guide
- [CHANGELOG.md](CHANGELOG.md) - Version history and changes

### 🛠️ Tools & Credits
- [ThioJoe's Windows Sandbox Tools](https://github.com/ThioJoe/Windows-Sandbox-Tools)
- [Windows Sandbox Documentation](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-sandbox/windows-sandbox-overview)
- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)

### 🎥 Video Tutorials
- [ThioJoe's Sandbox Setup Guide](https://www.youtube.com/watch?v=510O-FkGv6U)
- [Windows Sandbox Overview](https://www.youtube.com/@ThioJoe)

---

## 🙏 Attribution

> [!IMPORTANT]
> **Credits and Attribution:**

This sandbox integration is made possible by:

- **[ThioJoe](https://github.com/ThioJoe)** - Creator of Windows Sandbox Tools
- **Repository**: [Windows-Sandbox-Tools](https://github.com/ThioJoe/Windows-Sandbox-Tools)
- **License**: MIT License  
- **Special Thanks**: To ThioJoe for creating tools that make Windows Sandbox truly usable

The Windows 11 Fresh Install Toolkit's sandbox integration builds upon ThioJoe's excellent work while adding automation, error handling, and progress tracking for a seamless user experience.

---

## 📄 License

This documentation is part of the Windows 11 Fresh Install Toolkit, licensed under the MIT License. 

ThioJoe's Windows Sandbox Tools are separately licensed under the MIT License.

---

*For questions or issues related to sandbox integration, please visit our [GitHub Issues](https://github.com/Mantej-Singh/windows11-fresh-install-toolkit/issues) page.*

---

*Last Updated: August 15, 2025*