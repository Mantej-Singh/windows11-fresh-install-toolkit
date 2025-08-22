# 🛡️ Telemetry and Data Collection Control

> [!IMPORTANT]
> **Privacy Enhancement Feature:** This guide covers the comprehensive telemetry disabling functionality introduced in v2.3.0. All registry modifications create automatic restore points and include rollback procedures for safety.

This document provides detailed information about Windows 11 telemetry and data collection systems, along with the registry modifications applied by this toolkit to enhance your privacy.

---

## 📊 **Overview**

Windows 11 collects various types of data for product improvement, diagnostics, and user experience enhancement. This toolkit provides comprehensive control over these data collection mechanisms through registry modifications.

> [!NOTE]
> **What is Telemetry?** Telemetry refers to the automatic collection and transmission of data from your system to Microsoft for analysis, including usage patterns, performance metrics, error reports, and system diagnostics.

---

## 🎯 **Telemetry Categories Controlled**

### **1. Core Data Collection**
**Registry Path:** `HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection`
- **Key:** `AllowTelemetry = 0`
- **Purpose:** Disables basic Windows telemetry collection
- **Impact:** Prevents system usage data transmission

### **2. Diagnostic Data Collection**
**Registry Path:** `HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection`
- **Key:** `AllowTelemetry = 0`
- **Purpose:** Disables diagnostic and usage data collection
- **Impact:** Stops detailed system diagnostics transmission

### **3. Customer Experience Improvement Program (CEIP)**
**Registry Path:** `HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows`
- **Key:** `CEIPEnable = 0`
- **Purpose:** Disables participation in Microsoft's improvement program
- **Impact:** Prevents voluntary data sharing for product enhancement

### **4. Windows Error Reporting**
**Registry Path:** `HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting`
- **Key:** `Disabled = 1`
- **Purpose:** Disables automatic error report transmission
- **Impact:** Prevents crash and error data from being sent to Microsoft

### **5. Application Impact Telemetry**
**Registry Path:** `HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat`
- **Key:** `AITEnable = 0`
- **Purpose:** Disables application compatibility telemetry
- **Impact:** Stops application usage and compatibility data collection

### **6. Advertising ID**
**Registry Path:** `HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo`
- **Key:** `Enabled = 0`
- **Purpose:** Disables personalized advertising identifier
- **Impact:** Prevents targeted advertising based on system usage

### **7. Feedback Notifications**
**Registry Path:** `HKCU:\Software\Microsoft\Siuf\Rules`
- **Key:** `NumberOfSIUFInPeriod = 0`
- **Purpose:** Disables Windows feedback notification prompts
- **Impact:** Eliminates feedback request popups

---

## ⚙️ **Configuration Options**

The telemetry settings are configured in your profile's JSON file under the `telemetry` section:

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

> [!TIP]
> **Granular Control:** You can disable individual telemetry components by setting specific settings to `false` while keeping others enabled. This allows for customized privacy levels based on your preferences.

---

## 🚀 **Usage Examples**

### **Apply All Telemetry Controls**
```powershell
# Standard usage - applies all configured telemetry settings
.\Install-Windows11-Toolkit.ps1
```

### **Skip Telemetry Modifications**
```powershell
# Skip telemetry changes while applying other tweaks
.\Install-Windows11-Toolkit.ps1 -SkipTelemetry
```

### **Selective Application**
```powershell
# Apply only telemetry and privacy tweaks
.\Install-Windows11-Toolkit.ps1 -OnlyApply "Telemetry,Privacy"
```

### **Sandbox Testing**
```powershell
# Test telemetry settings in Windows Sandbox
.\Install-Windows11-Toolkit.ps1 -Sandbox -OnlyApply "Telemetry"
```

---

## ⚠️ **Important Considerations**

> [!WARNING]
> **System Restore Point Required:** Always create a system restore point before applying telemetry modifications. This toolkit automatically creates one, but manual creation is recommended for additional safety.

> [!CAUTION]
> **Enterprise Environments:** Some telemetry settings may be managed by Group Policy in enterprise environments. Registry changes may not take effect if overridden by organizational policies.

### **Potential Impacts**

**Positive Effects:**
- ✅ Enhanced privacy protection
- ✅ Reduced network usage from data transmission
- ✅ Decreased system resource usage for telemetry processes
- ✅ Elimination of feedback notification interruptions

**Considerations:**
- ❓ Microsoft may have limited ability to diagnose system issues
- ❓ Product improvement data won't be contributed
- ❓ Some personalized features may be reduced
- ❓ Error reporting for troubleshooting may be disabled

