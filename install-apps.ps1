# ============================================================
# Install Claude Desktop and Postman on Windows 11
# Run as Administrator: powershell -ExecutionPolicy Bypass -File install-apps.ps1
# Log: C:\Installers\install-apps-log.txt
# ============================================================

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ErrorActionPreference = "Continue"

New-Item -ItemType Directory -Path C:\Installers -Force | Out-Null
Start-Transcript -Path C:\Installers\install-apps-log.txt -Append

# ============================================================
# 1. Claude Desktop
# ============================================================
Write-Output "=== Installing Claude Desktop ==="

if (Test-Path "$env:LOCALAPPDATA\AnthropicClaude\Claude.exe") {
    Write-Output "Claude Desktop already installed — skipping."
} else {
    $claudeInstaller = "C:\Installers\Claude-Setup-x64.exe"
    $claudeUrl = "https://storage.googleapis.com/osprey-downloads-c02f6a0d-347c-492b-a752-3e0651722e97/nest-win-x64/Claude-Setup-x64.exe"

    Write-Output "Downloading Claude Desktop..."
    C:\Windows\System32\curl.exe -L -o $claudeInstaller $claudeUrl

    if ($LASTEXITCODE -ne 0 -or -not (Test-Path $claudeInstaller) -or (Get-Item $claudeInstaller).Length -lt 1MB) {
        Write-Output "ERROR: Claude Desktop download failed (exit $LASTEXITCODE, size $((Get-Item $claudeInstaller -ErrorAction SilentlyContinue).Length))."
    } else {
        Write-Output "Download OK — $([math]::Round((Get-Item $claudeInstaller).Length / 1MB, 1)) MB"
        Write-Output "Running installer..."
        Start-Process -FilePath $claudeInstaller -ArgumentList "--silent" -Wait
        Write-Output "Claude Desktop installation complete."
    }
}

# ============================================================
# 2. Postman
# ============================================================
Write-Output "=== Installing Postman ==="

if (Test-Path "$env:LOCALAPPDATA\Postman\Postman.exe") {
    Write-Output "Postman already installed — skipping."
} else {
    $postmanInstaller = "C:\Installers\PostmanSetup.exe"

    Write-Output "Downloading Postman..."
    C:\Windows\System32\curl.exe -L -o $postmanInstaller "https://dl.pstmn.io/download/latest/win64"

    if ($LASTEXITCODE -ne 0 -or -not (Test-Path $postmanInstaller) -or (Get-Item $postmanInstaller).Length -lt 1MB) {
        Write-Output "ERROR: Postman download failed (exit $LASTEXITCODE, size $((Get-Item $postmanInstaller -ErrorAction SilentlyContinue).Length))."
    } else {
        Write-Output "Download OK — $([math]::Round((Get-Item $postmanInstaller).Length / 1MB, 1)) MB"
        Write-Output "Running installer..."
        Start-Process -FilePath $postmanInstaller -ArgumentList "/S" -Wait
        Write-Output "Postman installation complete."
    }
}

Write-Output "=== Done at $(Get-Date -Format o) ==="
Stop-Transcript
