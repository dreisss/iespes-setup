#!/bin/bash

if [ ! -f /usr/bin/firefox-default ]; then
	sudo mv /usr/bin/firefox /usr/bin/firefox-default
	echo "firefox-default -private-window" | sudo tee /usr/bin/firefox
	sudo chmod +x /usr/bin/firefox
fi
