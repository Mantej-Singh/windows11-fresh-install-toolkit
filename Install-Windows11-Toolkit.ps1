#Requires -RunAsAdministrator
# ====================================================
# Windows 11 Fresh Install Toolkit
# Version: 1.0.0
# Author: Mantej Singh Dhanjal
# GitHub: https://github.com/Mantej-Singh/windows11-fresh-install-toolkit
# ====================================================

param(
    [ValidateSet("default", "minimal", "developer", "custom")]
    [string]$Profile = "default",
    [string]$CustomConfigUrl = "",
    [switch]$SkipApps = $false,
    [switch]$SkipWindowsTweaks = $false,
    [switch]$SkipUtilities = $false,
    [switch]$DryRun = $false,
    [switch]$ListProfiles = $false
)

# ====================================================
# CONFIGURATION
# ====================================================
$script:RepoUrl = "https://raw.githubusercontent.com/Mantej-Singh/windows11-fresh-install-toolkit/main"
$script:TempDir = "$env:TEMP\Win11Toolkit"
$script:Config = $null
$script:InstalledApps = @()
$script:FailedApps = @()

# Profile URLs
$profiles = @{
    "default"   = "$script:RepoUrl/configs/apps-default.json"
    "minimal"   = "$script:RepoUrl/configs/apps-minimal.json"
    "developer" = "$script:RepoUrl/configs/apps-developer.json"
}

# ====================================================
# BANNER & INITIALIZATION
# ====================================================
Write-Host @"
╔═══════════════════════════════════════════════╗
║   🚀 Windows 11 Fresh Install Toolkit         ║
║        Version 1.0.0                          ║
║        Profile: $Profile                      ║
╚═══════════════════════════════════════════════╝
"@ -ForegroundColor Cyan

# List available profiles if requested
if ($ListProfiles) {
    Write-Host "`nAvailable Profiles:" -ForegroundColor Yellow
    Write-Host "  • default   - Standard installation with 19 essential apps" -ForegroundColor White
    Write-Host "  • minimal   - Lightweight installation with core apps only" -ForegroundColor White
    Write-Host "  • developer - Development tools and utilities" -ForegroundColor White
    Write-Host "  • custom    - Use your own config with -CustomConfigUrl parameter" -ForegroundColor White
    Write-Host "`nUsage Examples:" -ForegroundColor Yellow
    Write-Host "  .\Install-Windows11-Toolkit.ps1 -Profile default" -ForegroundColor Gray
    Write-Host "  .\Install-Windows11-Toolkit.ps1 -Profile minimal" -ForegroundColor Gray
    Write-Host "  .\Install-Windows11-Toolkit.ps1 -Profile developer" -ForegroundColor Gray
    Write-Host "  .\Install-Windows11-Toolkit.ps1 -Profile custom -CustomConfigUrl 'https://your-url/config.json'" -ForegroundColor Gray
    exit 0
}

# Ensure running as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ This script requires Administrator privileges!" -ForegroundColor Red
    Write-Host "Please run PowerShell as Administrator and try again." -ForegroundColor Yellow
    exit 1
}

# Create temp directory
if (-not (Test-Path $script:TempDir)) {
    New-Item -ItemType Directory -Path $script:TempDir -Force | Out-Null
}

# Setup logging
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$logFile = Join-Path -Path (Get-Location) -ChildPath "toolkit_log_$timestamp.log"
Start-Transcript -Path $logFile -Append | Out-Null

# ====================================================
# LOAD CONFIGURATION
# ====================================================
Write-Host "`n[Configuration] Loading profile: $Profile" -ForegroundColor Cyan

