#!/bin/bash

PURPLE='0;35'
NC='\033[0m'
VERSAO=17

echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Olá Aluno, serei seu assistente para instalação do CashTech!;"

echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Vamos verificar se o docker está instalado...;"
sleep 2

docker --version
if [ $? -eq 0 ]; then
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) : Você já tem o docker instalado!"
else
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Opa! Não identifiquei nenhuma versão do Docker, irei resolver isso agora!"
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Ok! começando processo de instalação"
	sleep 2
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Atualizando! Quase lá."
	sleep 2
	sudo apt update -y
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Preparando para instalar o Docker."
	sleep 2
	sudo apt install docker.io
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Ativando o serviço..."
	sleep 2
	sudo systemctl start docker
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Habilitando o serviço..." 
	sudo systemctl enable docker
	clear
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Docker instalado com sucesso!"
	sleep 2
fi

echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Criando ambiente para execução do projeto"
echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Baixando imagem do banco de dados no DockerHub..."
sudo docker pull pedrorocs/cash_tech
echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Criando container do banco de dados da aplicação"
sudo docker run -d -p 3306:3306 --name ContainerCashtechBd pedrorocs/cash_tech
echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) A instalação foi concluida com sucesso!"
sleep 2
clear

echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Digite 1 para instação com interface gráfica e 2 para command line!"

read tipo

if [ \"$tipo\" == \"1\" ]; then
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Ok! Você escolheu instalar com interface gráfica ;D"
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Baixando o executavel....."
	wget https://github.com/CashTec/CashTechExecutavel/raw/main/cashtech-jar-gui.jar
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Verificando aqui se você possui o Java instalado...;"
	sleep 2

	java -version
	if [ $? -eq 0 ]; then
		echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) : Você já tem o java instalado!!!"
	else
		echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Opa! Não identifiquei nenhuma versão do Java instalado, mas sem problemas, irei resolver isso agora!"
		echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Confirme para mim se realmente deseja instalar o Java (S/N)?"
		read inst
		if [ \"$inst\" == \"S\" ]; then
			echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Ok! Você escolheu instalar o Java ;D"
			echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Adicionando o repositório!"
			sleep 2
			sudo add-apt-repository ppa:webupd8team/java -y
			echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Atualizando! Quase lá."
			sleep 2
			sudo apt update -y
			clear

			if [ $VERSAO -eq 17 ]; then
				echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Preparando para instalar a versão 17 do Java. Confirme a instalação quando solicitado ;D"
				sudo apt install openjdk-17-jdk
				-y
				clear
				echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Java instalado com sucesso!"
			fi
		else
			echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Você optou por não instalar o Java por enquanto, até a próxima então!"
		fi
	fi
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Iniciando a execução da aplicação"
	sleep 2
	clear
	java -jar cashtech-jar-gui.jar
else
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7)  Ok! Você escolheu instalar com command line ;D"
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Baixando o executavel....."
	sudo docker pull murilosbarbosa/cashtech-cli
	echo "$(tput setaf 10)[Bot assistant]:$(tput setaf 7) Iniciando a execução da aplicação"
	sleep 2
	clear
	sudo docker run -it --name ContainerCashTech -p 8080:8080 murilosbarbosa/cashtech-cli
fi
