Import-Module "$PSScriptRoot/utilities"

function getWallpaper {
  printInfo("Downloading wallpapers...") "   "

  try {
    $outPath = "$env:WINDIR/Personalization"
    New-Item $outPath -ItemType "Directory" | Out-Null
    (New-Object System.Net.WebClient).DownloadFile("https://github.com/dreisss/iespes-extra/raw/main/design/wallpapers/wallpaper.png", "$outPath/wallpaper.png")
    printSuccess("Wallpapers downloaded.") "   "
  }
  catch {
    printError("Failed to download wallpapers.") "   "
  }
}

function setDesktopWallpaper {
  printInfo("Setting desktop wallpaper...") "   "

  try {
    New-ItemProperty -PropertyType "DWord" -Value 1 -Name "DesktopImageStatus" "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null
    New-ItemProperty -PropertyType "String" -Value "$env:WINDIR/Personalization/wallpaper.png" -Name "DesktopImagePath" "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null
    printSuccess("Desktop wallpaper set.") "   "
  }
  catch {
    printError("Failed to set desktop wallpaper.") "   "
  }
}

function setLockScreenWallpaper {
  printInfo("Setting lock screen wallpaper...") "   "

  try {
    New-ItemProperty -PropertyType "DWord" -Value 1 -Name "LockScreenImageStatus" "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null
    New-ItemProperty -PropertyType "String" -Value "$env:WINDIR/Personalization/wallpaper.png" -Name "LockScreenImagePath" "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null
    printSuccess("Lock screen wallpaper set.") "   "
  }
  catch {
    printError("Failed to set lock screen wallpaper.") "   "
  }
}

function setWallpapers {
  printInfo("Setting wallpapers...")

  New-Item -Path "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null

  getWallpaper
  setDesktopWallpaper
  setLockScreenWallpaper
}

function setAccentColor {
  [byte[]] $binaryPaletteCode = "94,e0,b1,00,75,c7,95,00,3d,ad,68,00,10,89,3e,00,0b,5c,2a,00,08,42,1e,00,05,2b,14,00,00,b7,c3,00".Split(',') | ForEach-Object { "0x$_" }

  Set-ItemProperty -Force -Type "String" -Value "0xff3e8910" -Name "AccentColorMenu" "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/Accent"
  Set-ItemProperty -Force -Type "Binary" -Value $binaryPaletteCode -Name "AccentPalette" "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/Accent"
  Set-ItemProperty -Force -Type "String" -Value "0xff2a5c0b" -Name "StartColorMenu" "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/Accent"
}

function setColorConfigs {
  print("Setting accent color...")
  setAccentColor

  print("Setting system color to black...")
  Set-ItemProperty -Force -Type "DWord" -Value 0 -Name "SystemUsesLightTheme" "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Themes/Personalize"

  print("Setting apps color to black...")
  Set-ItemProperty -Force -Type "DWord" -Value 0 -Name "AppsUseLightTheme" "HKCU:/SOFTWARE/Microsoft/Windows/CurrentVersion/Themes/Personalize"

  print("Enabling font smoothing again...")
  Set-ItemProperty -Force -Type "String" -Value 2 -Name "FontSmoothing" "HKCU:/Control Panel/Desktop"
}