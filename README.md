# fwebai-app-setup

````
New-Item -ItemType Directory -Force -Path "C:\Install"
$ghRawUrl="https://raw.githubusercontent.com/apachecom40net/fwebai-app-setup/refs/heads/main/install-apps.ps1"
curl.exe -L -o C:\Install\install-apps.ps1 $ghRawUrl 
````