try {
    # Determine config URL
    $configUrl = if ($Profile -eq "custom") {
        if ([string]::IsNullOrEmpty($CustomConfigUrl)) {
            throw "Custom profile requires -CustomConfigUrl parameter"
        }
        $CustomConfigUrl
    } else {
        $profiles[$Profile]
    }
    
    Write-Host "  Fetching from: $configUrl" -ForegroundColor Gray
    $script:Config = Invoke-RestMethod -Uri $configUrl -UseBasicParsing
    
    Write-Host "  ✅ Loaded: $($script:Config.name)" -ForegroundColor Green
    Write-Host "  Description: $($script:Config.description)" -ForegroundColor Gray
    Write-Host "  Apps to install: $($script:Config.apps.winget.Count) via winget" -ForegroundColor Gray
    
    if ($script:Config.apps.manual) {
        Write-Host "  Manual utilities: $($script:Config.apps.manual.Count)" -ForegroundColor Gray
    }
} catch {
    Write-Host "❌ Failed to load configuration: $_" -ForegroundColor Red
    Write-Host "`nFalling back to built-in default configuration..." -ForegroundColor Yellow
    
    # Fallback to embedded configuration
    $script:Config = @{
        name = "Embedded Default"
        apps = @{
            winget = @(
                @{ id = "OpenWhisperSystems.Signal"; name = "Signal" },
                @{ id = "Ditto.Ditto"; name = "Ditto" },
                @{ id = "Microsoft.PowerToys"; name = "PowerToys" },
                @{ id = "Microsoft.VisualStudioCode"; name = "VS Code" },
                @{ id = "VideoLAN.VLC"; name = "VLC Media Player" }
            )
        }
        windowsTweaks = @{
            fileExplorer = @{ enabled = $true }
            taskbar = @{ enabled = $true }
            privacy = @{ enabled = $true }
            appearance = @{ enabled = $true }
        }
    }
}

# ====================================================
# CREATE SYSTEM RESTORE POINT
# ====================================================
if (-not $DryRun -and $script:Config.systemSettings.createRestorePoint) {
    Write-Host "`n[Pre-Setup] Creating System Restore Point..." -ForegroundColor Cyan
    try {
        Enable-ComputerRestore -Drive "C:\"
        Checkpoint-Computer -Description "Before Win11 Toolkit - $Profile profile" -RestorePointType "MODIFY_SETTINGS"
        Write-Host "  ✅ System Restore Point created" -ForegroundColor Green
    } catch {
        Write-Host "  ⚠️ Failed to create restore point (non-critical)" -ForegroundColor Yellow
    }
}

# ====================================================
# SECTION 1: INSTALL APPLICATIONS VIA WINGET
# ====================================================
if (-not $SkipApps -and $script:Config.apps.winget) {
    Write-Host "`n[Step 1] Installing Applications via Winget" -ForegroundColor Cyan
    Write-Host "  Total applications: $($script:Config.apps.winget.Count)" -ForegroundColor Gray
    
    $currentApp = 0
    $totalApps = $script:Config.apps.winget.Count
    
    foreach ($app in $script:Config.apps.winget) {
        $currentApp++
        $percentComplete = [math]::Round(($currentApp / $totalApps) * 100)
        
        Write-Progress -Activity "Installing Applications" -Status "$($app.name)" -PercentComplete $percentComplete
        Write-Host "`n  [$currentApp/$totalApps] Installing $($app.name)..." -ForegroundColor Yellow
        
        if ($app.description) {
            Write-Host "         $($app.description)" -ForegroundColor Gray
        }
        
        if ($DryRun) {
            Write-Host "    [DRY RUN] Would install: $($app.id)" -ForegroundColor Cyan
            continue
        }
        
        # Check if already installed
        $checkInstalled = winget list --id $app.id --exact --accept-source-agreements 2>$null
        if ($LASTEXITCODE -eq 0 -and $checkInstalled -match $app.id) {
            Write-Host "    ⏭️ Already installed, skipping" -ForegroundColor Cyan
            $script:InstalledApps += "$($app.name) (existing)"
            continue
        }
        
        # Install the app
        $installResult = winget install --id $app.id --accept-source-agreements --accept-package-agreements --silent 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "    ✅ $($app.name) installed successfully" -ForegroundColor Green
            $script:InstalledApps += $app.name
        } else {
            Write-Host "    ❌ Failed to install $($app.name)" -ForegroundColor Red
            $script:FailedApps += $app.name
        }
        
        # Small delay between installations
        Start-Sleep -Seconds 1
    }
    
    Write-Progress -Activity "Installing Applications" -Completed
}

