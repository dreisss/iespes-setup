Import-Module "$PSScriptRoot/../utilities"

function downloadWallpaper {
  printInfo "Downloading wallpaper..." "   "

  try {
    $outPath = "$env:WINDIR/Personalization"
    New-Item $outPath -ItemType "Directory" | Out-Null
    (New-Object System.Net.WebClient).DownloadFile("https://github.com/dreisss/iespes-extra/raw/main/design/wallpapers/wallpaper.png", "$outPath/wallpaper.png")
    printSuccess "Wallpaper downloaded." "   "
  }
  catch {
    printError "Failed to download wallpaper." "   "
  }
}

function setDesktopWallpaper {
  printInfo "Setting desktop wallpaper..." "   "

  try {
    New-ItemProperty -PropertyType "DWord" -Value 1 -Name "DesktopImageStatus" "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null
    New-ItemProperty -PropertyType "String" -Value "$env:WINDIR/Personalization/wallpaper.png" -Name "DesktopImagePath" "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null
    printSuccess "Desktop wallpaper set." "   "
  }
  catch {
    printError "Failed to set desktop wallpaper." "   "
  }
}

function setLockScreenWallpaper {
  printInfo "Setting lock screen wallpaper..." "   "

  try {
    New-ItemProperty -PropertyType "DWord" -Value 1 -Name "LockScreenImageStatus" "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null
    New-ItemProperty -PropertyType "String" -Value "$env:WINDIR/Personalization/wallpaper.png" -Name "LockScreenImagePath" "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null
    printSuccess "Lock screen wallpaper set." "   "
  }
  catch {
    printError "Failed to set lock screen wallpaper." "   "
  }
}

function setWallpapers {
  printInfo "Setting wallpapers..."

  New-Item -Path "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null

  downloadWallpaper
  setDesktopWallpaper
  setLockScreenWallpaper

  printSuccess "Wallpapers set."
}
