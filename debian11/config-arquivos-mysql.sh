#!/bin/bash

echo "Configurando os arquivos do mysql"

echo "Copiando o arquivo my.cnf"

cp /tmp/my.cnf /etc/

chown mysql:mysql /etc/my.cnf

echo "Copiando o arquivo mysql.cnf"

mkdir /etc/mysql

cp /tmp/mysql.cnf  /etc/mysql/

chown -R mysql:mysql /etc/mysql/

echo "Configurando o mysql files default"
cd /usr/local/mysql
./bin/mysqld --defaults-extra-file=/etc/my.cnf
