#!/bin/bash

echo -e "Instalar e configurar servidor de e-mail"
sleep 2

echo -e "Instalando dependencias"
sleep 2

sudo apt-get update
sudo apt-get install postfix -y
sudo apt-get install mailutils -y
sudo apt-get install libsasl2-2 -y
sudo apt-get install ca-certificates -y
sudo apt-get install libsasl2-modules -y

echo -e ""
echo -e "Configurando servidor"
sleep 2

conf2="main.cf"

sudo mv /etc/postfix/main.cf /etc/postfix/main.cf.old
sudo cp $conf2 /etc/postfix/

sleep 2
echo -e ""
echo -e "Configurar e-mail de saida"
sleep 2

echo -e "Digite o seu Gmail:"
read email
echo -e "Digite a senha do seu Gmail:"
read senha

sleep 2

sudo touch /etc/postfix/sasl_passwd

echo "[smtp.gmail.com]:587 $email:$senha" > /etc/postfix/sasl_passwd

echo -e ""
echo -e "Inserindo permissoes"
sleep 2

sudo chmod 400 /etc/postfix/sasl_passwd
sudo postmap /etc/postfix/sasl_passwd

sleep 2
echo -e ""
echo -e "Validade certificados"
sleep 2

sudo cat /etc/ssl/certs/thawte_Primary_Root_CA.pem | sudo tee -a /etc/postfix/cacert.pem

sleep 2

echo -e ""
echo -e "Reiniciando servidor Postfix"
sleep 2

sudo /etc/init.d/postfix reload

sleep 2
echo -e ""
echo -e "Fim"
exit
