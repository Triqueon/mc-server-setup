Setup Steps

1. General Setup
  * Install low privilege user and setup login via ssh keys (ssh-copy-id)
  * Disallow SSH Login for root
  * Setup fail2ban/sendmail and enable them via systemctl start ==> systemctl enable
  * Install screen and JRE (headless, currently openjdk-8-jre-headless)
  * Install firewall (ufw)
