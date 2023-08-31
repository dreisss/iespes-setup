Import-Module "$PSScriptRoot/../lib/main"

function setNewGroupPolicy([string] $path, [string] $name, [string] $value) {
  printInfo("Setting new group policy $name to $value on $path")

  try {
    New-ItemProperty -PropertyType "DWord" $path -Name $name -Value $value | Out-Null
    printSuccess("New group policy $name set to $value on $path.") "   "
  }
  catch {
    printError("Failed to set new group policy $name to $value on $path") "   "
  }
}

function setGroupPolocies {
  printInfo("Setting group policies...")

  setNewGroupPolicy "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/Policies/System" "NoDispAppearancePage" 1
  setNewGroupPolicy "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/Policies/Explorer" "NoThemesTab" 1
  setNewGroupPolicy "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/Policies/Explorer" "TaskbarLockAll" 1

  printSuccess("Group policies set.")

  Write-Host ""
}