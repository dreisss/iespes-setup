Import-Module "$PSScriptRoot/../utilities"

function optimizeComputer {
  printInfo "Optimizing computer..."

  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/VisualEffects" "VisualFXSetting" 2
  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Themes/Personalize" "EnableTransparency" 0
  setRegistryValue "HKLM:/SOFTWARE/Policies/Microsoft/Windows/DataCollection" "AllowTelemetry" 0

  New-Item -Force -Path "HKLM:/SOFTWARE/Policies/Microsoft/Windows/AppPrivacy" | Out-Null
  setRegistryValue "HKLM:/SOFTWARE/Policies/Microsoft/Windows/AppPrivacy" "LetAppsRunInBackground" 2

  printSuccess "Computer optimized."

  Write-Host ""
}

function setPreferences {
  printInfo "Configuring preferences..."

  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Search" "BingSearchEnabled" 0
  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/Advanced" "LaunchTo" 1
  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer" "ShowRecent" 0
  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer" "ShowFrequent" 0

  printInfo "Disabling monitor sleeping timeout..." "   "
  try {
    powercfg.exe -change -monitor-timeout-ac 0
    powercfg.exe -change -standby-timeout-ac 0
    printSuccess "Monitor sleeping timeout disabled." "   "
  }
  catch {
    printError "Failed to disable monitor sleeping timeout." "   "
  }

  printSuccess "Preferences configured."

  Write-Host ""
}
