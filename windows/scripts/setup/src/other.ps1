Import-Module "$env:TEMP/utilities"

# ===================================================================> Functions

function createDefaultUser {
  New-LocalUser -Name "Aluno" -NoPassword | Out-Null
  Set-LocalUser -Name "Aluno" -UserMayChangePassword $false  -PasswordNeverExpires $true -AccountNeverExpires | Out-Null
  Add-LocalGroupMember -SID "S-1-5-32-545" -Member "Aluno" | Out-Null
}

# =====================================================================> Running
function configComputerOther {
  Set-ItemProperty -Force -Type "DWord" -Value 0 -Name "BingSearchEnabled" "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Search"
  print("Disabled bing search on menu")

  Set-ItemProperty -Force -Type "DWord" -Value 1 -Name "LaunchTo" "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/Advanced"
  print("Configured explorer launch page to 'This Computer' page")

  Set-ItemProperty -Force -Type "DWord" -Value 0 -Name "ShowRecent" "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer"
  Set-ItemProperty -Force -Type "DWord" -Value 0 -Name "ShowFrequent" "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer"
  print("Configured 'Quick Access' explorer page")

  powercfg.exe -change -monitor-timeout-ac 0
  print("Disabled monitor sleeping timeout")

  powercfg.exe -change -standby-timeout-ac 0
  print("Disabled computer sleeping timeout")

  createDefaultUser
  print("Created default user")
}

configComputerOther
