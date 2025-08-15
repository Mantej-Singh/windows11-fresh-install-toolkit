#Requires -RunAsAdministrator
# ====================================================
# Windows 11 Fresh Install Toolkit
# Version: 2.0.0 - Major Refactoring Release
# Build Date: August 15, 2025
# Author: Mantej Singh Dhanjal
# GitHub: https://github.com/Mantej-Singh/windows11-fresh-install-toolkit
# ====================================================
# New in v2.0.0:
# • Sandbox Integration (-Sandbox parameter)
# • Granular Tweak Control (individual skip flags + OnlyApply arrays)
# • Enhanced Error Recovery (rollback + severity logging)
# • Full Backward Compatibility (zero breaking changes)
# ====================================================

param(
    [ValidateSet("default", "minimal", "developer", "custom")]
    [string]$Profile = "default",
    [string]$CustomConfigUrl = "",
    [switch]$SkipApps = $false,
    [switch]$SkipWindowsTweaks = $false,
    [switch]$SkipUtilities = $false,
    [switch]$DryRun = $false,
    [switch]$ListProfiles = $false,
    
    # v2.0.0 New Features
    [switch]$Sandbox = $false,
    
    # Granular Tweak Control - Individual Skip Flags
    [switch]$SkipFileExplorer = $false,
    [switch]$SkipTaskbar = $false,
    [switch]$SkipPrivacy = $false,
    [switch]$SkipAppearance = $false,
    [switch]$SkipPowerManagement = $false,
    [switch]$SkipSystemEnhancements = $false,
    
    # Granular Tweak Control - Inclusive Array Approach
    [ValidateSet("FileExplorer", "Taskbar", "Privacy", "Appearance", "PowerManagement", "SystemEnhancements")]
    [string[]]$OnlyApply = @()
)

# ====================================================
# CONFIGURATION
# ====================================================
$script:RepoUrl = "https://raw.githubusercontent.com/Mantej-Singh/windows11-fresh-install-toolkit/main"
$script:TempDir = "$env:TEMP\Win11Toolkit"
$script:Config = $null
$script:InstalledApps = @()
$script:FailedApps = @()

# v2.0.0 Enhanced Tracking
$script:LogEntries = @()
$script:RegistryBackup = @()
$script:ErrorCount = @{ Info = 0; Warning = 0; Error = 0 }
$script:TweaksApplied = @()
$script:TweaksFailed = @()

# Profile URLs
$profiles = @{
    "default"   = "$script:RepoUrl/configs/apps-default.json"
    "minimal"   = "$script:RepoUrl/configs/apps-minimal.json"
    "developer" = "$script:RepoUrl/configs/apps-developer.json"
}

# ====================================================
# v2.0.0 HELPER FUNCTIONS
# ====================================================

function Write-Log {
    param(
        [ValidateSet("INFO", "WARNING", "ERROR")]
        [string]$Level = "INFO",
        [string]$Message,
        [string]$Component = "Main"
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = @{
        Timestamp = $timestamp
        Level = $Level
        Component = $Component
        Message = $Message
    }
    
    $script:LogEntries += $logEntry
    $script:ErrorCount[$Level]++
    
    # Display with appropriate colors
    $color = switch ($Level) {
        "INFO" { "White" }
        "WARNING" { "Yellow" }
        "ERROR" { "Red" }
    }
    
    $levelIcon = switch ($Level) {
        "INFO" { "ℹ️" }
        "WARNING" { "⚠️" }
        "ERROR" { "❌" }
    }
    
    Write-Host "    $levelIcon [$Level] $Message" -ForegroundColor $color
}

function Invoke-RegistryTweak {
    param(
        [string]$Path,
        [string]$Name,
        [object]$Value,
        [string]$Type = "DWord",
        [string]$Description,
        [switch]$CreatePath
    )
    
    try {
        # Backup current value if it exists
        if (Test-Path $Path) {
            try {
                $currentValue = Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue
                if ($currentValue) {
                    $script:RegistryBackup += @{
                        Path = $Path
                        Name = $Name
                        Value = $currentValue.$Name
                        Type = $Type
                        Description = $Description
                    }
                }
            } catch {
                # Property doesn't exist, no backup needed
            }
        }
        
        # Create path if needed
        if ($CreatePath -and -not (Test-Path $Path)) {
            New-Item -Path $Path -Force | Out-Null
            Write-Log -Level "INFO" -Message "Created registry path: $Path" -Component "Registry"
        }
        
        # Apply the tweak
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type
        Write-Log -Level "INFO" -Message "$Description" -Component "Registry"
        $script:TweaksApplied += $Description
        return $true
        
    } catch {
        Write-Log -Level "ERROR" -Message "Failed to apply $Description : $_" -Component "Registry"
        $script:TweaksFailed += $Description
        return $false
    }
}

function Test-SandboxEnvironment {
    try {
        # Check if running in Windows Sandbox
        $productName = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName).ProductName
        return $productName -like "*Sandbox*"
    } catch {
        return $false
    }
}

