#!/bin/bash
echo "Inicial a instalação do BD"

cd /tmp

echo "Baixando o MariDB 10.0.38"
wget https://archive.mariadb.org/mariadb-10.0.38/bintar-linux-systemd-x86_64/mariadb-10.0.38-linux-systemd-x86_64.tar.gz

echo "Criando o grupo mysql"
groupadd mysql

echo "Criando o usuário mysql e adicionando ao grupo mysql"
useradd -g mysql mysql

echo "Extraindo e criando o link para a pasta mysql"
cd /usr/local

gunzip < /tmp/mariadb-10.0.38-linux-systemd-x86_64.tar.gz | tar xvf -

ln -s mariadb-10.0.38-linux-systemd-x86_64 mysql

cd mysql

chown -R mysql .

chgrp -R mysql .

echo "Instalando o MariaDB 10.0.38"
scripts/mysql_install_db --user=mysql

chown -R root .

chown -R mysql data

apt-get install libncurses5 -y

echo "export PATH=$PATH:/usr/local/mysql/bin/" >> /etc/bash.bashrc

echo "Criando o Seriviço do MariaDB"
# Criando o Serviço do maria DB
cd /etc/systemd/system/

touch  mariadb.service

cat <<EOF >>/etc/systemd/system/mariadb.service
[Unit]
Description=MariaDB

[Service]
Environment=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/mysql/bin/:/usr/local/m>
User=root
WorkingDirectory=/usr/local/mysql
ExecStart=/usr/local/mysql/bin/mysqld_safe --user=mysql
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

systemctl status mariadb.service