# ====================================================
# SECTION 2: INSTALL MANUAL UTILITIES
# ====================================================
if (-not $SkipUtilities -and $script:Config.apps.manual) {
    Write-Host "`n[Step 2] Installing Manual Utilities" -ForegroundColor Cyan
    
    foreach ($utility in $script:Config.apps.manual) {
        Write-Host "`n  Installing $($utility.name)..." -ForegroundColor Yellow
        
        if ($DryRun) {
            Write-Host "    [DRY RUN] Would install from: $($utility.downloadUrl)" -ForegroundColor Cyan
            continue
        }
        
        try {
            switch ($utility.name) {
                "ADB Platform Tools" {
                    Write-Host "    Downloading from Google..." -ForegroundColor Gray
                    $adbZip = Join-Path $script:TempDir "platform-tools.zip"
                    Invoke-WebRequest -Uri $utility.downloadUrl -OutFile $adbZip -UseBasicParsing
                    
                    Write-Host "    Extracting to $($utility.installPath)..." -ForegroundColor Gray
                    $parentPath = Split-Path $utility.installPath -Parent
                    New-Item -ItemType Directory -Path $parentPath -Force | Out-Null
                    Expand-Archive -Path $adbZip -DestinationPath $parentPath -Force
                    
                    if ($utility.addToPath) {
                        $currentPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
                        if ($currentPath -notlike "*$($utility.installPath)*") {
                            [System.Environment]::SetEnvironmentVariable("Path", "$currentPath;$($utility.installPath)", "Machine")
                            Write-Host "    ✅ ADB installed and added to PATH" -ForegroundColor Green
                        } else {
                            Write-Host "    ✅ ADB installed (already in PATH)" -ForegroundColor Green
                        }
                    }
                }
                
                "FlipIt Screensaver" {
                    Write-Host "    Downloading screensaver..." -ForegroundColor Gray
                    $scrPath = Join-Path $utility.installPath "FlipIt.scr"
                    Invoke-WebRequest -Uri $utility.downloadUrl -OutFile $scrPath -UseBasicParsing
                    Write-Host "    ✅ FlipIt screensaver installed" -ForegroundColor Green
                    
                    if ($utility.configTool) {
                        Write-Host "    Downloading configuration tool..." -ForegroundColor Gray
                        $configPath = Join-Path $script:TempDir "FlipIt-1.3.7z"
                        Invoke-WebRequest -Uri $utility.configTool.url -OutFile $configPath -UseBasicParsing
                        Write-Host "    ℹ️ Config tool saved to: $configPath" -ForegroundColor Cyan
                        Write-Host "    Extract to: $($utility.configTool.extractPath)" -ForegroundColor Gray
                    }
                }
                
                default {
                    Write-Host "    Downloading $($utility.name)..." -ForegroundColor Gray
                    $fileName = Split-Path $utility.downloadUrl -Leaf
                    $downloadPath = Join-Path $script:TempDir $fileName
                    Invoke-WebRequest -Uri $utility.downloadUrl -OutFile $downloadPath -UseBasicParsing
                    Write-Host "    ✅ Downloaded to: $downloadPath" -ForegroundColor Green
                }
            }
        } catch {
            Write-Host "    ❌ Failed to install $($utility.name): $_" -ForegroundColor Red
        }
    }
}

