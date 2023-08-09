function optimize {
  Set-ItemProperty -Force -Type "DWord" -Value 2 -Name "VisualFXSetting" "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
  Set-ItemProperty -Force -Type "DWord" -Value 0 -Name "EnableTransparency" "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
}

function setColorConfigs {
  [byte[]] $binaryPaletteCode = "94,e0,b1,00,75,c7,95,00,3d,ad,68,00,10,89,3e,00,0b,5c,2a,00,08,42,1e,00,05,2b,14,00,00,b7,c3,00".Split(',') | ForEach-Object { "0x$_" }
  Set-ItemProperty -Force -Type "String" -Value "0xff3e8910" -Name "AccentColorMenu" "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent"
  Set-ItemProperty -Force -Type "Binary" -Value $binaryPaletteCode -Name "AccentPalette" "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent"
  Set-ItemProperty -Force -Type "String" -Value "0xff2a5c0b" -Name "StartColorMenu" "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent"
  Set-ItemProperty -Force -Type "DWord" -Value 0 -Name "SystemUsesLightTheme" "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
  Set-ItemProperty -Force -Type "DWord" -Value 0 -Name "AppsUseLightTheme" "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
  Set-ItemProperty -Force -Type "String" -Value 2 -Name "FontSmoothing" "HKCU:\Control Panel\Desktop"
}

function other {
  Set-ItemProperty -Force -Type "DWord" -Value 0 -Name "BingSearchEnabled" "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"
  Set-ItemProperty -Force -Type "DWord" -Value 1 -Name "LaunchTo" "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
  Set-ItemProperty -Force -Type "DWord" -Value 0 -Name "ShowRecent" "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
  Set-ItemProperty -Force -Type "DWord" -Value 0 -Name "ShowFrequent" "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
}

optimize
setColorConfigs
other