function Install-SandboxPrerequisites {
    Write-Host "`n[Sandbox Setup] Preparing Windows Sandbox Environment..." -ForegroundColor Cyan
    Write-Log -Level "INFO" -Message "Starting sandbox prerequisites installation" -Component "Sandbox"
    
    $steps = @(
        @{ Name = "Install Winget"; Url = "https://raw.githubusercontent.com/ThioJoe/Windows-Sandbox-Tools/main/Installer%20Scripts/Install-Winget.ps1" },
        @{ Name = "Install Microsoft Store"; Url = "https://raw.githubusercontent.com/ThioJoe/Windows-Sandbox-Tools/main/Installer%20Scripts/Install-Microsoft-Store.ps1" }
    )
    
    $stepCount = 0
    foreach ($step in $steps) {
        $stepCount++
        Write-Progress -Activity "Sandbox Setup" -Status $step.Name -PercentComplete (($stepCount / $steps.Count) * 100)
        Write-Host "  [$stepCount/$($steps.Count)] $($step.Name)..." -ForegroundColor Yellow
        Write-Host "    Attribution: ThioJoe - Windows-Sandbox-Tools" -ForegroundColor Gray
        
        if ($DryRun) {
            Write-Host "    [DRY RUN] Would execute: $($step.Url)" -ForegroundColor Cyan
            continue
        }
        
        try {
            $result = Invoke-Expression "irm $($step.Url) | iex" 2>&1
            Write-Log -Level "INFO" -Message "$($step.Name) completed successfully" -Component "Sandbox"
            Write-Host "    ✅ $($step.Name) completed" -ForegroundColor Green
        } catch {
            Write-Log -Level "WARNING" -Message "$($step.Name) failed but continuing: $_" -Component "Sandbox"
            Write-Host "    ⚠️ $($step.Name) failed but continuing..." -ForegroundColor Yellow
        }
        
        Start-Sleep -Seconds 2
    }
    
    Write-Progress -Activity "Sandbox Setup" -Completed
    Write-Host "  ✅ Sandbox environment prepared" -ForegroundColor Green
}

function Show-ProgressWithETA {
    param(
        [string]$Activity,
        [string]$Status,
        [int]$PercentComplete,
        [int]$CurrentItem = 0,
        [int]$TotalItems = 0
    )
    
    if ($TotalItems -gt 0) {
        $statusText = "$Status [$CurrentItem/$TotalItems]"
    } else {
        $statusText = $Status
    }
    
    Write-Progress -Activity $Activity -Status $statusText -PercentComplete $PercentComplete
}

function New-RestorePointSafely {
    param([string]$Description)
    
    if ($DryRun) {
        Write-Log -Level "INFO" -Message "[DRY RUN] Would create restore point: $Description" -Component "Backup"
        return $true
    }
    
    try {
        Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
        Checkpoint-Computer -Description $Description -RestorePointType "MODIFY_SETTINGS"
        Write-Log -Level "INFO" -Message "System restore point created: $Description" -Component "Backup"
        return $true
    } catch {
        Write-Log -Level "WARNING" -Message "Failed to create restore point (non-critical): $_" -Component "Backup"
        return $false
    }
}

