# Sandbox-Test.ps1
Write-Host "Testing core functionality in Sandbox..." -ForegroundColor Cyan

# Test with apps known to work well in Sandbox
$testApps = @(
    @{id = "Microsoft.VisualStudioCode"; name = "VS Code"},
    @{id = "VideoLAN.VLC"; name = "VLC"},
    @{id = "Microsoft.PowerToys"; name = "PowerToys"}
)

foreach ($app in $testApps) {
    Write-Host "Installing $($app.name)..." -ForegroundColor Yellow
    winget install --id $app.id --silent --force --disable-interactivity
    if ($?) {
        Write-Host "✅ Success" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed" -ForegroundColor Red
    }
}

Write-Host "`nTest complete!" -ForegroundColor Green
