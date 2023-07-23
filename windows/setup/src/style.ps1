Import-Module "$env:TEMP/utilities"

# ==================================================================> Wallpapers
function getWallpaper {
  $outPath = "$env:WINDIR/Personalization"
  New-Item $outPath -ItemType "Directory" | Out-Null
  (New-Object System.Net.WebClient).DownloadFile("https://github.com/dreisss/iespes-extra/raw/main/design/wallpapers/wallpaper.png", "$outPath/wallpaper.png")
}

function setDesktopWallpaper {
  New-ItemProperty -PropertyType "DWord" -Value 1 -Name "DesktopImageStatus" "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null
  New-ItemProperty -PropertyType "String" -Value "$env:WINDIR/Personalization/wallpaper.png" -Name "DesktopImagePath" "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null
}

function setLockScreenWallpaper {
  New-ItemProperty -PropertyType "DWord" -Value 1 -Name "LockScreenImageStatus" "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null
  New-ItemProperty -PropertyType "String" -Value "$env:WINDIR/Personalization/wallpaper.png" -Name "LockScreenImagePath" "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null
}

function setWallpapers {
  print("Downloading wallpapers...")
  getWallpaper
  print("Setting desktop wallpaper...")
  New-Item -Path "HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/PersonalizationCSP" | Out-Null
  setDesktopWallpaper
  print("Setting lock screen wallpaper...")
  setLockScreenWallpaper
}

# ======================================================================> Colors
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

# =====================================================================> Running

setWallpapers
setColorConfigs
