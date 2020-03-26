#!/bin/sh -e

VERSION=1353
sudo adduser --disabled-login terraria
wget -O terraria-server.zip http://terraria.org/server/terraria-server-${VERSION}.zip
unzip terraria-server.zip
rm -rf ${VERSION}/Windows
rm -rf ${VERSION}/Mac
sudo mv ${VERSION} /usr/local/terraria
rm -rf ${VERSION}
rm terraria-server.zip
sudo chown -R terraria:terraria /usr/local/terraria
sudo cp terraria.service.default /etc/systemd/system/terraria.service
sudo ufw allow 7777
sudo -u terraria /usr/local/terraria/Linux/TerrariaServer.bin.x86_64
sudo systemctl daemon-reload
sudo systemctl enable terraria.service
sudo systemctl start terraria
sudo systemctl status terraria