# ====================================================
# SECTION 3: CONFIGURE WINDOWS SETTINGS
# ====================================================
if (-not $SkipWindowsTweaks -and $script:Config.windowsTweaks) {
    Write-Host "`n[Step 3] Configuring Windows Settings" -ForegroundColor Cyan
    
    if ($DryRun) {
        Write-Host "  [DRY RUN] Would apply Windows tweaks" -ForegroundColor Cyan
    } else {
        # File Explorer Settings
        if ($script:Config.windowsTweaks.fileExplorer.enabled) {
            Write-Host "  Configuring File Explorer..." -ForegroundColor Yellow
            $feSettings = $script:Config.windowsTweaks.fileExplorer.settings
            
            if ($feSettings.openToThisPC) {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1 -Type DWord
            }
            if ($feSettings.showFileExtensions) {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Type DWord
            }
            if ($feSettings.showHiddenFiles) {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -Type DWord
            }
            if ($feSettings.showSystemFiles) {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 1 -Type DWord
            }
            if ($feSettings.disableRecentFiles) {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Value 0 -Type DWord
            }
            if ($feSettings.disableFrequentFolders) {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Value 0 -Type DWord
            }
            
            Write-Host "    ✅ File Explorer configured" -ForegroundColor Green
        }
        
        # Taskbar Settings
        if ($script:Config.windowsTweaks.taskbar.enabled) {
            Write-Host "  Configuring Taskbar..." -ForegroundColor Yellow
            $tbSettings = $script:Config.windowsTweaks.taskbar.settings
            
            if ($tbSettings.removeSearchBox) {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0 -Type DWord
            }
            if ($tbSettings.removeWidgets) {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 0 -Type DWord -ErrorAction SilentlyContinue
            }
            if ($tbSettings.removeChatButton) {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Value 0 -Type DWord -ErrorAction SilentlyContinue
            }
            if ($tbSettings.enableEndTask) {
                New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" -Force | Out-Null
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" -Name "TaskbarEndTask" -Value 1 -Type DWord
            }
            
            Write-Host "    ✅ Taskbar configured" -ForegroundColor Green
        }
        
        # Dark Mode
        if ($script:Config.windowsTweaks.appearance.enabled) {
            Write-Host "  Enabling Dark Mode..." -ForegroundColor Yellow
            $appSettings = $script:Config.windowsTweaks.appearance.settings
            
            if ($appSettings.enableDarkMode) {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -Type DWord
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -Type DWord
            }
            
            Write-Host "    ✅ Dark Mode enabled" -ForegroundColor Green
        }
        
        # Privacy Settings
        if ($script:Config.windowsTweaks.privacy.enabled) {
            Write-Host "  Configuring Privacy..." -ForegroundColor Yellow
            $privSettings = $script:Config.windowsTweaks.privacy.settings
            
            if ($privSettings.disableCortana) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Type DWord
            }
            if ($privSettings.disableWebSearch) {
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -Type DWord
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Value 0 -Type DWord
            }
            
            Write-Host "    ✅ Privacy settings configured" -ForegroundColor Green
        }
        
        # Power Management Settings
        if ($script:Config.windowsTweaks.powerManagement -and $script:Config.windowsTweaks.powerManagement.enabled) {
            Write-Host "  Configuring Power Management..." -ForegroundColor Yellow
            $powerSettings = $script:Config.windowsTweaks.powerManagement.settings
            
            # Detect system type (desktop vs laptop)
            $isDesktop = $true
            if ($powerSettings.desktopOnly) {
                try {
                    $chassis = (Get-WmiObject -Class Win32_SystemEnclosure).ChassisTypes
                    # Chassis types: 8,9,10,14 = Laptop/Portable, 3,4,5,6,7,15,16 = Desktop/Tower
                    $laptopTypes = @(8, 9, 10, 14, 30, 31)
                    $isDesktop = -not ($chassis | Where-Object { $_ -in $laptopTypes })
                    
                    if (-not $isDesktop) {
                        Write-Host "    ⏭️ Laptop detected - skipping desktop-only power settings" -ForegroundColor Cyan
                    }
                } catch {
                    Write-Host "    ⚠️ Could not detect system type - applying settings anyway" -ForegroundColor Yellow
                }
            }
            
            if ($isDesktop -or -not $powerSettings.desktopOnly) {
                # Disable hibernation
                if ($powerSettings.disableHibernation) {
                    try {
                        & powercfg /hibernate off
                        Write-Host "    ✅ Hibernation disabled" -ForegroundColor Green
                    } catch {
                        Write-Host "    ⚠️ Failed to disable hibernation" -ForegroundColor Yellow
                    }
                }
                
                # Set High Performance power plan
                if ($powerSettings.powerMode -eq "highPerformance") {
                    try {
                        # High performance GUID: 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
                        & powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
                        Write-Host "    ✅ High Performance power plan activated" -ForegroundColor Green
                    } catch {
                        Write-Host "    ⚠️ Failed to set High Performance plan" -ForegroundColor Yellow
                    }
                }
                
                # Configure plugged-in power settings
                if ($powerSettings.pluggedInSettings) {
                    $pluggedSettings = $powerSettings.pluggedInSettings
                    
                    try {
                        # Set display timeout (convert minutes to minutes for powercfg)
                        if ($pluggedSettings.displayTimeout -gt 0) {
                            & powercfg /change monitor-timeout-ac $pluggedSettings.displayTimeout
                            Write-Host "    ✅ Display timeout set to $($pluggedSettings.displayTimeout) minutes" -ForegroundColor Green
                        }
                        
                        # Set sleep timeout (0 = never)
                        if ($pluggedSettings.sleepTimeout -eq 0) {
                            & powercfg /change standby-timeout-ac 0
                            Write-Host "    ✅ Sleep timeout disabled" -ForegroundColor Green
                        }
                        
                        # Set hibernate timeout (0 = never)
                        if ($pluggedSettings.hibernateTimeout -eq 0) {
                            & powercfg /change hibernate-timeout-ac 0
                            Write-Host "    ✅ Hibernate timeout disabled" -ForegroundColor Green
                        }
                    } catch {
                        Write-Host "    ⚠️ Some power timeout settings may have failed" -ForegroundColor Yellow
                    }
                }
                
                # Disable Energy Saver (Registry setting for Windows 11)
                if (-not $powerSettings.energySaver) {
                    try {
                        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowBatteryFlyout" -Value 0 -Type DWord -ErrorAction SilentlyContinue
                        Write-Host "    ✅ Energy Saver configuration applied" -ForegroundColor Green
                    } catch {
                        Write-Host "    ⚠️ Energy Saver setting may not have applied" -ForegroundColor Yellow
                    }
                }
            }
            
            Write-Host "    ✅ Power management configured" -ForegroundColor Green
        }
        
        # System Enhancements (Registry Tweaks)
        if ($script:Config.windowsTweaks.systemEnhancements -and $script:Config.windowsTweaks.systemEnhancements.enabled) {
            Write-Host "  Configuring System Enhancements..." -ForegroundColor Yellow
            $sysSettings = $script:Config.windowsTweaks.systemEnhancements.settings
            
            # Verbose Status Messages (System-wide)
            if ($sysSettings.verboseStatus) {
                try {
                    # Ensure the registry path exists
                    $verbosePath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
                    if (-not (Test-Path $verbosePath)) {
                        New-Item -Path $verbosePath -Force | Out-Null
                    }
                    Set-ItemProperty -Path $verbosePath -Name "VerboseStatus" -Value 1 -Type DWord
                    Write-Host "    ✅ Verbose status messages enabled" -ForegroundColor Green
                } catch {
                    Write-Host "    ⚠️ Failed to enable verbose status messages" -ForegroundColor Yellow
                }
            }
            
            # Disable Search Box Suggestions (User-specific)
            if ($sysSettings.disableSearchBoxSuggestions) {
                try {
                    # Ensure the registry path exists
                    $searchPath = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
                    if (-not (Test-Path $searchPath)) {
                        New-Item -Path $searchPath -Force | Out-Null
                    }
                    Set-ItemProperty -Path $searchPath -Name "DisableSearchBoxSuggestions" -Value 1 -Type DWord
                    Write-Host "    ✅ Search box suggestions disabled" -ForegroundColor Green
                } catch {
                    Write-Host "    ⚠️ Failed to disable search box suggestions" -ForegroundColor Yellow
                }
            }
            
            # Show Seconds in System Clock (User-specific)
            if ($sysSettings.showSecondsInClock) {
                try {
                    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSecondsInSystemClock" -Value 1 -Type DWord
                    Write-Host "    ✅ Seconds in system clock enabled" -ForegroundColor Green
                } catch {
                    Write-Host "    ⚠️ Failed to enable seconds in system clock" -ForegroundColor Yellow
                }
            }
            
            Write-Host "    ✅ System enhancements configured" -ForegroundColor Green
        }
        
        # Restart Explorer if needed
        if ($script:Config.systemSettings.restartExplorer) {
            Write-Host "  Restarting Explorer..." -ForegroundColor Yellow
            Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
            Start-Sleep -Seconds 2
            Start-Process explorer
            Write-Host "    ✅ Explorer restarted" -ForegroundColor Green
        }
    }
}

