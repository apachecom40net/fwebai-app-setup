# Claude Desktop (MSIX - best for automation)
curl.exe -L "https://claude.ai/api/desktop/win32/x64/msix/latest/redirect" -o "C:\Install\Claude.msix"
Add-AppxPackage -Path "C:\Install\Claude.msix"

# Postman
curl.exe -L "https://dl.pstmn.io/download/latest/win64" -o "C:\Install\Postman.exe"
Start-Process "C:\Install\Postman.exe" -ArgumentList "/S"

Write-Host "Done!"
