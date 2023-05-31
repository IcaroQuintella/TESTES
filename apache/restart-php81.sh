#!/bin/bash
if [ "$EUID" -ne 0 ]
          then echo "Por favor, execute como root!"
                    exit
fi

#------------------------------------------------------------------------------------#
# Reiniciando apache
echo -e "\033[0;33mReiniciando PHP 8.1 $HOSTNAME\033[0m"
systemctl restart php8.1-fpm
if [ $? == '0' ]; then
        echo -e "\033[0;32m OK \033[0m"
else
        echo -e "\033[0;32m Não foi possivel reinciar o PHP 8.1 $HOSTNAME \033[0m"
fi
echo

# Reiniciando apache Apache2
ssh -i /home/syncdir/chave syncdir@192.168.100.142 'echo -e "\033[0;33mReiniciando PHP 8.1 $HOSTNAME\033[0m"'
ssh -i /home/syncdir/chave syncdir@192.168.100.142 'sudo systemctl restart php8.1-fpm'
if [ $? == '0' ]; then
        echo -e "\033[0;32m OK \033[0m"
else
        echo -e "\033[0;32m Não foi possivel reinciar o PHP 8.1 \033[0m"
fi
echo
