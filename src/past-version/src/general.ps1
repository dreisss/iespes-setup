Import-Module "$env:TEMP/utilities"
[string] $labinNumber = $args[1]
[string] $computerNumber = $args[2]

# ===================================================================> Functions
function renameComputer {
  $newName = "LABIN$(formatNumber($labinNumber))-PC$(formatNumber($computerNumber))"
  Rename-Computer -NewName $newName | Out-Null
}

function activateWindows {
  cmd.exe /c slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
  cmd.exe /c slmgr /skms kms8.msguides.com
  cmd.exe /c slmgr /ato
}

# =====================================================================> Running
print("Renaming computer...")
renameComputer

print("Activating Windows...")
activateWindows
