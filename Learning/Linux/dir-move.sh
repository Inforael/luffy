#!/bin/bash

conv_img(){

    local caminho_imagem=$1
    local imagem_sem_extensao=$(ls $caminho_imagem | awk -F. '{ print $1 }')
    convert $imagem_sem_extensao.jpg $imagem_sem_extensao.png
}

varrer_diretorio(){

    cd $1
    for arquivo in *
    do 
        local caminho_arquivo=$(find ~/scripts -name $arquivo)
        if [ -d $caminho_arquivo]
        then
                varrer_diretorio $caminho_arquivo
        else
                conv_img $caminho_arquivo
        fi 
    done 
}

varrer_diretorio ~/scripts
if [ $? -eq 0 ]
then
      echo "conversão relalizada com sucesso"
else 
      echo "falha na conversão"
fi             