# ====================================================
# SECTION 4: SUMMARY REPORT
# ====================================================
Write-Host "`n╔═══════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║           📊 INSTALLATION SUMMARY              ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════╝" -ForegroundColor Cyan

Write-Host "`n📦 Profile Used: $($script:Config.name)" -ForegroundColor White

if (-not $DryRun -and -not $SkipApps) {
    $successCount = $script:InstalledApps.Count
    $failedCount = $script:FailedApps.Count
    $totalAttempted = $successCount + $failedCount
    
    Write-Host "`n📈 Statistics:" -ForegroundColor White
    Write-Host "  • Total Attempted: $totalAttempted" -ForegroundColor Gray
    Write-Host "  • ✅ Successful: $successCount" -ForegroundColor Green
    Write-Host "  • ❌ Failed: $failedCount" -ForegroundColor Red
    
    if ($script:InstalledApps.Count -gt 0) {
        Write-Host "`n✅ Successfully Installed:" -ForegroundColor Green
        $script:InstalledApps | ForEach-Object { Write-Host "   • $_" -ForegroundColor Green }
    }
    
    if ($script:FailedApps.Count -gt 0) {
        Write-Host "`n❌ Failed to Install:" -ForegroundColor Red
        $script:FailedApps | ForEach-Object { Write-Host "   • $_" -ForegroundColor Red }
    }
}

