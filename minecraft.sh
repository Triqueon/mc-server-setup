#!/bin/sh -e

sudo adduser --disabled-login minecraft
wget -O server.jar https://launcher.mojang.com/v1/objects/808be3869e2ca6b62378f9f4b33c946621620019/server.jar
sudo mv server.jar /usr/local/minecraft
echo "eula=true" > eula.txt
sudo mv eula.txt /usr/local/minecraft
sudo chown -R minecraft:minecraft /usr/local/minecraft
sudo cp minecraft.service.default /etc/systemd/system/minecraft.service
sudo systemctl daemon-reload
sudo systemctl enable minecraft.service
sudo systemctl start minecraft
sudo systemctl status minecraft