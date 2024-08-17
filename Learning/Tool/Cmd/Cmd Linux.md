--------------------------------------------------------

########### --- Comando --- Linux------################

# https://ss64.com/bash/


vi /etc/apt/sources.list

apt-get update

lsb_release -a

apt-get install module-assistant build-essential -y

m-a prepare

cd /media/cdrom
mount /media/cdrom

ctrl + d sai do usuário root

---------------------------------------------------------


---------------------------------------------------------
wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -

sudo apt update

sudo apt install opera-stable

----------------------------------------------------------------

sudo apt update
sudo apt install snap snapd

sudo snap install vlc


--------------------------------------------------------------

sudo apt install
apt --fix-broken install


--------------------------------------------------------
link
https://www.hostinger.com.br/tutoriais/comandos-linux



vi /etc/apt/sources.list

apt-get update

lsb_release -a

apt-get install module-assistant build-essential -y

m-a prepare

cd /media/cdrom
mount /media/cdrom

ctrl + d sai do usuário root

----------------------------------------------------------------
wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -

sudo apt update

sudo apt install opera-stable

----------------------------------------------------------------

sudo apt update
sudo apt install snap snapd

sudo snap install vlc


----------------------------------------------------------------

cmd para concertar pacotes.

sudo apt install
apt --fix-broken install

----------------------------------------------------------------

cmd para escrever em um bloco de notas

echo "israel escrevendo em linux"> nota.txt

Cmd para ler conteúdo do arquivo

cat nota.txt


----------------------------------------------------------------

-- Cmd grep expressão regular 

ls -l /etc | grep -n "log_teste"

----------------------------------------------------------------

-- Cmd para copiar arquivo

cp /etc/passwd .

---------------------------------------------------------------

-- Cmd para colocar número de linhas

nl passwd

---------------------------------------------------------------

-- Cmd para sed

sed '31d' passwd


---------------------------------------------------------------

-- Cmd para adicionar usuário ao sudo

gpasswd -a rael sudo
vi /etc/sudoers

---------------------------------------------------------------


-- Cmd para dar permissão de execução

chmod a+x testevar2.sh
chmod 755 va.sh
./testevar2.sh
---------------------------------------------------------------

-- Cmd para instalr vim atualizado 

sudo apt update

sudo apt install vim

vim -version

linha no vim 

set number 
:set nonumber

---------------------------------------------------------------

-- Cmd Vim

i ou insert entra no vim

o

Entra modo de inserção movendo linha para 

Shift + O 

Entra modo de inserção movendo texto para cima

u desfaz no modo cmd

ctrl + r refaz no modo cmd

sair sem salvar 

:q!

salvar e sair

:wq ou :x ou ZZ

ajuda no vi
:help ou help + comando or vimtutor

para sair :q

mod cmd 
yank para copiar no vim

yy ou Y cópia linha interia

p cola 

dd para deletar

cc deleta e entra mod insert

:digraphs
ctrl + K 

---------------------------------------------------------------
https://linuxize.com/post/how-to-install-visual-studio-code-on-debian-10/

-- Cmd para instalar vccode 

sudo apt install software-properties-common apt-transport-https curl

curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"




---------------------------------------------------------------

-- Cmd para criar diretório(pasta)

MKDIR WORKSPACE

/ e raiz da máquina linux

remove diretório se ele estiver vazio

rmdir workspace

rm -r workspace apaga recursivamente dos os arquivos 

--------------------------------------------------------------

cmd para remover arquivos

rm arquivo3.txt

rm -r workspace

---------------------------------------------------------------



---------------------------------------------------------------

-- Cmd para criar arquivo

echo "criando arquivo" > new-arquivo.txt
---------------------------------------------------------------

-- Cmd para ler conteúdo do arquivo.

cat new-arquivo.txt
cat *.txt le todos os arquivos da pasta


---------------------------------------------------------------

-- Cmd para copiar conteúdo do arquivo

cp cópiar arquivo

cp msg.txt bemvindo.txt

mv move arquivo 

mv msg.txt bemvindo3.txt

move para diretório

mv msg.txt projeto-java/

Cmd para cópiar o diretório inteiro 

cp - r pasta1 pasta2


---------------------------------------------------------------

-- Cmd para abrir arquivo zip

zip -r work.zip workspace/

cmd para dizipar
unzip -rq work.zip

