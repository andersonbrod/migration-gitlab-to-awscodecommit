#!/bin/sh
#Escrito por Anderson Barbosa Rodrigues - NTI Sistemas em 23-01-2020
#Params
#<script> [página do diretório ./] - arquivo deve conter nome gitlab-projects-p[número da página]
#

echo "Migrating GITLab repositories to CodeCommit";
echo ""
echo "===================================================="
echo "Processing file gitlab-projects-p$1.json"
echo "===================================================="
echo " "
echo " "

#variáveis de controle
continua=1
i=0
length_json=$(cat gitlab-projects-p$1.json | jq '. | length')

while [ $i -lt $length_json ]
do
	description=$(cat gitlab-projects-p$1.json | jq '.['$i'].description')
	name=$(cat gitlab-projects-p$1.json | jq '.['$i'].name')
	http_url_to_repo=$(cat gitlab-projects-p$1.json | jq '.['$i'].http_url_to_repo')
    
	#teste de name null
	#name=$(cat gitlab-projects.json | jq '.[500].name')
	
    #inserir operacoes aqui
    echo $i ' - ' $name

    echo "...Processo de cópia repositório $name do Gitlab para AWS..."
    echo "Command: aws codecommit create-repository --repository-name $name"
    $(eval "aws codecommit create-repository --repository-name $name > .temp.json")
    
    echo "...Clonando projeto original do Gitlab $name"
    echo "Command: git clone --mirror $http_url_to_repo $name"
    $(eval "git clone --mirror $http_url_to_repo $name")
    
    echo "...Enviando Projeto $name para AWS..."
    pwd
    url_aws_repo=$(cat /home/user/migration-gitlab-to-awscodecommit/.temp.json | jq '.repositoryMetadata.cloneUrlSsh')
    $(eval "git -C /home/user/migration-gitlab-to-awscodecommit/$name push $url_aws_repo --all")
    rm .temp.json
    echo "Projeto $name enviado com sucesso..."
	
    i=$(($i+1))
done
