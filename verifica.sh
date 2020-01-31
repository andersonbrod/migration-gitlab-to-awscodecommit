#!/bin/bash
echo "Verificação de diretórios GITLab para CodeCommit";
echo "Nti Sistemas - Uninta"
echo "===================================================="
echo "Processamento do arquivo repositories-aws.json"
echo "===================================================="
echo " "
echo " "

#variáveis de controle
continua=1
i=0
length_json=$(cat gitlab-projects-p$1.json | jq '. | length')

while [ $i -lt $length_json ]
do
    repo_name=$(cat gitlab-projects-p$1.json | jq '.['$i'].name')
    
    #echo $repo_name
    {
        $(eval "aws codecommit get-repository --repository-name $repo_name > temp.json")
    } ||
    {
        $(eval "echo $repo_name >> resultado.txt")
        echo "$repo_name ****Repositório não encontrado****" 
    }
	

    repo_exist=$(cat temp.json | jq '.repositoryMetadata.repositoryName')

    echo "$repo_exist Repositório encontrado"

    # if [ $repo_exist = "null" ]
    # then
    #     $(eval "echo $repo_name >> resultado.txt")
    #     echo "$repo_name ****Repositório não encontrado****" 
    # fi
    rm temp.json
    i=$(($i+1))
done