---

## 🔧 **Manual Registry Modifications**

If you prefer to apply these changes manually, use the following registry commands:

> [!NOTE]
> **Administrator Rights Required:** All registry modifications require elevated PowerShell or Command Prompt access.

```powershell
# Core Data Collection
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord

# Diagnostic Data Collection
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord

# Customer Experience Improvement Program
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows" -Name "CEIPEnable" -Value 0 -Type DWord

# Windows Error Reporting
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 1 -Type DWord

# Application Impact Telemetry
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -Value 0 -Type DWord

# Advertising ID (User-specific)
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0 -Type DWord

# Feedback Notifications (User-specific)
New-Item -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Value 0 -Type DWord
```

---

## 🔄 **Reverting Changes**

To restore Windows telemetry to default settings, use these registry modifications:

> [!IMPORTANT]
> **System Restore Alternative:** The easiest way to revert all changes is using the system restore point created before applying modifications.

```powershell
# Restore Core Data Collection (Default: 3 for Full telemetry)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 3 -Type DWord

# Restore Diagnostic Data Collection (Default: 3 for Full telemetry)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 3 -Type DWord

# Restore Customer Experience Improvement Program (Default: 1 for Enabled)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows" -Name "CEIPEnable" -Value 1 -Type DWord

# Restore Windows Error Reporting (Default: 0 for Enabled)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 0 -Type DWord

# Restore Application Impact Telemetry (Default: 1 for Enabled)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -Value 1 -Type DWord

# Restore Advertising ID (Default: 1 for Enabled)
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 1 -Type DWord

# Restore Feedback Notifications (Default: Remove the restriction)
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -ErrorAction SilentlyContinue
```

---

## 📊 **Verification Commands**

To verify that telemetry settings have been applied correctly:

```powershell
# Check Core Data Collection
Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -ErrorAction SilentlyContinue

# Check Diagnostic Data Collection
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -ErrorAction SilentlyContinue

# Check CEIP Status
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows" -Name "CEIPEnable" -ErrorAction SilentlyContinue

# Check Error Reporting
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -ErrorAction SilentlyContinue

# Check Application Telemetry
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -ErrorAction SilentlyContinue

# Check Advertising ID (User-specific)
Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -ErrorAction SilentlyContinue

# Check Feedback Notifications (User-specific)
Get-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -ErrorAction SilentlyContinue
```

> [!TIP]
> **Expected Values:** For disabled telemetry, most values should be `0` except for Windows Error Reporting which should be `1` when disabled.

---

## 🛠️ **Troubleshooting**

### **Common Issues**

**Registry Keys Not Found:**
- **Solution:** Some keys may not exist by default. The toolkit creates them automatically using the `-CreatePath` parameter.

**Changes Not Taking Effect:**
- **Solution:** Restart Windows Explorer or reboot the system for all changes to take effect.

**Group Policy Override:**
- **Solution:** In enterprise environments, check with your system administrator about Group Policy settings that may override registry changes.

### **Verification Steps**

1. **Registry Verification:** Use the verification commands above to confirm registry values
2. **System Restart:** Reboot after applying changes for full effect
3. **Privacy Settings:** Check Windows Settings > Privacy & security for reflected changes
4. **Task Manager:** Monitor for reduced telemetry-related processes

---

## 📚 **Additional Resources**

> [!NOTE]
> **Related Documentation:** For comprehensive privacy configuration, also review the Privacy settings in `TWEAKS.md` which covers Cortana and web search disabling.

- **Windows Privacy Settings:** Settings > Privacy & security > Diagnostics & feedback
- **Microsoft Privacy Policy:** https://privacy.microsoft.com/privacystatement
- **Windows Telemetry Documentation:** Microsoft's official telemetry documentation
- **Registry Safety:** Best practices for registry modifications

---

## 📞 **Support and Safety**

> [!CAUTION]
> **Registry Modification Warning:** Always backup your registry before making manual changes. This toolkit automatically creates system restore points for safety.

For issues related to telemetry configuration:
1. Use system restore point to revert all changes
2. Check the main toolkit documentation for troubleshooting
3. Verify enterprise policy settings if in a managed environment
4. Test changes in Windows Sandbox first when possible

---

**Last Updated:** August 22, 2025  
**Version:** v2.3.0 - Privacy Enhancement Release  
**Part of:** Windows 11 Fresh Install Toolkit

> [!IMPORTANT]
> **Toolkit Integration:** This telemetry control system integrates seamlessly with other toolkit privacy features and maintains full backward compatibility with all existing usage patterns.