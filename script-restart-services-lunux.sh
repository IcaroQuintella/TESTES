#!/bin/bash
if [ "$EUID" -ne 0 ]
      then echo "Por favor, execute como root!"
    exit
fi
#------------------------------------------------------------------------------------#
SERVER=DEBIAN-PHP2 # IP ou nome do servidor de destino (se for colocar o nome, favor adicionar a arquivo /etc/hosts)
USER=icaro # Usuário configurado com a chave ssh
PATH_KEY_SSH=/home/$USER/.ssh/id_rsa # Caminho da chave ssh
# Função
executa_validacao() {
  # Variavel retorno usada para pegar o valor da saida do comando, 0 para OK e 1 para erro
  retorno=$?
  # Validacao do comando
  if [ $1 == "start" ] || [ $1 == "stop" ] || [ $1 == "restart" ] || [ $1 == "reload" ]; then
    if [ $retorno -eq 0 ]; then
          echo -e "\033[0;32m $1 $2 OK \033[0m"
    else
          echo -e "\033[0;32m Não foi possivel $1 o $2, journalctl -xe para logs \033[0m"
    fi
  fi
}
#------------------------------------------------------------------------------------#
# Local command
echo -e "\033[0;33m... $1 $2 no $HOSTNAME\033[0m"
systemctl $1 $2
executa_validacao $1 $2

echo

# Remote command
echo -e -n "\033[0;33m... $1 $2 no \033[0m" && ssh -i $PATH_KEY_SSH $USER@$SERVER 'echo -e "\033[0;33m$HOSTNAME\033[0m"'
ssh -i $PATH_KEY_SSH $USER@$SERVER "sudo systemctl $1 $2"
executa_validacao $1 $2

# O Scrip deverá ser salvo com nome "remote-systemctl.sh" com as permissções de execução (chmod +x remote-systemctl.sh)
# Para facilitar o a utilização do comando, um alias deverá ser criado. Veja uma exemplo de alias
# alias remote-systemctl="/Caminho_do_script/remote-systemctl.sh"
#
# A execução do comando seguirá da seguinte forma:
# remote-systemctl start|restart|status|reload <Serviço>
#
# Exemplo com o apache:
# remote-systemctl start apache2