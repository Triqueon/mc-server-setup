#!/bin/sh -e

VERSION=1353
ARCHITECTURE=x86_64
if ! id "terraria" >/dev/null 2>&1; then
  sudo adduser --disabled-login terraria
fi
wget -O terraria-server.zip http://terraria.org/server/terraria-server-${VERSION}.zip
unzip terraria-server.zip
sudo cp -r ${VERSION}/Linux/* /usr/local/terraria
rm -rf ${VERSION}
rm terraria-server.zip
sudo chown -R terraria:terraria /usr/local/terraria
sudo cp terraria.service.default /etc/systemd/system/terraria.service
sudo cp terraria.config /usr/local/terraria/terraria.config
sudo ufw allow 7777
sudo chmod +x /usr/local/terraria/TerrariaServer.bin.${ARCHITECTURE}
sudo -H -u terraria sh -c /usr/local/terraria/TerrariaServer.bin.${ARCHITECTURE}
sudo systemctl daemon-reload
sudo systemctl enable terraria.service
echo "Installation successful. Starting service, this may take a while..."
sudo systemctl start terraria
echo "Service started successfully."
sudo systemctl status terraria