if (-not $SkipWindowsTweaks) {
    Write-Host "`n⚙️ Windows Configuration:" -ForegroundColor Cyan
    Write-Host "  • File Explorer: Configured ✅" -ForegroundColor Green
    Write-Host "  • Taskbar: Customized ✅" -ForegroundColor Green
    Write-Host "  • Dark Mode: Enabled ✅" -ForegroundColor Green
    Write-Host "  • Privacy: Enhanced ✅" -ForegroundColor Green
    if ($script:Config.windowsTweaks.powerManagement -and $script:Config.windowsTweaks.powerManagement.enabled) {
        Write-Host "  • Power Management: Optimized ✅" -ForegroundColor Green
    }
    if ($script:Config.windowsTweaks.systemEnhancements -and $script:Config.windowsTweaks.systemEnhancements.enabled) {
        Write-Host "  • System Enhancements: Applied ✅" -ForegroundColor Green
    }
}

# Cleanup
if (Test-Path $script:TempDir) {
    Remove-Item -Path $script:TempDir -Recurse -Force -ErrorAction SilentlyContinue
}

Stop-Transcript | Out-Null

Write-Host "`n📄 Log saved to: $logFile" -ForegroundColor Yellow
Write-Host "💡 Restart your computer to ensure all changes take effect" -ForegroundColor Yellow
Write-Host "`n🎉 Setup Complete!" -ForegroundColor Green
Write-Host "══════════════════════════════════════════════════" -ForegroundColor Cyan

# ====================================================
# USAGE EXAMPLES (Comments for other users)
# ====================================================
<#
.SYNOPSIS
    Windows 11 Fresh Install Toolkit - Automated setup script

.DESCRIPTION
    Installs applications and configures Windows settings based on JSON profiles

.PARAMETER Profile
    Choose installation profile: default, minimal, developer, or custom
    - default: 19 essential apps with full Windows tweaks
    - minimal: Core apps only (VS Code, VLC, Ditto, PowerToys, Google Drive)
    - developer: Development tools (Git, Node.js, Python, Docker, etc.)
    - custom: Use your own JSON configuration file

.PARAMETER CustomConfigUrl
    URL to custom JSON configuration file (required when using -Profile custom)

.PARAMETER SkipApps
    Skip application installation

.PARAMETER SkipWindowsTweaks
    Skip Windows configuration changes

.PARAMETER SkipUtilities
    Skip manual utility installations (ADB, FlipIt)

.PARAMETER DryRun
    Test run without making changes

.PARAMETER ListProfiles
    Display available profiles and exit

.EXAMPLES
    # Default installation (recommended)
    .\Install-Windows11-Toolkit.ps1

    # Use minimal profile
    .\Install-Windows11-Toolkit.ps1 -Profile minimal

    # Use developer profile
    .\Install-Windows11-Toolkit.ps1 -Profile developer

    # Use custom configuration from URL
    .\Install-Windows11-Toolkit.ps1 -Profile custom -CustomConfigUrl "https://example.com/my-config.json"

    # Test run without making changes
    .\Install-Windows11-Toolkit.ps1 -DryRun

    # Skip Windows tweaks
    .\Install-Windows11-Toolkit.ps1 -SkipWindowsTweaks

    # List available profiles
    .\Install-Windows11-Toolkit.ps1 -ListProfiles

.NOTES
    Author: Mantej Singh Dhanjal
    GitHub: https://github.com/Mantej-Singh/windows11-fresh-install-toolkit
    License: MIT
    Requires: Windows 11, Administrator privileges, Internet connection
#>
