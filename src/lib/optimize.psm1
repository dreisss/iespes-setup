Import-Module "$PSScriptRoot/utilities"

function optimizeComputer {
  printInfo("Optimizing computer...")

  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/VisualEffects" "VisualFXSetting" 2
  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Themes/Personalize" "EnableTransparency" 0
  setRegistryValue "HKLM:/SOFTWARE/Policies/Microsoft/Windows/DataCollection" "AllowTelemetry" 0

  New-Item -Force -Path "HKLM:/SOFTWARE/Policies/Microsoft/Windows/AppPrivacy" | Out-Null
  setRegistryValue "HKLM:/SOFTWARE/Policies/Microsoft/Windows/AppPrivacy" "LetAppsRunInBackground" 2

  printSuccess("Computer optimized.")

  Write-Host ""
}
