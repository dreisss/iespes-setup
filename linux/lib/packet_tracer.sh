#!/bin/bash

# TODO: fix installation
wget -O ~/Downloads/packet-tracer-6.3.gz https://github.com/dreisss/iespes-setup/raw/main/linux/other/packet-tracer-6.3.gz
cd ~/Downloads && tar -xf packet-tracer-6.3.gz && cd PacketTracer63 && ./install && cd

# tar -xf ~/Downloads/packet-tracer-7.0.0.tar.gz -C ~/Downloads
# cd ~/Downloads/PacketTracer70 && sudo ./install && cd

# cp /opt/pt/bin/Cisco-PacketTracer.desktop ~/.local/share/applications/
# sed -i 's/Exec=.*/Exec=\/opt\/pt\/packettracer/g' ~/.local/share/applications/Cisco-PacketTracer.desktop
# sed -i 's/Icon=.*/Icon=\/opt\/pt\/art\/app.png/g' ~/.local/share/applications/Cisco-PacketTracer.desktop
# chmod +x ~/.local/share/applications/Cisco-PacketTracer.desktop

# sudo rm -rf ~/Downloads/{packet-tracer-7.0.0.tar.gz,PacketTracer70}
