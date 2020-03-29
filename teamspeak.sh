#!/bin/sh -e

#Add user if not already present
if ! id "teamspeak" >/dev/null 2>&1; then
  sudo adduser --disabled-login teamspeak
fi

#get teamspeak files. Must be updated for current version
wget -O teamspeak3-server.tar.bz2 http://dl.4players.de/ts/releases/3.7.1/teamspeak3-server_linux_amd64-3.7.1.tar.bz2
tar -jxvf teamspeak3-server.tar.bz2
sudo mv teamspeak3-server_linux_amd64 /usr/local/teamspeak
rm teamspeak3-server.tar.bz2

#accept EULA
sudo touch /usr/local/teamspeak/.ts3server_license_accepted

sudo chown -R teamspeak:teamspeak /usr/local/teamspeak
sudo cp ts3.service.default /etc/systemd/system/ts3.service

#Setup firewall rules
sudo ufw allow 9987/udp
sudo ufw allow 10011/tcp
sudo ufw allow 3033/tcp

#enable new service
sudo systemctl daemon-reload
sudo systemctl enable ts3.service
sudo systemctl start ts3
sudo systemctl status ts3