#!/bin/bash
sudo apt update 
echo "Editando o arquivo de rede"
cat <<EOF > /etc/netplan/50-vagrant.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s8:
      addresses:
      - 192.168.100.180/24
      gateway4: 192.168.100.1
      nameservers:
        addresses:
        - 8.8.8.8
        - 8.8.4.4
EOF
sudo netplan try
sudo netplan apply
### vars.sh ####
USER='usuario'
PASS='Tech@2022'
echo "Criando usuário"
sudo useradd -m -d "/home/${USER}" -p $(openssl passwd -1 ${PASS}) -s /bin/bash ${USER}
echo "Tornando o usuario como sudo"
sudo usermod -aG sudo usuario
sudo mkdir /home/${USER}/.ssh && sudo touch /home/${USER}/.ssh/authorized_keys
sudo cat <<EOF > /home/${USER}/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3yyHoItY1v50BZkzsL2xGjdR8/2KvwiZzHMFaURhm3L4I/kxlBpxpecgCatUWaY7bMMOl4FeRhlHxUX5l+EqnV1YB4bHxZPWxE3tdqqySk/c3Xlheu/l2giaYFEbhXfaAK8jwyaCNy6EqNwd6BLlwNOLjBjEHRWK+CDv4ehOJbjz/Z01wKa+7Ul8bUoicdz0qoeeUwMgFVBOLyA0FrPwd5z7ce8oHK9ZaojJm3zRml2MZ5VE5pThyJLjAc7+QZ9k9ZzF9/Q9ohM7dKahQ/VlML1KNZLnnHXDXnpEbzli7Aq6fjVHzDHXuKR0OfwUdHmi4kdCxsTofdfMGP7cWwd2z88/nUg1fTYDtkCog+/nq0Q5cvWeap72lQ4N8zFtc6j0+Hq1TMcVjKH+bYPgViDVZfpYamBwxnfs1IFlP7AIMbJPB+3DF8q9lO6hxUSqDZbSgeiUQhUOYOfrm53phD9ujXK8yaCpy8RxIFAwfnggdrTZtJhoUqB5HCzv4p9wYngE= root@SPIDER-UBUNTU
EOF
echo "fim criação de usuário"
sudo systemctl restart ssh 