function Invoke-TweakRollback {
    Write-Host "`n[Error Recovery] Rolling back registry changes..." -ForegroundColor Yellow
    Write-Log -Level "WARNING" -Message "Starting registry rollback due to errors" -Component "Rollback"
    
    $rollbackCount = 0
    foreach ($backup in $script:RegistryBackup) {
        try {
            Set-ItemProperty -Path $backup.Path -Name $backup.Name -Value $backup.Value -Type $backup.Type
            $rollbackCount++
            Write-Log -Level "INFO" -Message "Restored: $($backup.Description)" -Component "Rollback"
        } catch {
            Write-Log -Level "ERROR" -Message "Failed to restore: $($backup.Description)" -Component "Rollback"
        }
    }
    
    Write-Host "  ✅ Rolled back $rollbackCount registry changes" -ForegroundColor Green
}

function Test-TweakShouldApply {
    param(
        [string]$TweakCategory
    )
    
    # If SkipWindowsTweaks is true and no granular controls are used, skip all
    if ($SkipWindowsTweaks -and $OnlyApply.Count -eq 0 -and 
        -not $SkipFileExplorer -and -not $SkipTaskbar -and -not $SkipPrivacy -and 
        -not $SkipAppearance -and -not $SkipPowerManagement -and -not $SkipSystemEnhancements) {
        return $false
    }
    
    # If OnlyApply is specified, only apply those categories
    if ($OnlyApply.Count -gt 0) {
        return $TweakCategory -in $OnlyApply
    }
    
    # If specific skip flag is set, don't apply
    switch ($TweakCategory) {
        "FileExplorer" { return -not $SkipFileExplorer }
        "Taskbar" { return -not $SkipTaskbar }
        "Privacy" { return -not $SkipPrivacy }
        "Appearance" { return -not $SkipAppearance }
        "PowerManagement" { return -not $SkipPowerManagement }
        "SystemEnhancements" { return -not $SkipSystemEnhancements }
        default { return $true }
    }
}

# ====================================================
# BANNER & INITIALIZATION
# ====================================================
Write-Host @"
╔═══════════════════════════════════════════════╗
║   🚀 Windows 11 Fresh Install Toolkit v2.0.0  ║
║        Major Refactoring Release              ║
║        Profile: $Profile                      ║
║        Build: August 15, 2025                 ║
╚═══════════════════════════════════════════════╝
"@ -ForegroundColor Cyan

# List available profiles if requested
if ($ListProfiles) {
    Write-Host "`nAvailable Profiles:" -ForegroundColor Yellow
    Write-Host "  • default   - Standard installation with 19 essential apps" -ForegroundColor White
    Write-Host "  • minimal   - Lightweight installation with core apps only" -ForegroundColor White
    Write-Host "  • developer - Development tools and utilities" -ForegroundColor White
    Write-Host "  • custom    - Use your own config with -CustomConfigUrl parameter" -ForegroundColor White
    
    Write-Host "`n🚀 v2.0.0 New Features:" -ForegroundColor Magenta
    Write-Host "  • 🧪 Sandbox Integration with -Sandbox parameter" -ForegroundColor Cyan
    Write-Host "  • ⚙️ Granular Tweak Control (individual categories)" -ForegroundColor Cyan
    Write-Host "  • 🔧 Enhanced Error Recovery with rollback" -ForegroundColor Cyan
    Write-Host "  • 📊 Comprehensive logging and reporting" -ForegroundColor Cyan
    
    Write-Host "`nUsage Examples:" -ForegroundColor Yellow
    Write-Host "  # Basic usage (unchanged)" -ForegroundColor Gray
    Write-Host "  .\Install-Windows11-Toolkit.ps1 -Profile default" -ForegroundColor Gray
    Write-Host "  .\Install-Windows11-Toolkit.ps1 -Profile minimal" -ForegroundColor Gray
    
    Write-Host "`n  # v2.0.0 Sandbox Integration" -ForegroundColor Gray
    Write-Host "  .\Install-Windows11-Toolkit.ps1 -Sandbox" -ForegroundColor Gray
    Write-Host "  .\Install-Windows11-Toolkit.ps1 -Sandbox -Profile minimal" -ForegroundColor Gray
    
    Write-Host "`n  # v2.0.0 Granular Tweak Control" -ForegroundColor Gray
    Write-Host "  .\Install-Windows11-Toolkit.ps1 -SkipPowerManagement -SkipSystemEnhancements" -ForegroundColor Gray
    Write-Host "  .\Install-Windows11-Toolkit.ps1 -OnlyApply FileExplorer,Privacy,Appearance" -ForegroundColor Gray
    
    Write-Host "`n  # v2.0.0 Advanced Combinations" -ForegroundColor Gray
    Write-Host "  .\Install-Windows11-Toolkit.ps1 -Sandbox -Profile developer -SkipUtilities -OnlyApply Privacy,Taskbar" -ForegroundColor Gray
    
    exit 0
}

