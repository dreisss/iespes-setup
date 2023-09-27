#!/bin/bash

if [ $(nmcli d s | grep " connected" | wc -l) != 1 ]
then
  nmcli c m "Wired connection 1" ipv4.addresses "192.168.3.$(($1 + 1))/24"
  nmcli c m "Wired connection 1" ipv4.gateway "192.168.3.1"
  nmcli c m "Wired connection 1" ipv4.dns "8.8.8.8"
  nmcli c m "Wired connection 1" ipv4.method "manual"
  nmcli c u "Wired connection 1"
fi

sudo adduser aluno
sudo passwd -d aluno

sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt install build-essential net-tools -y

sudo wget -O /usr/share/backgrounds/wallpaper.png https://raw.githubusercontent.com/dreisss/iespes-extra/main/design/wallpapers/wallpaper.png

gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/wallpaper.png"
gsettings set com.zorin.desktop.auto-theme day-theme "ZorinGreen-Light"
gsettings set com.zorin.desktop.auto-theme night-theme "ZorinGreen-Dark"
gsettings set org.gnome.desktop.interface icon-theme "ZorinGreen-Dark"
gsettings set org.gnome.desktop.interface gtk-theme "ZorinGreen-Dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.shell.extensions.user-theme name "ZorinGreen-Dark"
