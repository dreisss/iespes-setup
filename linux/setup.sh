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
	exit
fi

if [ $(cat /etc/passwd | grep "aluno" | wc -l) != 1 ]; then
	sudo adduser --disabled-password --gecos "" aluno
	sudo passwd -d aluno
fi

sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt install build-essential net-tools cpu-x -y

if [ $1 = 3 ]; then
	sudo apt install vim virtualbox -y

	wget -O ~/Downloads/packet-tracer-7.0.0.tar.gz https://raw.githubusercontent.com/dreisss/iespes-setup/linux/other/packet-tracer-7.0.0.tar.gz
	tar -xf ~/Downloads/packet-tracer-7.0.0.tar.gz -C ~/Downloads
	~/Downloads/PacketTracer70/install

	rm -rf ~/Downloads/{packet-tracer-7.0.0.tar.gz,PackertTracer70}
fi

sudo wget -O /usr/share/backgrounds/wallpaper.png https://raw.githubusercontent.com/dreisss/iespes-extra/main/design/wallpapers/wallpaper.png

gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/wallpaper.png"
gsettings set com.zorin.desktop.auto-theme day-theme "ZorinGreen-Light"
gsettings set com.zorin.desktop.auto-theme night-theme "ZorinGreen-Dark"
gsettings set org.gnome.desktop.interface icon-theme "ZorinGreen-Dark"
gsettings set org.gnome.desktop.interface gtk-theme "ZorinGreen-Dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.shell.extensions.user-theme name "ZorinGreen-Dark"

gsettings set org.gnome.desktop.session idle-delay "uint32 0"
