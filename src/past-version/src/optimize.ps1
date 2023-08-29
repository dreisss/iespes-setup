Import-Module "$env:TEMP/utilities"

# =====================================================================> Running
function optimizeComputer {
  Set-ItemProperty -Force -Type "DWord" -Value 2 -Name "VisualFXSetting" "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/VisualEffects"
  print("Configured visual effects to minimal")

  Set-ItemProperty -Force -Type "DWord" -Value 0 -Name "EnableTransparency" "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Themes/Personalize"
  print("Disabled transparency effects")

  Set-ItemProperty -Force -Type "DWord" -Value 0 -Name "AllowTelemetry" "HKLM:/SOFTWARE/Policies/Microsoft/Windows/DataCollection"
  print("Disabled Telemetry")

  New-Item -Path "HKLM:/SOFTWARE/Policies/Microsoft/Windows/AppPrivacy" | Out-Null
  Set-ItemProperty -Force -Type "DWord" -Value 2 -Name "LetAppsRunInBackground" "HKLM:/SOFTWARE/Policies/Microsoft/Windows/AppPrivacy"
  print("Disabled background applications")
}

optimizeComputer