cmd para ver conteúdo do zip
unzip -l work.zip

--------------------------------------------------------------

Cmd tar

tar -cz workspace > work.tar.gz
tar -czf work.tar.gz workspace/

copacta mais rápido
tar -cjf work.tar.bz2 workspace/

cmd p/ dizipar

tar -xzf work.tar.gz
tar -vxzf work.tar.gz


---------------------------------------------------------------

-- Cmd para trabalhar com data

date

date "+%d de %B de %Y"
date "+%d de %b de %Y"
---------------------------------------------------------------

-- Cmd para ler as primeiras linhas do cabeçalho

head -n 3 arquivo.txt

less arquivo.txt

tail -n 3 arquivo.txt


---------------------------------------------------------------


-- Cmd para add caminho path

env | grep PATH
PATH=$PATH:/home/rael/pasta
which pasta
-----------------------------------

Cmd para instalar pacotes

sudo dpkg -i pacote
sudo dpkg -r pacote

sudo apt-get -f install

---------------------------------
sudo service nome programa stop
sudo service nome programa start

---------------------------------

https://www.lifewire.com/convert-linux-command-unix-command-4097060

sudo apt install imagemagick

cmd para converte arquivo

convert foto.jpg fotopng.

-----------------------------------------------------------------------
#! /bin/bash

converte_imagem(){

cd ~/Downloads/imagens-livros

if [ ! -d png ]
then
    mkdir png
fi

for imagem in *.jpg
do
    imagem_sem_extensao=$(ls $imagem | awk -F. '{ print $1 }')
    convert $imagem_sem_extensao.jpg png/$imagem_sem_extensao.png
done
}

converte_imagem 2>erros.txt
if [$? -eq 0]
then
     echo " Conversão feita com sucesso"
else
     echo " houve uma falha no processo"

fi

-----------------------------------------------------------------------
Cmd para instalar pacote gedit

Update the package index:
# sudo apt-get update
Install gedit deb package:
# sudo apt-get install gedit

-----------------------------------------------------------------------
#! /bin/bash

if [ ! -d log ]
then
     mkdir log
fi

processos_memoria(){
processos=$(ps -e -o pid --sort -size | head -n 11 | grep [0 - 9])
for pid in $processos
do
    nome_processo=$(ps -p $pid -o comm=)
    echo -n $(date +%F,%H:%M:%S,) >> log/$nome_processo.log
    tamanho_processo=$(ps -p $pid -o size | grep [0-9])
    echo "$(bc <<< "scale=2;$tamanho_processo/1024") MB" >> log/$nome_processo.log
done
}
processos_memoria
if [ $? -eq 0 ]
then 
     echo " Os arquvivos foram salvos com sucesso"
else
     echo " Houve um erro na hora de salvar o arquivo"
fi

vboxmanage modifyhd "C:\Bko\VM\Tux\Tux.vdi" --resize 10000

----------------------------------

cmd mudar senha do usuário

passwd rael

cmd sync para gravar no disco


cmd para reiniciar

reboot -f  para reiniciar o pc
sudo shutdown -r now

cmd  para desligar 

sudo shutdown -h now

----------------------------------

Cmd Matar processos

ps aux | grep bash

sudo kill -9 2315

-----------------------------------

Cmd add sudo ao usuário

sudo vim sudores 

# User privilege specification
root	ALL=(ALL:ALL) ALL
rael    ALL=(ALL:ALL) ALL

----------------------------------

Cmd para reinstalar pacotes

sudo dpkg-reconfigure postfix

apt install dovecot-imapd dovecot-pop3d
sudo service dovecot restart

wget https://sourceforce.net/projects/squirrelmail/filea/stable/1.4.22/squirrelmail-webmail-1.4.22.zip

squirrelmail-1.4.8

unzip squirrelmail-webmail-1.4.22.zip
sudo unzip squirrelmail-webmail-1.4.22.zip



---------------------------------

cmd instalação vscode linux

sudo dpkg -i 

-------------------------------------
Cmd para rrodar sdk google 

curl https://sdk.cloud.google.com | bash
exec -l $SHELL

gcloud components update --version 186.0.0

gcloud auth login

gcloud config set project [ID do projeto]
gcloud compute instances create servidor-casadocodigo 
--image-family=ubuntu-1604-lts --image-project=ubuntu-os-cloud 
--zone southamerica-east1-a






























