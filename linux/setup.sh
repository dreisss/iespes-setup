#!/bin/bash

./lib/network.sh $1 $2
./lib/default_user.sh

sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt install build-essential net-tools vim cpu-x -y

./lib/firefox.sh

if [ $1 = 3 ]; then
	sudo apt install virtualbox -y

	./lib/packet_tracer.sh
fi

./lib/tweaks.sh
