#!/bin/bash

networkInterface="$(nmcli c | awk -F '  ' '{ if (NR==2) print $1 }')"

if [ $(nmcli d | grep "conectado" -c) -lt 1 ]; then
	if [ $(nmcli d | grep "wifi" -c) -ge 1 ]; then
		nmcli d w c "WIFI ALUNOS IESPES"
	else
		nmcli c m "$networkInterface" ipv4.addresses "192.168.$1.$(($2 + 1))/24"
		nmcli c m "$networkInterface" ipv4.gateway "192.168.$1.1"
		nmcli c m "$networkInterface" ipv4.dns "8.8.8.8"
		nmcli c m "$networkInterface" ipv4.method "manual"
		nmcli c u "$networkInterface"
	fi
fi

sleep 5

if [ $(nmcli d | grep "conectado" | wc -l) != 1]; then
	echo "Failed to connect to internet."
fi

gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/wallpaper.png"
gsettings set com.zorin.desktop.auto-theme day-theme "ZorinGreen-Light"
gsettings set com.zorin.desktop.auto-theme night-theme "ZorinGreen-Dark"
gsettings set org.gnome.desktop.interface icon-theme "ZorinGreen-Dark"
gsettings set org.gnome.desktop.interface gtk-theme "ZorinGreen-Dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.shell.extensions.user-theme name "ZorinGreen-Dark"

gsettings set org.gnome.desktop.session idle-delay "uint32 0"
