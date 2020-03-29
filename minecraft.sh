#!/bin/sh -e

#Add User
if ! id "minecraft" >/dev/null 2>&1; then
  sudo adduser --disabled-login minecraft
fi

#Download JAR File. This may need to updated for the current version
wget -O server.jar https://launcher.mojang.com/v1/objects/808be3869e2ca6b62378f9f4b33c946621620019/server.jar
sudo mkdir /usr/local/minecraft
sudo mv server.jar /usr/local/minecraft/

#Accept EULA
echo "eula=true" > eula.txt
sudo mv eula.txt /usr/local/minecraft

sudo chown -R minecraft:minecraft /usr/local/minecraft

#Copy service file and load the new service
sudo cp minecraft.service.default /etc/systemd/system/minecraft.service
sudo systemctl daemon-reload
sudo systemctl enable minecraft.service
sudo systemctl start minecraft
sudo systemctl status minecraft