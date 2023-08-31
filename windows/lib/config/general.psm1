Import-Module "$PSScriptRoot/../utilities"

function renameComputer([int] $laboratoryNumber, [int] $computerNumber) {
  printInfo "Renaming computer..."

  try {
    $newName = "LAB$(formatNumber($laboratoryNumber))-PC$(formatNumber($computerNumber))"
    Rename-Computer -NewName "$newName" | Out-Null
    printSuccess "Computer renamed to '$newName'."
  }
  catch {
    printError "Failed to rename computer."
  }
}

function activateWindows {
  printInfo "Activating Windows..."

  try {
    cmd.exe /c slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
    cmd.exe /c slmgr /skms kms8.msguides.com
    cmd.exe /c slmgr /ato

    printSuccess "Windows activated."
  }
  catch {
    printError "Failed to activate Windows."
  }
}

function createDefaultUser {
  printInfo "Creating default user..."

  try {
    New-LocalUser -Name "Aluno" -NoPassword | Out-Null
    Set-LocalUser -Name "Aluno" -UserMayChangePassword $false  -PasswordNeverExpires $true -AccountNeverExpires | Out-Null
    Add-LocalGroupMember -SID "S-1-5-32-545" -Member "Aluno" | Out-Null

    printSuccess "Default user created."
  }
  catch {
    printError "Failed to create default user."
  }
}
