#!/bin/sh -e

VERSION=1353
ARCHITECTURE=x86_64
if ! id "terraria" >/dev/null 2>&1; then
  sudo adduser --disabled-login terraria
fi
wget -O terraria-server.zip http://terraria.org/server/terraria-server-${VERSION}.zip
unzip terraria-server.zip
sudo mv -f ${VERSION}/Linux/* /usr/local/terraria
rm -rf ${VERSION}
rm terraria-server.zip
sudo chown -R terraria:terraria /usr/local/terraria
sudo cp terraria.service.default /etc/systemd/system/terraria.service
sudo ufw allow 7777
sudo chmod +x /usr/local/terraria/TerrariaServer.bin.${ARCHITECTURE}
sudo -H -u terraria sh -c /usr/local/terraria/TerrariaServer.bin.${ARCHITECTURE}
sudo systemctl daemon-reload
sudo systemctl enable terraria.service
sudo systemctl start terraria
sudo systemctl status terraria
