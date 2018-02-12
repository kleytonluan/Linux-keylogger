#!/bin/bash

echo -e "Instalar e configurar servidor smtp"
sleep 2

echo -e "Instalando dependencias"
sleep 2

sudo apt-get update
sudo apt-get install ssmtp -y
sudo apt-get install mailutils -y

echo -e ""
echo -e "Configurando servidor"
sleep 2

conf1="ssmtp.conf"

sudo mv /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.old
sudo cp $conf1 /etc/ssmtp/

sudo mv /etc/ssmtp/revaliases /etc/ssmtp/revaliases.old

sleep 2

echo -e ""
echo -e "Configurar e-mail de saida"

sleep 1

echo -e "Digite o seu Gmail para o root:"
read email
echo -e "Digite o Gmail novamente:"
read email
echo -e "Digite a senha do seu Gmail:"
read senha

sleep 2

echo "root=$email" >> /etc/ssmtp/ssmtp.conf
echo "AuthUser=$email" >> /etc/ssmtp/ssmtp.conf
echo "AuthPass=$senha" >> /etc/ssmtp/ssmtp.conf

sleep 2

echo -e "Configurando Revaliases"

sudo touch /etc/ssmtp/revaliases

echo "root:$email:smtp.gmail.com:587" > /etc/ssmtp/revaliases

sleep 2
echo -e ""
echo -e "Fim"
exit
