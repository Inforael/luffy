Cmd para logar no GCP

gcloud init -- help 
gcloud init --console-only

---------------------------

Cmd para listar bucket

gsutil ls gs://dolsite/*

------------------------------------------------------------

Cmd para registrar o dominio 

https://www.google.com/webmasters/verification/home?hl=pt-PT

nome: WWW
Type CNAME
TTL 3600
TARGET:c.storage.googleapis.com

---------------------------------------------
cmd para criar um bucket 

gsutil mb gs://contabil-varejista
gsutil mb gs://www.contabilvarejista.com.br

--------------------------------------------

Cmd para subir arquivo bucket 

gsutil -m cp -R * gs://www.despensaonline.com.br

gsutil -m cp -R * gs://www.contabilvarejista.com.br

---------------------------------------------------------------------

Cmd para fazer download servidor




---------------------------------------------

Cmd para listar conteúdo do backet

gsutil ls gs://www.despensaonline.com.br/

-----------------------------------------------

cmd para ver permissões

gsutil acl get gs://www.despensaonline.com.br/
gsutil acl get gs://www.contabilvarejista.com.br

--------------------------------------------------------------------------
Cmd para deixar acesso público

gsutil acl ch -R -u AllUsers:R gs://www.despensaonline.com.br
gsutil acl ch -R -u AllUsers:R gs://www.contabilvarejista.com.br

--------------------------------------------------------------------------

Cmd para tornar um serviço web

gsutil web set -m index.html -e 404.html  gs://www.despensaonline.com.br
gsutil web set -m index.html -e 404.html  gs://www.contabilvarejista.com.br

-------------------------------------------------------------------------

Cmd para atualizar site.

gsutil -m rsync . gs://www.despensaonline.com.br
gsutil -m rsync . gs://www.contabilvarejista.com.br

--------------------------------------------------------

Cmd criação Bucket por região

gsutil mb -l us-east1  gs://004_ula


--------------------------------------------------------
Cmd controle de versionamento

cria versonamento

gsutil versioning set on gs://001-spacex

cria uma cópia

gsutil ls -a gs://001-spacex

restaura última versão

gsutil cp gs://001-spacex/arquivo.png#1548267325488499 gs://001-spacex/arquivo.png

------------------------------------------------------------
Cmd para acessar Bucket via API

pip install --upgrade google-cloud-storage

--------------------------------------------

gcloud components update --version

-------------------------------------------

Cmd para criar vm via sdk

https://cloud.google.com/sdk/gcloud/reference/compute/instances/create

gcloud compute instances create example-instance  --image-family=rhel-8 
--image-project=rhel-cloud  --zone=us-central1-a

Configuração de zona


https://cloud.google.com/about/locations/?hl=PT#network

São Paulo = southamerica-east1


gcloud compute instances create despensa-online --image-family=debian-9 --image-project=debian-cloud --zone=southamerica-east1-a

35.215.231.228

------------------------------------------------

cmd de images

cmd para listar imagens = gcloud compute images list

https://cloud.google.com/compute/docs/images#gcloud

gcloud compute images list --project debian-cloud-testing --no-standard-images

https://cloud.google.com/compute/docs/shutdownscript

project =debian-cloud
family = debian-9

--------------------------------------------------

Primeiros comando na VM

sudo apt-get update

--------------------------------------------------

Cmd para envio de arquivo para VM

cmd feito linux

scp -i key_pk_vm_dol_envio_arquivos.pem index.html saldanha@35.215.231.228:~

chmod 777 index.html
sudo mv index.html /home/saldanha



----------------------------------------------------------------------------























