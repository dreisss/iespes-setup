Import-Module "$PSScriptRoot/utilities"

function renameComputer([int] $laboratoryNumber, [int] $computerNumber) {
  printInfo("Renaming computer...")

  try {
    $newName = "LAB$(formatNumber($laboratoryNumber))-PC$(formatNumber($computerNumber))"
    Rename-Computer -NewName "$newName" | Out-Null
    printSuccess("Computer renamed to $newName.")
  }
  catch {
    printError("Failed to rename computer.")
  }

  Write-Host ""
}

function activateWindows {
  printInfo("Activating Windows...")

  try {
    cmd.exe /c slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
    cmd.exe /c slmgr /skms kms8.msguides.com
    cmd.exe /c slmgr /ato
    printSuccess("Windows activated.")
  }
  catch {
    printError("Failed to activate Windows.")
  }

  Write-Host ""
}

function createDefaultUser {
  printInfo("Creating default user...")

  try {
    New-LocalUser -Name "Aluno" -NoPassword | Out-Null
    Set-LocalUser -Name "Aluno" -UserMayChangePassword $false  -PasswordNeverExpires $true -AccountNeverExpires | Out-Null
    Add-LocalGroupMember -SID "S-1-5-32-545" -Member "Aluno" | Out-Null
    printSuccess("Default user created.")
  }
  catch {
    printError("Failed to create default user.")
  }

  Write-Host ""
}

function setPreferences {
  printInfo("Configuring preferences...")

  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Search" "BingSearchEnabled" 0
  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/Advanced" "LaunchTo" 1
  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer" "ShowRecent" 0
  setRegistryValue "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer" "ShowFrequent" 0

  printInfo("Disabling monitor sleeping timeout...") "   "
  try {
    powercfg.exe -change -monitor-timeout-ac 0
    powercfg.exe -change -standby-timeout-ac 0
    printSuccess("Monitor sleeping timeout disabled.") "   "
  }
  catch {
    printError("Failed to disable monitor sleeping timeout.") "   "
  }

  printSuccess("Preferences configured.")

  Write-Host ""
}