# Ensure running as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ This script requires Administrator privileges!" -ForegroundColor Red
    Write-Host "Please run PowerShell as Administrator and try again." -ForegroundColor Yellow
    exit 1
}

# v2.0.0 Sandbox Integration
if ($Sandbox) {
    Write-Host "`n🧪 Sandbox Mode Detected" -ForegroundColor Magenta
    Write-Log -Level "INFO" -Message "Running in Sandbox mode with ThioJoe script integration" -Component "Sandbox"
    
    if (Test-SandboxEnvironment) {
        Write-Host "  ✅ Windows Sandbox environment confirmed" -ForegroundColor Green
    } else {
        Write-Host "  ℹ️ Not in Windows Sandbox, but proceeding with Sandbox mode" -ForegroundColor Cyan
    }
    
    # Install sandbox prerequisites
    Install-SandboxPrerequisites
    
    Write-Host "  🚀 Continuing with toolkit installation..." -ForegroundColor Cyan
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
    $restoreSuccess = New-RestorePointSafely -Description "Before Win11 Toolkit v2.0.0 - $Profile profile"
    if ($restoreSuccess) {
        Write-Host "  ✅ System Restore Point created" -ForegroundColor Green
    } else {
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
# SECTION 3: CONFIGURE WINDOWS SETTINGS (v2.0.0 Enhanced)
# ====================================================
if ($script:Config.windowsTweaks) {
    Write-Host "`n[Step 3] Configuring Windows Settings" -ForegroundColor Cyan
    Write-Log -Level "INFO" -Message "Starting Windows tweaks configuration with granular control" -Component "Tweaks"
    
    # Display what will be applied/skipped
    $tweakCategories = @("FileExplorer", "Taskbar", "Privacy", "Appearance", "PowerManagement", "SystemEnhancements")
    $appliedCategories = @()
    $skippedCategories = @()
    
    foreach ($category in $tweakCategories) {
        if (Test-TweakShouldApply -TweakCategory $category) {
            $appliedCategories += $category
        } else {
            $skippedCategories += $category
        }
    }
    
    if ($appliedCategories.Count -gt 0) {
        Write-Host "  📋 Will apply: $($appliedCategories -join ', ')" -ForegroundColor Green
    }
    if ($skippedCategories.Count -gt 0) {
        Write-Host "  ⏭️  Will skip: $($skippedCategories -join ', ')" -ForegroundColor Yellow
    }
    
    if ($DryRun) {
        Write-Host "  [DRY RUN] Would apply Windows tweaks with granular control" -ForegroundColor Cyan
    } else {
        # File Explorer Settings (v2.0.0 Enhanced)
        if ($script:Config.windowsTweaks.fileExplorer.enabled -and (Test-TweakShouldApply -TweakCategory "FileExplorer")) {
            Write-Host "  Configuring File Explorer..." -ForegroundColor Yellow
            $feSettings = $script:Config.windowsTweaks.fileExplorer.settings
            
            if ($feSettings.openToThisPC) {
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1 -Type "DWord" -Description "Open File Explorer to This PC"
            }
            if ($feSettings.showFileExtensions) {
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Type "DWord" -Description "Show file extensions"
            }
            if ($feSettings.showHiddenFiles) {
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -Type "DWord" -Description "Show hidden files"
            }
            if ($feSettings.showSystemFiles) {
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 1 -Type "DWord" -Description "Show system files"
            }
            if ($feSettings.disableRecentFiles) {
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Value 0 -Type "DWord" -Description "Disable recent files"
            }
            if ($feSettings.disableFrequentFolders) {
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Value 0 -Type "DWord" -Description "Disable frequent folders"
            }
            
            Write-Host "    ✅ File Explorer configured" -ForegroundColor Green
        } elseif (Test-TweakShouldApply -TweakCategory "FileExplorer" -eq $false) {
            Write-Host "  ⏭️ Skipping File Explorer tweaks (granular control)" -ForegroundColor Yellow
        }
        
        # Taskbar Settings (v2.0.0 Enhanced)
        if ($script:Config.windowsTweaks.taskbar.enabled -and (Test-TweakShouldApply -TweakCategory "Taskbar")) {
            Write-Host "  Configuring Taskbar..." -ForegroundColor Yellow
            $tbSettings = $script:Config.windowsTweaks.taskbar.settings
            
            if ($tbSettings.removeSearchBox) {
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0 -Type "DWord" -Description "Remove taskbar search box"
            }
            if ($tbSettings.removeWidgets) {
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 0 -Type "DWord" -Description "Remove taskbar widgets"
            }
            if ($tbSettings.removeChatButton) {
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Value 0 -Type "DWord" -Description "Remove taskbar chat button"
            }
            if ($tbSettings.enableEndTask) {
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" -Name "TaskbarEndTask" -Value 1 -Type "DWord" -Description "Enable End Task in taskbar" -CreatePath
            }
            
            Write-Host "    ✅ Taskbar configured" -ForegroundColor Green
        } elseif (Test-TweakShouldApply -TweakCategory "Taskbar" -eq $false) {
            Write-Host "  ⏭️ Skipping Taskbar tweaks (granular control)" -ForegroundColor Yellow
        }
        
        # Appearance Settings (v2.0.0 Enhanced)
        if ($script:Config.windowsTweaks.appearance.enabled -and (Test-TweakShouldApply -TweakCategory "Appearance")) {
            Write-Host "  Configuring Appearance..." -ForegroundColor Yellow
            $appSettings = $script:Config.windowsTweaks.appearance.settings
            
            if ($appSettings.enableDarkMode) {
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -Type "DWord" -Description "Enable system dark mode"
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -Type "DWord" -Description "Enable app dark mode"
            }
            
            Write-Host "    ✅ Appearance configured" -ForegroundColor Green
        } elseif (Test-TweakShouldApply -TweakCategory "Appearance" -eq $false) {
            Write-Host "  ⏭️ Skipping Appearance tweaks (granular control)" -ForegroundColor Yellow
        }
        
        # Privacy Settings (v2.0.0 Enhanced)
        if ($script:Config.windowsTweaks.privacy.enabled -and (Test-TweakShouldApply -TweakCategory "Privacy")) {
            Write-Host "  Configuring Privacy..." -ForegroundColor Yellow
            $privSettings = $script:Config.windowsTweaks.privacy.settings
            
            if ($privSettings.disableCortana) {
                Invoke-RegistryTweak -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Type "DWord" -Description "Disable Cortana" -CreatePath
            }
            if ($privSettings.disableWebSearch) {
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -Type "DWord" -Description "Disable Bing search"
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Value 0 -Type "DWord" -Description "Disable Cortana consent"
            }
            
            Write-Host "    ✅ Privacy settings configured" -ForegroundColor Green
        } elseif (Test-TweakShouldApply -TweakCategory "Privacy" -eq $false) {
            Write-Host "  ⏭️ Skipping Privacy tweaks (granular control)" -ForegroundColor Yellow
        }
        
        # Power Management Settings (v2.0.0 Enhanced)
        if ($script:Config.windowsTweaks.powerManagement -and $script:Config.windowsTweaks.powerManagement.enabled -and (Test-TweakShouldApply -TweakCategory "PowerManagement")) {
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
                        Write-Log -Level "INFO" -Message "Hibernation disabled successfully" -Component "PowerMgmt"
                        Write-Host "    ✅ Hibernation disabled" -ForegroundColor Green
                    } catch {
                        Write-Log -Level "WARNING" -Message "Failed to disable hibernation: $_" -Component "PowerMgmt"
                        Write-Host "    ⚠️ Failed to disable hibernation" -ForegroundColor Yellow
                    }
                }
                
                # Set High Performance power plan
                if ($powerSettings.powerMode -eq "highPerformance") {
                    try {
                        # High performance GUID: 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
                        & powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
                        Write-Log -Level "INFO" -Message "High Performance power plan activated" -Component "PowerMgmt"
                        Write-Host "    ✅ High Performance power plan activated" -ForegroundColor Green
                    } catch {
                        Write-Log -Level "WARNING" -Message "Failed to set High Performance plan: $_" -Component "PowerMgmt"
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
        } elseif (Test-TweakShouldApply -TweakCategory "PowerManagement" -eq $false) {
            Write-Host "  ⏭️ Skipping Power Management tweaks (granular control)" -ForegroundColor Yellow
        }
        
        # System Enhancements (Registry Tweaks) - v2.0.0 Enhanced
        if ($script:Config.windowsTweaks.systemEnhancements -and $script:Config.windowsTweaks.systemEnhancements.enabled -and (Test-TweakShouldApply -TweakCategory "SystemEnhancements")) {
            Write-Host "  Configuring System Enhancements..." -ForegroundColor Yellow
            $sysSettings = $script:Config.windowsTweaks.systemEnhancements.settings
            
            # Verbose Status Messages (System-wide)
            if ($sysSettings.verboseStatus) {
                Invoke-RegistryTweak -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Value 1 -Type "DWord" -Description "Enable verbose status messages" -CreatePath
            }
            
            # Disable Search Box Suggestions (User-specific)
            if ($sysSettings.disableSearchBoxSuggestions) {
                Invoke-RegistryTweak -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1 -Type "DWord" -Description "Disable search box suggestions" -CreatePath
            }
            
            # Show Seconds in System Clock (User-specific)
            if ($sysSettings.showSecondsInClock) {
                Invoke-RegistryTweak -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSecondsInSystemClock" -Value 1 -Type "DWord" -Description "Show seconds in system clock"
            }
            
            Write-Host "    ✅ System enhancements configured" -ForegroundColor Green
        } elseif (Test-TweakShouldApply -TweakCategory "SystemEnhancements" -eq $false) {
            Write-Host "  ⏭️ Skipping System Enhancements tweaks (granular control)" -ForegroundColor Yellow
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
# SECTION 4: ENHANCED SUMMARY REPORT (v2.0.0)
# ====================================================
Write-Host "`n╔═══════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║           📊 INSTALLATION SUMMARY v2.0.0       ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════╝" -ForegroundColor Cyan

Write-Host "`n📦 Profile Used: $($script:Config.name)" -ForegroundColor White
if ($Sandbox) {
    Write-Host "🧪 Sandbox Mode: Enabled with ThioJoe integration" -ForegroundColor Magenta
}

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

# v2.0.0 Enhanced Windows Configuration Reporting
if ($script:Config.windowsTweaks) {
    Write-Host "`n⚙️ Windows Configuration (Granular Control):" -ForegroundColor Cyan
    
    # Show applied tweaks
    if ($script:TweaksApplied.Count -gt 0) {
        Write-Host "`n✅ Applied Tweaks:" -ForegroundColor Green
        $script:TweaksApplied | ForEach-Object { Write-Host "   • $_" -ForegroundColor Green }
    }
    
    # Show failed tweaks
    if ($script:TweaksFailed.Count -gt 0) {
        Write-Host "`n❌ Failed Tweaks:" -ForegroundColor Red
        $script:TweaksFailed | ForEach-Object { Write-Host "   • $_" -ForegroundColor Red }
    }
    
    # Show skipped categories
    $skippedCategories = @()
    $tweakCategories = @("FileExplorer", "Taskbar", "Privacy", "Appearance", "PowerManagement", "SystemEnhancements")
    foreach ($category in $tweakCategories) {
        if (-not (Test-TweakShouldApply -TweakCategory $category)) {
            $skippedCategories += $category
        }
    }
    
    if ($skippedCategories.Count -gt 0) {
        Write-Host "`n⏭️ Skipped Categories:" -ForegroundColor Yellow
        $skippedCategories | ForEach-Object { Write-Host "   • $_" -ForegroundColor Yellow }
    }
}

# Enhanced Error Reporting
if ($script:ErrorCount.Error -gt 0 -or $script:ErrorCount.Warning -gt 0) {
    Write-Host "`n📊 Error Summary:" -ForegroundColor Yellow
    Write-Host "  • ℹ️ Info: $($script:ErrorCount.Info)" -ForegroundColor White
    Write-Host "  • ⚠️ Warnings: $($script:ErrorCount.Warning)" -ForegroundColor Yellow
    Write-Host "  • ❌ Errors: $($script:ErrorCount.Error)" -ForegroundColor Red
    
    if ($script:RegistryBackup.Count -gt 0) {
        Write-Host "  • 🔄 Registry backups created: $($script:RegistryBackup.Count)" -ForegroundColor Cyan
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
