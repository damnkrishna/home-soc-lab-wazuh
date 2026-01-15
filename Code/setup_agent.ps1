### 🖥️ Windows Agent Setup Script (`setup_agent.ps1`)

This PowerShell script automates the service management and configuration parts of your guide.

```powershell
# Run this script as Administrator
Write-Host "🚀 Starting Wazuh Agent Configuration..." -ForegroundColor Cyan

# 1. Define Variables
$installPath = "C:\Program Files (x86)\ossec-agent"
$configFile = "$installPath\ossec.conf"

# 2. Check if Wazuh is installed
if (-not (Test-Path $installPath)) {
    Write-Host "❌ Wazuh Agent not found. Please download and install the MSI first." -ForegroundColor Red
    return
}

# 3. Apply the Authentication Key
$key = Read-Host "🔑 Paste the Authentication Key from the Ubuntu Manager"
if ($key) {
    Write-Host "💾 Applying Key..." -ForegroundColor Cyan
    & "$installPath\agent-auth.exe" -k $key
}

# 4. Configure File Integrity Monitoring (FIM)
Write-Host "📂 Configuring FIM for 'C:\Users\abc\Test'..." -ForegroundColor Cyan
$monitoredDir = '<directories realtime="yes">C:\Users\abc\Test</directories>'
$configContent = Get-Content $configFile

# Injecting the directory into the syscheck block if it doesn't exist
if ($configContent -notcontains "*C:\Users\abc\Test*") {
    $configContent = $configContent -replace '<syscheck>', "<syscheck>`n    $monitoredDir"
    $configContent | Set-Content $configFile
}

# 5. Restart Service to apply changes
Write-Host "🔄 Restarting Wazuh Service..." -ForegroundColor Cyan
Restart-Service wazuhsvc
Write-Host "✅ Setup Complete! Check your Dashboard." -ForegroundColor Green

```

---

