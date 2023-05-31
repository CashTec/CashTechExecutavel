#!/bin/bash

COR='36'
NC='\033[0m'
VERSAO=17

echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) Olá Aluno, serei seu assistente para instalação do Java!;"
echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Verificando aqui se você possui o Java instalado...;"
sleep 2

java -version
if [ $? -eq 0 ]; then
	echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) : Você já tem o java instalado!!!"
else
	echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Opa! Não identifiquei nenhuma versão do Java instalado, mas sem problemas, irei resolver isso agora!"
	echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Confirme para mim se realmente deseja instalar o Java (S/N)?"
	read inst
	if [ \"$inst\" == \"S\" ]; then
		echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Ok! Você escolheu instalar o Java ;D"
		echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Adicionando o repositório!"
		sleep 2
		sudo add-apt-repository ppa:webupd8team/java -y
		clear
		echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Atualizando! Quase lá."
		sleep 2
		sudo apt update -y
		clear

		if [ $VERSAO -eq 17 ]; then
			echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) Preparando para instalar a versão 17 do Java."
			sleep 2
			sudo apt install openjdk-17-jdk -y
			echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) Java instalado com sucesso!"
			sleep 2
			clear
		fi
	else
		echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Você optou por não instalar o Java por enquanto, até a próxima então!"
	fi
fi

echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Agora, vamos verificar se o docker esta instalado...;"
sleep 2

docker --version
if [ $? -eq 0 ]; then
	echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) : Você já tem o docker instalado!"
	sleep 2
else
	echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Opa! Não identifiquei nenhuma versão do Docker, irei resolver isso agora!"
	echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Ok! começando processo de instalação"
	sleep 2
	clear
	echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Atualizando! Quase lá."
	sleep 2
	sudo apt update -y
	clear
	echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) Preparando para instalar o Docker."
	sudo apt install docker.io
	echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) Iniciando o serviço do Docker."
	sleep 5
	sudo service docker start
	sudo systemctl start docker
	sudo systemctl enable docker
	sleep 2
	clear
	echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) Docker instalado com sucesso!"
fi

echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Criando ambiente para execução do projeto"
echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Baixando imagem do DockerHub..."
sudo docker pull pedrorocs/cash_tech
echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) Criando container da aplicação"
sudo docker run -d -p 3306:3306 --name container-cashtech pedrorocs/cash_tech
echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) A instalação foi concluida com sucesso!"
sleep 2
clear
echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) Digite 1 para instalação com interface gráfica ou 2 para command line!"

sudo find -name 'cashtech-jar*.jar' -delete

read tipo

if [ \"$tipo\" == \"1\" ]; then
	echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Ok! Você escolheu instalar com interface gráfica ;D"
	echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) Baixando o executavel....."
	wget https://github.com/CashTec/CashTechExecutavel/raw/main/cashtech-jar-gui.jar
	jar='./cashtech-jar-gui.jar'
else
	echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7)  Ok! Você escolheu instalar com command line ;D"
	echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) Baixando o executavel....."
	wget https://github.com/CashTec/CashTechExecutavel/raw/main/cashtech-jar-cli.jar
	jar='./cashtech-jar-cli.jar'
fi
echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) Aplicação baixada com sucesso!"

sleep 2

clear

echo "$(tput setaf $COR)[CashTech assistant]:$(tput setaf 7) Iniciando a execução da aplicação"
java -jar $jar
