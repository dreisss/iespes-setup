Import-Module "$PSScriptRoot/../utilities"

# ====> Package Managers
function installChocolatey {
  printInfo "Installing Chocolatey..."

  try {
    Set-ExecutionPolicy Bypass -Scope Process -Force;
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    printSuccess "Chocolatey installed."
  }
  catch {
    printError "Failed to install Chocolatey."
  }
}

function installWinget {
  printInfo "Installing Winget..."

  try {
    Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe

    printSuccess "Winget installed."
  }
  catch {
    printError "Failed to install winget."
  }
}

# ====> Other Apps
function installApp([string] $app) {
  printInfo "Installing $app..." "   "

  try {
    choco.exe install $app -yf --ignore-checksums | Out-Null

    printSuccess "$app installed." "   "
  }
  catch {
    printError "Failed to install $app." "   "
  }
}

function installDefaultApps {
  printInfo "Installing default apps..."

  foreach ($app in @("firefox", "winrar", "adobereader", "vlc", "cpu-z")) {
    installApp $app
  }

  printSuccess "Default apps installed."
}

function installDeveloperApps {
  printInfo "Installing developer apps..."

  foreach ($app in @("git", "python", "sqlite", "vscode")) {
    installApp $app
  }

  printSuccess "Developer apps installed."
}
