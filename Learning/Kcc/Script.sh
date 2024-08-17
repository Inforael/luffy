#!/bin/bash
# ==============================================================================================
# DATE ORIGINATED   :Jun 31-08-2020
# AUTHOR            :Gawan 
# VERSION           :1.0
# CHANGE LOG:
# VER       DATE            WHO                 COMMENTS
# ==============================================================================================
# 1.0       Ago 31 2020         Gawan           Initial Version.
# ==============================================================================================
# DESCRIPTION: 
# 
# CALL EXAMPLE:
#	cd dev-wdu-sba-001/dev-wdu-sba-kcc/script; ./smart-workflow-kcc-mestre_prd.sh KCC WORKFLOW `date +"%Y%m%d"`
# ==============================================================================================
clear;\
    
ProjectName=$1
FileName=$2
Day=$3

if [ -z "$ProjectName" ] # -z verifica se o parÃƒÆ’Ã‚Â¢metro ÃƒÆ’Ã‚Â© vazio
  then
    echo "Please, verify the list of parameters 1"; exit 1
fi
if [ -z "$FileName" ]
  then
    echo "Please, verify the list of parameters 2"; exit 1
fi
if [ -z "$Day" ]
  then
    echo "Please, verify the list of parameters 3"; exit 1
fi


#PARAMETROS DE AMBIENTE
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ParamEnvironment=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamEnvironment' | cut -d"=" -f2 | head -1`
ParamBQDataSet=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQDataSet' | cut -d"=" -f2 | head -1`

#PARAMETROS DE EMAIL
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#email de envio do log
ParamEmailSender=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamEmailSender' | cut -d"=" -f2 | head -1`
#Assundo do email para erro
ParamEmailSubjectError=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamEmailSubjectError' | cut -d"=" -f2 | head -1`
#Assunto do email para aviso
ParamEmailSubjectWarning=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamEmailSubjectWarning' | cut -d"=" -f2 | head -1`
#Assunto do email para sucesso
ParamEmailSubjectSuccess=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamEmailSubjectSuccess' | cut -d"=" -f2 | head -1`
#Mensagem de corpo de email para erro
ParamEmailBodyError=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamEmailBodyError' | cut -d"=" -f2 | head -1`
#Mensagem de corpo de email para aviso
ParamEmailBodyWarning=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamEmailBodyWarning' | cut -d"=" -f2 | head -1`
#Mensagem de corpo de email para sucesso
ParamEmailBodySuccess=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamEmailBodySuccess' | cut -d"=" -f2 | head -1`
#Grupo de email que irÃƒÆ’Ã‚Â£o receber avisos de erro
ParamEmailRecipientError=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamEmailRecipientError' | cut -d"=" -f2 | head -1`
#Grupo de email que irÃƒÆ’Ã‚Â£o receber avisos de alerta
ParamEmailRecipientWarning=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamEmailRecipientWarning' | cut -d"=" -f2 | head -1`
#Grupo de email que irÃƒÆ’Ã‚Â£o receber avisos de sucesso
ParamEmailRecipientSuccess=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamEmailRecipientSuccess' | cut -d"=" -f2 | head -1`
#email weduu.retail@weduu.com
ParamEmailBccRecipientError=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamEmailBccRecipientError' | cut -d"=" -f2 | head -1`
#email weduu.retail@weduu.com
ParamEmailBccRecipientWarning=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamEmailBccRecipientWarning' | cut -d"=" -f2 | head -1`
#email weduu.retail@weduu.com
ParamEmailBccRecipientSuccess=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamEmailBccRecipientSuccess' | cut -d"=" -f2 | head -1`


#PARAMETROS LOCAIS
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Pasta local
ParamLocalFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalFolder' | cut -d"=" -f2 | head -1`
#Pasta TemporÃƒÆ’Ã‚Â¡ria
ParamLocalTempFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalTempFolder' | cut -d"=" -f2 | head -1`
#Pasta de log
ParamLocalLogFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalLogFolder' | cut -d"=" -f2 | head -1`
#Pasta de funÃƒÆ’Ã‚Â§ÃƒÆ’Ã‚Âµes SQL
ParamLocalUDFFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalUDFFolder' | cut -d"=" -f2 | head -1`
#Pasta de arquivos sql com query
ParamLocalLoadFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalLoadFolder' | cut -d"=" -f2 | head -1`
#pasta que recebe os arquivos para serem processados
ParamLocalInputFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalInputFolder' | cut -d"=" -f2 | head -1`
#Pasta local que recebe os arquivos apÃƒÆ’Ã‚Â³s serem processados
ParamLocalProcessingFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalProcessingFolder' | cut -d"=" -f2 | head -1`
ParamStoreBreakRunSleep=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamStoreBreakRunSleep' | cut -d"=" -f2 | head -1`
ParamLocalParameterFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalParameterFolder' | cut -d"=" -f2 | head -1`

#PARAMETROS DE CLOUD
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Pasta cloud temporÃƒÆ’Ã‚Â¡ria
ParamCloudTempFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamCloudTempFolder' | cut -d"=" -f2 | head -1`
#Pasta que armazena os arquivos a serÃƒÆ’Ã‚Â£o processados
ParamCloudSourceFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamCloudSourceFolder' | cut -d"=" -f2 | head -1`
#Pasta que armazena os ÃƒÆ’Ã‚Âºltimos arquivos processados na cloud
ParamCloudProcessingFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamCloudProcessingFolder' | cut -d"=" -f2 | head -1`
#Pasta que armazena arquivos que jÃƒÆ’Ã‚Â¡ foram processados
ParamCloudProcessedFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamCloudProcessedFolder' | cut -d"=" -f2 | head -1`
#Dataset do projeto
ParamCloudBackupFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamCloudBackupFolder' | cut -d"=" -f2 | head -1`
ParamCloudOutputFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamCloudOutputFolder' | cut -d"=" -f2 | head -1`

#PARÃƒÆ’Ã¢â‚¬Å¡METROS DE FTP - NEO
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#UsuÃƒÆ’Ã‚Â¡rio para acesso ao FTP
ParamFTPUser=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFTPUser' | cut -d"=" -f2 | head -1`
#Senha do usuÃƒÆ’Ã‚Â¡rio de acesso ao FTP
ParamFTPPassword=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFTPPassword' | cut -d"=" -f2 | head -1`
#Host para acesso ao FTP
ParamFTPHost=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFTPHost' | cut -d"=" -f2 | head -1`
#Pasta que armazena arquivos a serem transferidos no FTP
ParamFTPFilePath=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFTPFilePath' | cut -d"=" -f2 | head -1`

#PARAMETROS FTP-PHARMA
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------
#UsuÃƒÆ’Ã‚Â¡rio para acesso ao FTP Pharma
ParamFTPUserPharma=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFTPUserPharma' | cut -d"=" -f2 | head -1`
#Senha do usuÃƒÆ’Ã‚Â¡rio de acesso ao FTP Pharma
ParamFTPPasswordPharma=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFTPPasswordPharma' | cut -d"=" -f2 | head -1`
#Host para acesso ao FTP Pharma
ParamFTPHostPharma=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFTPHostPharma' | cut -d"=" -f2 | head -1`
#Pasta que armazena arquivos a serem transferidos no FTP Pharma
ParamFTPFilePathPharma=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFTPFilePathPharma' | cut -d"=" -f2 | head -1`
#Pasta que armazena arquivos a serem transferidos no FTP Pharma Week
ParamFTPFilePathPharmaWeek=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFTPFilePathPharmaWeek' | cut -d"=" -f2 | head -1`

#PARÃƒÆ’Ã¢â‚¬Å¡METROS DE SFTP
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#UsuÃƒÆ’Ã‚Â¡rio para acesso ao FTP
ParamSFTPUser=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamSFTPUser' | cut -d"=" -f2 | head -1`
#Senha do usuÃƒÆ’Ã‚Â¡rio de acesso ao FTP
ParamSFTPPassword=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamSFTPPassword' | cut -d"=" -f2 | head -1`
#Host para acesso ao FTP
ParamSFTPHost=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamSFTPHost' | cut -d"=" -f2 | head -1`
#Pasta que armazena arquivos a serem transferidos no FTP
ParamSFTPFilePath=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamSFTPFilePath' | cut -d"=" -f2 | head -1`

#PARÃƒâ€šMETROS DE FPT - FIA
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#UsuÃƒÂ¡rio para acesso ao FTP
ParamSFTPUserFia=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamSFTPUserFia' | cut -d"=" -f2 | head -1`
#Senha do usuÃƒÂ¡rio de acesso ao FTP
ParamSFTPPasswordFia=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamSFTPPasswordFia' | cut -d"=" -f2 | head -1`
#Host para acesso ao FTP
ParamSFTPHostFia=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamSFTPHostFia' | cut -d"=" -f2 | head -1`

#PARAMETROS DE PRODUTO
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Prefixo dos arquivos que serÃƒÆ’Ã‚Â£o processados
ParamFileMovementPrefixProduct=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFileMovementPrefixProduct' | cut -d"=" -f2 | head -1`
#tabela externa de produto
ParamBQTableExtProduct=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableExtProduct' | cut -d"=" -f2 | head -1`
#tabela diaria de produto
ParamBQTableDayProduct=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDayProduct' | cut -d"=" -f2 | head -1`
#tabela histÃƒÆ’Ã‚Â³rica de produto
ParamBQTableHisProduct=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisProduct' | cut -d"=" -f2 | head -1`


#PARAMETROS DE CLIENTE
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Prefixo dos arquivos que serÃƒÆ’Ã‚Â£o processados
ParamFileMovementPrefixCustomer=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFileMovementPrefixCustomer' | cut -d"=" -f2 | head -1`
#tabela externa de produto
ParamBQTableExtCustomer=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableExtCustomer' | cut -d"=" -f2 | head -1`
#tabela diaria de produto
ParamBQTableDayCustomer=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDayCustomer' | cut -d"=" -f2 | head -1`
#tabela histÃƒÆ’Ã‚Â³rica de produto
ParamBQTableHisCustomer=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisCustomer' | cut -d"=" -f2 | head -1`


#PARAMETROS DE SALES STRUCTURE
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Prefixo dos arquivos que serÃƒÆ’Ã‚Â£o processados
ParamFileMovementPrefixSalesStructure=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFileMovementPrefixSalesStructure' | cut -d"=" -f2 | head -1`
#tabela externa de produto
ParamBQTableExtSalesStructure=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableExtSalesStructure' | cut -d"=" -f2 | head -1`
#tabela diaria de produto
ParamBQTableDaySalesStructure=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDaySalesStructure' | cut -d"=" -f2 | head -1`
#tabela histÃƒÆ’Ã‚Â³rica de produto
ParamBQTableHisSalesStructure=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisSalesStructure' | cut -d"=" -f2 | head -1`


#PARAMETROS DE SELLIN
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Prefixo dos arquivos que serÃƒÂ£o processados
ParamFileMovementPrefixSellin=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFileMovementPrefixSellin' | cut -d"=" -f2 | head -1`
#tabela externa de sellin
ParamBQTableExtSellin=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableExtSellin' | cut -d"=" -f2 | head -1`
#tabela diaria de sellin
ParamBQTableDaySellin=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDaySellin' | cut -d"=" -f2 | head -1`
#tabela histÃƒÂ³rica de sellin
ParamBQTableHisSellin=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisSellin' | cut -d"=" -f2 | head -1`
#Campo de particionamento
ParamPartitioningFieldSellin=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamPartitioningFieldSellin' | cut -d"=" -f2 | head -1`
#Campo de clusterizaÃƒÂ§ÃƒÂ£o
ParamClusteringFieldSellin=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamClusteringFieldSellin' | cut -d"=" -f2 | head -1`
#Tabela temporÃƒÂ¡ria de sellin
ParamBQTableTmpTRSSellin=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableTmpTRSSellin' | cut -d"=" -f2 | head -1`
#Prefixo do arquivo que serÃƒÂ¡ geradoa para o robÃƒÂ´ de clientes
ParamCSVSellinFileName=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamCSVSellinFileName' | cut -d"=" -f2 | head -1`


#PARAMETROS DE SELLOUT
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Prefixo dos arquivos que serÃƒÆ’Ã‚Â£o processados
ParamFileMovementPrefixSellout=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFileMovementPrefixSellout' | cut -d"=" -f2 | head -1`
#tabela externa de sellout
ParamBQTableExtSellout=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableExtSellout' | cut -d"=" -f2 | head -1`
#tabela diaria de sellout
ParamBQTableDaySellout=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDaySellout' | cut -d"=" -f2 | head -1`
#tabela temporÃƒÆ’Ã‚Â¡ria de sellout
ParamBQTableTmpSellout=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableTmpSellout' | cut -d"=" -f2 | head -1`
#tabela histÃƒÆ’Ã‚Â³rica de sellout
ParamBQTableHisSellout=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisSellout' | cut -d"=" -f2 | head -1`
#Campo de particionamento
ParamPartitioningFieldSellout=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamPartitioningFieldSellout' | cut -d"=" -f2 | head -1`
#Campos de clusterizaÃƒÆ’Ã‚Â§ÃƒÆ’Ã‚Â£o
ParamClusteringFieldSellout=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamClusteringFieldSellout' | cut -d"=" -f2 | head -1`

#PARAMETROS DE SELLTHROUGH
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#tabela externa de sellthrough
ParamBQTableExtSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableExtSellthrough' | cut -d"=" -f2 | head -1`
#tabela diaria de sellthrough
ParamBQTableDaySellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDaySellthrough' | cut -d"=" -f2 | head -1`
#tabela temporÃƒÂ¡ria de sellthrough
ParamBQTableTmpSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableTmpSellthrough' | cut -d"=" -f2 | head -1`
#tabela histÃƒÂ³rica de sellthrough
ParamBQTableHisSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisSellthrough' | cut -d"=" -f2 | head -1`
#Campo de particionamento
ParamPartitioningFieldSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamPartitioningFieldSellthrough' | cut -d"=" -f2 | head -1`
#Campos de clusterizaÃƒÂ§ÃƒÂ£o
ParamClusteringFieldSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamClusteringFieldSellthrough' | cut -d"=" -f2 | head -1`
#Pasta onde sÃƒÂ£o copiados os arquivos do ftp 
ParamLocalFTPFolderSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalFTPFolderSellthrough' | cut -d"=" -f2 | head -1`
#Pasta onde os arquivos transformados sÃƒÂ£o depositados
ParamLocalCSVFolderSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalCSVFolderSellthrough' | cut -d"=" -f2 | head -1`
#Pasta onde ficam os scripts python responsÃƒÂ¡veis pelo etl
ParamLocalFolderScriptSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalFolderScriptSellthrough' | cut -d"=" -f2 | head -1`
#nome do script responsavel pelo etl dos arquivos de sellthrough
ParamScriptETLSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamScriptETLSellthrough' | cut -d"=" -f2 | head -1`
#nome do script responsavel pelo etl do arquvo da dec sul - layout flexivel
ParalScriptETLDescSul=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParalScriptETLDescSul' | cut -d"=" -f2 | head -1`
#nome do arquivo de log dos arquivos capturados do ftp 
ParamNameLogFileFTPSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamNameLogFileFTPSellthrough' | cut -d"=" -f2 | head -1`
#nome do arquivo de log dos arquivos vazios
ParamLogCtrlFileLog=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLogCtrlFileLog' | cut -d"=" -f2 | head -1`
#predixo dos arquivos fia
ParamFileMovementPrefixSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFileMovementPrefixSellthrough' | cut -d"=" -f2 | head -1`
ParamNameLogFileFTPSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamNameLogFileFTPSellthrough' | cut -d"=" -f2 | head -1`
ParamNameLogFileFTPCopySellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamNameLogFileFTPCopySellthrough' | cut -d"=" -f2 | head -1`
ParamNameLogFileCSVSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamNameLogFileCSVSellthrough' | cut -d"=" -f2 | head -1`

#nome do arquivo zip dos arquivos enriquecidos
ParamZipNameEnrichedSellthroughFile=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamZipNameEnrichedSellthroughFile' | cut -d"=" -f2 | head -1`
#nome dos aruqivo zip originais
ParamZipNameOriginaldSellthroughFile=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamZipNameOriginaldSellthroughFile' | cut -d"=" -f2 | head -1`

#PARAMETROS DE PHARMA
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Prefixo dos arquivos que serÃƒÆ’Ã‚Â£o processados
ParamFileMovementPrefixPharma=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFileMovementPrefixPharma' | cut -d"=" -f2 | head -1`
#tabela externa de pharma
ParamBQTableExtPharma=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableExtPharma' | cut -d"=" -f2 | head -1`
#tabela diaria de pharma
ParamBQTableDayPharma=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDayPharma' | cut -d"=" -f2 | head -1`
#tabela histÃƒÆ’Ã‚Â³rica de pharma
ParamBQTableHisPharma=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisPharma' | cut -d"=" -f2 | head -1`
#Campo de particionamento
ParamPartitioningFieldPharma=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamPartitioningFieldPharma' | cut -d"=" -f2 | head -1`


#PARAMETROS DE PHARMA WEEK
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Prefixo dos arquivos que serÃƒÆ’Ã‚Â£o processados
ParamFileMovementPrefixPharmaWeek=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFileMovementPrefixPharmaWeek' | cut -d"=" -f2 | head -1`
#tabela externa de pharma week
ParamBQTableExtPharmaWeek=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableExtPharmaWeek' | cut -d"=" -f2 | head -1`
#tabela diaria de pharma week
ParamBQTableDayPharmaWeek=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDayPharmaWeek' | cut -d"=" -f2 | head -1`
#tabela histÃƒÆ’Ã‚Â³rica de pharma week
ParamBQTableHisPharmaWeek=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisPharmaWeek' | cut -d"=" -f2 | head -1`
#Campo de particionamento
ParamPartitioningFieldPharmaWeek=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamPartitioningFieldPharmaWeek' | cut -d"=" -f2 | head -1`


#PARAMETROS DE LIGHTHOUSE
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Prefixo dos arquivos que serÃƒÆ’Ã‚Â£o processados
ParamFileMovementPrefixLightHouse=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFileMovementPrefixLightHouse' | cut -d"=" -f2 | head -1`
#tabela externa de produto
ParamBQTableExtLightHouse=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableExtLightHouse' | cut -d"=" -f2 | head -1`
#tabela diaria de produto
ParamBQTableDayLightHouse=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDayLightHouse' | cut -d"=" -f2 | head -1`
#tabela histÃƒÆ’Ã‚Â³rica de produto
ParamBQTableHisLightHouse=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisLightHouse' | cut -d"=" -f2 | head -1`
#Campo de particionamento
ParamPartitioningFieldLightHouse=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamPartitioningFieldLightHouse' | cut -d"=" -f2 | head -1`


#PARAMETROS DE TABELA DE CONTROLE
#--------------------------------------------------------------------------------------------------------------------------------------------------------
ParamInsertCtrlFileProduct=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamInsertCtrlFileProduct' | cut -d"=" -f2 | head -1`
ParamInsertCtrlFileCustomer=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamInsertCtrlFileCustomer' | cut -d"=" -f2 | head -1`
ParamInsertCtrlFileSalesStructure=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamInsertCtrlFileSalesStructure' | cut -d"=" -f2 | head -1`
ParamInsertCtrlFileSellin=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamInsertCtrlFileSellin' | cut -d"=" -f2 | head -1`
ParamInsertCtrlFileSellout=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamInsertCtrlFileSellout' | cut -d"=" -f2 | head -1`
ParamInsertCtrlFilePharma=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamInsertCtrlFilePharma' | cut -d"=" -f2 | head -1`
ParamInsertCtrlFilePharmaWeek=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamInsertCtrlFilePharmaWeek' | cut -d"=" -f2 | head -1`
ParamInsertCtrlFileSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamInsertCtrlFileSellthrough' | cut -d"=" -f2 | head -1`
ParamInsertCtrlEmptyFilesFileSellthrough=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamInsertCtrlEmptyFilesFileSellthrough' | cut -d"=" -f2 | head -1`

#PARAMETROS DE TABELA DE LOJAS
#--------------------------------------------------------------------------------------------------------------------------------------------------------
ParamBQTableDayStore=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDayStore' | cut -d"=" -f2 | head -1`
ParamBQTableHisStore=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisStore' | cut -d"=" -f2 | head -1`

#PARAMETROS DE GC - GESTAO DE CATEGORIAS
#--------------------------------------------------------------------------------------------------------------------------------------------------------
ParamLocalCloudSourceMovimentFolderGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalCloudSourceMovimentFolderGC' | cut -d"=" -f2 | head -1`
ParamLocalCloudSourceProductFolderGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalCloudSourceProductFolderGC' | cut -d"=" -f2 | head -1`
ParamLocalCloudSourceStoreFolderGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalCloudSourceStoreFolderGC' | cut -d"=" -f2 | head -1`
ParamLocalFolderGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalFolderGC' | cut -d"=" -f2 | head -1`
ParamLocalExceMovimentFolderGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalExceMovimentFolderGC' | cut -d"=" -f2 | head -1`
ParamLocalExcelProductFolderGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalExcelProductFolderGC' | cut -d"=" -f2 | head -1`
ParamLocalExcelStoreFolderGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalExcelStoreFolderGC' | cut -d"=" -f2 | head -1`
ParamLocalCSVFolderGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalCSVFolderGC' | cut -d"=" -f2 | head -1`
ParamLocalScriptFolderGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalScriptFolderGC' | cut -d"=" -f2 | head -1`
ParamScriptETLGCProduct=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamScriptETLGCProduct' | cut -d"=" -f2 | head -1`
ParamScriptETLGCMovement=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamScriptETLGCMovement' | cut -d"=" -f2 | head -1`
ParamScriptETLGCStore=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamScriptETLGCStore' | cut -d"=" -f2 | head -1`
ParamFileStorePrefixGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFileStorePrefixGC' | cut -d"=" -f2 | head -1`
ParamBQTableExtStoreGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableExtStoreGC' | cut -d"=" -f2 | head -1`
ParamBQTableDayStoreGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDayStoreGC' | cut -d"=" -f2 | head -1`
ParamBQTableHisStoreGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisStoreGC' | cut -d"=" -f2 | head -1`
ParamFileProductPrefixGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFileProductPrefixGC' | cut -d"=" -f2 | head -1`
ParamBQTableExtProductGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableExtProductGC' | cut -d"=" -f2 | head -1`
ParamBQTableDayProductGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDayProductGC' | cut -d"=" -f2 | head -1`
ParamBQTableHisProductGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisProductGC' | cut -d"=" -f2 | head -1`
ParamFileMovementPrefixGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFileMovementPrefixGC' | cut -d"=" -f2 | head -1`
ParamBQTableExtMovimentGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableExtMovimentGC' | cut -d"=" -f2 | head -1`
ParamBQTableDayMovimentGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDayMovimentGC' | cut -d"=" -f2 | head -1`
ParamBQTableHisMovimentGC=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisMovimentGC' | cut -d"=" -f2 | head -1`


#TABELAS E VIEWS - ROBO
#------------------------------------------------------------------------------------------------------------------------------------------------------------
ParamBQTableHisProductRobot=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisProductRobot' | cut -d"=" -f2 | head -1`
ParamBQTableITGProductRobot=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableITGProductRobot' | cut -d"=" -f2 | head -1`
ParamBQTableTmpMRDProductRobot=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableTmpMRDProductRobot' | cut -d"=" -f2 | head -1`
ParamBQTableTmpTRSProductRobot=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableTmpTRSProductRobot' | cut -d"=" -f2 | head -1`
ParamBQTableITRSProductRobot=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableITRSProductRobot' | cut -d"=" -f2 | head -1`
ParamBQTableDayProductRobot=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDayProductRobot' | cut -d"=" -f2 | head -1`
ParamBQViewProductRobot=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQViewProductRobot' | cut -d"=" -f2 | head -1`
ParamBQTableHisCustomerRobot=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisCustomerRobot' | cut -d"=" -f2 | head -1`
ParamBQTableITGCustomerRobot=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableITGCustomerRobot' | cut -d"=" -f2 | head -1`
ParamBQTableTmpMRDCustomerRobot=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableTmpMRDCustomerRobot' | cut -d"=" -f2 | head -1`
ParamBQTableTmpTRSCustomerRobot=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableTmpTRSCustomerRobot' | cut -d"=" -f2 | head -1`
ParamBQTableITRSCustomerRobot=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableITRSCustomerRobot' | cut -d"=" -f2 | head -1`
ParamBQTableDayCustomerRobot=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableDayCustomerRobot' | cut -d"=" -f2 | head -1`
ParamBQViewCustomerRobot=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQViewCustomerRobot' | cut -d"=" -f2 | head -1`
ParamBQViewHisCustomer=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQViewHisCustomer' | cut -d"=" -f2 | head -1`
ParamCSVCustomerRobotFileName=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamCSVCustomerRobotFileName' | cut -d"=" -f2 | head -1`

#PARAMETROS DE PROJETO - ROBO
#---------------------------------------------------------------------------------------------------------------------------------------------------------
ParamBQCDCompany=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQCDCompany' | cut -d"=" -f2 | head -1`
ParamBQSHDProject=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQSHDProject' | cut -d"=" -f2 | head -1`
ParamBQRBAProject=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQRBAProject' | cut -d"=" -f2 | head -1`
ParamBQSBAProject=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQSBAProject' | cut -d"=" -f2 | head -1`
ParamBQSBAProjectStrg=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQSBAProjectStrg' | cut -d"=" -f2 | head -1`
#---------------------------------------------------------------------------------------------------------------------------------------------------------

#PARAMETROS DE API - ROBO
#------------------------------------------------------------------------API--------------------------------------------------------------------------------------------------
ParamProductRobotAPIURL=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamProductRobotAPIURL' | cut -d"=" -f2 | head -1`
ParamProductRobotAPIUser=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamProductRobotAPIUser' | cut -d"=" -f2 | head -1`
ParamProductRobotAPIPassword=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamProductRobotAPIPassword' | cut -d"=" -f2 | head -1`
ParamProductRobotAPICheckTimes=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamProductRobotAPICheckTimes' | cut -d"=" -f2 | head -1`
ParamProductRobotAPICheckSleep=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamProductRobotAPICheckSleep' | cut -d"=" -f2 | head -1`
ParamCustomerRobotAPIURL=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamCustomerRobotAPIURL' | cut -d"=" -f2 | head -1`
ParamCustomerRobotAPIUser=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamCustomerRobotAPIUser' | cut -d"=" -f2 | head -1`
ParamCustomerRobotAPIPassword=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamCustomerRobotAPIPassword' | cut -d"=" -f2 | head -1`
ParamCustomerRobotAPICheckTimes=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamCustomerRobotAPICheckTimes' | cut -d"=" -f2 | head -1`
ParamCustomerRobotAPICheckSleep=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamCustomerRobotAPICheckSleep' | cut -d"=" -f2 | head -1`

#AMAZON S3
#------------------------------------------------------------------------------------------------------------------------------------------------------------
ParamAWSS3InputFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamAWSS3InputFolder' | cut -d"=" -f2 | head -1`
ParamAWSS3OutputFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamAWSS3OutputFolder' | cut -d"=" -f2 | head -1`

#COMPANY
#------------------------------------------------------------------------------------------------------------------------------------------------------------
ParamBQTableHisCompany=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQTableHisCompany' | cut -d"=" -f2 | head -1`

#PROCEDURES
#------------------------------------------------------------------------------------------------------------------------------------------------------------
ParamBQProcedureSellthroughDuplicates=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamBQProcedureSellthroughDuplicates' | cut -d"=" -f2 | head -1`

#------------------------------------------------CHECK IN DOS PARAMETROS --------------------------------------------------------------------------------
#empty_param_num faz referencia a linha desse arquivo no qual o parametro veio vazio.
#Deve-se setar empty_param_num com o numero do inicio da linha onde se inicia os blocos
#if-fi que verificam os parametros. Os blocos devem manter o padrao de 5 linhas por bloco.
empty_param_num=402
if [ -z "$ParamEnvironment" ]
  then
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQDataSet" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+6))  #----------------- PARAMETROS DE EMAIL -------------------------------
if [ -z "$ParamEmailSender" ]
  then
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamEmailSubjectError" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamEmailSubjectWarning" ]
  then
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamEmailSubjectSuccess" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamEmailBodyError" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamEmailBodyWarning" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamEmailBodySuccess" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamEmailRecipientError" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamEmailRecipientWarning" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamEmailRecipientSuccess" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamEmailBccRecipientError" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamEmailBccRecipientWarning" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamEmailBccRecipientSuccess" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))  #--------------------- PARAMETROS LOCAIS ------------------------------------
if [ -z "$ParamLocalFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalTempFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalLogFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalUDFFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalLoadFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalInputFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalProcessingFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamStoreBreakRunSleep" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalParameterFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))  #-------------------- PARAMETROS CLOUD -----------------------------
if [ -z "$ParamCloudTempFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamCloudSourceFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamCloudProcessingFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamCloudProcessedFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamCloudBackupFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamCloudOutputFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))  #------------------------PARAMETROS DE FTP ----------------------------
if [ -z "$ParamFTPUser" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamFTPPassword" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamFTPHost" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamFTPFilePath" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamInsertCtrlFileSellout" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))      #------------------------- FTP PHARMA ----------------------------------
if [ -z "$ParamFTPUserPharma" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamFTPPasswordPharma" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamFTPHostPharma" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamFTPFilePathPharma" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamFTPFilePathPharmaWeek" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))  #---------PARAMETROS SFTP----------------------------------------------------
if [ -z "$ParamSFTPUser" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamSFTPPassword" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamSFTPHost" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamSFTPFilePath" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))  #---------PARAMETROS FTP - FIA ----------------------------------------------------
if [ -z "$ParamSFTPUserFia" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamSFTPPasswordFia" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamSFTPHostFia" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))  #--------------------PARAMETROS DE PRODUTOS ------------------------------------
if [ -z "$ParamFileMovementPrefixProduct" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableExtProduct" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableDayProduct" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableHisProduct" ]
  then   
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5)) #--------------------PARAMETROS DE CLIENTES ------------------------------------
if [ -z "$ParamFileMovementPrefixCustomer" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableExtCustomer" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableDayCustomer" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableHisCustomer" ]
  then   
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5)) #--------------------PARAMETROS DE ESTRUTURA DE VENDAS -------------------------
if [ -z "$ParamFileMovementPrefixSalesStructure" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableExtSalesStructure" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableDaySalesStructure" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableHisSalesStructure" ]
  then   
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5)) #--------------------PARAMETROS SELLIN -----------------------------------------
if [ -z "$ParamFileMovementPrefixSellin" ]
  then   
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableExtSellin" ]
  then 
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableDaySellin" ]
  then
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableHisSellin" ]
  then
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamPartitioningFieldSellin" ]
  then
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamClusteringFieldSellin" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5)) #--------------------PARAMETROS SELLOUT ----------------------------------------
if [ -z "$ParamFileMovementPrefixSellout" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableExtSellout" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableDaySellout" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableTmpSellout" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableHisSellout" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamPartitioningFieldSellout" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamClusteringFieldSellout" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))  #--------------------PARAMETROS SELLTHROUGH ----------------------------------------
if [ -z "$ParamBQTableExtSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableDaySellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableTmpSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableHisSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamPartitioningFieldSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamClusteringFieldSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalFTPFolderSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalCSVFolderSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalFolderScriptSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamScriptETLSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParalScriptETLDescSul" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamNameLogFileFTPSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLogCtrlFileLog" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5)) 
if [ -z "$ParamFileMovementPrefixSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5)) 
if [ -z "$ParamNameLogFileFTPSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5)) 
if [ -z "$ParamNameLogFileFTPCopySellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5)) 
if [ -z "$ParamNameLogFileCSVSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamZipNameEnrichedSellthroughFile" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamZipNameOriginaldSellthroughFile" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5)) #--------------------PARAMETROS PHARMA----------------------------------------
if [ -z "$ParamFileMovementPrefixPharma" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableExtPharma" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableDayPharma" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableHisPharma" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamPartitioningFieldPharma" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5)) #--------------------PARAMETROS PHARMA WEEK----------------------------------------
if [ -z "$ParamFileMovementPrefixPharmaWeek" ]
  then    
	echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableExtPharmaWeek" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableDayPharmaWeek" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableHisPharmaWeek" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamPartitioningFieldPharmaWeek" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
    
fi  
empty_param_num=$(($empty_param_num+5)) #--------------------PARAMETROS LIGHTHOUSE ----------------------------------------
if [ -z "$ParamFileMovementPrefixLightHouse" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableExtLightHouse" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableDayLightHouse" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableHisLightHouse" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamPartitioningFieldLightHouse" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))  #---------- PARAMETROS TABELA DE CONTROLE---------------
if [ -z "$ParamInsertCtrlFileProduct" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamInsertCtrlFileCustomer" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamInsertCtrlFileSalesStructure" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamInsertCtrlFileSellin" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamInsertCtrlFileSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamInsertCtrlEmptyFilesFileSellthrough" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))  #-------------------------PARAMETROS TABELA DE LOJAS -------------------------
if [ -z "$ParamBQTableDayStore" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableHisStore" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))  # -------------------------- PARAMETROS - GESTAO DE CATEGORIAS - GC -----------
if [ -z "$ParamLocalCloudSourceMovimentFolderGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalCloudSourceProductFolderGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalCloudSourceStoreFolderGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalFolderGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalExceMovimentFolderGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalExcelProductFolderGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalExcelStoreFolderGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalCSVFolderGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamLocalScriptFolderGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamScriptETLGCProduct" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamScriptETLGCMovement" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamScriptETLGCStore" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamFileStorePrefixGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableExtStoreGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableDayStoreGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableHisStoreGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamFileProductPrefixGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableExtProductGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableDayProductGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableHisProductGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamFileMovementPrefixGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableExtMovimentGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableDayMovimentGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableHisMovimentGC" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))   #---------------PARAMETROS TABELAS E VIEWS - ROBO ----------------------------
if [ -z "$ParamBQTableHisProductRobot" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5)) 
if [ -z "$ParamBQTableITGProductRobot" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5)) 
if [ -z "$ParamBQTableTmpMRDProductRobot" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableTmpTRSProductRobot" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableITRSProductRobot" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableDayProductRobot" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQViewProductRobot" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableHisCustomerRobot" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableITGCustomerRobot" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableTmpMRDCustomerRobot" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableTmpTRSCustomerRobot" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableITRSCustomerRobot" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQTableDayCustomerRobot" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQViewCustomerRobot" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQViewHisCustomer" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5)) #-----------------------PARAMETROS DE PROJETO - ROBO -------------------
if [ -z "$ParamCSVCustomerRobotFileName" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQCDCompany" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQSHDProject" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQRBAProject" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQSBAProject" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamBQSBAProjectStrg" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))   #------------------ PARAMETROS DE API - ROBO ---------------------------
if [ -z "$ParamProductRobotAPIURL" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamProductRobotAPIUser" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamProductRobotAPIPassword" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamProductRobotAPICheckTimes" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamProductRobotAPICheckSleep" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamCustomerRobotAPIURL" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamCustomerRobotAPIUser" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamCustomerRobotAPIPassword" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamCustomerRobotAPICheckTimes" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamCustomerRobotAPICheckSleep" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))   #------------------ PARAMETROS DE AMAZON S3 ---------------------------
if [ -z "$ParamAWSS3InputFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))
if [ -z "$ParamAWSS3OutputFolder" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))   #------------------ PARAMETROS DE COMPANY ---------------------------
if [ -z "$ParamBQTableHisCompany" ]
  then    
    echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi
empty_param_num=$(($empty_param_num+5))   #------------------ PARAMETROS DE PROCEDURES ---------------------------
if [ -z "$ParamBQProcedureSellthroughDuplicates" ]
  then    
	echo "Please, verify the list of parameters" $empty_param_num; exit 1
fi

#FUNCTIONS:-------------------------------------------------------------------------------------------------------------------------------------
#Function 1: Log generation.
generate_log()
{
    echo `date +"[%Y-%m-%d %T] "` $* >> $ParamLocalLogFolder/Smart-Workflow-Day.$ProjectName.$FileName.$Day.log
}
#Function 2: Lighthouse generation.
generate_lh()
{
    echo "${1}#${2}#${3}#${4}#${5}#${6}#${7}#${8}#${9}#${10}#${11}#${12}#${13}#${14}#${15}#${16}#${17}#${18}#${19}#${20}" >> $ParamLocalProcessingFolder/LH_Smart-Workflow-Day.$ProjectName.$FileName.$Day.txt
}
#Function 3: Error email sending.
send_email_error()
{
    echo -e "$ParamEmailBodyError" | mutt "$ParamEmailRecipientError" -b "$ParamEmailBccRecipientError" -s "[$ProjectName] $ParamEnvironment $ParamEmailSubjectError" -a "$ParamLocalLogFolder/Smart-Workflow-Day.$ProjectName.$FileName.$Day.log"
}
#Function 4: Warning email sending.

send_email_warning()
{
    echo -e "$ParamEmailBodyWarning" | mutt "$ParamEmailRecipientWarning" -b "$ParamEmailBccRecipientWarning" -s "[$ProjectName] $ParamEnvironment $ParamEmailSubjectWarning" -a "$ParamLocalLogFolder/Smart-Workflow-Day.$ProjectName.$FileName.$Day.log"
}

#Function 5: Success email sending.
send_email_success()
{
    echo -e "$ParamEmailBodySuccess" | mutt "$ParamEmailRecipientSuccess" -b "$ParamEmailBccRecipientSuccess" -s "[$ProjectName] $ParamEnvironment $ParamEmailSubjectSuccess" -a "$ParamLocalLogFolder/Smart-Workflow-Day.$ProjectName.$FileName.$Day.log"
}

#Function 6: Shell script exiting.
exit_sh()
{   
    generate_log "Smart-Workflow-Day: Move daily lighthouse file from local processing folder to cloud processing folder to be processed."
    #gsutil -q -m cp $ParamLocalProcessingFolder/$ParamFileMovementPrefixLightHouse* $ParamCloudProcessingFolder/
    gsutil cp $ParamLocalProcessingFolder/$ParamFileMovementPrefixLightHouse* $ParamCloudProcessingFolder/
    if [ $? -ne 0 ] #SE NÃƒÆ’Ã†â€™O FOR POSSÃƒÆ’Ã‚ÂVEL MOVER OS ARQUIVO DA LIGHTHOUT PARA A PROCESSING UM AVISO DE ERROR ÃƒÆ’Ã¢â‚¬Â° ADICIONADO A LOG
        then
            generate_log "Smart-Workflow-Day: GCP error. Please check if GCP is available or contact your administrator."; exit 17
    fi
    generate_log "Smart-Workflow-Day: Daily lighthouse file copied to cloud processing folder successfully."
    
    generate_log "Smart-Workflow-Day: Replace daily lighthouse table with the daily process status contents."
    bq  query -n=0 --replace --destination_table $ParamBQDataSet.$ParamBQTableDayLightHouse --time_partitioning_field $ParamPartitioningFieldLightHouse  --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/$ParamBQTableDayLightHouse.sql)"
    if [ $? -ne 0 ] #SE NÃƒÆ’Ã†â€™O FOR POSSÃƒÆ’Ã‚ÂVEL SUBSTITUIR A PLANILHA DIARIA DA LIGHTHOUT PARA A PROCESSING UM AVISO DE ERROR ÃƒÆ’Ã¢â‚¬Â° ADICIONADO A LOG
        then
            generate_log "Smart-Workflow-Day: GCP error. Please check if GCP is available or contact your administrator."; exit 18
    fi
    generate_log "Smart-Workflow-Day: Daily lighthouse table replaced successfully."

    generate_log "Smart-Workflow-Day: Merge daily lighthouse table with history lighthouse table."
    bq cp -f $ParamBQDataSet.$ParamBQTableDayLightHouse\$$Day $ParamBQDataSet.$ParamBQTableHisLightHouse\$$Day
    if [ $? -ne 0 ] #SE NÃƒÆ’Ã†â€™O FOR POSSÃƒÆ’Ã‚ÂVEL ATUALIZAR A PLANILHA HISTÃƒÆ’Ã¢â‚¬Å“RICA DA LIGHTHOUT PARA A PROCESSING UM AVISO DE ERROR ÃƒÆ’Ã¢â‚¬Â° ADICIONADO A LOG
        then
            generate_log "Smart-Workflow-Day: GCP error. Please check if GCP is available or contact your administrator."; exit 19
    fi
    generate_log "Smart-Workflow-Day: History lighthouse table merged successfully."
    
    echo -e "\n++++++++\n| FIM! |\n++++++++"
    if [ $1 -ne 0 ]
        then
            echo -e "\n++++++++\n| ERRO! |\n++++++++"
            send_email_error
        else
            echo -e "\n++++++++++++\n| SUCESSO! |\n++++++++++++"
            send_email_success
    fi
    
    exit $1
}

#-------------------------------------------------------------------------------------------------------------------------------------------
#INITIALIZATION:
#Initialize date.
DATE=`date +%Y-%m-%d`
#Initialize date and time.
DATETIME=`date +"%Y-%m-%d %T"`
#Initialize project.
PROJECT=`gcloud config list project --format "value(core.project)" --verbosity error`
#Initialize company.
COMPANY=`echo "$ProjectName""001"`
#Initialize load control.
LOAD_CONTROL=`date +"%Y%m%d%H%M%S"`
#Initialize account.
ACCOUNT=`gcloud config list account --format "value(core.account)" --verbosity error`
#Initialize system.
SYSTEM=`echo "WDU001"`
#Initialize status variables.
CD_STATUS_SUCCESS=`echo "2"`; CD_STATUS_ERROR=`echo "3"`; DS_STATUS_SUCCESS=`echo "Job Executado com Sucesso"`; DS_STATUS_ERROR=`echo "Job Executado com Erro"`
#Initialize e-mail.
export EMAIL=$ParamEmailSender
#Initialize log file.
echo `date +"[%Y-%m-%d %T] "` "Smart-Workflow-Day: Start daily SBA workflow process orchestrator." > $ParamLocalLogFolder/Smart-Workflow-Day.$ProjectName.$FileName.$Day.log
#Initialize lighthouse file.
echo -n > $ParamLocalProcessingFolder/LH_Smart-Workflow-Day.$ProjectName.$FileName.$Day.txt

#REFERENCE DATES INITIALIZATION:
date_reference_d1=`echo $Day`
date_reference_d1_dashes=`date -d "$date_reference_d1 -0 days" +"%Y-%m-%d"`

#Move arquivo boto para etc/
sudo cp /prd-wdu-sba-001/prd-wdu-sba-kcc/parameter/boto.cfg /etc

#--------------------------------------------COLETA DADOS MESTRES----------------------------------------------------------
#Procedure 1: Collect master files to be processed.
generate_log "Procedure 1: Collect master files to be processed."

#Procedure 1 - Step 1: Clean cloud processing folder to receive the new files to be processed.
generate_log "Procedure 1 - Step 1: Clean cloud processing folder to receive the new files to be processed."
cd_interface="p001.s001";
ds_interface="Procedure 1 - Step 1: Clean cloud processing folder to receive the new files to be processed.";
cd_start_by="gsutil rm";
ds_object_system="Master Files";
ds_path_input="$ParamCloudProcessingFolder";
ds_path_output="";
date_start_processing=`date +"%Y-%m-%d %T"`

#Remove todos arquivos de dados mestre em processing
gsutil ls $ParamCloudProcessingFolder | egrep KCC_[A-Z\|A-Z_A_Z]+_[0-9]+.*FINAL.csv | gsutil -m rm -I

#apaga arquivos enriquecidos
cd $ParamLocalInputFolder
#prepara input para receber novos arquivos
#remove arquivos de cadastro
rm -rf KCC*
#remove arquivos de sellout neogrid
rm -rf RI_KCC*
#remove arquivo de neogrid enriquecidos caso o orquestrador tenha dado exit antes de mover para processing
rm -rf FINAL*


#------- controle de fluxo --------
#cd_exit=$?
cd_exit=0
#----------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 1 - Step 1: Filesystem error. Please check if filesystem is full or contact your administrator."
		exit_sh 2; exit 2
fi
generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 1 - Step 1: Cloud processing folder cleaned successfully."


#SFTP---------------------------------------------------------------------------------------------------------------------------------------
#Procedure_sfpt1: Copy master files from sFTP to VM input folder
generate_log "Procedure 1 - Step 2: Clean input folder to receive the new files to be processed."
cd_interface="p001.s002";
ds_interface="Procedure 1 - Step 2: Clean input folder to receive the new files to be processed.";
cd_start_by="rm -rf";
ds_object_system="KCC_[A-Z\|A-Z_A_Z]+_[0-9]+.TXT";
ds_path_input="$ParamLocalInputFolder";
ds_path_output="$ParamLocalInputFolder"
date_start_processing=`date +"%Y-%m-%d %T"`
	
file_count=$(ls $ParamLocalInputFolder | egrep KCC_[A-Z\|A-Z_A_Z]+_[0-9]+.TXT | wc -l)

if [ $? -ne 0 ] || [ $file_count -lt 1 ]
    then
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=$date_end_processing;
        qt_read_records=$file_count;
        qt_load_records=$file_count;
        qt_rejected_records=``
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 1 - Step 2: Input folder is already empty and does not need to be cleaned."
    else
        ls $ParamLocalInputFolder | egrep KCC_[A-Z\|A-Z_A_Z]+_[0-9]+.TXT | xargs rm -rf
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=$date_end_processing;
        qt_read_records=$file_count;
        qt_load_records=$file_count;
        qt_rejected_records=``;

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 1 - Step 2: Filesystem error. Please check if filesystem is full or contact your administrator."
		exit_sh 2; exit 2
fi
generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 1 - Step 2: VM input folder cleaned successfully."
fi
        
#Procedure 1 - Step 3: Connect sFTP to copy master files from sFTP to VM input folder.
generate_log "Procedure 1 - Step 3: Connect sFTP to copy master files from sFTP to VM input folder."

cd_interface="p001.s003";
ds_interface="Procedure 1 - Step 3: Connect sFTP to copy master files from sFTP to VM input folder.";
cd_start_by="sftp";
ds_object_system="KCC_[A-Z\|A-Z_A_Z]+_[0-9]+.TXT";
ds_path_input="$ParamSFTPFilePath";
ds_path_output="$ParamLocalInputFolder";
date_start_processing=`date +"%Y-%m-%d %T"`;


#acessar sftp via modulo sftp 
#sshpass -p $ParamSFTPPassword sftp $ParamSFTPUser"@"$ParamSFTPHost":"$ParamSFTPFilePath"/*" $ParamLocalInputFolder

#acessar sftp via modulo/pacote lftp - aceita regex - necessÃƒÆ’Ã‚Â¡rio para captar apenas arquivos do dia, caso existam outros arquivos em outbound (como histÃƒÆ’Ã‚Â³ricos)
data_falcon=$(date --date=$Day" -0 days" '+%Y%m%d')

#Copia e Remove arquivo do sftp 
lftp -e "open sftp://"$ParamSFTPUser":"$ParamSFTPPassword"@"$ParamSFTPHost"; cd "$ParamSFTPFilePath"; mirror --Remove-source-files -p -c -i KCC_[A-Z\|A-Z_A_Z]+_"$data_falcon".TXT "$ParamSFTPFilePath" "$ParamLocalInputFolder"; bye"

#Copia e nao remove arquivos do sftp
#lftp -e "open sftp://"$ParamSFTPUser":"$ParamSFTPPassword"@"$ParamSFTPHost"; cd "$ParamSFTPFilePath"; mirror -p -c -i KCC_[A-Z\|A-Z_A_Z]+_"$data_falcon".TXT "$ParamSFTPFilePath" "$ParamLocalInputFolder"; bye"


#------- controle de fluxo --------------
cd_exit=$?
#cd_exit=0
#-----------------------------------------

file_count=$(ls $ParamLocalInputFolder | egrep KCC_[A-Z\|A-Z_A_Z]+_[0-9]+.TXT | wc -l)
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing;
      qt_read_records=``;
      qt_load_records=$file_count;
      qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 1 - Step 3: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 3; exit 3	
fi
generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 1 - Step 3: Connect sFTP to copy master files from sFTP to VM input folder successfully."        
      generate_log "Procedure 1: Collect master files successfully."

#---------------------------------------------------ENRIQUECIMENTO PRODUTO-------------------------------------------
echo -e "\n+++++++++++++++++++++++++\n| ENRIQUECIMENTO PRODUTO|\n+++++++++++++++++++++++++"
generate_log "Procedure 2: Process product data."
#Procedure 2 - Step 1: Enriched files.
generate_log "Procedure 2 - Step 1: Enriched files." 
cd_interface="p002.s001";
ds_interface="Procedure 2 - Step 1: Enriched files.";
cd_start_by="cat, sed, nl";
ds_object_system="$ParamFileMovementPrefixProduct";
ds_path_input=$ParamLocalInputFolder;
ds_path_output=$ParamLocalInputFolder
date_start_processing=`date +"%Y-%m-%d %T"`

#ENRIQUECIMETO
for product_file in $(ls $ParamLocalInputFolder | grep $ParamFileMovementPrefixProduct);\
do \
enriched_file=$(echo $product_file | cut -d '.' -f 1);\
cat $ParamLocalInputFolder/$product_file | sed 's/^/'$product_file';/' | nl -s";" > $ParamLocalInputFolder/$enriched_file"_FINAL.csv";\
done

ls $ParamLocalInputFolder | grep $ParamFileMovementPrefixProduct

#------- controle de fluxo --------------
cd_exit=$?
#cd_exit=0
#----------------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; qt_read_records=$(ls $ParamLocalInputFolder | grep  $ParamFileMovementPrefixProduct'_FINAL' | wc -l); qt_load_records=``; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 2 - Step 1: Filesystem error. Please check if filesystem is full or contact your administrator."
		#exit_sh 2; exit 2
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 2 - Step 1: Enriched product file successfully."
fi



echo -e "\n+++++++++++++++++++++++++++++++++\n| Movendo da vm para processing |\n+++++++++++++++++++++++++++++++++"
#Procedure 2 - Step 2: Copy daily product file from local input folder to cloud processing folder to be processed..
generate_log "Procedure 2 - Step 2: Copy daily product file from local input folder to cloud processing folder to be processed."
cd_interface="p002.s002";
ds_interface="Procedure 2 - Step 2: Copy daily product file from local input folder to cloud processing folder to be processed.";
cd_start_by="gsutil cp";
ds_object_system="$ParamFileMovementPrefixProduct";
ds_path_input=$ParamFileMovementPrefixProduct;
ds_path_output="$ParamCloudProcessingFolder";
date_start_processing=`date +"%Y-%m-%d %T"`;
qt_load_records=$(ls $ParamLocalInputFolder | grep  $ParamFileMovementPrefixProduct'_FINAL' | wc -l)

find $ParamLocalInputFolder | grep -i $ParamFileMovementPrefixProduct.*'_FINAL'.* | gsutil -m cp -I $ParamCloudProcessingFolder


#------- controle de fluxo --------------
cd_exit=$?
#cd_exit=0
#----------------------------------------
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; qt_read_records=``; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 2 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 3; exit 3
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 2 - Step 2: Daily product file copied to cloud processing folder successfully."
fi


#-------------------------------------------- PROCESSA PRODUTO -------------------------------------------------
#Procedure 2 - Step 3: Replace daily product table with the daily product contents.
generate_log "Procedure 2 - Step 3: Replace daily product table with the daily product contents."
cd_interface="p002.s003";
ds_interface="Procedure 2 - Step 3: Replace daily product table with the daily product contents.";
cd_start_by="bq replace";
ds_object_system="$ParamLocalLoadFolder/tb_day_mrd_kcc001_product.sql";
ds_path_input="$ParamBQDataSet.$ParamBQTableExtProduct";
ds_path_output="$ParamBQDataSet.$ParamBQTableDayProduct"


#------------------------------ SUBSTITUIR ----------------------------------------------
#DIARIA
qt_records=`bq query --nouse_legacy_sql --format=prettyjson "select count(*) from $ParamBQDataSet.$ParamBQTableExtProduct" | grep f0_ | cut -d"\"" -f4`
echo $qt_records "Registros na tabela $ParamBQDataSet.$ParamBQTableExtProduct";\

if [ $qt_records -ne 0 ]
    then
        date_start_processing=`date +"%Y-%m-%d %T"`;\
        
        bq query -n 0 --replace --destination_table $ParamBQDataSet.$ParamBQTableDayProduct \
        --use_legacy_sql=false "$(cat $ParamLocalUDFFolder/*.sql)" \
        "$(cat $ParamLocalLoadFolder/$ParamBQTableDayProduct.sql)";\
 
        cd_exit=$?

        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDayProduct | grep nr_load_control | cut -d"\"" -f4`;
        qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayProduct | grep numRows | cut -d"\"" -f4`; 
        qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayProduct | grep numRows | cut -d"\"" -f4`; 
        qt_rejected_records=``
fi

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 2 - Step 3: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 12; exit 12
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 2 - Step 3: Daily product table replaced successfully." 
fi

#------------------------------------------------------------------------------------

#Procedure 2 - Step 4: Merge daily product table with history product table.
generate_log "Procedure 2 - Step 4: Merge daily product table with history product table."
cd_interface="p002.s004";
ds_interface="Procedure 2 - Step 4: Merge daily product table with history product table.";
cd_start_by="bq query";
ds_object_system="$ParamLocalLoadFolder/$ParamBQTableHisProduct.sql";
ds_path_input="$ParamBQDataSet.$ParamBQTableDayProduct";
ds_path_output="$ParamBQDataSet.$ParamBQTableHisProduct"
date_start_processing=`date +"%Y-%m-%d %T"`

#HISTÃƒÆ’Ã¢â‚¬Å“RICA
bq query --use_legacy_sql=false "$(cat $ParamLocalUDFFolder/*.sql)" \
"$(cat $ParamLocalLoadFolder/$ParamBQTableHisProduct.sql)"

cd_exit=$?
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDayProduct | grep nr_load_control | cut -d"\"" -f4`; qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayProduct | grep numRows | cut -d"\"" -f4`; qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayProduct | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 2 - Step 4: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 13; exit 13
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 2 - Step 4: Daily product table and history product table merged successfully."
fi


#----------------------------------------------TABELA DE CONTROLE - PRODUTO --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Procedure 2 - Step 5: Insert control infos from tb_day_mrd_wdu001_product in tb_day_sys_wdu001_received_ctrl_files.
generate_log "Procedure 2 - Step 5: Insert control infos from tb_day_mrd_wdu001_product in tb_day_sys_wdu001_received_ctrl_files."
cd_interface="p002.s005";
ds_interface="Procedure 2 - Step 5: Insert control infos from tb_day_mrd_wdu001_product in tb_day_sys_wdu001_received_ctrl_files.";
cd_start_by="bq query";
ds_object_system="$ParamLocalLoadFolder/$ParamInsertCtrlFileProduct.sql";
ds_path_input="$ParamLocalLoadFolder";
ds_path_output="$ParamLocalLoadFolder";
date_start_processing=`date +"%Y-%m-%d %T"`

#CONTROLE
qt_load_records=$(bq --headless --quiet query --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/$ParamInsertCtrlFileProduct.sql)" | cut -d ":" -f 2)

cd_exit=$?
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing;
qt_read_records=``;
#qt_load_records=``;
qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 2 - Step 5: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 161; exit 161
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 2 - Step 5: Insert control infos from tb_day_mrd_wdu001_product successfully."
        generate_log "Procedure 2: Processed product data successfully."
fi


#---------------------------------------------------ENRIQUECIMENTO CLIENTES-------------------------------------------
echo -e "\n+++++++++++++++++++++++++++\n| ENRIQUECIMENTO CLIENTES |\n+++++++++++++++++++++++++++"

generate_log "Procedure 3: Processed customer data."
#Procedure 3 - Step 1: Enriched files
generate_log "Procedure 3 - Step 1: Enriched files" 
cd_interface="p003.s001";
ds_interface="Procedure 3 - Step 1: Enriched files";
cd_start_by="cat, sed, nl";
ds_object_system="$ParamFileMovementPrefixCustomer";
ds_path_input=$ParamLocalInputFolder;
ds_path_output=$ParamLocalInputFolder
date_start_processing=`date +"%Y-%m-%d %T"`


#ENRIQUECIMENTO
for customer_file in $(ls $ParamLocalInputFolder | grep $ParamFileMovementPrefixCustomer);\
do \
enriched_file=$(echo $customer_file | cut -d '.' -f 1);\
cat $ParamLocalInputFolder/$customer_file | sed 's/^/'$customer_file';/' | nl -s";" >$ParamLocalInputFolder/$enriched_file"_FINAL.csv";\
done

ls $ParamLocalInputFolder | grep $ParamFileMovementPrefixCustomer

#------- controle de fluxo --------------
cd_exit=$?
#cd_exit=0
#----------------------------------------
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing;
qt_read_records=$(ls $ParamLocalInputFolder | grep  $ParamFileMovementPrefixCustomer | wc -l);
qt_load_records=``;
qt_rejected_records=``;

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 3 - Step 1: Filesystem error. Please check if filesystem is full or contact your administrator."
		#exit_sh 2; exit 2
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 3 - Step 1: Enriched customer file successfully."
fi


#---------------------------------------------------- MOVE CLIENTES ---------------------------------------------------------
echo -e "\n+++++++++++++++++++++++++++++++++\n| Movendo da vm para processing |\n+++++++++++++++++++++++++++++++++"
#Procedure 3 - Step 2: Copy daily customer file from local input folder to cloud processing folder to be processed.
generate_log "Procedure 3 - Step 2: Copy daily customer file from local input folder to cloud processing folder to be processed."
cd_interface="p003.s002";
ds_interface="Procedure 3 - Step 2: Copy daily customer file from local input folder to cloud processing folder to be processed.";
cd_start_by="gsutil cp";
ds_object_system="$ParamFileMovementPrefixCustomer";
ds_path_input=$ParamFileMovementPrefixCustomer;
ds_path_output="$ParamCloudProcessingFolder";
date_start_processing=`date +"%Y-%m-%d %T"`;
qt_load_records=$(ls $ParamLocalInputFolder | grep  -i $ParamFileMovementPrefixCustomer | wc -l)

find $ParamLocalInputFolder | grep -i $ParamFileMovementPrefixCustomer.*'_FINAL'.* | gsutil -m cp -I $ParamCloudProcessingFolder

#------- controle de fluxo --------------
cd_exit=$?
#cd_exit=0
#----------------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; qt_read_records=``; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 3 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 3; exit 3
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 3 - Step 2: Daily customer file copied to cloud processing folder successfully."
fi


#Procedure 3 - Step 3: Replace daily customer table with the daily customer contents.
generate_log "Procedure 3 - Step 3: Replace daily customer table with the daily customer contents."
cd_interface="p003.s003";
ds_interface="Procedure 3 - Step 3: Replace daily customer table with the daily customer contents.";
cd_start_by="bq replace"; 
ds_object_system="$ParamLocalLoadFolder/tb_day_mrd_kcc001_customer.sql"; 
ds_path_input="$ParamBQDataSet.$ParamBQTableExtCustomer"; 
ds_path_output="$ParamBQDataSet.$ParamBQTableDayCustomer";


#DIARIA
qt_records=`bq query --nouse_legacy_sql --format=prettyjson "select count(*) from $ParamBQDataSet.$ParamBQTableExtCustomer" | grep f0_ | cut -d"\"" -f4`
echo $qt_records "Registros na tabela $ParamBQDataSet.$ParamBQTableExtCustomer"
if [ $qt_records -ne 0 ]
    then
    date_start_processing=`date +"%Y-%m-%d %T"`
    bq query -n=0 --replace --destination_table $ParamBQDataSet.$ParamBQTableDayCustomer  \
    --clustering_fields cd_customer_code_cpg \
    --use_legacy_sql=false "$(cat $ParamLocalUDFFolder/*.sql)" \
    "$(cat $ParamLocalLoadFolder/$ParamBQTableDayCustomer.sql)"

    cd_exit=$?
    date_end_processing=`date +"%Y-%m-%d %T"`
    nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDayCustomer | grep nr_load_control | cut -d"\"" -f4`; 
    qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayCustomer | grep numRows | cut -d"\"" -f4`; 
    qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayCustomer | grep numRows | cut -d"\"" -f4`; 
    qt_rejected_records=``
fi
    
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 3 - Step 3: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 12; exit 12
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 3 - Step 3: Daily customer table replaced successfully."
fi


#Procedure 3 - Step 4: Merge daily customer table with history customer table.
generate_log "Procedure 3 - Step 4: Merge daily customer table with history customer table."
cd_interface="p003.s004";
ds_interface="Procedure 3 - Step 4: Merge daily customer table with history customer table.";
cd_start_by="bq replace";
ds_object_system="$ParamLocalLoadFolder/tb_his_mrd_kcc001_customer.sql";
ds_path_input="$ParamBQDataSet.$ParamBQTableDayCustomer";
ds_path_output="$ParamBQDataSet.$ParamBQTableHisCustomer";
date_start_processing=`date +"%Y-%m-%d %T"`

#HISTÃƒÆ’Ã¢â‚¬Å“RICA
bq --headless --quiet query --use_legacy_sql=false \
"$(cat $ParamLocalLoadFolder/$ParamBQTableHisCustomer.sql)"

cd_exit=$?
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDayCustomer | grep nr_load_control | cut -d"\"" -f4`; qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayCustomer | grep numRows | cut -d"\"" -f4`; qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayCustomer | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 3 - Step 4: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 13; exit 13
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 3 - Step 4: Daily customer table and history customer table merged successfully."
fi


#----------------------------------------------TABELA DE CONTROLE - CLIENTE --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Procedure 3 - Step 5: Insert control infos in tb_day_sys_wdu001_received_ctrl_files.
generate_log "Procedure 3 - Step 5: Insert control infos from $ParamBQTableDayCustomer in tb_day_sys_wdu001_received_ctrl_files."
cd_interface="p003.s005";
ds_interface="Procedure 3 - Step 5: Insert control infos from $ParamBQTableDayCustomer in tb_day_sys_wdu001_received_ctrl_files.";
cd_start_by="bq query";
ds_object_system="$ParamLocalLoadFolder/$ParamInsertCtrlFileCustomer.sql";
ds_path_input="$ParamLocalLoadFolder";
ds_path_output="$ParamLocalLoadFolder";
date_start_processing=`date +"%Y-%m-%d %T"`

#CONTROLE DE ARQUIVOS
qt_load_records=$(bq --headless --quiet query --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/$ParamInsertCtrlFileCustomer.sql)" | cut -d ":" -f 2)

cd_exit=$?
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; 
qt_read_records=``;
#qt_load_records=``;
qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 3 - Step 5: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 161; exit 161
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 3 - Step 5: Insert control infos from $ParamBQTableDayCustomer successfully."
        generate_log "Procedure 3: Processed customer data successfully."
fi

#---------------------------------------------- GERAÃƒâ€¡ÃƒÆ’O DE ARQUIVO DE CLIENTES - ROBO DE CLIENTES --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Procedure 3 - Step 6: Create temp table with customer robot master data.
	generate_log "Procedure 3 - Step 6: Create temp table with customer robot master data."
	cd_interface="p003.s006"; ds_interface="Procedure 3:  Extracts master data of customers. | Step 6: Create temp table with customer robot master data."; cd_start_by="bq"; ds_object_system=""; ds_path_input="$ParamBQDataSet.$ParamBQViewHisCustomer"; ds_path_output=""$ParamBQDataSet"_tmp.$ParamBQTableTmpMRDCustomerRobot"
	date_start_processing=`date +"%Y-%m-%d %T"`
		bq --headless --quiet query --replace --destination_table "$ParamBQDataSet"_tmp.$ParamBQTableTmpMRDCustomerRobot --use_legacy_sql=false "SELECT SAFE_CAST(t1.nr_registered_number AS STRING) AS r_cnpj, SAFE_CAST(t1.cd_customer_code_cpg AS STRING) AS r_codigo_cliente, SAFE_CAST(COALESCE(t2.nm_company_name,t1.nm_customer_name_cpg) AS STRING) AS r_razao_social, SAFE_CAST(COALESCE(t2.ds_public_place,t1.ds_blg_address) AS STRING) AS r_endereco_logradouro, SAFE_CAST(t2.ds_number AS STRING) AS r_endereco_numero, SAFE_CAST(t2.ds_complement AS STRING) AS r_endereco_complemento, SAFE_CAST(t2.ds_district AS STRING) AS r_endereco_bairro, SAFE_CAST(COALESCE(t2.ds_locality,t1.ds_blg_city) AS STRING) AS r_endereco_cidade, SAFE_CAST(COALESCE(t2.cd_state,t1.cd_blg_uf) AS STRING) AS r_endereco_uf, SAFE_CAST(COALESCE(t2.nr_zip_code,t1.nr_blg_zip) AS STRING) AS r_endereco_cep, SAFE_CAST(t1.cd_blg_country AS STRING) AS r_endereco_pais, SAFE_CAST(t2.nm_partner AS STRING) AS r_qsa_socio_nome_00, SAFE_CAST(t2.nm_representative_partner_01 AS STRING) AS r_qsa_socio_nome_01, SAFE_CAST(t2.nm_representative_partner_02 AS STRING) AS r_qsa_socio_nome_02, SAFE_CAST(t2.nm_representative_partner_03 AS STRING) AS r_qsa_socio_nome_03, SAFE_CAST(t2.nm_representative_partner_04 AS STRING) AS r_qsa_socio_nome_04, SAFE_CAST(t2.nm_representative_partner_05 AS STRING) AS r_qsa_socio_nome_05, SAFE_CAST(t2.nm_representative_partner_06 AS STRING) AS r_qsa_socio_nome_06, SAFE_CAST(t2.nm_representative_partner_07 AS STRING) AS r_qsa_socio_nome_07, SAFE_CAST(t2.nm_representative_partner_08 AS STRING) AS r_qsa_socio_nome_08, SAFE_CAST(t2.nm_representative_partner_09 AS STRING) AS r_qsa_socio_nome_09, SAFE_CAST(t2.nm_representative_partner_10 AS STRING) AS r_qsa_socio_nome_10, SAFE_CAST(t2.nm_representative_partner_11 AS STRING) AS r_qsa_socio_nome_11, SAFE_CAST(t2.nm_representative_partner_12 AS STRING) AS r_qsa_socio_nome_12, SAFE_CAST(t2.nm_representative_partner_13 AS STRING) AS r_qsa_socio_nome_13, SAFE_CAST(t2.nm_representative_partner_14 AS STRING) AS r_qsa_socio_nome_14, SAFE_CAST(t2.nm_representative_partner_15 AS STRING) AS r_qsa_socio_nome_15, SAFE_CAST(t1.cd_area_nielsen AS STRING) AS r_codigo_area_nielsen, SAFE_CAST(t1.ds_area_nielsen AS STRING) AS r_descricao_area_nielsen FROM $ParamBQDataSet.$ParamBQViewHisCustomer t1 LEFT JOIN $ParamBQSHDProject.core.$ParamBQTableHisCompany t2 ON t1.nr_registered_number = t2.nr_registered_number_searched AND t2.ds_api_return = 'OK' ORDER BY t1.nr_registered_number"
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDayStore | grep nr_load_control | cut -d"\"" -f4`; qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayStore | grep numRows | cut -d"\"" -f4`; qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayStore | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"      
			generate_log "Procedure 3 - Step 6: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 50; exit 50
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 3 - Step 6: Temp table with customer robot master data created successfully."

#Procedure 3 - Step 7: Run query to extract master data of customers.
generate_log "Procedure 3 - Step 7: Run query to extract master data of customers."
	cd_interface="p003.s007"; ds_interface="Procedure 3:  Extracts master data of customers. | Step 7: Run query to extract master data of customers."; cd_start_by="bq"; ds_object_system=""; ds_path_input=""$ParamBQDataSet"_tmp.$ParamBQTableTmpMRDCustomerRobot"; ds_path_output="$ParamCloudTempFolder/"$ParamBQTableTmpMRDCustomerRobot"_$LOAD_CONTROL.txt.gz"
	date_start_processing=`date +"%Y-%m-%d %T"`
		bq --headless --quiet extract --destination_format CSV --compression GZIP --field_delimiter ';' --noprint_header "$ParamBQDataSet"_tmp.$ParamBQTableTmpMRDCustomerRobot $ParamCloudTempFolder/"$ParamBQTableTmpMRDCustomerRobot"_$LOAD_CONTROL.txt.gz
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 3 - Step 7: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 50; exit 50
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 3 - Step 7: Query to extract master data of customers ran successfully."

#Procedure 3 - Step 8: Move customer robot master data files from GCS to local folder.
generate_log "Procedure 3 - Step 8: Move customer robot master data files from GCS to local folder."
	cd_interface="p003.s008"; ds_interface="Procedure 3:  Extracts master data of customers. | Step 8: Move customer robot master data files from GCS to local folder."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamCloudTempFolder/"$ParamBQTableTmpMRDCustomerRobot"_$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamLocalTempFolder/"
	date_start_processing=`date +"%Y-%m-%d %T"`
		gsutil -q -m mv $ParamCloudTempFolder/"$ParamBQTableTmpMRDCustomerRobot"_$LOAD_CONTROL.txt.gz $ParamLocalTempFolder/
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 3 - Step 8: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 50; exit 50
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 3 - Step 8: Customer robot master data files from GCS moved to local folder successfully."
	
#Procedure 3 - Step 9: Add header and rename the extracted customer file.
generate_log "Procedure 3 - Step 9: Add header and rename the extracted customer file."
	cd_interface="p003.s009"; ds_interface="Procedure 3:  Extracts master data of customers. | Step 9: Add header and rename the extracted customer file."; cd_start_by="gzip"; ds_object_system=""; ds_path_input="$ParamLocalParameterFolder/$ParamBQTableTmpMRDCustomerRobot-HEADER.txt"; ds_path_output="$ParamLocalTempFolder/$ParamBQTableTmpMRDCustomerRobot-$LOAD_CONTROL.txt.gz"
	date_start_processing=`date +"%Y-%m-%d %T"`
		gzip -q -c $ParamLocalParameterFolder/$ParamBQTableTmpMRDCustomerRobot-HEADER.txt > $ParamLocalTempFolder/$ParamBQTableTmpMRDCustomerRobot-$LOAD_CONTROL.txt.gz
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 3 - Step 9: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 50; exit 50
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 3 - Step 9: Header added and the extracted customer file renamed successfully."
	
#Procedure 3 - Step 10: Concatenate customer robot master data files to final file.
generate_log "Procedure 3 - Step 10: Concatenate customer robot master data files to final file."
	cd_interface="p003.s010"; ds_interface="Procedure 3:  Extracts master data of customers. | Step 10: Concatenate customer robot master data files to final file."; cd_start_by="cat"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/"$ParamBQTableTmpMRDCustomerRobot"_$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamLocalTempFolder/$ParamBQTableTmpMRDCustomerRobot-$LOAD_CONTROL.txt.gz"
	date_start_processing=`date +"%Y-%m-%d %T"`
		cat $ParamLocalTempFolder/"$ParamBQTableTmpMRDCustomerRobot"_$LOAD_CONTROL.txt.gz >> $ParamLocalTempFolder/$ParamBQTableTmpMRDCustomerRobot-$LOAD_CONTROL.txt.gz
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 3 - Step 10: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 50; exit 50
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 3 - Step 10: Customer robot master data files concatened to final file successfully."

#Procedure 3 - Step 11: Remove customer robot master data files from local folder.
generate_log "Procedure 3 - Step 11: Remove customer robot master data files from local folder."
	cd_interface="p003.s011"; ds_interface="Procedure 3:  Extracts master data of customers. | Step 11: Remove customer robot master data files from local folder."; cd_start_by="rm"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/"$ParamBQTableTmpMRDCustomerRobot"_$LOAD_CONTROL.txt.gz"; ds_path_output=""
	date_start_processing=`date +"%Y-%m-%d %T"`
		rm -f $ParamLocalTempFolder/"$ParamBQTableTmpMRDCustomerRobot"_$LOAD_CONTROL.txt.gz
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 3 - Step 11: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 50; exit 50
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 3 - Step 11: Customer robot master data files removed from local folder successfully."

#Procedure 3 - Step 12: Generate uncompressed csv input file.
generate_log "Procedure 3 - Step 12: Generate uncompressed csv input file."
	cd_interface="p003.s012"; ds_interface="Procedure 3:  Extracts master data of customers. | Step 12: Generate uncompressed csv input file."; cd_start_by="gunzip"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/$ParamBQTableTmpMRDCustomerRobot-$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamLocalTempFolder/$ParamCSVCustomerRobotFileName.csv"
	date_start_processing=`date +"%Y-%m-%d %T"`
		gunzip -q -c $ParamLocalTempFolder/$ParamBQTableTmpMRDCustomerRobot-$LOAD_CONTROL.txt.gz > $ParamLocalTempFolder/$ParamCSVCustomerRobotFileName.csv
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 3 - Step 12: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 50; exit 50
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 3 - Step 12: Uncompressed csv input file generated successfully."

#Procedure 3 - Step 13: Clean cloud input S3 folder to receive the new file to be processed.
generate_log "Procedure 3 - Step 13: Clean cloud input S3 folder to receive the new file to be processed."
	cd_interface="p003.s013"; ds_interface="Procedure 3: Extracts master data of customers. | Step 13: Clean cloud input S3 folder to receive the new file to be processed."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamAWSS3InputFolder/$ParamCSVCustomerRobotFileName.csv"; ds_path_output=""
	date_start_processing=`date +"%Y-%m-%d %T"`
		file_count=`gsutil -q -m ls $ParamAWSS3InputFolder/$ParamCSVCustomerRobotFileName.csv | wc -l`
	if [ $? -ne 0 ] || [ $file_count -lt 1 ]
		then
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 3 - Step 13: Cloud input S3 folder is already empty and does not need to be cleaned."
	else
			gsutil -q -m rm $ParamAWSS3InputFolder/$ParamCSVCustomerRobotFileName.csv
		cd_exit=$?
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
		if [ $cd_exit -ne 0 ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
				generate_log "Procedure 3 - Step 13: GCP error. Please check if GCP is available or contact your administrator."
				exit_sh 50; exit 50
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 3 - Step 13: Cloud input S3 folder to receive the new file to be processed was cleaned successfully."
	fi
	
#Procedure 3 - Step 14: Move uncompressed csv input file to AWS S3.
generate_log "Procedure 3 - Step 14: Move uncompressed csv input file to AWS S3."
	cd_interface="p003.s014"; ds_interface="Procedure 3:  Extracts master data of customers. | Step 14: Move uncompressed csv input file to AWS S3."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/$ParamCSVCustomerRobotFileName.csv"; ds_path_output="$ParamAWSS3InputFolder/"
	date_start_processing=`date +"%Y-%m-%d %T"`
		gsutil -q -m mv $ParamLocalTempFolder/$ParamCSVCustomerRobotFileName.csv $ParamAWSS3InputFolder/
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 3 - Step 14: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 50; exit 50
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 3 - Step 14: Uncompressed csv input file moved to AWS S3 successfully."

#Procedure 3 - Step 15: Move final customer robot master data file to GCS.
generate_log "Procedure 3 - Step 15: Move final customer robot master data file to GCS."
	cd_interface="p003.s015"; ds_interface="Procedure 3:  Extracts master data of customers. | Step 15: Move final customer robot master data file to GCS."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/$ParamBQTableTmpMRDCustomerRobot-$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamCloudOutputFolder/rba/$date_reference_d1/"
	date_start_processing=`date +"%Y-%m-%d %T"`
		gsutil -q -m mv $ParamLocalTempFolder/$ParamBQTableTmpMRDCustomerRobot-$LOAD_CONTROL.txt.gz $ParamCloudOutputFolder/rba/$date_reference_d1/
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 3 - Step 15: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 50; exit 50
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 3 - Step 15: Final customer robot master data file moved to GCS successfully."

#Procedure 3 - Step 16: Remove temp table with customer robot master data.
generate_log "Procedure 3 - Step 16: Remove temp table with customer robot master data."
	cd_interface="p003.s016"; ds_interface="Procedure 3:  Extracts master data of customers. | Step 16: Remove temp table with customer robot master data."; cd_start_by="bq"; ds_object_system=""; ds_path_input=""$ParamBQDataSet"_tmp.$ParamBQTableTmpMRDCustomerRobot"; ds_path_output=""
	date_start_processing=`date +"%Y-%m-%d %T"`
		bq --headless --quiet rm -f "$ParamBQDataSet"_tmp.$ParamBQTableTmpMRDCustomerRobot
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 3 - Step 16: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 50; exit 50
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 3 - Step 16: Temp table with customer robot master data removed successfully."
			
#---------------------------------------------- FIM - GERAÃƒâ€¡ÃƒÆ’O DE ARQUIVO DE CLIENTES - ROBO DE CLIENTES --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#--------------------------------------------------- ENRIQUECIMENTO SALES STRUCTURE -------------------------------------------
echo -e "\n++++++++++++++++++++++++++++++++++\n| ENRIQUECIMENTO SALES STRUCTURE |\n++++++++++++++++++++++++++++++++++"
generate_log "Procedure 4: Processed sales structure data."


#Procedure 4 - Step 1: Enriched files.
generate_log "Procedure 4 - Step 1: Enriched files." 
cd_interface="p004.s001";
ds_interface="Procedure 4 - Step 1: Enriched files.";
cd_start_by="cat, sed, nl";
ds_object_system="$ParamFileMovementPrefixSalesStructure";
ds_path_input=$ParamLocalInputFolder;
ds_path_output=$ParamLocalInputFolder
date_start_processing=`date +"%Y-%m-%d %T"`


#ENRIQUECIMENTO
for sales_struc_file in $(ls $ParamLocalInputFolder | grep $ParamFileMovementPrefixSalesStructure);\
do \
enriched_file=$(echo $sales_struc_file | cut -d '.' -f 1);\
cat $ParamLocalInputFolder/$sales_struc_file | sed 's/^/'$sales_struc_file';/' | nl -s";" > $ParamLocalInputFolder/$enriched_file"_FINAL.csv";\
done

ls $ParamLocalInputFolder | grep $ParamFileMovementPrefixSalesStructure

#------- controle de fluxo --------------
cd_exit=$?
#------- controle de fluxo --------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; qt_read_records=$(ls $ParamLocalInputFolder | grep  $ParamFileMovementPrefixSalesStructure | wc -l); qt_load_records=``; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 4 - Step 1: Filesystem error. Please check if filesystem is full or contact your administrator."
		#exit_sh 2; exit 2
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 4 - Step 1: Enriched sales structure file successfully."
fi


echo -e "\n+++++++++++++++++++++++++++++++++\n| Movendo da vm para processing |\n+++++++++++++++++++++++++++++++++"

#Procedure 4 - Step 2: Copy daily sales structure file from local input folder to cloud processing folder to be processed.
generate_log "Procedure 4 - Step 2: Copy daily sales structure file from local input folder to cloud processing folder to be processed."
cd_interface="p004.s002";
ds_interface="Procedure 4 - Step 2: Copy daily sales structure file from local input folder to cloud processing folder to be processed.";
cd_start_by="gsutil cp";
ds_object_system="$ParamFileMovementPrefixSalesStructure";
ds_path_input="$ParamLocalInputFolder";
ds_path_output="$ParamCloudProcessingFolder"
date_start_processing=`date +"%Y-%m-%d %T"`
qt_load_records=$(ls $ParamLocalInputFolder | grep  -i $ParamFileMovementPrefixSalesStructure | wc -l)

find $ParamLocalInputFolder | grep -i $ParamFileMovementPrefixSalesStructure.*'_FINAL'.* | gsutil -m cp -I $ParamCloudProcessingFolder

#------- controle de fluxo --------------
cd_exit=$?
#cd_exit=0
#---------------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; qt_read_records=``; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 4 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 3; exit 3
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 4 - Step 2: Daily sales structure file copied to cloud processing folder successfully."      
fi


#Procedure 4 - Step 3: Replace daily sales structure table with the daily sales structure contents.
generate_log "Procedure 4 - Step 3: Replace daily sales structure table with the daily sales structure contents."
cd_interface="p004.s003"; 
ds_interface="Procedure 4 - Step 3: Replace daily sales structure table with the daily sales structure contents.";
cd_start_by="bq replace";
ds_object_system="$ParamLocalLoadFolder/$ParamBQTableDaySalesStructure.sql";
ds_path_input="$ParamBQDataSet.$ParamBQTableExtSalesStructure";
ds_path_output="$ParamBQDataSet.$ParamBQTableDaySalesStructure"


#DIARIA
qt_records=`bq query --nouse_legacy_sql --format=prettyjson "select count(*) from $ParamBQDataSet.$ParamBQTableExtSalesStructure" | grep f0_ | cut -d"\"" -f4`
echo $qt_records "Registros na tabela $ParamBQDataSet.$ParamBQTableExtSalesStructure"
if [ $qt_records -ne 0 ]
    then
    date_start_processing=`date +"%Y-%m-%d %T"`
    bq query -n=0 --replace --destination_table $ParamBQDataSet.$ParamBQTableDaySalesStructure  \
    --clustering_fields cd_customer_unique_cpg,cd_sales_organization,cd_distribution_channel,cd_division_level \
    --use_legacy_sql=false "$(cat $ParamLocalUDFFolder/*.sql)" \
    "$(cat $ParamLocalLoadFolder/$ParamBQTableDaySalesStructure.sql)"

    cd_exit=$?
    date_end_processing=`date +"%Y-%m-%d %T"`
    nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySalesStructure | grep nr_load_control | cut -d"\"" -f4`; 
    qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySalesStructure | grep numRows | cut -d"\"" -f4`; 
    qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySalesStructure | grep numRows | cut -d"\"" -f4`; 
    qt_rejected_records=``
fi

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 4 - Step 3: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 12; exit 12
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 4 - Step 3: Daily sales structure table replaced successfully."
fi


#Procedure 4 - Step 4: Merge daily sales structure table with history sales structure table.
generate_log "Procedure 4 - Step 4: Merge daily sales structure table with history sales structure table."
cd_interface="p004.s004";
ds_interface="Procedure 4 - Step 4: Merge daily sales structure table with history sales structure table.";
cd_start_by="bq";
ds_object_system="$ParamLocalLoadFolder/$ParamBQTableHisSalesStructure.sql";
ds_path_input="$ParamBQDataSet.$ParamBQTableDaySalesStructure";
ds_path_output="$ParamBQDataSet.$ParamBQTableHisSalesStructure"
date_start_processing=`date +"%Y-%m-%d %T"`

#HISTORICA
bq  query --use_legacy_sql=false \
"$(cat $ParamLocalLoadFolder/$ParamBQTableHisSalesStructure.sql)"

#------- controle de fluxo --------------
cd_exit=$?
#----------------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySalesStructure | grep nr_load_control | cut -d"\"" -f4`; qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySalesStructure | grep numRows | cut -d"\"" -f4`; qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySalesStructure | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 4 - Step 4: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 13; exit 13
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 4 - Step 4: Daily sales structure table and history sales structure table merged successfully."
fi



#----------------------------------------------TABELA DE CONTROLE - SALES STRUCTURE --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Procedure 4 - Step 5: Insert control infos in tb_day_sys_wdu001_received_ctrl_files.
generate_log "Procedure 4 - Step 5: Insert control infos from $ParamBQTableDaySalesStructure in tb_day_sys_wdu001_received_ctrl_files."
cd_interface="p004.s005";
ds_interface="Procedure 4 - Step 5: Insert control infos from $ParamBQTableDaySalesStructure in tb_day_sys_wdu001_received_ctrl_files.";
cd_start_by="bq query";
ds_object_system="$ParamBQTableDaySalesStructure";
ds_path_input="$ParamLocalLoadFolder";
ds_path_output="$ParamLocalLoadFolder"
date_start_processing=`date +"%Y-%m-%d %T"`

qt_load_records=$(bq --headless --quiet query --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/$ParamInsertCtrlFileSalesStructure.sql)" | cut -d ":" -f 2)

#------- controle de fluxo --------------
cd_exit=$?
#----------------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing;
qt_read_records=``;
#qt_load_records=``;
qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 4 - Step 5: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 161; exit 161
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 4 - Step 5: Insert control infos from $ParamBQTableDaySalesStructure successfully."
        generate_log "Procedure 4: Processed sales structure data successfully."
fi

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



#-------------------------------------------------- ENRIQUECIMENTO SELLIN -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
generate_log "Procedure 5: Process sellin data."
#Procedure 5 - Step 1: Enriched files
generate_log "Procedure 5 - Step 1: Enriched files" 
cd_interface="p005.s001";
ds_interface="Procedure 5 - Step 1: Enriched files";
cd_start_by="cat, sed, nl";
ds_object_system="$ParamFileMovementPrefixSellin";
ds_path_input=$ParamLocalInputFolder;
ds_path_output=$ParamLocalInputFolder
date_start_processing=`date +"%Y-%m-%d %T"`

#----------------------------- enriquecimento ----------------------------------------
for sellin_file in $(ls $ParamLocalInputFolder | grep $ParamFileMovementPrefixSellin);\
do \
enriched_file=$(echo $sellin_file | cut -d '.' -f 1);\
cat $ParamLocalInputFolder/$sellin_file | sed 's/^/'$sellin_file';/' | nl -s";" > $ParamLocalInputFolder/$enriched_file"_FINAL.csv";\
done

ls $ParamLocalInputFolder | grep $ParamFileMovementPrefixSellin
#------- controle de fluxo --------------
cd_exit=$?
#----------------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; qt_read_records=$(ls $ParamLocalInputFolder | grep  $ParamFileMovementPrefixSellin | wc -l); qt_load_records=``; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 5 - Step 1: Filesystem error. Please check if filesystem is full or contact your administrator."
		#exit_sh 2; exit 2
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 5 - Step 1: Enriched sellin file successfully."
fi



#Procedure 5 - Step 2: Copy daily sellin files from local input folder to cloud processing folder to be processed.
generate_log "Procedure 5 - Step 2: Copy daily sellin files from local input folder to cloud processing folder to be processed."
cd_interface="p005.s002";
ds_interface="Procedure 5 - Step 2: Copy daily sellin files from local input folder to cloud processing folder to be processed.";
cd_start_by="gsutil cp";
ds_object_system="$ParamFileMovementPrefixSellin";
ds_path_input="$ParamLocalInputFolder";
ds_path_output="$ParamCloudProcessingFolder";
date_start_processing=`date +"%Y-%m-%d %T"`

find $ParamLocalInputFolder | grep -i $ParamFileMovementPrefixSellin.*'_FINAL'.* | gsutil -m cp -I $ParamCloudProcessingFolder

#------- controle de fluxo --------------
cd_exit=$?
#cd_exit=0
#----------------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing;
qt_read_records=``;
qt_load_records=``;
qt_rejected_records=``

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 5 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 3; exit 3
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 5 - Step 2: Daily files copied to cloud processing folder successfully."
fi



#Procedure 5 - Step 3: Replace daily sellin table with the daily sellin contents.
generate_log "Procedure 5 - Step 3: Replace daily sellin table with the daily sellin contents."
cd_interface="p005.s003";
ds_interface="Procedure 5 - Step 3: Replace daily sellin table with the daily sellin contents."; 
cd_start_by="bq replace"; 
ds_object_system="$ParamLocalLoadFolder/$ParamBQTableDaySellin.sql"; 
ds_path_input="$ParamBQDataSet.$ParamBQTableExtSellin"; 
ds_path_output="$ParamBQDataSet.$ParamBQTableDaySellin"


#DIARIA
qt_records=`bq query --nouse_legacy_sql --format=prettyjson "select count(*) from $ParamBQDataSet.$ParamBQTableExtSellin" | grep f0_ | cut -d"\"" -f4`
echo $qt_records "Registros na tabela $ParamBQDataSet.$ParamBQTableExtSellin"

if [ $qt_records -ne 0 ]
    then
    date_start_processing=`date +"%Y-%m-%d %T"`
    bq query -n=0 --replace --destination_table $ParamBQDataSet.$ParamBQTableDaySellin \
    --time_partitioning_field dt_movement_reference \
    --use_legacy_sql=false "$(cat $ParamLocalUDFFolder/*.sql)" \
    "$(cat $ParamLocalLoadFolder/$ParamBQTableDaySellin.sql)"

    cd_exit=$?
    date_end_processing=`date +"%Y-%m-%d %T"`
    nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySellin | grep nr_load_control | cut -d"\"" -f4`; qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySellin | grep numRows | cut -d"\"" -f4`; qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySellin | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``
fi

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 5 - Step 3: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 12; exit 12
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 5 - Step 3: Daily sellin table replaced successfully."
fi


#Procedure 5 - Step 4: Merge daily sellin table with history sellin table.
generate_log "Procedure 5 - Step 4: Merge daily sellin table with history sellin table."
cd_interface="p005.s004";
ds_interface="Procedure 5 - Step 4: Merge daily sellin table with history sellin table.";
cd_start_by="func_copia_part";
ds_object_system="workflow";
ds_path_input="$ParamBQDataSet.$ParamBQTableDaySellin";
ds_path_output="$ParamBQDataSet.$ParamBQTableHisSellin";
date_start_processing=`date +"%Y-%m-%d %T"`

#ATUALIZA A HISTÃƒÆ’Ã¢â‚¬Å“RICA DE SELLIN
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
func_copia_part() #FUNÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O QUE ATUALIZA AS PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã¢â‚¬Â¢ES DA TABELA HISTÃƒÆ’Ã¢â‚¬Å“RICA
{
    echo -e "++++++++++++++++++++++++++++++++++\n| Transferindo partiÃƒÆ’Ã‚Â§ÃƒÆ’Ã‚Â£o $1 |\n++++++++++++++++++++++++++++++++++"
	store=$1 #STORE: PARÃƒÆ’Ã¢â‚¬Å¡METRO QUE RECEBE A PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O 
	bq cp -f "$ParamBQDataSet.$ParamBQTableDaySellin\$$store" "$ParamBQDataSet.$ParamBQTableHisSellin\$$store"
}
for store in $(bq query --max_rows=366 --use_legacy_sql=true 'SELECT partition_id FROM ['$ParamBQDataSet'.'$ParamBQTableDaySellin'$__PARTITIONS_SUMMARY__]' | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g')
do
	if [ $store != "__NULL__" ];
		then func_copia_part "$store"; #CHAMA A FUNÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O QUE COPIA AS PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã¢â‚¬Â¢ES, RECEBENDO COMO PARAMETRO A PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O EM QUE O FOR ESTA ITERANDO.
		sleep $ParamStoreBreakRunSleep; # APLICA UM INTERVALO DE TEMPO ENTRE UMA CÃƒÆ’Ã¢â‚¬Å“PIA E OUTRA. NECESSÃƒÆ’Ã‚ÂRIO DEVIDO AO TEMPO DE CLUSTERING DAS VM DA GOOGLE.
	fi;
done
cd_exit=$?
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySellin | grep nr_load_control | cut -d"\"" -f4`; qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySellin | grep numRows | cut -d"\"" -f4`; qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySellin | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 5 - Step 4: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 13; exit 13
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 5 - Step 4: Daily sellin table and history sellin table merged successfully."
fi



#----------------------------------------------TABELA DE CONTROLE - SELLIN --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Procedure 5 - Step 5: Insert control infos in tb_day_sys_wdu001_received_ctrl_files.
generate_log "Procedure 5 - Step 5: Insert control infos from $ParamBQTableDaySellin in tb_day_sys_wdu001_received_ctrl_files."
cd_interface="p005.s005";
ds_interface="Procedure 5 - Step 5: Insert control infos from $ParamBQTableDaySellin in tb_day_sys_wdu001_received_ctrl_files.";
cd_start_by="bq query";
ds_object_system="$ParamLocalLoadFolder/$ParamInsertCtrlFileSellin.sql";
ds_path_input="$ParamLocalLoadFolder";
ds_path_output="$ParamLocalLoadFolder";
date_start_processing=`date +"%Y-%m-%d %T"`

#CONTROLE
qt_load_records=$(bq --headless --quiet query --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/$ParamInsertCtrlFileSellin.sql)" | cut -d ":" -f 2)


#------- controle de fluxo --------------
cd_exit=$?
#----------------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing;
qt_read_records=``;
#qt_load_records=``;
qt_rejected_records=``;

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 5 - Step 5: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 161; exit 161
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 5 - Step 5: Insert control infos from $ParamBQTableDaySellin successfully."
        generate_log "Procedure 5: Processed sellin data successfully."
fi

#---------------------------------------------- GERAÃƒâ€¡ÃƒÆ’O DE ARQUIVO DE SELLIN - ROBO DE CLIENTES --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
#Procedure 5 - Step 6: Create temp table with Sellin data.
	generate_log "Procedure 5 - Step 6: Create temp table with Sellin data."
	cd_interface="p005.s006"; ds_interface="Procedure 5: Extracts data of Sellin. | Step 6: Create temp table with Sellin data."; cd_start_by="bq"; ds_object_system=""; ds_path_input="$ParamBQDataSet.$ParamBQTableHisSellin"; ds_path_output=""$ParamBQDataSet"_tmp.$ParamBQTableTmpTRSSellin"
	date_start_processing=`date +"%Y-%m-%d %T"`
		bq --headless --quiet query --replace --destination_table "$ParamBQDataSet"_tmp.$ParamBQTableTmpTRSSellin --use_legacy_sql=false "SELECT SAFE_CAST(t1.dt_movement_reference AS STRING) dt_movement_reference, SAFE_CAST(t1.dt_movement AS STRING) dt_movement, SAFE_CAST(t1.cd_customer_code_cpg AS STRING) cd_customer_code_cpg, SAFE_CAST(t1.nr_registered_number AS STRING) nr_registered_number, SAFE_CAST(t1.nr_product_ean_cpg AS STRING) nr_product_ean_cpg, SAFE_CAST(t1.cd_sku_unique_cpg AS STRING) cd_sku_unique_cpg, SAFE_CAST(qt_sale_un AS STRING) qt_sale_un FROM $ParamBQDataSet.$ParamBQTableHisSellin t1 INNER JOIN (SELECT cd_customer_unique_cpg, nr_registered_number, nr_product_ean_cpg, MAX(dt_movement) AS dt_movement FROM $ParamBQDataSet.$ParamBQTableHisSellin WHERE dt_movement_reference >= DATE_SUB(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL 6 MONTH) GROUP BY cd_customer_unique_cpg, nr_registered_number, nr_product_ean_cpg) t2 ON t2.cd_customer_unique_cpg = t1.cd_customer_code_cpg AND t2.nr_registered_number = t1.nr_registered_number AND t2.nr_product_ean_cpg = t1.nr_product_ean_cpg AND t2.dt_movement = t1.dt_movement WHERE qt_sale_un > 0 ORDER BY dt_movement"
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDayStore | grep nr_load_control | cut -d"\"" -f4`; qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayStore | grep numRows | cut -d"\"" -f4`; qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayStore | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"      
			generate_log "Procedure 5 - Step 6: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 51; exit 51
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 5 - Step 6: Temp table with Sellin data created successfully."

#Procedure 5 - Step 7: Run query to extract Sellin data.
generate_log "Procedure 5 - Step 7: Run query to extract Sellin data."
	cd_interface="p005.s007"; ds_interface="Procedure 5: Extracts data of Sellin. | Step 7: Run query to extract Sellin data."; cd_start_by="bq"; ds_object_system=""; ds_path_input=""$ParamBQDataSet"_tmp.$ParamBQTableTmpTRSSellin"; ds_path_output="$ParamCloudTempFolder/"$ParamBQTableTmpTRSSellin"_$LOAD_CONTROL.txt.gz"
	date_start_processing=`date +"%Y-%m-%d %T"`
		bq --headless --quiet extract --destination_format CSV --compression GZIP --field_delimiter ';' --noprint_header "$ParamBQDataSet"_tmp.$ParamBQTableTmpTRSSellin $ParamCloudTempFolder/"$ParamBQTableTmpTRSSellin"_$LOAD_CONTROL.txt.gz
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 5 - Step 7: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 51; exit 51
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 5 - Step 7: Query to extract Sellin data ran successfully."

#Procedure 5 - Step 8: Move Sellin data files from GCS to local folder.
generate_log "Procedure 5 - Step 8: Move Sellin data files from GCS to local folder."
	cd_interface="p005.s008"; ds_interface="Procedure 5: Extracts data of Sellin. | Step 8: Move Sellin data files from GCS to local folder."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamCloudTempFolder/"$ParamBQTableTmpTRSSellin"_$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamLocalTempFolder/"
	date_start_processing=`date +"%Y-%m-%d %T"`
		gsutil -q -m mv $ParamCloudTempFolder/"$ParamBQTableTmpTRSSellin"_$LOAD_CONTROL.txt.gz $ParamLocalTempFolder/
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 5 - Step 8: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 51; exit 51
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 5 - Step 8: Sellin data files from GCS moved to local folder successfully."
	
#Procedure 5 - Step 9: Add header and rename the extracted sellin file.
generate_log "Procedure 5 - Step 9: Add header and rename the extracted sellin file."
	cd_interface="p005.s009"; ds_interface="Procedure 5: Extracts data of Sellin. | Step 9: Add header and rename the extracted sellin file."; cd_start_by="gzip"; ds_object_system=""; ds_path_input="$ParamLocalParameterFolder/$ParamBQTableTmpTRSSellin-HEADER.txt"; ds_path_output="$ParamLocalTempFolder/$ParamBQTableTmpTRSSellin-$LOAD_CONTROL.txt.gz"
	date_start_processing=`date +"%Y-%m-%d %T"`
		gzip -q -c $ParamLocalParameterFolder/$ParamBQTableTmpTRSSellin-HEADER.txt > $ParamLocalTempFolder/$ParamBQTableTmpTRSSellin-$LOAD_CONTROL.txt.gz
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 5 - Step 9: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 51; exit 51
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 5 - Step 9: Header added and the extracted sellin file renamed successfully."
	
#Procedure 5 - Step 10: Concatenate Sellin data files to final file.
generate_log "Procedure 5 - Step 10: Concatenate Sellin data files to final file."
	cd_interface="p005.s010"; ds_interface="Procedure 5: Extracts data of Sellin. | Step 10: Concatenate Sellin data files to final file."; cd_start_by="cat"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/"$ParamBQTableTmpTRSSellin"_$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamLocalTempFolder/$ParamBQTableTmpTRSSellin-$LOAD_CONTROL.txt.gz"
	date_start_processing=`date +"%Y-%m-%d %T"`
		cat $ParamLocalTempFolder/"$ParamBQTableTmpTRSSellin"_$LOAD_CONTROL.txt.gz >> $ParamLocalTempFolder/$ParamBQTableTmpTRSSellin-$LOAD_CONTROL.txt.gz
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 5 - Step 10: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 51; exit 51
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 5 - Step 10: Sellin data files concatened to final file successfully."

#Procedure 5 - Step 11: Remove Sellin data files from local folder.
generate_log "Procedure 5 - Step 11: Remove Sellin data files from local folder."
	cd_interface="p005.s011"; ds_interface="Procedure 5: Extracts data of Sellin. | Step 11: Remove Sellin data files from local folder."; cd_start_by="rm"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/"$ParamBQTableTmpTRSSellin"_$LOAD_CONTROL.txt.gz"; ds_path_output=""
	date_start_processing=`date +"%Y-%m-%d %T"`
		rm -f $ParamLocalTempFolder/"$ParamBQTableTmpTRSSellin"_$LOAD_CONTROL.txt.gz
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 5 - Step 11: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 51; exit 51
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 5 - Step 11: Sellin data files removed from local folder successfully."

#Procedure 5 - Step 12: Generate uncompressed csv input file.
generate_log "Procedure 5 - Step 12: Generate uncompressed csv input file."
	cd_interface="p005.s012"; ds_interface="Procedure 5: Extracts data of Sellin. | Step 12: Generate uncompressed csv input file."; cd_start_by="gunzip"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/$ParamBQTableTmpTRSSellin-$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamLocalTempFolder/$ParamCSVSellinFileName.csv"
	date_start_processing=`date +"%Y-%m-%d %T"`
		gunzip -q -c $ParamLocalTempFolder/$ParamBQTableTmpTRSSellin-$LOAD_CONTROL.txt.gz > $ParamLocalTempFolder/$ParamCSVSellinFileName.csv
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 5 - Step 12: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 51; exit 51
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 5 - Step 12: Uncompressed csv input file generated successfully."

#Procedure 5 - Step 13: Clean cloud input S3 folder to receive the new file to be processed.
generate_log "Procedure 5 - Step 13: Clean cloud input S3 folder to receive the new file to be processed."
	cd_interface="p005.s013"; ds_interface="Procedure 5: Extracts data of Sellin. | Step 13: Clean cloud input S3 folder to receive the new file to be processed."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamAWSS3InputFolder/$ParamCSVSellinFileName.csv"; ds_path_output=""
	date_start_processing=`date +"%Y-%m-%d %T"`
		file_count=`gsutil -q -m ls $ParamAWSS3InputFolder/$ParamCSVSellinFileName.csv | wc -l`
	if [ $? -ne 0 ] || [ $file_count -lt 1 ]
		then
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 5 - Step 13: Cloud input S3 folder is already empty and does not need to be cleaned."
	else
			gsutil -q -m rm $ParamAWSS3InputFolder/$ParamCSVSellinFileName.csv
		cd_exit=$?
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
		if [ $cd_exit -ne 0 ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 5 - Step 13: GCP error. Please check if GCP is available or contact your administrator."
				exit_sh 51; exit 51
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 5 - Step 13: Cloud input S3 folder to receive the new file to be processed was cleaned successfully."
	fi
	
#Procedure 5 - Step 14: Move uncompressed csv input file to AWS S3.
generate_log "Procedure 5 - Step 14: Move uncompressed csv input file to AWS S3."
	cd_interface="p005.s014"; ds_interface="Procedure 5: Extracts data of Sellin. | Step 14: Move uncompressed csv input file to AWS S3."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/$ParamCSVSellinFileName.csv"; ds_path_output="$ParamAWSS3InputFolder/"
	date_start_processing=`date +"%Y-%m-%d %T"`
		gsutil -q -m mv $ParamLocalTempFolder/$ParamCSVSellinFileName.csv $ParamAWSS3InputFolder/
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 5 - Step 14: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 51; exit 51
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 5 - Step 14: Uncompressed csv input file moved to AWS S3 successfully."

#Procedure 5 - Step 15: Move final Sellin data file to GCS.
generate_log "Procedure 5 - Step 15: Move final Sellin data file to GCS."
	cd_interface="p005.s015"; ds_interface="Procedure 5: Extracts data of Sellin. | Step 15: Move final Sellin data file to GCS."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/$ParamBQTableTmpTRSSellin-$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamCloudOutputFolder/rba/$date_reference_d1/"
	date_start_processing=`date +"%Y-%m-%d %T"`
		gsutil -q -m mv $ParamLocalTempFolder/$ParamBQTableTmpTRSSellin-$LOAD_CONTROL.txt.gz $ParamCloudOutputFolder/rba/$date_reference_d1/
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 5 - Step 15: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 51; exit 51
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 5 - Step 15: Final Sellin data file moved to GCS successfully."

#Procedure 5 - Step 16: Remove temp table with Sellin data.
generate_log "Procedure 5 - Step 16: Remove temp table with Sellin data."
	cd_interface="p005.s016"; ds_interface="Procedure 5: Extracts data of Sellin. | Step 16: Remove temp table with Sellin data."; cd_start_by="bq"; ds_object_system=""; ds_path_input=""$ParamBQDataSet"_tmp.$ParamBQTableTmpTRSSellin"; ds_path_output=""
	date_start_processing=`date +"%Y-%m-%d %T"`
		bq --headless --quiet rm -f "$ParamBQDataSet"_tmp.$ParamBQTableTmpTRSSellin
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 5 - Step 16: GCP error. Please check if GCP is available or contact your administrator."
			exit_sh 51; exit 51
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 5 - Step 16: Temp table with Sellin data removed successfully."
#---------------------------------------------- FIM - GERAÃƒâ€¡ÃƒÆ’O DE ARQUIVO DE SELLIN - ROBO DE CLIENTES --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	


#--------------------------------------- SELLOUT ---------------------------------------------------------------------
#Procedure 6: Collect sellout files to be processed.
generate_log "Procedure 6: Collect sellout files to be processed."

#Procedure 6 - Step 1: Clean cloud processing folder to receive the new files to be processed.
generate_log "Procedure 6 - Step 1: Clean cloud processing folder to receive the new files to be processed."

cd_interface="p006.s001"; ds_interface="Procedure 6: Collect files to be processed. | Step 1: Procedure 6 - Step 1: Clean cloud processing folder to receive the new files to be processed.."; cd_start_by="gsutil rm"; ds_object_system="FINAL_RI_KCC_*.txt"; ds_path_input="$ParamCloudProcessingFolder"; ds_path_output=""

#qt_load_records nesse caso esta no inÃƒÆ’Ã‚Â­cio para registrar a quantidade de registros apagados de processing
qt_load_records=$(gsutil ls $ParamCloudProcessingFolder/$ParamFileMovementPrefixSellout* | wc -l)

date_start_processing=`date +"%Y-%m-%d %T"`

#Remove todos arquivos com prefixo FINAL_KCC em processing se houver
gsutil rm -f $ParamCloudProcessingFolder/$ParamFileMovementPrefixSellout*

#----------- controle de fluxo ----------
cd_exit=$?
#cd_exit=0
#-----------------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; qt_read_records=``; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 6 - Step 1: Filesystem error. Please check if filesystem is full or contact your administrator."
		#exit_sh 2; exit 2
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 6 - Step 1: Cloud processing folder cleaned successfully."
fi



generate_log "Procedure 6 - Step 2: Transferring files from FTP to be enriched"
cd_interface="p006.s002"; ds_interface="Procedure 6: Collect files to be processed. | Step 2: Transferring files from FTP to be enriched"; cd_start_by="lftp"; ds_object_system="RI_KCC_*.ZIP"; ds_path_input="$ParamSFTPHost$ParamSFTPFilePath"; ds_path_output="$ParamLocalInputFolder";\

date_start_processing=`date +"%Y-%m-%d %T"`;\

data=$(date --date=$Day" -1 days" '+%Y%m%d');\
lftp -e  "open -u "$ParamFTPUser","$ParamFTPPassword" -p 21 "$ParamFTPHost";
set ftp:ssl-allow no;
cd $ParamFTPFilePath;
mirror -p -c -i RI_KCC_[A-Z]{1}+_"$data"[0-9]+.ZIP "$ParamFTPFilePath" "$ParamLocalInputFolder";
close;
quit";\

#------------- controle de fluxo -----------------
cd_exit=$?
#cd_exit=0
#-------------------------------------------------



date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; qt_read_records=``; qt_load_records=$(ls $ParamLocalInputFolder | egrep -i ri_kcc_.*.zip | wc -l); qt_rejected_records=``;
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 6 - Step 2: Filesystem error. Please check if filesystem is full or contact your administrator."
		#exit_sh 2; exit 2
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 6 - Step 2: Transferring files from FTP successfully."
fi


echo -e "\n++++++++++++++++++\n| descompactaÃƒÆ’Ã‚Â§ÃƒÆ’Ã‚Â£o |\n++++++++++++++++++"

#Procedure 6 - Step 3: Unzip files to be enriched
generate_log "Procedure 6 - Step 3: Unzip files to be enriched"
cd_interface="p006.s003"; ds_interface="Procedure 6: Collect files to be processed. | Step 3: Unzip files to be enriched"; cd_start_by="unzip"; ds_object_system="RI_KCC_*.ZIP"; ds_path_input=$ParamLocalInputFolder; ds_path_output=$ParamLocalInputFolder

date_start_processing=`date +"%Y-%m-%d %T"`
cd $ParamLocalInputFolder;\
unzip '*.ZIP';\

#------------ controle de fluxo ---------
cd_exit=$?
#cd_exit=0
#----------------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; qt_read_records=``; qt_load_records=$(ls $ParamLocalInputFolder | grep  RI_KCC_*.TXT | wc -l); qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 6 - Step 3: Filesystem error. Please check if filesystem is full or contact your administrator."
		#exit_sh 2; exit 2
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 6 - Step 3: Unzip files successfully."
fi


echo -e "\n++++++++++++++++++++++++++++++++++++++\n| enriquecimento |\n++++++++++++++++++++++++++++++++++++++"

#Procedure 6 - Step 4: Enriched files
generate_log "Procedure 6 - Step 4: Enriched files" 
cd_interface="p006.s004"; ds_interface="Procedure 6: Collect files to be processed. | Step 4: Enriched files"; cd_start_by="cat RI_KCC_*.TXT| sed 's/^/RI_KCC_*.TXT;/'|  nl -s \";\" > FINAL_RI_KCC_*.txt"; ds_object_system="FINAL_RI_KCC_*.txt"; ds_path_input=$ParamLocalInputFolder; ds_path_output=$ParamLocalInputFolder

#------------------------------- enriquecimento --------------------------------------------------------------
date_start_processing=`date +"%Y-%m-%d %T"`
for neogrid_file in $(ls $ParamLocalInputFolder | grep RI_KCC_.*.TXT);
do \
enriched_file=$(echo $neogrid_file | cut -d '.' -f 1);\
cat $ParamLocalInputFolder/$neogrid_file | sed 's/^/'$neogrid_file';/' | nl -s";" > $ParamLocalInputFolder/FINAL_$enriched_file".txt";\
done;\

find $ParamLocalInputFolder | grep FINAL_RI_KCC;\


#------------ controle de fluxo ------------
cd_exit=$?
#cd_exit=0
#-------------------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; qt_read_records=$(ls $ParamLocalInputFolder | grep  FINAL_RI_KCC_*.txt | wc -l); qt_load_records=``; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 6 - Step 4: Filesystem error. Please check if filesystem is full or contact your administrator."
		#exit_sh 2; exit 2
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 6 - Step 4: Enriched files successfully."
fi



echo -e "\n+++++++++++++++++++++++++++++++++\n| Movendo da vm para processing |\n+++++++++++++++++++++++++++++++++"
#Procedure 6- Step 5: Copy daily files from local input folder to cloud processing folder to be processed.


generate_log "Procedure 6 - Step 5: Copy daily files from local input folder to cloud processing folder to be processed."
cd_interface="p006.s005"; ds_interface="Procedure 6: Collect files to be processed. | Step 5: Copy daily files from local input folder to cloud processing folder to be processed."; cd_start_by="gsutil mv"; ds_object_system="FINAL_RI_KCC_*.txt"; ds_path_input="$ParamLocalInputFolder/FINAL_RI_KCC_*.txt"; ds_path_output="$ParamCloudProcessingFolder"

date_start_processing=`date +"%Y-%m-%d %T"`

qt_load_records=$(ls $ParamLocalInputFolder | grep  FINAL_RI_KCC_.*.txt | wc -l)

#@@@@@@@@@@ melhorar esse trecho @@@@@@@@@@@@@@
find $ParamLocalInputFolder | grep FINAL_RI_KCC.*.txt | gsutil -m cp -I $ParamCloudProcessingFolder


#--------- controle de fluxo ------------
cd_exit=$?
#cd_exit=0
#----------------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; qt_read_records=``; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 6 - Step 5: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 3; exit 3
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 6 - Step 5: Daily files copied to cloud processing folder successfully."
        generate_log "Procedure 6: Sellout files to be processed collected successfully."
fi


#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Procedure 7: Process sellout data.
generate_log "Procedure 7: Process sellout data."

#Procedure 7 - Step 1: Replace daily sellout table with the daily sellout contents.
generate_log "Procedure 7 - Step 1: Replace daily sellout table with the daily sellout contents."
cd_interface="p007.s001"; ds_interface="Procedure 7: Process sellout data. | Step 1: Replace daily sellout table with the daily sellout contents."; cd_start_by="bq replace"; ds_object_system="cat $ParamLocalLoadFolder/tb_day_trs_kcc001_sellout.sql"; ds_path_input="$ParamBQDataSet.$ParamBQTableExtSellout"; ds_path_output="$ParamBQDataSet.$ParamBQTableDaySellout"

echo "Replace tb_day_trs_wdu001_sellout_neogrid"
qt_records=`bq query --nouse_legacy_sql --format=prettyjson "select count(*) from $ParamBQDataSet.$ParamBQTableExtSellout" | grep f0_ | cut -d"\"" -f4`
echo $qt_records "Registros na tabela $ParamBQDataSet.$ParamBQTableExtSellout"
if [ $qt_records -ne 0 ]
    then
        date_start_processing=`date +"%Y-%m-%d %T"`
        bq query -n=0 --replace --destination_table $ParamBQDataSet.$ParamBQTableDaySellout \
        --time_partitioning_field $ParamPartitioningFieldSellout \
        --clustering_fields $ParamClusteringFieldSellout \
        --use_legacy_sql=false "$(cat $ParamLocalUDFFolder/*.sql)" \
        "$(cat $ParamLocalLoadFolder/$ParamBQTableDaySellout.sql)"
        
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySellout | grep nr_load_control | cut -d"\"" -f4`; 
        qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySellout | grep numRows | cut -d"\"" -f4`; 
        qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySellout | grep numRows | cut -d"\"" -f4`; 
        qt_rejected_records=``
        
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 7 - Step 1: Daily sellout table replaced successfully."
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 7 - Step 1: GCP error. Please check if GCP is available or contact your administrator."
fi

#Procedure 7 - Step 2: Replace temp sellout table with new data to update.
generate_log "Procedure 7 - Step 2:  Replace temp sellout table with new data to update."
cd_interface="p007.s002"; ds_interface="Procedure 7: Process sellout data. | Step 2:  Replace temp sellout table with new data to update."; cd_start_by="bq replace"; ds_object_system="cat $ParamLocalLoadFolder/tb_his_trs_kcc001_sellout.sql"; ds_path_input="$ParamBQDataSet.$ParamBQTableDaySellout"; ds_path_output="$ParamBQDataSet.$ParamBQTableTmpSellout"
date_start_processing=`date +"%Y-%m-%d %T"`

minimo=$(bq query --use_legacy_sql=false 'SELECT DATE_TRUNC(MIN(dt_movement),MONTH) from '$ParamBQDataSet.$ParamBQTableDaySellout | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g');\
maximo=$(bq query --use_legacy_sql=false 'SELECT DATE_TRUNC(MAX(dt_movement),MONTH) from '$ParamBQDataSet.$ParamBQTableDaySellout | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g');\

echo "data minima" $minimo;\
echo "data maxima" $maximo;\

bq query -n=0 --replace --destination_table $ParamBQDataSet.$ParamBQTableTmpSellout \
--time_partitioning_field $ParamPartitioningFieldSellout \
--clustering_fields $ParamClusteringFieldSellout \
--use_legacy_sql=false "$(cat $ParamLocalUDFFolder/*.sql)" \
"$(cat $ParamLocalLoadFolder/$ParamBQTableHisSellout.sql | sed "s/data_minima/$minimo/g" | sed "s/data_maxima/$maximo/g")"
cd_exit=$?

echo "saida_temp_sellout" $cd_exit
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableTmpSellout | grep nr_load_control | cut -d"\"" -f4`; qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableTmpSellout | grep numRows | cut -d"\"" -f4`; qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableTmpSellout | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 7 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 12; exit 12
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 7 - Step 2:  Replace temp sellout table successfully."
fi



#Procedure 7 - Step 3: Transfer partition time from temp sellout table to history sellout table.
generate_log "Procedure 7 - Step 3: Transfer partition time from temp sellout table to history sellout table."
cd_interface="p007.s003"; ds_interface="Procedure 7: Process sellout data. | Step 3: Transfer partition time from temp sellout table to his sellout table."; cd_start_by="bq cp \$store"; ds_object_system="func_copia_part"; ds_path_input="$ParamBQDataSet.$ParamBQTableTmpSellout"; ds_path_output="$ParamBQDataSet.$ParamBQTableHisSellout"

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#cd_exit #variavel de saÃƒÆ’Ã‚Â­da declarada fora de func_copia_part() PARA SER USAVA NA FUNCAO DE LOG.
func_copia_part() #FUNÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O QUE ATUALIZA AS PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã¢â‚¬Â¢ES DA TABELA HISTÃƒÆ’Ã¢â‚¬Å“RICA
{
    echo -e "++++++++++++++++++++++++++++++++++\n| Transferindo partiÃƒÆ’Ã‚Â§ÃƒÆ’Ã‚Â£o $1 |\n++++++++++++++++++++++++++++++++++"
	store=$1 #STORE: PARÃƒÆ’Ã¢â‚¬Å¡METRO QUE RECEBE A PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O 
	bq cp -f "$ParamBQDataSet.$ParamBQTableTmpSellout\$$store" "$ParamBQDataSet.$ParamBQTableHisSellout\$$store" # COPIA A PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O DA TABELA DIÃƒÆ’Ã‚ÂRIA PARA A HISTÃƒÆ’Ã¢â‚¬Å“RICA. \$ ÃƒÆ’Ã¢â‚¬Â° NECESSÃƒÆ’Ã‚ÂRIO PARA TRANSFORMAR $ EM UM CARARECTE DE ESCAPE. JÃƒÆ’Ã‚Â QUE O COMANDO NO BIGQUERY UTILIZA $ COM empty_param_num DE SUA SINTAXE
}

date_start_processing=`date +"%Y-%m-%d %T"`
for store in $(bq query --max_rows=366 --use_legacy_sql=true 'SELECT partition_id FROM ['$ParamBQDataSet'.'$ParamBQTableTmpSellout'$__PARTITIONS_SUMMARY__]' | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g')  # O COMANDO ENTRE () LISTA AS PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã¢â‚¬Â¢ES PRESENTES NA TABELA DIÃƒÆ’Ã‚ÂRIA. O FOR ITERA SOBRE ESSAS PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã¢â‚¬Â¢ES
do
	if [ $store != "__NULL__" ];
		then func_copia_part "$store"; #CHAMA A FUNÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O QUE COPIA AS PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã¢â‚¬Â¢ES, RECEBENDO COMO PARAMETRO A PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O EM QUE O FOR ESTA ITERANDO.
		sleep $ParamStoreBreakRunSleep; # APLICA UM INTERVALO DE TEMPO ENTRE UMA CÃƒÆ’Ã¢â‚¬Å“PIA E OUTRA. NECESSÃƒÆ’Ã‚ÂRIO DEVIDO AO TEMPO DE CLUSTERING DAS VM DA GOOGLE.
	fi;
done
cd_exit=$?

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableHisSellout | grep nr_load_control | cut -d"\"" -f4`; qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableHisSellout | grep numRows | cut -d"\"" -f4`; qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableHisSellout | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 7 - Step 3: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 13; exit 13
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 7 - Step 3: Transfer partition time from temp sellout table to history sellout table successfully."
        generate_log "Procedure 7: Processed sellout data successfully."
fi



#--------------------------------------- TABELA DE CONTROLE DE SELLOUT -------------------------
#Procedure 7 - Step 4: Insert control infos in tb_day_sys_wdu001_received_ctrl_files.
generate_log "Procedure 7 - Step 4: Insert control infos from $ParamBQTableDaySellout in tb_day_sys_wdu001_received_ctrl_files."
cd_interface="p007.s004";
ds_interface="Procedure 7 - Step 4: Insert control infos from $ParamBQTableDaySellout in tb_day_sys_wdu001_received_ctrl_files.";
cd_start_by="bq query";
ds_object_system="$ParamLocalLoadFolder/$ParamInsertCtrlFileSellout.sql";
ds_path_input="$ParamLocalLoadFolder";
ds_path_output="$ParamLocalLoadFolder";
date_start_processing=`date +"%Y-%m-%d %T"`

#CONTROLE
qt_load_records=$(bq --headless --quiet query --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/$ParamInsertCtrlFileSellout.sql)" | cut -d ":" -f 2)


cd_exit=$?
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing;
qt_read_records=``;
#qt_load_records=``;
qt_rejected_records=``;

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 7 - Step 4: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 161; exit 161
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 7 - Step 4: Insert control infos from $ParamBQTableDaySellout successfully."
        generate_log "Procedure 7: Processed sellout data successfully."
fi

#------------------------------------------------- BACKUP DIRETO------------------------------------------------------------
#Procedure 8: Backup processed files.
generate_log "Procedure 8: Backup processed files."

#Procedure 8 - Step 1: Move processed daily files from local input folder to cloud processed folder.
generate_log "Procedure 8 - Step 1: Move processed daily files from local input folder to cloud processed folder."
cd_interface="p008.s001";
ds_interface="Procedure 8 - Step 1: Move processed daily files from local input folder to cloud processed folder."; 
cd_start_by="gsutil mv"; 
ds_object_system="Enriched Master Files"; 
ds_path_input="$ParamCloudProcessingFolder"; 
ds_path_output="$ParamCloudProcessedFolder"
date_start_processing=`date +"%Y-%m-%d %T"`

echo -e "++++++++++++++++++++++++++++++++++++\n| Movendo da source para processed |\n++++++++++++++++++++++++++++++++++++"


#------------------------------ backup cadastros enriquecidos ----------------------------------------
#zip arquivos enriquecidos e salva em processed/$Day
ls $ParamLocalInputFolder | egrep ^KCC_[A-Z\|A-Z_A_Z]+_[0-9]+_FINAL.csv | xargs zip -r cadastros_enriquecidos_$Day.zip;\

#move arquivo enriquecidos de cadastro para processed
gsutil mv cadastros_enriquecidos_$Day.zip $ParamCloudProcessedFolder/$Day/
#------------------------------------------------------------------------------------------------------

#----------------------------- backup neogrid enriquecido -----------------------------------------------------------
#zipa e arquivoa enriquecidos neogrid
ls $ParamLocalInputFolder | egrep ^FINAL_RI_KCC_[A-Z\|A-Z_A_Z]+_[0-9]+.txt | xargs zip -r sellouts_neogrid_enriquecidos_$Day.zip;\

#move arquivos enriquecidos de sellout para processed
gsutil mv $ParamLocalInputFolder/sellouts_neogrid_enriquecidos_$Day.zip $ParamCloudProcessedFolder/$Day/;\
#---------------------------------------------------------------------------------------------------------------------

#lista o que foi transferido - para teste
gsutil ls $ParamCloudProcessedFolder/$Day

#------- controle de fluxo --------------
cd_exit=$?
#cd_exit=0
#----------------------------------------


date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing;
qt_load_records=$(ls | egrep ^KCC_[A-Z\|A-Z_A_Z]+_[0-9]+_FINAL.csv | wc -l)

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 8 - Step 1: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 13; exit 13
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 8 - Step 1: Backup processed files successfully."
fi


echo -e "+++++++++++++++++++++++++++++\n| Movendo da vm para source |\n+++++++++++++++++++++++++++++"

#Procedure 8 - Step 2: Move zip file from vm to cloud source folder.
generate_log "Procedure 8 - Step 2: Move orignal master file from vm to cloud source folder."
cd_interface="p008.s002";
ds_interface="Procedure 8 - Step 2: Move orignal master file from vm to cloud source folder.";
cd_start_by="gsutil mv";
ds_object_system="Orignal Master Files"; ds_path_input="$ParamLocalInputFolder"; ds_path_output="$ParamCloudSourceFolder/$Day"
qt_load_records=$(ls | egrep ^KCC_[A-Z\|A-Z_A_Z]+_[0-9]+.TXT | wc -l)
date_start_processing=`date +"%Y-%m-%d %T"`

cd $ParamLocalInputFolder
#------------- backup de cadastros originais -----------------------------------------------------
#zip arquivos originais

ls $ParamLocalInputFolder | egrep ^KCC_[A-Z\|A-Z_A_Z]+_[0-9]+.TXT | xargs zip -r cadastros_$Day.zip;\

#move arquivo de cadastros originais para source
gsutil mv $ParamLocalInputFolder/cadastros_$Day.zip $ParamCloudSourceFolder/$Day/;\
#--------------------------------------------------------------------------------------------------


#------------- backup de neogrid originais ---------------------------------------------------------
#zipa arquivos originais neogrid e salva em source
ls $ParamLocalInputFolder | egrep ^RI_KCC_[A-Z\|A-Z_A_Z]+_[0-9]+.TXT | xargs zip -r sellouts_neogrid_$Day.zip;\

#move arquivos originais de sellout para source
gsutil mv $ParamLocalInputFolder/sellouts_neogrid_$Day.zip $ParamCloudSourceFolder/$Day/;\

#lista o que exista em source/$Day - para teste
gsutil ls $ParamCloudSourceFolder/$Day
#--------------------------------------------------------------------------------------------------


#------- controle de fluxo --------------
cd_exit=$?
#cd_exit=0
#----------------------------------------
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; qt_read_records=``; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 8 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 16; exit 16
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 8 - Step 2: Move original master files from vm to cloud source folder successfully."
        generate_log "Procedure 8: Processed files backed up successfully."
fi



#------------------------- limpeza arquivos de cadastro ---------------------------
#apaga arquivos enriquecidos de cadastro
ls $ParamLocalInputFolder | egrep ^KCC_[A-Z\|A-Z_A_Z]+_[0-9]+_FINAL.csv | xargs rm -rf;\

#apaga arquivos que foram baixados do sftp
ls $ParamLocalInputFolder | egrep ^KCC_[A-Z\|A-Z_A_Z]+_[0-9]+.TXT | xargs rm -rf;\
#-----------------------------------------------------------------------------------

#------------------------- limpeza arquivos neogrid --------------------------------
#apaga arquivos enriquecidos de sellout
ls $ParamLocalInputFolder | egrep ^FINAL_RI_KCC_[A-Z\|A-Z_A_Z]+_[0-9]+.txt | xargs rm -rf;\

#apaga arquivos zips e txt originais da neoogrid
ls $ParamLocalInputFolder | egrep ^RI_KCC_[A-Z\|A-Z_A_Z]+_[0-9]+.ZIP | xargs rm -rf;\
ls $ParamLocalInputFolder | egrep ^RI_KCC_[A-Z\|A-Z_A_Z]+_[0-9]+.TXT | xargs rm -rf;\
#-----------------------------------------------------------------------------------

#-----------------------------------------------------PHARMA WEEK----------------------------------------------------------------------------------------------
##Procedure 10 - Step 1: Clean local input folder to receive the new files to be processed.
generate_log "Procedure 10 - Step 1: Clean local input folder to receive the new files to be processed."
cd_interface="p010.s001"; ds_interface="Procedure 10: Move weekly Pharma file from FTP to GCP cloud source folder. | Step 1: Clean local input folder to receive the new files to be processed."; cd_start_by="rm"; ds_object_system=""; ds_path_input="$ParamLocalInputFolder/*$ParamFileMovementPrefixPharmaWeek*"; ds_path_output=""
date_start_processing=`date +"%Y-%m-%d %T"`
file_count=`ls $ParamLocalInputFolder/*$ParamFileMovementPrefixPharmaWeek* | wc -l`

if [ $? -ne 0 ] || [ $file_count -lt 1 ]
    then
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 10 - Step 1: Local input folder is already empty and does not need to be cleaned."
    else
        rm -f $ParamLocalInputFolder/*$ParamFileMovementPrefixPharmaWeek*
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 10 - Step 1: Filesystem error. Please check if filesystem is full or contact your administrator."
                #exit_sh 2; exit 2
            else
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 10 - Step 1: Local input folder cleaned successfully."
        fi
fi
	

#Procedure 10 - Step 2: Move weekly Pharma file from FTP to local input folder.
generate_log "Procedure 10 - Step 2: Move weekly Pharma file from FTP to local input folder."
cd_interface="p010.s003"; ds_interface="Procedure 10: Move weekly Pharma file from FTP to GCP cloud source folder. | Step 2: Move weekly Pharma file from FTP to local input folder."; cd_start_by="sftp"; ds_object_system=""; ds_path_input="$ParamFTPFilePathPharmaWeek/$ParamFileMovementPrefixPharmaWeek*.zip"; ds_path_output="$ParamLocalInputFolder/"
date_start_processing=`date +"%Y-%m-%d %T"`

#bloco original
##sshpass -p $ParamFTPPasswordPharma sftp -o "StrictHostKeyChecking no" $ParamFTPUserPharma@$ParamFTPHostPharma:$ParamFTPFilePathPharmaWeek/$ParamFileMovementPrefixPharmaWeek*.zip $ParamLocalInputFolder/
#lftp -e "set sftp:auto-confirm yes; open sftp://"$ParamFTPUserPharma":"$ParamFTPPasswordPharma"@"$ParamFTPHostPharma"; cd "$ParamFTPFilePathPharmaWeek"; mirror -p -c -i K_C_SMDTR_"$Day".zip ~/"$ParamFTPFilePathPharmaWeek" "$ParamLocalInputFolder"; bye"
#    
#cd_exit=$?

#bloco teste
penultimo_domingo=$(date --date="last Sunday - 1 week" '+%Y%m%d');\
data_arquivo_day=$(bq query -q --use_legacy_sql=false "SELECT distinct SUBSTR(SPLIT(nm_file,'.')[OFFSET(0)],-08,8) FROM $ParamBQDataSet.$ParamBQTableDayPharmaWeek" | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g');\



if [ $penultimo_domingo -gt $data_arquivo_day ]
    then
        echo "Verificando chegada do arquivo..."
        lftp -e "set sftp:auto-confirm yes; open sftp://"$ParamFTPUserPharma":"$ParamFTPPasswordPharma"@"$ParamFTPHostPharma"; cd "$ParamFTPFilePathPharmaWeek"; mirror -p -c -i K_C_SMDTR_"$penultimo_domingo".zip ~/"$ParamFTPFilePathPharmaWeek" "$ParamLocalInputFolder"; bye"
        cd_exit=$?
    else
        echo "ultimo arquivo jÃƒÆ’Ã‚Â¡ carregado."
        cd_exit=1
fi

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 10 - Step 2: GCP error. Please check if weekly Pharma file is available or contact your administrator."
		#exit_sh 3; exit 3
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 10 - Step 2: Weekly Pharma file was successfully moved to local input folder."
fi
	

#Procedure 10 - Step 3: Unzip weekly Pharma file.
generate_log "Procedure 10 - Step 3: Unzip weekly Pharma file."
cd_interface="p010.s003"; ds_interface="Procedure 10: Move weekly Pharma file from FTP to GCP cloud source folder. | Step 3: Unzip weekly Pharma file."; cd_start_by="unzip"; ds_object_system=""; ds_path_input="$ParamLocalInputFolder/$ParamFileMovementPrefixPharmaWeek*.zip"; ds_path_output="$ParamLocalInputFolder/$ParamFileMovementPrefixPharmaWeek*.TXT"
date_start_processing=`date +"%Y-%m-%d %T"`

    cd $ParamLocalInputFolder/;
    unzip -u -o ./$ParamFileMovementPrefixPharmaWeek*.zip

cd_exit=$?
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``

if [ $cd_exit -ne 0 ]
    then
        #limpa processing para day e his nÃƒÆ’Ã‚Â£o ser processada novamente sem novos arquivos e manter day
        gsutil -q -m rm $ParamCloudProcessingFolder/*$ParamFileMovementPrefixPharmaWeek*
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 10 - Step 3: GCP error. Please check if GCP is available or contact your administrator."
        #exit_sh 4; exit 4
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 10 - Step 3: Weekly Pharma file was unziped successfully."

        #Procedure 10 - Step 4: Enrich weekly Pharma file with source file name and record line number.
        generate_log "Procedure 10 - Step 4: Enrich weekly Pharma file with source file name and record line number."
        cd_interface="p010.s004"; ds_interface="Procedure 10: Move weekly Pharma file from FTP to GCP cloud source folder. | Step 4: Enrich weekly Pharma file with source file name and record line number."; cd_start_by="sed"; ds_object_system=""; ds_path_input="$ParamLocalInputFolder/$ParamFileMovementPrefixPharmaPharma*"; ds_path_output="$ParamLocalInputFolder/FINAL_'$ParamFileMovementPrefixPharmaPharma'_*.csv"
        date_start_processing=`date +"%Y-%m-%d %T"`
        
            arquivo=$(find . | grep $ParamFileMovementPrefixPharmaWeek*.TXT | cut -c3-)
            tail -n +2 $arquivo | sed 's/^/'$arquivo'|/' | nl -s"|" > FINAL_$arquivo
            
            #rm $ParamLocalInputFolder/$ParamFileMovementPrefixPharmaWeek*.TXT
        
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 10 - Step 4: GCP error. Please check if GCP is available or contact your administrator."
                #exit_sh 5; exit 5
            else
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 10 - Step 4: Weekly Pharma file was enriched with source file name and record line number successfully."
        fi
                
        
        #Procedure 10 - Step 5: Copy weekly Pharma files from local temp folder to cloud source folder.
        generate_log "Procedure 10 - Step 5: Copy weekly Pharma files from local temp folder to cloud source folder."
        cd_interface="p010.s005"; ds_interface="Procedure 10: Copy weekly Pharma files from FTP to GCP cloud source folder. |Step 5: Copy weekly Pharma files from local temp folder to cloud source folder."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalInputFolder/$ParamFileMovementPrefixPharmaWeek*"; ds_path_output="$ParamCloudSourceFolder/"
        date_start_processing=`date +"%Y-%m-%d %T"`
                
            gsutil -q -m cp $ParamLocalInputFolder/$ParamFileMovementPrefixPharmaWeek*.zip $ParamCloudSourceFolder/$Day/
        
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 10 - Step 5: GCP error. Please check if GCP is available or contact your administrator."
                #exit_sh 6; exit 6
            else
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 10 - Step 5: Weekly Pharma files were successfully copied to cloud source folder."  
        fi
            
        
        #Procedure 10 - Step 6: Remove original files from local input folder.
        generate_log "Procedure 10 - Step 6: Remove original files from local input folder."
        cd_interface="p010.s006"; ds_interface="Procedure 10: Move weekly Pharma file from FTP to GCP cloud source folder. | Step 6: Remove original files from local input folder."; cd_start_by="rm"; ds_object_system=""; ds_path_input="$ParamLocalInputFolder/$ParamFileMovementPrefixPharmaWeek*"; ds_path_output=""
        date_start_processing=`date +"%Y-%m-%d %T"`
        
            rm $ParamLocalInputFolder/$ParamFileMovementPrefixPharmaWeek*
        
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 10 - Step 6: GCP error. Please check if GCP is available or contact your administrator."
                #exit_sh 7; exit 7
            else
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 10 - Step 6: Original files removed from local input folder successfully."
        fi
                
        
        #Procedure 11: Collect weekly Pharma file to be processed.
        generate_log "Procedure 11: Collect weekly Pharma file to be processed."
        
        #Procedure 11 - Step 1: Clean GCS processing folder to receive the new file to be processed.
        generate_log "Procedure 11 - Step 1: Clean GCS processing folder to receive the new file to be processed."
        cd_interface="p011.s001"; ds_interface="Procedure 11: Collect weekly Pharma file to be processed. | Step 1: Clean GCS processing folder to receive the new file to be processed."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamCloudProcessingFolder/$ParamFileMovementPrefixPharma_*.csv"; ds_path_output=""
        
            date_start_processing=`date +"%Y-%m-%d %T"`
            file_count=`gsutil -q -m ls $ParamCloudProcessingFolder/*$ParamFileMovementPrefixPharmaWeek* | wc -l`
        
        if [ $? -ne 0 ] || [ $file_count -lt 1 ]
            then
                date_end_processing=`date +"%Y-%m-%d %T"`
                nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 11 - Step 1: Cloud processing folder is already empty and does not need to be cleaned."
            else
            gsutil -q -m rm $ParamCloudProcessingFolder/*$ParamFileMovementPrefixPharmaWeek*
            cd_exit=$?
            date_end_processing=`date +"%Y-%m-%d %T"`
            nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
            if [ $cd_exit -ne 0 ]
                    then
                        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                        generate_log "Procedure 11 - Step 1: Filesystem error. Please check if filesystem is full or contact your administrator."
                        #exit_sh 8; exit 8
                    else
                        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                        generate_log "Procedure 11 - Step 1: GCS processing folder cleaned successfully."
            fi
        fi
            
        #Procedure 11 - Step 2: Move weekly Pharma file from cloud source folder to cloud processing folder to be processed.
        generate_log "Procedure 11 - Step 2: Move weekly Pharma file from cloud source folder to cloud processing folder to be processed."
        cd_interface="p011.s002"; ds_interface="Procedure 11: Collect weekly Pharma file to be processed. | Step 2: Move weekly Pharma file from cloud source folder to cloud processing folder to be processed."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamCloudSourceFolder/*$ParamFileMovementPrefixPharmaWeek*.TXT"; ds_path_output="$ParamCloudProcessingFolder/"
        date_start_processing=`date +"%Y-%m-%d %T"`
        
            gsutil -q -m cp $ParamLocalInputFolder/FINAL_$ParamFileMovementPrefixPharmaWeek* $ParamCloudProcessingFolder/
        
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 11 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
                #exit_sh 9; exit 9
            else
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 11 - Step 2: Weekly Pharma file was successfully moved to cloud processing folder."
        fi
                
        
        generate_log "Procedure 11: Weekly Pharma file was successfully collected to be processed."
fi

#Procedure 12: Process weekly Pharma data.
generate_log "Procedure 12: Process weekly Pharma data."

#Procedure 12 - Step 1: Replace daily Pharma table with the weekly Pharma contents.
generate_log "Procedure 12 - Step 1: Replace daily Pharma table with the weekly Pharma contents."
cd_interface="p012.s001"; ds_interface="Procedure 12: Process weekly Pharma data. | Step 1: Replace daily Pharma table with the weekly Pharma contents."; cd_start_by="bq"; ds_object_system="$ParamLocalLoadFolder/$ParamBQTableDayPharmaWeek.sql"; ds_path_input="$ParamBQDataSet.$ParamBQTableExtPharmaWeek"; ds_path_output="$ParamBQDataSet.$ParamBQTableDayPharmaWeek"
	
    qt_records=`bq query --nouse_legacy_sql --format=prettyjson "select count(*) from $ParamBQDataSet.$ParamBQTableExtPharmaWeek" | grep f0_ | cut -d"\"" -f4`
    echo $qt_records "Registros na tabela $ParamBQDataSet.$ParamBQTableExtPharmaWeek"

if [ $qt_records -ne 0 ]
    then
        date_start_processing=`date +"%Y-%m-%d %T"`
        bq --headless --quiet query -n=0 --replace --destination_table $ParamBQDataSet.$ParamBQTableDayPharmaWeek --time_partitioning_field $ParamPartitioningFieldPharmaWeek --use_legacy_sql=false "$(cat $ParamLocalUDFFolder/*.sql)" "$(cat $ParamLocalLoadFolder/$ParamBQTableDayPharmaWeek.sql)"			
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharmaWeek | grep nr_load_control | cut -d"\"" -f4`; qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharmaWeek | grep numRows | cut -d"\"" -f4`; qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharmaWeek | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``
        qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharmaWeek | grep numRows | cut -d"\"" -f4`; 
        qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharmaWeek | grep numRows | cut -d"\"" -f4`; 
        qt_rejected_records=``


        #Procedure 12 - Step 2: Merge daily Pharma table with history Pharma table.
        generate_log "Procedure 12 - Step 2: Merge daily Pharma table with history Pharma table."
        cd_interface="p012.s002"; ds_interface="Procedure 12: Process weekly Pharma data. | Step 2: Merge daily Pharma table with history Pharma table."; cd_start_by="bq"; ds_object_system="cat $ParamLocalLoadFolder/$ParamBQTableHisPharmaWeek.sql"; ds_path_input="$ParamBQDataSet.$ParamBQTableDayPharmaWeek"; ds_path_output="$ParamBQDataSet.$ParamBQTableHisPharmaWeek"
        date_start_processing=`date +"%Y-%m-%d %T"`
        
        FUNC_COPIA_PART(){ #FUNÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O QUE ATUALIZA AS PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã¢â‚¬Â¢ES DA TABELA HISTÃƒÆ’Ã¢â‚¬Å“RICA
            #echo -e "\nTransferindo partiÃƒÆ’Ã‚Â§ÃƒÆ’Ã‚Â£o: "$1 "\n"
            echo -e "++++++++++++++++++++++++++++++++++\n| Transferindo partiÃƒÆ’Ã‚Â§ÃƒÆ’Ã‚Â£o $1 |\n++++++++++++++++++++++++++++++++++"
            store=$1 #STORE: PARÃƒÆ’Ã¢â‚¬Å¡METRO QUE RECEBE A PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O 
            bq cp -f "$ParamBQDataSet.$ParamBQTableDayPharmaWeek\$$store" "$ParamBQDataSet.$ParamBQTableHisPharmaWeek\$$store" # COPIA A PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O DA TABELA DIÃƒÆ’Ã‚ÂRIA PARA A HISTÃƒÆ’Ã¢â‚¬Å“RICA. \$ ÃƒÆ’Ã¢â‚¬Â° NECESSÃƒÆ’Ã‚ÂRIO PARA TRANSFORMAR $
            cd_exit=$?
        }
        
        for store in $(bq query --use_legacy_sql=true 'SELECT partition_id FROM ['kcc'.'$ParamBQTableDayPharmaWeek'$__PARTITIONS_SUMMARY__]' | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g')  # O $
        do
            if [ $store != "__NULL__" ];
                then FUNC_COPIA_PART "$store"; #CHAMA A FUNÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O QUE COPIA AS PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã¢â‚¬Â¢ES, RECEBENDO COMO PARAMETRO A PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O EM QUE O FOR ESTA ITERANDO.
                sleep $ParamStoreBreakRunSleep; # APLICA UM INTERVALO DE TEMPO ENTRE UMA CÃƒÆ’Ã¢â‚¬Å“PIA E OUTRA. NECESSÃƒÆ’Ã‚ÂRIO DEVIDO AO TEMPO DE CLUSTERING DAS VM DA GOOGLE.
            fi;
        done
        
        
        
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharmaWeek | grep nr_load_control | cut -d"\"" -f4`; qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharmaWeek | grep numRows | cut -d"\"" -f4`; qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharmaWeek | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``
        
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 12 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
                #exit_sh 11; exit 11
            else
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 12 - Step 2: Daily Pharma table and history Pharma table merged successfully."
                generate_log "Procedure 12: Processed Pharma data successfully."
        fi
        
        
        #Procedure 13: Move weekly enriched Pharma file to cloud processed folder.
        generate_log "Procedure 13: Move weekly enriched Pharma file to cloud processed folder."
        
        #Procedure 13 - Step 1: Compress consolidated JSONL file.
        generate_log "Procedure 13 - Step 1: Compress consolidated JSONL file."
        cd_interface="p013.s009"; ds_interface="Procedure 13: Run Cross Reference Robot API by retail customer. | Step 1: Compress consolidated JSONL file."; cd_start_by="zip"; ds_object_system=""; ds_path_input="$ParamLocalInputFolder/FINAL_$ParamFileMovementPrefixPharmaWeek*.TXT"; ds_path_output="$ParamLocalInputFolder/FINAL_$ParamFileMovementPrefixPharmaWeek*.zip"
        date_start_processing=`date +"%Y-%m-%d %T"`
        
            cd $ParamLocalInputFolder/ ;\
            arquivo=$( ls | grep FINAL_$ParamFileMovementPrefixPharmaWeek* | cut -d"." -f1);\
            zip $ParamLocalInputFolder/$arquivo.zip FINAL_$ParamFileMovementPrefixPharmaWeek*;\
        
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 13 - Step 1: Filesystem error. Please check if filesystem is full or contact your administrator."; 
                #exit_sh 12; exit 12
            else
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 13 - Step 1: File converted successfully."     
        fi
                
        
        #Procedure 13 - Step 2: Move compressed weekly Pharma file to cloud processed folder.
        generate_log "Procedure 13 - Step 2: Move compressed weekly Pharma file to cloud processed folder."
        cd_interface="p013.s002"; ds_interface="Procedure 13: Move weekly enriched Pharma file to cloud processed folder. | Step 2: Move compressed weekly Pharma file to cloud processed folder."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalInputFolder/*$ParamFileMovementPrefixPharmaWeek*.zip"; ds_path_output="$ParamCloudProcessedFolder/$Day/"
        date_start_processing=`date +"%Y-%m-%d %T"`
            
            gsutil -m mv $ParamLocalInputFolder/FINAL_$ParamFileMovementPrefixPharmaWeek*.zip $ParamCloudProcessedFolder/$Day/
            
            #deleta o arquivo enriquecido deixado localmente
            rm -f $ParamLocalInputFolder/FINAL_$ParamFileMovementPrefixPharmaWeek*
        
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 13 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
                exit_sh 13; exit 13
        fi
        
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 13 - Step 2: Processed weekly Pharma file were moved to cloud processed folder successfully."
        
        generate_log "Procedure 13: Weekly Pharma file were moved to cloud processed folder successfully."
        
        #-----------------------------------------------------TABELA DE CONTROLE DE PHARMA WEEK--------------------------------------------------------------------------------------
        #Procedure 14: Insert control infos of weekly Pharma file in tb_day_sys_wdu001_received_ctrl_files.
        generate_log "Procedure 14: Move weekly enriched Pharma file to cloud processed folder."
            
        #Procedure 14 - Step 1: Insert control infos from $ParamBQTableDayPharmaWeek in tb_day_sys_wdu001_received_ctrl_files.
        generate_log "Procedure 14 - Step 1: Insert control infos from $ParamBQTableDayPharmaWeek in tb_day_sys_wdu001_received_ctrl_files."
        cd_interface="p014.s001";
        ds_interface="Procedure 14 - Step 1: Insert control infos from $ParamBQTableDayPharmaWeek in tb_day_sys_wdu001_received_ctrl_files.";
        cd_start_by="bq query";
        ds_object_system="$ParamLocalLoadFolder/$ParamInsertCtrlFilePharmaWeek.sql";
        ds_path_input="$ParamLocalLoadFolder";
        ds_path_output="$ParamLocalLoadFolder";
        date_start_processing=`date +"%Y-%m-%d %T"`
        
        #CONTROLE
            qt_load_records=$(bq --headless --quiet query --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/$ParamInsertCtrlFilePharmaWeek.sql)" | cut -d ":" -f 2)
        
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=$date_end_processing;
        qt_read_records=``;
        qt_rejected_records=``;
        
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 14 - Step 1: GCP error. Please check if GCP is available or contact your administrator."
                #exit_sh 161; exit 161
            else
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 14 - Step 1: Control infos from $ParamBQTableDayPharmaWeek inserted successfully."
                generate_log "Procedure 14: Control infos of weekly Pharma file inserted in tb_day_sys_wdu001_received_ctrl_files successfully."
        fi

    else
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 12 - Step 1: GCP error. Please check if GCP is available or contact your administrator."
                #exit_sh 10; exit 10
            else
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 12 - Step 1: Daily Pharma table replaced successfully."
        fi
fi

#-----------------------------------------------------PHARMA MENSAL----------------------------------------------------------------------------------------------
#Procedure 15 - Step 1: Clean local input folder to receive the new files to be processed.
generate_log "Procedure 15 - Step 1: Clean local input folder to receive the new files to be processed."
cd_interface="p015.s001"; ds_interface="Procedure 15: Move monthly Pharma file from FTP to GCP cloud source folder. | Step 1: Clean local input folder to receive the new files to be processed."; cd_start_by="rm"; ds_object_system=""; ds_path_input="$ParamLocalInputFolder/*$ParamFileMovementPrefixPharma*"; ds_path_output=""
date_start_processing=`date +"%Y-%m-%d %T"`

    file_count=`ls $ParamLocalInputFolder/*$ParamFileMovementPrefixPharma* | wc -l`

if [ $? -ne 0 ] || [ $file_count -lt 1 ]
    then
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 15 - Step 1: Local input folder is already empty and does not need to be cleaned."
    else
        rm -f $ParamLocalInputFolder/*$ParamFileMovementPrefixPharma*
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 15 - Step 1: Filesystem error. Please check if filesystem is full or contact your administrator."
                #exit_sh 2; exit 2
            else
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 15 - Step 1: Local input folder cleaned successfully."
        fi
fi


#Procedure 15 - Step 2: Move monthly Pharma file from FTP to local input folder.
generate_log "Procedure 15 - Step 2: Move monthly Pharma file from FTP to local input folder."
cd_interface="p015.s002"; ds_interface="Procedure 15: Move monthly Pharma file from FTP to GCP cloud source folder. | Step 2: Move monthly Pharma file from FTP to local input folder."; cd_start_by="sftp"; ds_object_system=""; ds_path_input="$ParamFTPFilePathPharma/$ParamFileMovementPrefixPharma*.zip"; ds_path_output="$ParamLocalInputFolder/"
date_start_processing=`date +"%Y-%m-%d %T"`

#bloco antigo
##sshpass -p $ParamFTPPasswordPharma sftp -o "StrictHostKeyChecking no" $ParamFTPUserPharma@$ParamFTPHostPharma:$ParamFTPFilePathPharma/$ParamFileMovementPrefixPharma*.zip $ParamLocalInputFolder/
#pharma_month=$(date --date=$Day '+%Y%m')
#lftp -e "open sftp://"$ParamFTPUserPharma":"$ParamFTPPasswordPharma"@"$ParamFTPHostPharma"; cd "$ParamFTPFilePathPharma"; mirror -p -c -i K_C_MDTR_"$pharma_month".zip ~/"$ParamFTPFilePathPharma" "$ParamLocalInputFolder"; bye"
#cd_exit=$?

#novo bloco - teste
ultimo_mes=$(date --date="1 month ago" '+%Y%m');\
mes_arquivo_day=$(bq query -q --use_legacy_sql=false "SELECT distinct SUBSTR(SPLIT(nm_file,'.')[OFFSET(0)],-06,6) FROM $ParamBQDataSet.$ParamBQTableDayPharma" | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g');\

if [ $ultimo_mes -gt $mes_arquivo_day ]
    then
        echo "Verificando chegada do arquivo..."
        lftp -e "open sftp://"$ParamFTPUserPharma":"$ParamFTPPasswordPharma"@"$ParamFTPHostPharma"; cd "$ParamFTPFilePathPharma"; mirror -p -c -i K_C_MDTR_"$ultimo_mes".zip ~/"$ParamFTPFilePathPharma" "$ParamLocalInputFolder"; bye"
        cd_exit=$?
    else
        echo "ultimo arquivo jÃƒÆ’Ã‚Â¡ carregado."
        cd_exit=1
fi

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``

if [ $cd_exit -ne 0 ]
    then
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 15 - Step 2: GCP error. Please check if monthly Pharma file is available or contact your administrator."
        #exit_sh 3; exit 3
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 15 - Step 2: Monthly Pharma file was successfully moved to local input folder."
fi

 #Procedure 15 - Step 3: Unzip monthly Pharma file.
 generate_log "Procedure 15 - Step 3: Unzip monthly Pharma file."
 cd_interface="p015.s003"; ds_interface="Procedure 15: Move monthly Pharma file from FTP to GCP cloud source folder. | Step 3: Unzip monthly Pharma file."; cd_start_by="unzip"; ds_object_system=""; ds_path_input="$ParamLocalInputFolder/$ParamFileMovementPrefixPharma*.zip"; ds_path_output="$ParamLocalInputFolder/$ParamFileMovementPrefixPharma*.TXT"
 date_start_processing=`date +"%Y-%m-%d %T"`
     
     echo -e "unzip"
     cd $ParamLocalInputFolder/
     unzip -u -o $ParamFileMovementPrefixPharma*.zip
 
     
 cd_exit=$?
 date_end_processing=`date +"%Y-%m-%d %T"`
 nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
 if [ $cd_exit -ne 0 ]
     then
         gsutil mv $ParamCloudProcessingFolder/FINAL_$ParamFileMovementPrefixPharma* $ParamCloudProcessedFolder/$Day/
         generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
         generate_log "Procedure 15 - Step 3: GCP error. Please check if GCP is available or contact your administrator."
         #exit_sh 4; exit 4
     else
         generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
         generate_log "Procedure 15 - Step 3: Monthly Pharma file was unziped successfully."
 
         #Procedure 15 - Step 4: Copy monthly Pharma files from local temp folder to cloud source folder.
         generate_log "Procedure 15 - Step 4: Copy monthly Pharma files from local temp folder to cloud source folder."
         cd_interface="p015.s004"; ds_interface="Procedure 15: Copy monthly Pharma files from FTP to GCP cloud source folder. |Step 4: Copy monthly Pharma files from local temp folder to cloud source folder."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalInputFolder/$ParamFileMovementPrefixPharma*"; ds_path_output="$ParamCloudSourceFolder/"
         date_start_processing=`date +"%Y-%m-%d %T"`
             
             echo -e "MOVENDO ZIP E TXT  PARA SOURCE"
             gsutil mv $ParamLocalInputFolder/*$ParamFileMovementPrefixPharma* $ParamCloudSourceFolder/$Day/
         
         cd_exit=$?
         date_end_processing=`date +"%Y-%m-%d %T"`
         nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
         
         if [ $cd_exit -ne 0 ]
             then
                 generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                 generate_log "Procedure 15 - Step 4: GCP error. Please check if GCP is available or contact your administrator."
                 #exit_sh 6; exit 6
             else
                 generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                 generate_log "Procedure 15 - Step 4: Monthly Pharma files were successfully copied to cloud source folder."
         fi
         
         
         #Procedure 15 - Step 5: Enrich monthly Pharma file with source file name and record line number.
         generate_log "Procedure 15 - Step 5: Enrich monthly Pharma file with source file name and record line number."
         cd_interface="p015.s005"; ds_interface="Procedure 15: Move monthly Pharma file from FTP to GCP cloud source folder. | Step 5: Enrich monthly Pharma file with source file name and record line number."; cd_start_by="sed"; ds_object_system=""; ds_path_input="$ParamCloudSourceFolder/$Day/"; ds_path_output="$ParamLocalInputFolder/FINAL_$ParamFileMovementPrefixPharmaPharma"
         date_start_processing=`date +"%Y-%m-%d %T"`
             
             echo -e "ENRIQUECIMENTO"
             arquivo=$(gsutil ls $ParamCloudSourceFolder/$Day/ | egrep $ParamFileMovementPrefixPharma.*.TXT | rev | cut -d '/' -f 1| rev);\
             gsutil cat $ParamCloudSourceFolder/$Day/$arquivo* | sed 's/^/'$arquivo'|/' | nl -s"|" > FINAL_$arquivo
             
             gsutil rm -f $ParamCloudSourceFolder/$Day/$ParamFileMovementPrefixPharma*.TXT
             
         cd_exit=$?
         date_end_processing=`date +"%Y-%m-%d %T"`
         nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
         if [ $cd_exit -ne 0 ]
             then
                 generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                 generate_log "Procedure 15 - Step 5: GCP error. Please check if GCP is available or contact your administrator."
                 #exit_sh 5; exit 5
             else
                 generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                 generate_log "Procedure 15 - Step 5: Monthly Pharma file was enriched with source file name and record line number successfully."
         fi
         
         #Procedure 16: Collect monthly Pharma file to be processed.
         generate_log "Procedure 16: Collect monthly Pharma file to be processed."
         
         #Procedure 16 - Step 1: Clean GCS processing folder to receive the new file to be processed.
         generate_log "Procedure 16 - Step 1: Clean GCS processing folder to receive the new file to be processed."
         cd_interface="p016.s001"; ds_interface="Procedure 16: Collect monthly Pharma file to be processed. | Step 1: Clean GCS processing folder to receive the new file to be processed."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamCloudProcessingFolder/$ParamFileMovementPrefixPharma_*.csv"; ds_path_output=""
         date_start_processing=`date +"%Y-%m-%d %T"`
         
             file_count=`gsutil -q -m ls $ParamCloudProcessingFolder/*$ParamFileMovementPrefixPharma* | wc -l`
             
         if [ $? -ne 0 ] || [ $file_count -lt 1 ]
             then
                 date_end_processing=`date +"%Y-%m-%d %T"`
                 nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
                 generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                 generate_log "Procedure 16 - Step 1: Cloud processing folder is already empty and does not need to be cleaned."
             else
                 gsutil -m rm $ParamCloudProcessingFolder/*$ParamFileMovementPrefixPharma*
                 cd_exit=$?
                 date_end_processing=`date +"%Y-%m-%d %T"`
                 nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
             if [ $cd_exit -ne 0 ]
                 then
                     generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                     generate_log "Procedure 16 - Step 1: Filesystem error. Please check if filesystem is full or contact your administrator."
                     #exit_sh 8; exit 8
                 else
                     generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                     generate_log "Procedure 16 - Step 1: GCS processing folder cleaned successfully."   
             fi
         fi
         
         
         ##Procedure 17: Move monthly enriched Pharma file to cloud processed folder.
         #generate_log "Procedure 17: Move monthly enriched Pharma file to cloud processed folder."
         #
         ##Procedure 17 - Step 1: Compress consolidated JSONL file.
         #generate_log "Procedure 17 - Step 1: Compress consolidated JSONL file."
         #cd_interface="p017.s001"; ds_interface="Procedure 17: Run Cross Reference Robot API by retail customer. | Step 1: Compress consolidated JSONL file."; cd_start_by="zip"; ds_object_system=""; ds_path_input="$ParamLocalInputFolder/"; ds_path_output="$ParamLocalInputFolder/FINAL_$ParamFileMovementPrefixPharma*.zip"
         #date_start_processing=`date +"%Y-%m-%d %T"`
         #
         #    cd $ParamLocalInputFolder/
         #    arquivo=$( ls | grep FINAL_$ParamFileMovementPrefixPharma* | cut -d"." -f1)
         #    zip $ParamLocalInputFolder/$arquivo.zip FINAL_$ParamFileMovementPrefixPharma*
         #
         #cd_exit=$?
         #date_end_processing=`date +"%Y-%m-%d %T"`
         #nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
         #
         #if [ $cd_exit -ne 0 ]
         #    then
         #        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
         #        generate_log "Procedure 17 - Step 1: Filesystem error. Please check if filesystem is full or contact your administrator."; 
         #        #exit_sh 12; exit 12
         #    else
         #        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
         #        generate_log "Procedure 17 - Step 1: File converted successfully."
         #fi
         
         
         ##Procedure 17 - Step 2: Move compressed monthly Pharma to cloud processed folder.
         #generate_log "Procedure 17 - Step 2: Move compressed monthly Pharma to cloud processed folder."
         #cd_interface="p017.s002"; ds_interface="Procedure 17: Move monthly enriched Pharma file to cloud processed folder. | Step 2: Move compressed monthly Pharma to cloud processed folder."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalInputFolder/*$ParamFileMovementPrefixPharma*.zip"; ds_path_output="$ParamCloudProcessedFolder/$Day/"
         #date_start_processing=`date +"%Y-%m-%d %T"`
         #    
         #    echo -e "MOVENDO ZIP ENRIQUECIDO PARA PROCESSED"
         #    gsutil -m mv $ParamLocalInputFolder/FINAL_$ParamFileMovementPrefixPharma*.zip $ParamCloudProcessedFolder/$Day/
         #
         #cd_exit=$?
         #date_end_processing=`date +"%Y-%m-%d %T"`
         #nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
         #
         #if [ $cd_exit -ne 0 ]
         #    then
         #        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
         #        generate_log "Procedure 17 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
         #        #exit_sh 13; exit 13
         #    else
         #        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
         #        generate_log "Procedure 17 - Step 2: Processed monthly Pharma file were moved to cloud processed folder successfully."
         #        generate_log "Procedure 17: Monthly Pharma file were moved to cloud processed folder successfully."
         #fi
         
         
         #Procedure 17 - Step 3: Move monthly Pharma file from cloud source folder to cloud processing folder to be processed.
         generate_log "Procedure 17 - Step 3: Move monthly Pharma file from cloud source folder to cloud processing folder to be processed."
         cd_interface="p017.s003"; ds_interface="Procedure 17: Collect monthly Pharma file to be processed. | Step 3: Move monthly Pharma file from cloud source folder to cloud processing folder to be processed."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamCloudSourceFolder/"; ds_path_output="$ParamCloudProcessingFolder/"
         date_start_processing=`date +"%Y-%m-%d %T"`
             
             cd $ParamLocalInputFolder
             echo -e "MOVENDO ARQUIVO ENRIQUECIDO PARA PROCESSING"
             gsutil mv $ParamLocalInputFolder/FINAL_$ParamFileMovementPrefixPharma* $ParamCloudProcessingFolder/
         
         cd_exit=$?
         date_end_processing=`date +"%Y-%m-%d %T"`
         nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
         
         if [ $cd_exit -ne 0 ]
             then
                 generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                 generate_log "Procedure 17 - Step 3: GCP error. Please check if GCP is available or contact your administrator."
                 #exit_sh 9; exit 9
             else
                 generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                 generate_log "Procedure 17 - Step 3: Monthly Pharma file was successfully moved to cloud processing folder."
                 generate_log "Procedure 17: Monthly Pharma file was successfully collected to be processed."
         fi
fi

#Procedure 18: Process monthly Pharma data.
generate_log "Procedure 18: Process monthly Pharma data."

#Procedure 18 - Step 1: Replace daily Pharma table with the monthly Pharma contents.
generate_log "Procedure 18 - Step 1: Replace daily Pharma table with the monthly Pharma contents."
cd_interface="p018.s001"; ds_interface="Procedure 18: Process monthly Pharma data. | Step 1: Replace daily Pharma table with the monthly Pharma contents."; cd_start_by="bq"; ds_object_system="$ParamLocalLoadFolder/$ParamBQTableDayPharma.sql"; ds_path_input="$ParamBQDataSet.$ParamBQTableExtPharma"; ds_path_output="$ParamBQDataSet.$ParamBQTableDayPharma"

    qt_records=`bq query --nouse_legacy_sql --format=prettyjson "select count(*) from $ParamBQDataSet.$ParamBQTableExtPharma" | grep f0_ | cut -d"\"" -f4`
    echo $qt_records "Registros na tabela $ParamBQDataSet.$ParamBQTableExtPharma"

if [ $qt_records -ne 0 ]
    then
        date_start_processing=`date +"%Y-%m-%d %T"`
            bq --headless query -n=0 --replace --destination_table $ParamBQDataSet.$ParamBQTableDayPharma --time_partitioning_field $ParamPartitioningFieldPharma --use_legacy_sql=false "$(cat $ParamLocalUDFFolder/*.sql)" "$(cat $ParamLocalLoadFolder/$ParamBQTableDayPharma.sql)"			
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharma | grep nr_load_control | cut -d"\"" -f4`; qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharma | grep numRows | cut -d"\"" -f4`; qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharma | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``
        qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharma | grep numRows | cut -d"\"" -f4`; 
        qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharma | grep numRows | cut -d"\"" -f4`; 
        qt_rejected_records=``
    
    
        #Procedure 18 - Step 2: Merge daily Pharma table with history Pharma table.
        generate_log "Procedure 18 - Step 2: Merge daily Pharma table with history Pharma table."
        cd_interface="p018.s002"; ds_interface="Procedure 18: Process monthly Pharma data. | Step 2: Merge daily Pharma table with history Pharma table."; cd_start_by="bq"; ds_object_system="cat $ParamLocalLoadFolder/$ParamBQTableHisPharma.sql"; ds_path_input="$ParamBQDataSet.$ParamBQTableDayPharma"; ds_path_output="$ParamBQDataSet.$ParamBQTableHisPharma"
        date_start_processing=`date +"%Y-%m-%d %T"`
        
        FUNC_COPIA_PART(){ #FUNÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O QUE ATUALIZA AS PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã¢â‚¬Â¢ES DA TABELA HISTÃƒÆ’Ã¢â‚¬Å“RICA
            #echo -e "\nTransferindo partiÃƒÆ’Ã‚Â§ÃƒÆ’Ã‚Â£o: "$1 "\n"
            echo -e "++++++++++++++++++++++++++++++++++\n| Transferindo partiÃƒÆ’Ã‚Â§ÃƒÆ’Ã‚Â£o $1 |\n++++++++++++++++++++++++++++++++++"
                store=$1 #STORE: PARÃƒÆ’Ã¢â‚¬Å¡METRO QUE RECEBE A PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O 
                bq cp -f "$ParamBQDataSet.$ParamBQTableDayPharma\$$store" "$ParamBQDataSet.$ParamBQTableHisPharma\$$store" # COPIA A PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O DA TABELA DIÃƒÆ’Ã‚ÂRIA PARA A HISTÃƒÆ’Ã¢â‚¬Å“RICA. \$ ÃƒÆ’Ã¢â‚¬Â° NECESSÃƒÆ’Ã‚ÂRIO PARA TRANSFORMAR $
                cd_exit=$?
        }
        
        for store in $(bq query --use_legacy_sql=true 'SELECT partition_id FROM ['kcc'.'$ParamBQTableDayPharma'$__PARTITIONS_SUMMARY__]' | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g')  # O $
        do
            FUNC_COPIA_PART "$store" #CHAMA A FUNÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O QUE COPIA AS PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã¢â‚¬Â¢ES, RECEBENDO COMO PARAMETRO A PARTIÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O EM QUE O FOR ESTA ITERANDO.
            sleep 5 # APLICA UM INTERVALO DE TEMPO ENTRE UMA CÃƒÆ’Ã¢â‚¬Å“PIA E OUTRA. NECESSÃƒÆ’Ã‚ÂRIO DEVIDO AO TEMPO DE CLUSTERING DAS VM DA GOOGLE.
        done
        
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharma | grep nr_load_control | cut -d"\"" -f4`; qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharma | grep numRows | cut -d"\"" -f4`; qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayPharma | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``
        
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 18 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
                #exit_sh 11; exit 11
            else
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 18 - Step 2: Daily Pharma table and history Pharma table merged successfully."
                generate_log "Procedure 18: Processed Pharma data successfully."
        fi
        
        
        #-----------------------------------------------------TABELA DE CONTROLE DE PHARMA--------------------------------------------------------------------------------------
        #Procedure 19: Insert control infos of monthly Pharma file in tb_day_sys_wdu001_received_ctrl_files.
        generate_log "Procedure 19: Move monthly enriched Pharma file to cloud processed folder."
        
        #Procedure 19 - Step 1: Insert control infos from $ParamBQTableDayPharma in tb_day_sys_wdu001_received_ctrl_files.
        generate_log "Procedure 19 - Step 1: Insert control infos from $ParamBQTableDayPharma in tb_day_sys_wdu001_received_ctrl_files."
        cd_interface="p019.s001";
        ds_interface="Procedure 19 - Step 1: Insert control infos from $ParamBQTableDayPharma in tb_day_sys_wdu001_received_ctrl_files.";
        cd_start_by="bq query";
        ds_object_system="$ParamLocalLoadFolder/$ParamInsertCtrlFilePharma.sql";
        ds_path_input="$ParamLocalLoadFolder";
        ds_path_output="$ParamLocalLoadFolder";
        date_start_processing=`date +"%Y-%m-%d %T"`
        
        #CONTROLE
            qt_load_records=$(bq --headless --quiet query --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/$ParamInsertCtrlFilePharma.sql)" | cut -d ":" -f 2)
        
        
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=$date_end_processing;
        qt_read_records=``;
        qt_rejected_records=``;
        
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 19 - Step 1: GCP error. Please check if GCP is available or contact your administrator."
                #exit_sh 161; exit 161
            else
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 19 - Step 1: Control infos from $ParamBQTableDayPharma inserted successfully."
                generate_log "Procedure 19: Control infos of monthly Pharma file inserted in tb_day_sys_wdu001_received_ctrl_files successfully."
        fi
    else
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 18 - Step 1: GCP error. Please check if GCP is available or contact your administrator."
                #exit_sh 10; exit 10
            else
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 18 - Step 1: Daily Pharma table replaced successfully."
        fi
fi

#--------------------------------------- SELLTHROUGH ---------------------------------------------------------------------
#Procedure 7: Process Sellthrough data.
generate_log "Procedure 7: Process Sellthrough data."


#Procedure 7 - Step 1: Replace daily sellthrough table with the daily sellthrough contents.
generate_log "Procedure 7 - Step 1: Replace daily sellthrough table with the daily sellthrough contents."
cd_interface="p007.s001"; 
ds_interface="Procedure 7: Process sellthrough data. | Step 1: Replace daily sellthrough table with the daily sellthrough contents."; 
cd_start_by="bq replace";
ds_object_system="cat $ParamLocalLoadFolder/$ParamBQTableDaySellthrough.sql"; 
ds_path_input="$ParamBQDataSet.$ParamBQTableExtSellthrough"; 
ds_path_output="$ParamBQDataSet.$ParamBQTableDaySellthrough"

echo "Replace $ParamBQTableDaySellthrough"
qt_records=`bq query --nouse_legacy_sql --format=prettyjson "select count(*) from $ParamBQDataSet.$ParamBQTableExtSellthrough" | grep f0_ | cut -d"\"" -f4`
echo $qt_records "Registros na tabela $ParamBQDataSet.$ParamBQTableExtSellthrough"
if [ $qt_records -ne 0 ]
    then
        date_start_processing=`date +"%Y-%m-%d %T"`
        replace_day () {
        bq query -n=0 --replace --destination_table $ParamBQDataSet.$ParamBQTableDaySellthrough \
        --time_partitioning_field $ParamPartitioningFieldSellthrough \
        --clustering_fields $ParamClusteringFieldSellthrough \
        "$(cat $ParamLocalLoadFolder/$ParamBQTableDaySellthrough.sql)"
        }
        
        replace_day
        
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySellthrough | grep nr_load_control | cut -d"\"" -f4`; 
        qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySellthrough | grep numRows | cut -d"\"" -f4`; 
        qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDaySellthrough | grep numRows | cut -d"\"" -f4`; 
        qt_rejected_records=``
        
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 7 - Step 1: Daily sellthrough table replaced successfully."
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 7 - Step 1: GCP error. Please check if GCP is available or contact your administrator."
fi

#Procedure 7 - Step 2: Execute duplicates sellthrough's procedure
generate_log "Procedure 7 - Step 2: Execute duplicates sellthrough's procedure"
	cd_interface="p007.s002"; ds_interface="Procedure 7: Process sellthrough data. | Step 2: Execute duplicates sellthrough's procedure."; cd_start_by="bq"; ds_object_system=""; ds_path_input=""; ds_path_output=""
	date_start_processing=`date +"%Y-%m-%d %T"`
		bq query --use_legacy_sql=false "call $ParamBQDataSet.$ParamBQProcedureSellthroughDuplicates()"
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 7 - Step 2: GCP error. Please check if GCP is available or contact your administrator."; 
			#exit_sh 12; exit 12
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 7 - Step 2: Procedure executed successfully."

#Procedure 7 - Step 3: Replace temp sellthrough table with new data to update.
generate_log "Procedure 7 - Step 3:  Replace temp sellthrough table with new data to update."
cd_interface="p007.s003"; 
ds_interface="Procedure 7: Process sellthrough data. | Step 3:  Replace temp sellthrough table with new data to update."; 
cd_start_by="bq replace"; 
ds_object_system="cat $ParamLocalLoadFolder/$ParamBQTableHisSellthrough.sql"; 
ds_path_input="$ParamBQDataSet.$ParamBQTableDaySellthrough"; 
ds_path_output="$ParamBQDataSet.$ParamBQTableTmpSellthrough"
date_start_processing=`date +"%Y-%m-%d %T"`


#captura maxima e minima datas da tabela diaria
#minimo=$(bq query --use_legacy_sql=false 'SELECT DATE_TRUNC(MIN(day.dt_movement),MONTH) as data from '$ParamBQDataSet'.'$ParamBQTableDaySellthrough' as day' | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g')
#maximo=$(bq query --use_legacy_sql=false 'SELECT DATE_TRUNC(MAX(day.dt_movement),MONTH) as data from '$ParamBQDataSet'.'$ParamBQTableDaySellthrough' as day' | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g')
#
#echo "data minima" $minimo;\
#echo "data maxima" $maximo;\
#
#bq query -n=0 --replace --destination_table $ParamBQDataSet.$ParamBQTableTmpSellthrough \
#--time_partitioning_field $ParamPartitioningFieldSellthrough \
#--clustering_fields $ParamClusteringFieldSellthrough \
#"$(cat $ParamLocalLoadFolder/$ParamBQTableHisSellthrough.sql | sed "s/data_minima/$minimo/g" | sed "s/data_maxima/$maximo/g")"

replace_tmp () {
    #captura maxima e minima datas da tabela diaria
    
    minimo=$(bq query --use_legacy_sql=false 'SELECT DATE_TRUNC(MIN(day.dt_movement),MONTH) as data from '$ParamBQDataSet'.'$ParamBQTableDaySellthrough' as day' | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g')
    maximo=$(bq query --use_legacy_sql=false 'SELECT DATE_TRUNC(MAX(day.dt_movement),MONTH) as data from '$ParamBQDataSet'.'$ParamBQTableDaySellthrough' as day' | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g')
    echo $minimo $maximo
    
    bq query -n=0 --replace --destination_table $ParamBQDataSet.$ParamBQTableTmpSellthrough \
    --time_partitioning_field $ParamPartitioningFieldSellthrough \
    --clustering_fields $ParamClusteringFieldSellthrough \
    "$(cat $ParamLocalLoadFolder/$ParamBQTableHisSellthrough.sql | sed "s/data_minima/$minimo/g" | sed "s/data_maxima/$maximo/g")"

}

replace_tmp

cd_exit=$?

echo "saida_temp_sellthrough" $cd_exit
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableTmpSellthrough | grep nr_load_control | cut -d"\"" -f4`; 
qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableTmpSellthrough | grep numRows | cut -d"\"" -f4`; 
qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableTmpSellthrough | grep numRows | cut -d"\"" -f4`; 
qt_rejected_records=``

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 7 - Step 3: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 12; exit 12
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 7 - Step 3:  Replace temp sellthrough table successfully."
fi

#Procedure 7 - Step 4: Transfer partition time from temp sellthrough table to history sellthrough table.
generate_log "Procedure 7 - Step 4: Transfer partition time from temp sellthrough table to history sellthrough table."
cd_interface="p007.s004"; 
ds_interface="Procedure 7: Process sellthrough data. | Step 4: Transfer partition time from temp sellthrough table to his sellthrough table."; 
cd_start_by="bq cp \$store"; 
ds_object_system="func_copia_part"; 
ds_path_input="$ParamBQDataSet.$ParamBQTableTmpSellthrough"; 
ds_path_output="$ParamBQDataSet.$ParamBQTableHisSellthrough"

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNC_COPIA_PART_FIA() #FUCAO QUE ATUALIZA AS PARTICOES DA TABELA HISTORICA
{
	#echo -e "\nTransferindo particao: "$1 "\n"
    echo -e "++++++++++++++++++++++++++++++++++\n| Transferindo particao $1 |\n++++++++++++++++++++++++++++++++++"
	store=$1 #STORE: PARÃƒâ€šMETRO QUE RECEBE A PARTICOES 
	bq cp -f "$ParamBQDataSet.$ParamBQTableTmpSellthrough\$$store" "$ParamBQDataSet.$ParamBQTableHisSellthrough\$$store" # COPIA A PARTIÃƒâ€¡ÃƒÆ’O DA TABELA DIÃƒÂRIA PARA A HISTÃƒâ€œRICA. \$ Ãƒâ€° NECESSÃƒÂRIO PARA TRANSFORMAR $ EM UM CARARECTE DE ESCAPE. JÃƒÂ QUE O COMANDO NO BIGQUERY UTILIZA $ COM empty_param_num DE SUA SINTAXE
	cd_exit=$?
}

#for store in $(bq query --max_rows=366 --use_legacy_sql=true 'SELECT partition_id FROM ['$ParamBQDataSet'.'$ParamBQTableTmpSellthrough'$__PARTITIONS_SUMMARY__]' | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g')  # O COMANDO ENTRE () LISTA AS PARTIÃƒâ€¡Ãƒâ€¢ES PRESENTES NA TABELA DIÃƒÂRIA. O FOR ITERA SOBRE ESSAS PARTIÃƒâ€¡Ãƒâ€¢ES
#do
#	if [ $store != "__NULL__" ];
#		then FUNC_COPIA_PART_FIA "$store"; #CHAMA A FUCAO QUE COPIA AS PARTICOES, RECEBENDO COMO PARAMETRO A PARTICOES EM QUE O FOR ESTA ITERANDO.
#		sleep $ParamStoreBreakRunSleep; # APLICA UM INTERVALO DE TEMPO ENTRE UMA CÃƒâ€œPIA E OUTRA. NECESSARIO DEVIDO AO TEMPO DE CLUSTERING DAS VM DA GOOGLE.
#	fi;
#done


replace_his () {
    for store in $(bq query --max_rows=366 --use_legacy_sql=true 'SELECT partition_id FROM ['$ParamBQDataSet'.'$ParamBQTableTmpSellthrough'$__PARTITIONS_SUMMARY__]' | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g')  # O COMANDO ENTRE () LISTA AS PARTIÃƒâ€¡Ãƒâ€¢ES PRESENTES NA TABELA DIÃƒÂRIA. O FOR ITERA SOBRE ESSAS PARTIÃƒâ€¡Ãƒâ€¢ES
    do
        if [ $store != "__NULL__" ];
            then FUNC_COPIA_PART_FIA "$store"; #CHAMA A FUCAO QUE COPIA AS PARTICOES, RECEBENDO COMO PARAMETRO A PARTICOES EM QUE O FOR ESTA ITERANDO.
            sleep $ParamStoreBreakRunSleep; # APLICA UM INTERVALO DE TEMPO ENTRE UMA CÃƒâ€œPIA E OUTRA. NECESSARIO DEVIDO AO TEMPO DE CLUSTERING DAS VM DA GOOGLE.
        fi;
    done
}

replace_his

cd_exit=$?

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableHisSellthrough | grep nr_load_control | cut -d"\"" -f4`; 
qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableHisSellthrough | grep numRows | cut -d"\"" -f4`; 
qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableHisSellthrough | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 7 - Step 4: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 13; exit 13
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 7 - Step 4: Transfer partition time from temp sellthrough table to history sellthrough table successfully."
        generate_log "Procedure 7: Processed sellthrough data successfully."
fi


##------------------------------------------- LOGS --------------------------------------------------
#echo date > $ParamLocalLogFolder/$ParamNameLogFileFTPCopySellthrough"_"$Day.txt
#ls $ParamLocalFTPFolderSellthrough >> $ParamLocalLogFolder/$ParamNameLogFileFTPCopySellthrough"_"$Day.txt
#
#echo date > $ParamLocalLogFolder/$ParamNameLogFileCSVSellthrough"_"$Day.txt
#ls $ParamLocalCSVFolderSellthrough >> $ParamLocalLogFolder/$ParamNameLogFileCSVSellthrough"_"$Day.txt
#
#
#mover_log_processed () {
#    gsutil cp \
#    $ParamLocalLogFolder/$ParamNameLogFileFTPCopySellthrough"_"$Day.txt \
#    $ParamLocalLogFolder/$ParamNameLogFileCSVSellthrough"_"$Day.txt \
#    $ParamLocalLogFolder/$ParamNameLogFileFTPSellthrough"_"$Day.txt \
#    $ParamLocalLogFolder/$ParamLogCtrlFileLog'_'$Day.txt \
#    $ParamCloudProcessedFolder/$Day
#}
#mover_log_processed
#    
#
#--------------------------------------- TABELA DE CONTROLE DE SELLTHROUGH -------------------------
#Procedure 7 - Step 5: Insert control infos in tb_day_sys_wdu001_received_ctrl_files.
generate_log "Procedure 7 - Step 5: Insert control infos from $ParamBQTableDaySellthrough in tb_day_sys_wdu001_received_ctrl_files."
cd_interface="p007.s005";
ds_interface="Procedure 7 - Step 5: Insert control infos from $ParamBQTableDaySellthrough in tb_day_sys_wdu001_received_ctrl_files.";
cd_start_by="bq query";
ds_object_system="$ParamLocalLoadFolder/$ParamInsertCtrlFileSellthrough.sql";
ds_path_input="$ParamLocalLoadFolder";
ds_path_output="$ParamLocalLoadFolder";
date_start_processing=`date +"%Y-%m-%d %T"`


#move arquivo de log com informaÃƒÂ§ÃƒÂµes sobre arquivos vazios
#gsutil cp $ParamLocalLogFolder/$ParamLogCtrlFileLog'_'$Day.txt $ParamCloudProcessingFolder

#insere infos na tabela externa de controle na tabela day de controle de arquivos
bq query --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/$ParamInsertCtrlEmptyFilesFileSellthrough.sql)"

#CONTROLE
qt_load_records=$(bq --headless --quiet query --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/$ParamInsertCtrlFileSellthrough.sql)" | cut -d ":" -f 2)


cd_exit=$?
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing;
qt_read_records=``;
qt_rejected_records=``;

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 7 - Step 5: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 161; exit 161
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 7 - Step 5: Insert control infos from $ParamBQTableDaySellout successfully."
        generate_log "Procedure 7: Processed sellthrough data successfully."
fi

#------------------------------------------------- BACKUP SELLTHROUGH------------------------------------------------------------
#Procedure 9: Backup processed files sellthrough.
generate_log "Procedure 9: Backup processed files sellthrough."

#Procedure 9 - Step 1: Move processed daily sellthrough files from local input folder to cloud processed folder.
generate_log "Procedure 9 - Step 1: Move processed daily sellthrough files from local input folder to cloud processed folder."
cd_interface="p009.s001";
ds_interface="Procedure 9 - Step 1: Move processed daily  sellthroughfiles from local input folder to cloud processed folder."; 
cd_start_by="gsutil mv"; 
ds_object_system="Enriched sellthrough Files"; 
ds_path_input="$ParamCloudProcessingFolder"; 
ds_path_output="$ParamCloudProcessedFolder"
date_start_processing=`date +"%Y-%m-%d %T"`

echo -e "++++++++++++++++++++++++++++++++++++\n| Movendo da INPUT para processed |\n++++++++++++++++++++++++++++++++++++"

cd $ParamLocalCSVFolderSellthrough

#zip arquivos transformados
ls | egrep -i '^sellthrough.*' | xargs -n 1 -i zip -r $ParamZipNameEnrichedSellthroughFile'_'$Day.zip {}

#move arquivos transformados para pasta de processed do dia
gsutil mv $ParamLocalCSVFolderSellthrough/$ParamZipNameEnrichedSellthroughFile'_'$Day.zip $ParamCloudProcessedFolder/$Day/

#------- controle de fluxo --------------
cd_exit=$?
#cd_exit=0
#----------------------------------------

date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing;
qt_load_records=$(ls -l | wc -l)

if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 9 - Step 1: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 13; exit 13
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 9 - Step 1: Backup processed files successfully."
fi

#limpa pasta dos arquivos transformados
rm -f $ParamLocalCSVFolderSellthrough/*

echo -e "+++++++++++++++++++++++++++++\n| Movendo da vm para source |\n+++++++++++++++++++++++++++++"

#Procedure 9 - Step 2: Move zip original sellthrough file from vm to cloud source folder.
generate_log "Procedure 9 - Step 2: Move orignal sellthrough file from vm to cloud source folder."
cd_interface="p009.s002";
ds_interface="Procedure 9 - Step 2: Move orignal sellthrough file from vm to cloud source folder.";
cd_start_by="gsutil mv";
ds_object_system="Orignal sellthrough files"; 
ds_path_input="$ParamLocalFTPFolderSellthrough"; 
ds_path_output="$ParamCloudSourceFolder/$Day"

qt_load_records=$(ls -l | wc -l)
date_start_processing=`date +"%Y-%m-%d %T"`

#entra na pasta dos arquivos originais
cd $ParamLocalFTPFolderSellthrough

#zipa arquivos originais do dia
ls | xargs -n 1 -i zip -r $ParamZipNameOriginaldSellthroughFile"_"$Day.zip {}


#move arquivos originais do dia para source
gsutil mv $ParamLocalFTPFolderSellthrough/$ParamZipNameOriginaldSellthroughFile"_"$Day.zip $ParamCloudSourceFolder/$Day/

#------- controle de fluxo --------------
cd_exit=$?
#cd_exit=0
#----------------------------------------
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=$date_end_processing; qt_read_records=``; qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 9 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 16; exit 16
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 9 - Step 2: Move original master files from vm to cloud source folder successfully."
        generate_log "Procedure 9: Processed sellthrough files backed up successfully."
fi

#limpa pasta dos arquivos originais
rm -f $ParamLocalFTPFolderSellthrough/*

#Procedure 7 - Step 5: Remove FIA old files.
generate_log "Procedure 7 - Step 5: Remove FIA old files."
	cd_interface="p007.s005"; ds_interface="Procedure 7: Collect Customer Robot files. | Step 5: Remove FIA old files."; cd_start_by="rm"; ds_object_system=""; ds_path_input="ParamCloudProcessingFolder/"; ds_path_output=""
	date_start_processing=`date +"%Y-%m-%d %T"`
		#remove arquivos de log existente em processing - temporario
			gsutil rm $ParamCloudProcessingFolder/$ParamLogCtrlFileLog'_'$Day.txt
		#Remove todos arquivos com prefixo SELLTHROUGH_FINAL em processing se houver
			gsutil -m rm $ParamCloudProcessingFolder/$ParamFileMovementPrefixSellthrough*
	cd_exit=$?
	date_end_processing=`date +"%Y-%m-%d %T"`
	nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
	if [ $cd_exit -ne 0 ]
		then
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
			generate_log "Procedure 7 - Step 5: Transfer error. Please check if API is available or contact your administrator."; 
			#exit_sh 3; exit 3
	fi
	generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 7 - Step 5: Files removed successfully."


#------------------------------------------TABELA DE LOJAS ------------------------------------------------------
#Procedure 19 - Step 1: Replace daily Store table with the daily contents.
generate_log "Procedure 19: Processed Store data"
generate_log "Procedure 19 - Step 1: Replace daily Store table with the daily contents"
cd_interface="p019.s001";
ds_interface="Procedure 19: Process Store data. Step 1: Replace daily Store table with the daily Store contents."; 
cd_start_by="bq replace"; 
ds_object_system="$ParamLocalLoadFolder/$ParamBQTableDayStore.sql"; 
ds_path_input="$ParamBQDataSet.$ParamBQTableDayStore"; 
ds_path_output="$ParamBQDataSet.$ParamBQTableHisStore"
date_start_processing=`date +"%Y-%m-%d %T"`

#DIARIA
echo -e "+++++++++++++++++++++++++++++++++++\n| replace $ParamBQTableDayStore |\n+++++++++++++++++++++++++++++++++++"
bq query --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/$ParamBQTableDayStore.sql)"

cd_exit=$?
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDayStore | grep nr_load_control | cut -d"\"" -f4`; 
qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayStore | grep numRows | cut -d"\"" -f4`; 
qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayStore | grep numRows | cut -d"\"" -f4`; 
qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 19 - Step 1: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 06; exit 061
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 19 - Step 1: Daily Store table replaced successfully."
fi


#Procedure 19 - Step_2: Merge daily Store table with history Store table.
generate_log "Procedure 19 - Step 2: Merge daily Store table with history Store table."
cd_interface="p019.s002"; 
ds_interface="Procedure 19: Process Store data. Step 2: Merge daily Store table with history Store table."; 
cd_start_by="bq query"; 
ds_object_system="$ParamLocalLoadFolder/$ParamBQTableHisStore.sql"; 
ds_path_input="$ParamBQTableDayStore"; 
ds_path_output="$ParamBQTableHisStore"; 
date_start_processing=`date +"%Y-%m-%d %T"`

#ATUALIZA A HISTÃƒÆ’Ã¢â‚¬Å“RICA DE LOJAS
echo -e "+++++++++++++++++++++++++++++++++\n| merge $ParamBQTableHisStore |\n+++++++++++++++++++++++++++++++++"
bq query --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/$ParamBQTableHisStore.sql)"

cd_exit=$?
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableHisStore | grep nr_load_control | cut -d"\"" -f4`; 
qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableHisStore | grep numRows | cut -d"\"" -f4`; 
qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableHisStore | grep numRows | cut -d"\"" -f4`; 
qt_rejected_records=``
if [ $cd_exit -ne 0 ]
	then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 19 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
		#exit_sh 06; exit 062
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 19 - Step 2: Daily Store table and history Store table merged successfully."
        generate_log "Procedure 19: Processed Store data successfully."  
fi


#-------------------------------------------------------ROBO DE PRODUTOS------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#PROCEDURES:	
#Procedure 20: Extracts master data of products.
generate_log "Procedure 20: Extracts master data of products."
	
	#Procedure 20 - Step 1: Create temp table with product robot master data.
		generate_log "Procedure 20 - Step 1: Create temp table with product robot master data."
		cd_interface="p020.s001"; ds_interface="Procedure 20: Extracts master data of products. | Step 1: Create temp table with product robot master data."; cd_start_by="bq"; ds_object_system=""; ds_path_input=""; ds_path_output="'$ParamBQDataSet'_tmp.$ParamBQTableTmpMRDProductRobot"
		date_start_processing=`date +"%Y-%m-%d %T"`
			bq --headless --quiet query --replace --destination_table "$ParamBQDataSet"_tmp.$ParamBQTableTmpMRDProductRobot --use_legacy_sql=false "select distinct SAFE_CAST(SAFE_CAST(product.cd_sku_unique_cpg AS INT64) AS STRING) cd_product_sku_cpg, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(product.ds_product_sku_cpg, '\'', ''), '\"', ''), '+', ' + '), '.', ' '), '  ', ' ') ds_product_sku_cpg, product.ds_brand_level, product.ds_family_level, product.ds_product_line_level, product.ds_brand_custom, product.ds_family_custom, product.nr_product_ean_cpg, product.nr_product_dun_cpg, product.cd_base_unit_measure, product.ds_base_unit_measure, product.qt_base_unit_measure, product.qt_volume, product.cd_volume_unit, product.dt_release from $ParamBQDataSet.$ParamBQTableHisProduct product, (select nr_product_ean_cpg, max(dt_release) dt_release from $ParamBQDataSet.$ParamBQTableHisProduct where fl_check_nrean3_cpg_inv = 0 group by nr_product_ean_cpg) max_ean where product.nr_product_ean_cpg = max_ean.nr_product_ean_cpg and product.fl_check_nrean3_cpg_inv = 0 and product.cd_sku_unique_cpg not in (select distinct cd_product_sku_old_cpg from $ParamBQDataSet.$ParamBQTableHisProduct where not cd_product_sku_old_cpg is null) union all select distinct SAFE_CAST(SAFE_CAST(product.cd_sku_unique_cpg AS INT64) AS STRING) cd_product_sku_cpg, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(product.ds_product_sku_cpg, '\'', ''), '\"', ''), '+', ' + '), '.', ' '), '  ', ' ') ds_product_sku_cpg, product.ds_brand_level, product.ds_family_level, product.ds_product_line_level, product.ds_brand_custom, product.ds_family_custom, product.nr_product_ean_cpg, product.nr_product_dun_cpg, product.cd_base_unit_measure, product.ds_base_unit_measure, product.qt_base_unit_measure, product.qt_volume, product.cd_volume_unit, product.dt_release from $ParamBQDataSet.$ParamBQTableHisProduct product where product.fl_check_nrean3_cpg_inv = 1"
        cd_exit=$?
        #cd_exit=1
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=`bq --headless --quiet head --max_rows=1 --format=prettyjson $ParamBQDataSet.$ParamBQTableDayStore | grep nr_load_control | cut -d"\"" -f4`; qt_read_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayStore | grep numRows | cut -d"\"" -f4`; qt_load_records=`bq --headless --quiet show --format=prettyjson $ParamBQDataSet.$ParamBQTableDayStore | grep numRows | cut -d"\"" -f4`; qt_rejected_records=``
		if [ $cd_exit -ne 0 ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"      
				generate_log "Procedure 20 - Step 1: GCP error. Please check if GCP is available or contact your administrator."
				exit_sh 2; exit 2
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 20 - Step 1: Temp table with product robot master data created successfully."

    #Procedure 20 - Step 2: Run query to extract master data of products.
    generate_log "Procedure 20 - Step 2: Run query to extract master data of products."
        cd_interface="p020.s002"; ds_interface="Procedure 20: Extracts master data of products. | Step 2: Run query to extract master data of products."; cd_start_by="bq"; ds_object_system=""; ds_path_input=""$ParamBQDataSet"_tmp.$ParamBQTableTmpMRDProductRobot"; ds_path_output="$ParamCloudTempFolder/"$ParamBQTableTmpMRDProductRobot"_$LOAD_CONTROL.txt.gz"
        date_start_processing=`date +"%Y-%m-%d %T"`
            bq --headless --quiet extract --destination_format CSV --compression GZIP --field_delimiter '|' --noprint_header "$ParamBQDataSet"_tmp.$ParamBQTableTmpMRDProductRobot $ParamCloudTempFolder/"$ParamBQTableTmpMRDProductRobot"_$LOAD_CONTROL.txt.gz
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 20 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
                exit_sh 3; exit 3
        fi
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 20 - Step 2: Query to extract master data of products ran successfully."

    #Procedure 20 - Step 3: Move product robot master data files from GCS to local folder.
	generate_log "Procedure 20 - Step 3: Move product robot master data files from GCS to local folder."
        cd_interface="p020.s003"; ds_interface="Procedure 20: Extracts master data of products. | Step 3: Move product robot master data files from GCS to local folder."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamCloudTempFolder/"$ParamBQTableTmpMRDProductRobot"_$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamLocalTempFolder/"
        date_start_processing=`date +"%Y-%m-%d %T"`
            gsutil -q -m mv $ParamCloudTempFolder/"$ParamBQTableTmpMRDProductRobot"_$LOAD_CONTROL.txt.gz $ParamLocalTempFolder/
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 20 - Step 3: GCP error. Please check if GCP is available or contact your administrator."
                exit_sh 4; exit 4
        fi
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 20 - Step 3: Product robot master data files from GCS moved to local folder successfully."
        
	#Procedure 20 - Step 4: Add header and rename the extracted product file.
	generate_log "Procedure 20 - Step 4: Add header and rename the extracted product file."
		cd_interface="p020.s004"; ds_interface="Procedure 20: Extracts master data of products. | Step 4: Add header and rename the extracted product file."; cd_start_by="gzip"; ds_object_system=""; ds_path_input="$ParamLocalParameterFolder/$ParamBQTableTmpMRDProductRobot-HEADER.txt"; ds_path_output="$ParamLocalTempFolder/$ParamBQTableTmpMRDProductRobot-$LOAD_CONTROL.txt.gz"
		date_start_processing=`date +"%Y-%m-%d %T"`
		gzip -q -c "$ParamLocalParameterFolder/"$ParamBQTableTmpMRDProductRobot'-HEADER.txt' > $ParamLocalTempFolder/$ParamBQTableTmpMRDProductRobot-$LOAD_CONTROL.txt.gz
		cd_exit=$?
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
		if [ $cd_exit -ne 0 ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
				generate_log "Procedure 20 - Step 4: GCP error. Please check if GCP is available or contact your administrator."
				exit_sh 5; exit 5
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 20 - Step 4: Header added and the extracted product file renamed successfully."
        
	#Procedure 20 - Step 5: Concatenate product robot master data files to final file.
	generate_log "Procedure 20 - Step 5: Concatenate product robot master data files to final file."
		cd_interface="p020.s005"; ds_interface="Procedure 20: Extracts master data of products. | Step 5: Concatenate product robot master data files to final file."; cd_start_by="cat"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/"$ParamBQTableTmpMRDProductRobot"_$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamLocalTempFolder/$ParamBQTableTmpMRDProductRobot-$LOAD_CONTROL.txt.gz"
		date_start_processing=`date +"%Y-%m-%d %T"`
			cat $ParamLocalTempFolder/"$ParamBQTableTmpMRDProductRobot"_$LOAD_CONTROL.txt.gz >> $ParamLocalTempFolder/$ParamBQTableTmpMRDProductRobot-$LOAD_CONTROL.txt.gz
		cd_exit=$?
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
		if [ $cd_exit -ne 0 ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
				generate_log "Procedure 20 - Step 5: GCP error. Please check if GCP is available or contact your administrator."
				exit_sh 6; exit 6
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 20 - Step 5: Product robot master data files concatened to final file successfully."

	#Procedure 20 - Step 6: Remove product robot master data files from local folder.
	generate_log "Procedure 20 - Step 6: Remove product robot master data files from local folder."
		cd_interface="p020.s006"; ds_interface="Procedure 20: Extracts master data of products. | Step 6: Remove product robot master data files from local folder."; cd_start_by="rm"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/"$ParamBQTableTmpMRDProductRobot"_$LOAD_CONTROL.txt.gz"; ds_path_output=""
		date_start_processing=`date +"%Y-%m-%d %T"`
			rm -f $ParamLocalTempFolder/"$ParamBQTableTmpMRDProductRobot"_$LOAD_CONTROL.txt.gz
		cd_exit=$?
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
		if [ $cd_exit -ne 0 ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
				generate_log "Procedure 20 - Step 6: GCP error. Please check if GCP is available or contact your administrator."
				exit_sh 7; exit 7
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 20 - Step 6: Product robot master data files removed from local folder successfully."

	#Procedure 20 - Step 7: Generate uncompressed csv input file.
	generate_log "Procedure 20 - Step 7: Generate uncompressed csv input file."
		cd_interface="p020.s007"; ds_interface="Procedure 20: Extracts master data of products. | Step 7: Generate uncompressed csv input file."; cd_start_by="gunzip"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/$ParamBQTableTmpMRDProductRobot-$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamLocalTempFolder/$ParamBQTableTmpMRDProductRobot-$LOAD_CONTROL.csv"
		date_start_processing=`date +"%Y-%m-%d %T"`
            gunzip -q -c $ParamLocalTempFolder/$ParamBQTableTmpMRDProductRobot-$LOAD_CONTROL.txt.gz > $ParamLocalTempFolder/$ParamBQTableTmpMRDProductRobot.csv
        cd_exit=$?
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
		if [ $cd_exit -ne 0 ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
				generate_log "Procedure 20 - Step 7: GCP error. Please check if GCP is available or contact your administrator."
				exit_sh 8; exit 8
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 20 - Step 7: Uncompressed csv input file generated successfully."
	
##ALTERAÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O !!! - BLOCO NOVO	
	#Procedure 20 - Step 8: Clean cloud input S3 folder to receive the new file to be processed.
	generate_log "Procedure 20 - Step 8: Clean cloud input S3 folder to receive the new file to be processed."
        cd_interface="p020.s008"; ds_interface="Procedure 20: Extracts master data of products. | Step 8.0: Clean cloud input S3 folder to receive the new file to be processed."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamAWSS3InputFolder/$ParamBQTableTmpMRDProductRobot.csv"; ds_path_output=""
        date_start_processing=`date +"%Y-%m-%d %T"`
			file_count=`gsutil -q -m ls $ParamAWSS3InputFolder/$ParamBQTableTmpMRDProductRobot.csv | wc -l`
        if [ $? -ne 0 ] || [ $file_count -lt 1 ]
	        then
                date_end_processing=`date +"%Y-%m-%d %T"`
                nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 20 - Step 8: Cloud input S3 folder is already empty and does not need to be cleaned."
	    else
                gsutil -q -m rm $ParamAWSS3InputFolder/$ParamBQTableTmpMRDProductRobot.csv
            cd_exit=$?
            date_end_processing=`date +"%Y-%m-%d %T"`
            nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
            if [ $cd_exit -ne 0 ]
                then
                    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                    generate_log "Procedure 20 - Step 8: GCP error. Please check if GCP is available or contact your administrator."
                    exit_sh 9; exit 9
            fi
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 20 - Step 8: Cloud input S3 folder to receive the new file to be processed was cleaned successfully."
        fi
##ALTERAÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O FIM!!!
    
    
	#Procedure 20 - Step 9: Move uncompressed csv input file to AWS S3.
	generate_log "Procedure 20 - Step 9: Move uncompressed csv input file to AWS S3."
		cd_interface="p020.s009"; ds_interface="Procedure 20: Extracts master data of products. | Step 9: Move uncompressed csv input file to AWS S3."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/$ParamBQTableTmpMRDProductRobot-$LOAD_CONTROL.csv"; ds_path_output="$ParamAWSS3InputFolder/"
		date_start_processing=`date +"%Y-%m-%d %T"`
			gsutil -q -m mv $ParamLocalTempFolder/$ParamBQTableTmpMRDProductRobot.csv $ParamAWSS3InputFolder/
		cd_exit=$?
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
		if [ $cd_exit -ne 0 ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
				generate_log "Procedure 20 - Step 9: GCP error. Please check if GCP is available or contact your administrator."
				exit_sh 9; exit 9
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 20 - Step 9: Uncompressed csv input file moved to AWS S3 successfully."
    
    
	#Procedure 20 - Step 10: Move final product robot master data file to GCS.
	generate_log "Procedure 20 - Step 10: Move final product robot master data file to GCS."
		cd_interface="p020.s010"; ds_interface="Procedure 20: Extracts master data of products. | Step 10: Move final product robot master data file to GCS."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/$ParamBQTableTmpMRDProductRobot-$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamCloudOutputFolder/rba/$date_reference_d1/"
		date_start_processing=`date +"%Y-%m-%d %T"`
			gsutil -q -m mv $ParamLocalTempFolder/$ParamBQTableTmpMRDProductRobot-$LOAD_CONTROL.txt.gz $ParamCloudOutputFolder/rba/$date_reference_d1/
		cd_exit=$?
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
		if [ $cd_exit -ne 0 ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
				generate_log "Procedure 20 - Step 10: GCP error. Please check if GCP is available or contact your administrator."
				exit_sh 10; exit 10
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 20 - Step 10: Final product robot master data file moved to GCS successfully."
    
    
	#Procedure 20 - Step 11: Remove temp table with product robot master data.
	generate_log "Procedure 20 - Step 11: Remove temp table with product robot master data."
		cd_interface="p020.s011"; ds_interface="Procedure 20: Extracts master data of products. | Step 11: Remove temp table with product robot master data."; cd_start_by="bq"; ds_object_system=""; ds_path_input=""$ParamBQDataSet"_tmp.$ParamBQTableTmpMRDProductRobot"; ds_path_output=""
		date_start_processing=`date +"%Y-%m-%d %T"`
			bq --headless --quiet rm -f "$ParamBQDataSet"_tmp.$ParamBQTableTmpMRDProductRobot
		cd_exit=$?
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
		if [ $cd_exit -ne 0 ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
				generate_log "Procedure 20 - Step 11: GCP error. Please check if GCP is available or contact your administrator."
				exit_sh 11; exit 11
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 20 - Step 11: Temp table with product robot master data removed successfully."
    
generate_log "Procedure 20: Master data of products extracted successfully."

##ALTERAÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O !!! - DOIS BLOCOS NOVOS		
	#Procedure 20 - Step 12: Authenticate to use the Load API.
	generate_log "Procedure 20 - Step 12: Authenticate to use the Load API."
        cd_interface="p020.s012"; ds_interface="Procedure 20: Extracts master data of products. | Step 12: Authenticate to use the Load API."; cd_start_by="curl"; ds_object_system=""; ds_path_input="/tmp/cookies"; ds_path_output=""
        date_start_processing=`date +"%Y-%m-%d %T"`
			bearer=`curl -c /tmp/cookies --request GET --url "$ParamProductRobotAPIURL/auth/login?email=$ParamProductRobotAPIUser&password=$ParamProductRobotAPIPassword" | cut -d"," -f2 | cut -d":" -f2 | cut -d"\"" -f2`
		cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ] || [ "$bearer" == 'Login failed.' ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 20 - Step 12: Authentication error. Please check if API is available or contact your administrator."
                exit_sh 13; exit 13
        fi
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 20 - Step 12: User authenticated successfully."
	
	#Procedure 20 - Step 13: Run the Load API.
		generate_log "Procedure 20 - Step 13: Run the Load API."
			cd_interface="p020.s013"; ds_interface="Procedure 20: Extracts master data of products. | Step 13: Run the Load API."; cd_start_by="curl"; ds_object_system=""; ds_path_input="/tmp/cookies"; ds_path_output=""
			date_start_processing=`date +"%Y-%m-%d %T"`	
			for i in `seq 3` 
				do
					api_output=`curl -b /tmp/cookies --request POST --url $ParamProductRobotAPIURL/load_data --header "Authorization: Bearer $bearer" --header 'Content-Type: application/json' -d $'{}' | cut -d':' -f3 | cut  -d'}' -f1`
					cd_exit=$?
					date_end_processing=`date +"%Y-%m-%d %T"`
					nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
					if [ $cd_exit -eq 0 ] && [ "$api_output" = '"Load data complete"' ]
						then
							generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
							generate_log "Procedure 20 - Step 13: API ran successfully."
							break						
						else
							generate_log "Procedure 20 - Step 13: API still running or not finished successfully."
					fi
					if [ $i -eq 3 ]
						then
							generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
							generate_log "Procedure 20 - Step 13: API error. Please check if API is available or contact your administrator."; 
							exit_sh 14; exit 14
					fi
					sleep 60
				done	
##ALTERAÃƒÆ’Ã¢â‚¬Â¡ÃƒÆ’Ã†â€™O FIM!!!

#Procedure 21: Extracts products from SellOut by retail customer.
generate_log "Procedure 21: Extracts products from SellOut by retail customer."

	IFS=$'\n'
	for cd_company_rba in $(bq query -n 10000 -q --use_legacy_sql=false "select cd_company_rba from (select cd_company_rba from (select distinct product_robot.cd_company_rba as cd_company_rba ,(count(*) over (partition by product_robot.cd_company_rba)) as count  from "$ParamBQDataSet"_rba.$ParamBQViewProductRobot as product_robot  where (product_robot.cd_status_curator = '1' OR product_robot.cd_status_curator IS NULL)) order by count desc)"  | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g')
    do
        #Removes special caracter for the table name
        cd_company=`(echo "$cd_company_rba" | sed "s/-//")`

		#Procedure 21 - Step 1: Create temp table with product robot transaction.
		generate_log "Procedure 21 - Step 1 - $cd_company_rba: Create temp table with product robot transaction."
			cd_interface="p021.s001"; ds_interface="Procedure 21: Extracts products from SellOut by retail customer. | Step 1: Create temp table with product robot transaction."; cd_start_by="bq"; ds_object_system=""; ds_path_input=""; ds_path_output=""$ParamBQDataSet"_tmp."$ParamBQTableTmpTRSProductRobot"_"$cd_company""
			date_start_processing=`date +"%Y-%m-%d %T"`
					bq --headless --quiet query -n 10000 --replace --destination_table "$ParamBQDataSet"_tmp."$ParamBQTableTmpTRSProductRobot"_"$cd_company" --use_legacy_sql=false "select product_robot.nm_company_rba nm_company_wdu, product_robot.cd_product_rba, product_robot.ds_product_rba, product_robot.cd_ean_rba, product_robot.ds_ean_rba, ifnull(ceil(SAFE_DIVIDE(sum(product_robot.qt_sale),count(distinct product_robot.dt_reference))), 0) qt_sale  from "$ParamBQDataSet"_rba.$ParamBQViewProductRobot product_robot where  product_robot.cd_company_rba = '$cd_company_rba' AND (product_robot.cd_status_curator = '1' OR product_robot.cd_status_curator IS NULL) group by product_robot.nm_company_rba, product_robot.cd_product_rba, product_robot.ds_product_rba, product_robot.cd_ean_rba, product_robot.ds_ean_rba order by count(*) over (partition by product_robot.nm_company_rba) desc"
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``	
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 21 - Step 1 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 12; exit 12
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 21 - Step 1 - $cd_company_rba: Temp table with product robot transaction created successfully."
		
		#Procedure 21 - Step 2: Run query to extract products from transactions.
		generate_log "Procedure 21 - Step 2 - $cd_company_rba: Run query to extract products from transactions."
			cd_interface="p021.s002"; ds_interface="Procedure 21: Extracts products from SellOut by retail customer. | Step 2: Run query to extract products from transactions."; cd_start_by="bq"; ds_object_system=""; ds_path_input=""$ParamBQDataSet"_tmp."$ParamBQTableTmpTRSProductRobot"_"$cd_company""; ds_path_output="$ParamCloudTempFolder/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"_$LOAD_CONTROL.txt.gz"
			date_start_processing=`date +"%Y-%m-%d %T"`
					bq --headless --quiet extract --destination_format CSV --compression GZIP --field_delimiter ';' --noprint_header ""$ParamBQDataSet"_tmp."$ParamBQTableTmpTRSProductRobot"_"$cd_company"" $ParamCloudTempFolder/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"_$LOAD_CONTROL.txt.gz
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 21 - Step 2 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 13; exit 13
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 21 - Step 2 - $cd_company_rba: Query to extract products from transactions ran successfully."
		
		#Procedure 21 - Step 3: Move product transaction files from GCS to local folder.
		generate_log "Procedure 21 - Step 3 - $cd_company_rba: Move product transaction files from GCS to local folder."
			cd_interface="p021.s003"; ds_interface="Procedure 21: Extracts products from SellOut by retail customer. | Step 3: Move product transaction files from GCS to local folder."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamCloudTempFolder/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"_$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamLocalTempFolder"
			date_start_processing=`date +"%Y-%m-%d %T"`
				gsutil -q -m mv $ParamCloudTempFolder/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"_*.txt.gz $ParamLocalTempFolder/
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 21 - Step 3 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 14; exit 14
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 21 - Step 3 - $cd_company_rba: Product transaction files from GCS moved to local folder successfully."
			
		#Procedure 21 - Step 4: Add header and rename the extracted product file.
		generate_log "Procedure 21 - Step 4 - $cd_company_rba: Add header and rename the extracted product file."
			cd_interface="p021.s004"; ds_interface="Procedure 21: Extracts products from SellOut by retail customer. | Step 4: Add header and rename the extracted product file."; cd_start_by="gzip"; ds_object_system=""; ds_path_input="$ParamLocalParameterFolder/"$ParamBQTableTmpTRSProductRobot"-HEADER.txt"; ds_path_output=""$ParamLocalTempFolder"/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz"
			date_start_processing=`date +"%Y-%m-%d %T"`
				gzip -q -c $ParamLocalParameterFolder/"$ParamBQTableTmpTRSProductRobot"-HEADER.txt > $ParamLocalTempFolder/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 21 - Step 4 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 15; exit 15
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 21 - Step 4 - $cd_company_rba: Header added and the extracted product file renamed successfully."
			
		#Procedure 21 - Step 5: Concatenate product robot transaction files to final file.
		generate_log "Procedure 21 - Step 5 - $cd_company_rba: Concatenate product robot transaction files to final file."
			cd_interface="p021.s005"; ds_interface="Procedure 21: Extracts products from SellOut by retail customer. | Step 5: Concatenate product robot transaction files to final file."; cd_start_by="cat"; ds_object_system=""; ds_path_input=""$ParamLocalTempFolder"/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"_$LOAD_CONTROL.txt.gz"; ds_path_output=""$ParamLocalTempFolder"/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz"
			date_start_processing=`date +"%Y-%m-%d %T"`
				cat $ParamLocalTempFolder/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"_*.txt.gz >> $ParamLocalTempFolder/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 21 - Step 5 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 16; exit 16
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 21 - Step 5 - $cd_company_rba: Product robot transaction files concatenated to final file successfully."
			
		#Procedure 21 - Step 6: Remove product transaction files from local folder.
		generate_log "Procedure 21 - Step 6 - $cd_company_rba: Remove product transaction files from local folder."
			cd_interface="p021.s006"; ds_interface="Procedure 21: Extracts products from SellOut by retail customer. | Step 6: Remove product transaction files from local folder."; cd_start_by="rm"; ds_object_system=""; ds_path_input=""$ParamLocalTempFolder"/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"_$LOAD_CONTROL.txt.gz"; ds_path_output=""
			date_start_processing=`date +"%Y-%m-%d %T"`
				rm -f $ParamLocalTempFolder/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"_*.txt.gz
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 21 - Step 6 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 17; exit 17
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 21 - Step 6 - $cd_company_rba: Product transaction files removed from local folder successfully."
			
		#Procedure 21 - Step 7: Generate uncompressed csv input file.
		generate_log "Procedure 21 - Step 7 - $cd_company_rba: Generate uncompressed csv input file."
			cd_interface="p021.s007"; ds_interface="Procedure 21: Extracts products from SellOut by retail customer. | Step 7: Generate uncompressed csv input file."; cd_start_by="gunzip"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamLocalTempFolder/$cd_company_rba-$LOAD_CONTROL.csv"
			date_start_processing=`date +"%Y-%m-%d %T"`
				gunzip -q -c $ParamLocalTempFolder/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz > $ParamLocalTempFolder/$cd_company_rba-$LOAD_CONTROL.csv
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 21 - Step 7 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 18; exit 18
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 21 - Step 7 - $cd_company_rba: Uncompressed csv input file generated successfully."
			
		#Procedure 21 - Step 8: Move uncompressed csv input file to AWS S3.
		generate_log "Procedure 21 - Step 8 - $cd_company_rba: Move uncompressed csv input file to AWS S3."
			cd_interface="p021.s008"; ds_interface="Procedure 21: Extracts products from SellOut by retail customer. | Step 8: Move uncompressed csv input file to AWS S3."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/$cd_company_rba-$LOAD_CONTROL.csv"; ds_path_output="$ParamAWSS3InputFolder/"
			date_start_processing=`date +"%Y-%m-%d %T"`
				gsutil -q -m mv $ParamLocalTempFolder/$cd_company_rba-$LOAD_CONTROL.csv $ParamAWSS3InputFolder/
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 21 - Step 8 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 19; exit 19
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 21 - Step 8 - $cd_company_rba: Uncompressed csv input file moved to AWS S3 successfully."

		#Procedure 21 - Step 9: Move final product robot transaction file to GCS.
		generate_log "Procedure 21 - Step 9 - $cd_company_rba: Move final product robot transaction file to GCS."
			cd_interface="p021.s009"; ds_interface="Procedure 21: Extracts products from SellOut by retail customer. | Step 9: Move final product robot transaction file to GCS."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamCloudOutputFolder/rba/$date_reference_d1/"
			date_start_processing=`date +"%Y-%m-%d %T"`
				gsutil -q -m mv $ParamLocalTempFolder/"$ParamBQTableTmpTRSProductRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz $ParamCloudOutputFolder/rba/$date_reference_d1/
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 21 - Step 9 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 20; exit 20
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 21 - Step 9 - $cd_company_rba: Final product robot transaction file moved to GCS successfully."			

		#Procedure 21 - Step 10: Remove temp table with product robot transaction.
		generate_log "Procedure 21 - Step 10 - $cd_company_rba: Remove temp table with product robot transaction."
			cd_interface="p021.s010"; ds_interface="Procedure 21: Extracts products from SellOut by retail customer. | Step 10: Remove temp table with product robot transaction."; cd_start_by="bq"; ds_object_system=""; ds_path_input=""$ParamBQDataSet"_tmp."$ParamBQTableTmpTRSProductRobot"_"$cd_company""; ds_path_output=""
			date_start_processing=`date +"%Y-%m-%d %T"`
				bq --headless --quiet rm -f "$ParamBQDataSet"_tmp."$ParamBQTableTmpTRSProductRobot"_"$cd_company"
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 21 - Step 10 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 21; exit 21
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 21 - Step 10 - $cd_company_rba: Temp table with product robot transaction removed successfully."
			
	done
generate_log "Procedure 21: Products from SellOut by retail customer extracted successfully"


#Procedure 22: Run Cross Reference Robot API by retail customer.
generate_log "Procedure 22: Run Cross Reference Robot API by retail customer."
	
	#Procedure 22 - Step 1: Authenticate to use the Product Robot API.
	generate_log "Procedure 22 - Step 1: Authenticate to use the Product Robot API."
        cd_interface="p022.s001"; ds_interface="Procedure 22: Run Cross Reference Robot API by retail customer. | Step 1: Authenticate to use the Product Robot API."; cd_start_by="curl"; ds_object_system=""; ds_path_input="/tmp/cookies"; ds_path_output=""
        date_start_processing=`date +"%Y-%m-%d %T"`
			bearer=`curl -c /tmp/cookies --request GET --url "$ParamProductRobotAPIURL/auth/login?email=$ParamProductRobotAPIUser&password=$ParamProductRobotAPIPassword" | cut -d"," -f2 | cut -d":" -f2 | cut -d"\"" -f2`
		cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ] || [ "$bearer" == 'Login failed.' ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 22 - Step 1: Authentication error. Please check if API is available or contact your administrator."
                exit_sh 22; exit 22
        fi
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 22 - Step 1: User authenticated successfully."

	#Procedure 22 - Step 2: Initialize API Output file.
	generate_log "Procedure 22 - Step 2: Initialize API Output file."
        cd_interface="p022.s002"; ds_interface="Procedure 22: Run Cross Reference Robot API by retail customer. | Step 2: Initialize API Output file."; cd_start_by="echo"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/"; ds_path_output="$ParamLocalTempFolder/Smart-ProductRobot-Day-APIOutput.ok"
        date_start_processing=`date +"%Y-%m-%d %T"`
			echo -n > $ParamLocalTempFolder/Smart-ProductRobot-Day-APIOutput.ok
		cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 22 - Step 2: Filesystem error. Please check if filesystem is full or contact your administrator." 
                exit_sh 23; exit 23
        fi
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
    generate_log "Procedure 22 - Step 2: File initialized successfully."

#Start running API, by cd_company_rba.
	for cd_company_rba_cnpj in $(bq --headless --quiet query -n 10000 --use_legacy_sql=false "select distinct CONCAT(product_robot.cd_company_rba, '_', SUBSTR(product_robot.cd_company_rba,1,9)) from "$ParamBQDataSet"_rba.$ParamBQViewProductRobot product_robot where (product_robot.cd_status_curator = '1' OR product_robot.cd_status_curator IS NULL)" | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g')
	do
		cd_company_rba=`echo $cd_company_rba_cnpj | cut -d"_" -f1`
		cd_cnpj=`echo $cd_company_rba_cnpj | cut -d"_" -f2`
		ds_json_data="{\"data\": [{\"path\": \"$cd_company_rba-$LOAD_CONTROL.csv\",\"cnpj\": \"$cd_cnpj\",\"id\": \"$cd_company_rba-$LOAD_CONTROL-$date_reference_d1\"}]}"

		#Procedure 22 - Step 3: Run the Product Robot API.
        generate_log "Procedure 22 - Step 3 - $cd_company_rba: Run the Product Robot API."
			cd_interface="p022.s003"; ds_interface="Procedure 22: Run Cross Reference Robot API by retail customer. | Step 3: Run the Product Robot API."; cd_start_by="curl"; ds_object_system=""; ds_path_input="/tmp/cookies"; ds_path_output=""
			date_start_processing=`date +"%Y-%m-%d %T"`
				api_output=$(curl -b /tmp/cookies --request POST --url $ParamProductRobotAPIURL/compute --header "Authorization: Bearer $bearer" --header 'Content-Type: application/json' --data "$ds_json_data" | cut -d"," -f6 | cut -d":" -f2 | cut -d"\"" -f2)
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ] || [ "$api_output" == 'Invalid user.' ] || [ "$api_output" == 'Token expired or invalid.' ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 22 - Step 3 - $cd_company_rba: API error. Please check if API is available or contact your administrator."; 
					exit_sh 24; exit 24
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 22 - Step 3 - $cd_company_rba: API ran successfully."			
			
		#Procedure 22 - Step 4: Append API response to API output file.
        generate_log "Procedure 22 - Step 4 - $cd_company_rba: Append API response to API output file."
			cd_interface="p022.s004"; ds_interface="Procedure 22: Run Cross Reference Robot API by retail customer. | Step 4: Append API response to API output file."; cd_start_by="echo"; ds_object_system=""; ds_path_input="$cd_company_rba|$api_output"; ds_path_output="$ParamLocalTempFolder/Smart-ProductRobot-Day-APIOutput.ok"
			date_start_processing=`date +"%Y-%m-%d %T"`
				echo "$cd_company_rba|$api_output" >> $ParamLocalTempFolder/Smart-ProductRobot-Day-APIOutput.ok
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 22 - Step 4 - $cd_company_rba: Filesystem error. Please check if filesystem is full or contact your administrator."; 
					exit_sh 25; exit 25
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 22 - Step 4 - $cd_company_rba: File appended successfully."
		
	done

#Start looking for API responses, by cd_company_rba.
	
    IFS=$'\n'
	for line in $(cat $ParamLocalTempFolder/Smart-ProductRobot-Day-APIOutput.ok)
	do
		nm_api_output_json=`echo $line | cut -d"|" -f2`
        cd_company_rba=`echo $line | cut -d"|" -f1`
			
		#Procedure 22 - Step 5: Collect JSON file created by the Product Robot API.
		generate_log "Procedure 22 - Step 5 - $cd_company_rba: Collect JSON file created by the Product Robot API."
			cd_interface="p022.s005"; ds_interface="Procedure 22: Run Cross Reference Robot API by retail customer. | Step 5: Collect JSON file created by the Product Robot API."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamAWSS3OutputFolder/$nm_api_output_json"; ds_path_output="$ParamLocalTempFolder/"
			date_start_processing=`date +"%Y-%m-%d %T"`
				for i in `seq $ParamProductRobotAPICheckTimes` 
				do
					gsutil -q -m cp $ParamAWSS3OutputFolder/$nm_api_output_json $ParamLocalTempFolder/
					cd_exit=$?
					date_end_processing=`date +"%Y-%m-%d %T"`
					nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
					if [ $cd_exit -ne 0 ]
						then
							generate_log "Procedure 22 - Step 5 - $cd_company_rba: API still running or not finished successfully."
						else
							generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
							generate_log "Procedure 22 - Step 5 - $cd_company_rba: File collected successfully."						
							break
					fi
					if [ $i -eq $ParamProductRobotAPICheckTimes ]
						then
							generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
							generate_log "Procedure 22 - Step 5 - $cd_company_rba: Transfer error. Please check if API is available or contact your administrator."; 
							exit_sh 26; exit 26
					fi
					sleep $ParamProductRobotAPICheckSleep
				done
		
		#Procedure 22 - Step 6: Append $cd_company_rba file content to a consolidated file.
		generate_log "Procedure 22 - Step 6 - $cd_company_rba: Append content to a consolidated file."
			cd_interface="p022.s006"; ds_interface="Procedure 22: Run Cross Reference Robot API by retail customer. | Step 6: Append content to a consolidated file."; cd_start_by="cat"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/$nm_api_output_json"; ds_path_output="$ParamLocalTempFolder/Smart-ProductRobot-Day-APIOutput.json"
			date_start_processing=`date +"%Y-%m-%d %T"`
				cat $ParamLocalTempFolder/$nm_api_output_json | tr -d "\n" | sed G >> $ParamLocalTempFolder/Smart-ProductRobot-Day-APIOutput.json
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 22 - Step 6 - $cd_company_rba: Filesystem error. Please check if filesystem is full or contact your administrator."; 
					exit_sh 27; exit 27
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 22 - Step 6 - $cd_company_rba: File appended successfully."
			
		#Procedure 22 - Step 7: Remove $cd_company_rba JSON file created by the Product Robot API.
		generate_log "Procedure 22 - Step 7 - $cd_company_rba: Remove JSON file created by the Product Robot API."
			cd_interface="p022.s007"; ds_interface="Procedure 22: Run Cross Reference Robot API by retail customer. | Step 7: Remove JSON file created by the Product Robot API."; cd_start_by="rm"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/$nm_api_output_json"; ds_path_output=""
			date_start_processing=`date +"%Y-%m-%d %T"`
			rm -f $ParamLocalTempFolder/$nm_api_output_json
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 22 - Step 7 - $cd_company_rba: Filesystem error. Please check if filesystem is full or contact your administrator."; 
					exit_sh 28; exit 28
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 22 - Step 7 - $cd_company_rba: File removed successfully."
		
	done

	#Procedure 22 - Step 8: Converts consolidated JSON file to a JSONL file.
	generate_log "Procedure 22 - Step 8: Converts consolidated JSON file to a JSONL file."
		cd_interface="p022.s008"; ds_interface="Procedure 22: Run Cross Reference Robot API by retail customer. | Step 8: Converts consolidated JSON file to a JSONL file."; cd_start_by="sed"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/Smart-ProductRobot-Day-APIOutput.json"; ds_path_output=""
		date_start_processing=`date +"%Y-%m-%d %T"`
			sed -i '/^$/d' $ParamLocalTempFolder/Smart-ProductRobot-Day-APIOutput.json
		cd_exit=$?
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
		if [ $cd_exit -ne 0 ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
				generate_log "Procedure 22 - Step 8: Filesystem error. Please check if filesystem is full or contact your administrator."; 
				exit_sh 29; exit 29
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 22 - Step 8: File converted successfully."

	#Procedure 22 - Step 9: Compress consolidated JSONL file.
	generate_log "Procedure 22 - Step 9: Compress consolidated JSONL file."
		cd_interface="p022.s009"; ds_interface="Procedure 22: Run Cross Reference Robot API by retail customer. | Step 9: Compress consolidated JSONL file."; cd_start_by="zip"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/CAD_PRDR_"$LOAD_CONTROL".zip"; ds_path_output="$ParamLocalTempFolder/Smart-ProductRobot-Day-APIOutput.json"
		date_start_processing=`date +"%Y-%m-%d %T"`
			zip -q -m $ParamLocalTempFolder/CAD_PRDR_"$LOAD_CONTROL".zip $ParamLocalTempFolder/Smart-ProductRobot-Day-APIOutput.json
		cd_exit=$?
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
		if [ $cd_exit -ne 0 ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
				generate_log "Procedure 22 - Step 9: Filesystem error. Please check if filesystem is full or contact your administrator."; 
				exit_sh 30; exit 30
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 22 - Step 9: File converted successfully."

	#Procedure 22 - Step 10: Move compressed JSONL file to Cloud Storage.
	generate_log "Procedure 22 - Step 10: Move compressed JSONL file to Cloud Storage."
		cd_interface="p022.s010"; ds_interface="Procedure 22: Run Cross Reference Robot API by retail customer. | Step 10: Move compressed JSONL file to Cloud Storage."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/CAD_PRDR_"$LOAD_CONTROL".zip"; ds_path_output="$ParamCloudSourceFolder/rba/$date_reference_d1/"
		date_start_processing=`date +"%Y-%m-%d %T"`
			gsutil -q -m mv $ParamLocalTempFolder/CAD_PRDR_"$LOAD_CONTROL".zip $ParamCloudSourceFolder/rba/$date_reference_d1/
		cd_exit=$?
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
		if [ $cd_exit -ne 0 ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
				generate_log "Procedure 22 - Step 10: Filesystem error. Please check if filesystem is full or contact your administrator."; 
				exit_sh 31; exit 31
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 22 - Step 10: File moved successfully."
		
generate_log "Procedure 22: Cross Reference Robot API by retail customer ran successfully."

#Procedure 23: Merge Robot API responses to the Product Robot table.
generate_log "Procedure 23: Merge Robot API responses to the Product Robot table."
	
	#Procedure 23 - Step 1: Clean local input folder to receive the new files to be processed.
	generate_log "Procedure 23 - Step 1: Clean local input folder to receive the new files to be processed."
        cd_interface="p023.s001"; ds_interface="Procedure 23: Merge Robot API responses to the Product Robot table. | Step 1: Clean local input folder to receive the new files to be processed."; cd_start_by="rm"; ds_object_system=""; ds_path_input=""$ParamLocalInputFolder"/CAD_PRDR_*"; ds_path_output=""
        date_start_processing=`date +"%Y-%m-%d %T"`
			rm -f $ParamLocalInputFolder/CAD_PRDR_*.zip
		cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 23 - Step 1: GCP error. Please check if GCP is available or contact your administrator."
                exit_sh 32; exit 32
        fi
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 23 - Step 1: Local input folder to receive the new files to be processed was cleaned successfully."

	#Procedure 23 - Step 2: Clean local processing folder to receive the new files to be processed.
	generate_log "Procedure 23 - Step 2: Clean local processing folder to receive the new files to be processed."
        cd_interface="p023.s002"; ds_interface="Procedure 23: Merge Robot API responses to the Product Robot table. | Step 2: Clean local processing folder to receive the new files to be processed."; cd_start_by="rm"; ds_object_system=""; ds_path_input="$ParamLocalProcessingFolder/FINAL_CAD_PRDR_*"; ds_path_output=""
        date_start_processing=`date +"%Y-%m-%d %T"`
			rm -f $ParamLocalProcessingFolder/FINAL_CAD_PRDR_*.json
		cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 23 - Step 2: GCP error. Please check if GCP is available or contact your administrator."
                exit_sh 33; exit 33
        fi
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 23 - Step 2: Local processing folder to receive the new files to be processed were cleaned successfully."

	#Procedure 23 - Step 3: Clean cloud processing folder to receive the new files to be processed.
	generate_log "Procedure 23 - Step 3: Clean cloud processing folder to receive the new files to be processed."
        cd_interface="p023.s003"; ds_interface="Procedure 23: Merge Robot API responses to the Product Robot table. | Step 3: Clean cloud processing folder to receive the new files to be processed."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamCloudProcessingFolder/FINAL_CAD_PRDR_*"; ds_path_output=""
        date_start_processing=`date +"%Y-%m-%d %T"`
			file_count=`gsutil -q -m ls $ParamCloudProcessingFolder/FINAL_CAD_PRDR_* | wc -l`
        if [ $? -ne 0 ] || [ $file_count -lt 1 ]
	        then
                date_end_processing=`date +"%Y-%m-%d %T"`
                nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 23 - Step 3: Cloud processing folder is already empty and does not need to be cleaned."
	    else
                gsutil -q -m rm $ParamCloudProcessingFolder/FINAL_CAD_PRDR_*
            cd_exit=$?
            date_end_processing=`date +"%Y-%m-%d %T"`
            nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
            if [ $cd_exit -ne 0 ]
                then
                    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                    generate_log "Procedure 23 - Step 3: GCP error. Please check if GCP is available or contact your administrator."
                    exit_sh 34; exit 34
            fi
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 23 - Step 3: Cloud processing folder to receive the new files to be processed were cleaned successfully."
        fi

	#Procedure 23 - Step 4: Copy daily files from cloud source folder to local input folder to be processed.
	generate_log "Procedure 23 - Step 4: Copy daily files from cloud source folder to local input folder to be processed."
        cd_interface="p023.s004"; ds_interface="Procedure 23: Merge Robot API responses to the Product Robot table. | Step 4:  Copy daily files from cloud source folder to local input folder to be processed."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamCloudSourceFolder/rba/$date_reference_d1/CAD_PRDR_$LOAD_CONTROL.zip"; ds_path_output="$ParamLocalInputFolder"
        date_start_processing=`date +"%Y-%m-%d %T"`
			gsutil -m cp $ParamCloudSourceFolder/rba/$date_reference_d1/CAD_PRDR_$LOAD_CONTROL.zip $ParamLocalInputFolder/
		cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 23 - Step 4 GCP error. Please check if GCP is available or contact your administrator."
                exit_sh 35; exit 35
        fi
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 23 - Step 4: Daily files from cloud source folder to local input folder to be processed were copied successfully."

	#Procedure 23 - Step 5: Unzip local input files to local processing folder and enrich with source file name and record line number.
	generate_log "Procedure 23 - Step 5: Unzip local input files to local processing folder and enrich with source file name and record line number."
        cd_interface="p023.s005"; ds_interface="Procedure 23: Merge Robot API responses to the Product Robot table. | Step 5: Unzip local input files to local processing folder and enrich with source file name and record line number."; cd_start_by="unzip"; ds_object_system=""; ds_path_input="$ParamLocalInputFolder/$nm_file.zip"; ds_path_output="$ParamLocalProcessingFolder/FINAL_"$nm_file".json"
        date_start_processing=`date +"%Y-%m-%d %T"`
			nm_file=`ls $ParamLocalInputFolder/CAD_PRDR_*.zip | rev | cut -d"/" -f1 | cut -d"." -f2 | rev`
			unzip -p $ParamLocalInputFolder/$nm_file.zip | sed 's/^{//' | nl -s"\"," | sed 's/^/&{"file":"'$nm_file.zip'","line":"/' > $ParamLocalProcessingFolder/FINAL_"$nm_file".json
		cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 23 - Step 5: GCP error. Please check if GCP is available or contact your administrator."
                exit_sh 36; exit 36
        fi
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 23 - Step 5: Local input files to local processing folder were unziped and enriched with source file name and record line number successfully."

	#Procedure 23 - Step 6: Move daily enriched files from local processing folder to cloud processing folder to be processed.
	generate_log "Procedure 23 - Step 6: Move daily enriched files from local processing folder to cloud processing folder to be processed."
        cd_interface="p023.s006"; ds_interface="Procedure 23: Merge Robot API responses to the Product Robot table. | Step 6: Move daily enriched files from local processing folder to cloud processing folder to be processed."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalProcessingFolder/FINAL_CAD_PRDR_"$LOAD_CONTROL".json"; ds_path_output="$ParamCloudProcessingFolder/"
        date_start_processing=`date +"%Y-%m-%d %T"`
			gsutil -m mv $ParamLocalProcessingFolder/FINAL_"$nm_file".json $ParamCloudProcessingFolder/
		cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 23 - Step 6: GCP error. Please check if GCP is available or contact your administrator."
                exit_sh 37; exit 37
        fi
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 23 - Step 6: Daily enriched files from local processing folder to cloud processing folder to be processed were moved successfully."

	#Procedure 23 - Step 7: Replace daily product robot table with the daily product robot contents.
	generate_log "Procedure 23 - Step 7: Replace daily product robot table with the daily product robot contents."
        cd_interface="p023.s007"; ds_interface="Procedure 23: Merge Robot API responses to the Product Robot table. | Step 7: Replace daily product robot table with the daily product robot contents."; cd_start_by="bq"; ds_object_system="$ParamLocalLoadFolder/rba/$ParamBQTableDayProductRobot.sql"; ds_path_input="$ParamLocalLoadFolder/rba/$ParamBQTableDayProductRobot.sql"; ds_path_output=""$ParamBQDataSet"_rba.$ParamBQTableDayProductRobot"
        date_start_processing=`date +"%Y-%m-%d %T"`
			bq query --replace --destination_table "$ParamBQDataSet"_rba."$ParamBQTableDayProductRobot" --use_legacy_sql=false "$(cat $ParamLocalUDFFolder/fnc_rpl_field_format.sql)" "$(cat $ParamLocalLoadFolder/rba/$ParamBQTableDayProductRobot.sql)"
		cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 23 - Step 7: GCP error. Please check if GCP is available or contact your administrator."
                exit_sh 38; exit 38
        fi
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 23 - Step 7: Daily product robot table with the daily product robot contents replaced successfully."

	#Procedure 23 - Step 8: Merge daily product robot table with history product robot table.
	generate_log "Procedure 23 - Step 8: Merge daily product robot table with history product robot table."
        cd_interface="p023.s008"; ds_interface="Procedure 23: Merge Robot API responses to the Product Robot table. | Step 8: Merge daily product robot table with history product robot table."; cd_start_by="bq"; ds_object_system="$ParamLocalLoadFolder/rba/$ParamBQTableHisProductRobot.sql"; ds_path_input="$ParamLocalLoadFolder/rba/$ParamBQTableHisProductRobot.sql"; ds_path_output=""
        date_start_processing=`date +"%Y-%m-%d %T"`
			bq query --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/rba/$ParamBQTableHisProductRobot.sql)"
        cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 23 - Step 8: GCP error. Please check if GCP is available or contact your administrator."
                exit_sh 39; exit 39
        fi
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 23 - Step 8: Daily product robot table merged with history product robot table successfully."

generate_log "Procedure 23: Robot API responses to the Product Robot table merged successfully"

#Procedure 24: Move product robot files to GCS processed folder.
	generate_log "Procedure 24: Move product robot files to GCS processed folder"
	
	#Procedure 24 - Step 1: Move product robot files to GCS processed folder.
	generate_log "Procedure 24 - Step 1: Move product robot files to GCS processed folder."
		cd_interface="p024.s001"; ds_interface="Procedure 24: Move product robot files to GCS processed folder. | Step 1: Move product robot files to GCS processed folder."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamCloudSourceFolder/rba/$date_reference_d1/*.zip"; ds_path_output="$ParamCloudProcessedFolder/$Day/"
		date_start_processing=`date +"%Y-%m-%d %T"`
			gsutil -m mv $ParamCloudSourceFolder/rba/$date_reference_d1/*.zip $ParamCloudProcessedFolder/rba/$date_reference_d1/
				cd_exit=$?
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
		if [ $cd_exit -ne 0 ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
				generate_log "Procedure 24 - Step 1: GCP error. Please check if GCP is available or contact your administrator."
				exit_sh 40; exit 40
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 24 - Step 1: Product robot files moved to GCS processed folder successfully."

generate_log "Procedure 24: Product robot files moved to GCS processed folder successfully"

#-------------------------------------------------------ROBO DE CLIENTES------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#Procedure 25: Extracts customers from SellOut by retail customer.
generate_log "Procedure 25: Extracts customers from SellOut by retail customer."

	#Procedure 25 - Step 1: Clean cloud input S3 folder to receive the new file to be processed.
	generate_log "Procedure 25 - Step 1: Clean cloud input S3 folder to receive the new file to be processed."
        cd_interface="p025.s001"; ds_interface="Procedure 25: Extracts data of Sellin. | Step 1: Clean cloud input S3 folder to receive the new file to be processed."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamAWSS3InputFolder/cr_*.csv"; ds_path_output=""
        date_start_processing=`date +"%Y-%m-%d %T"`
			file_count=`gsutil -q -m ls $ParamAWSS3InputFolder/cr_*.csv | wc -l`
        if [ $? -ne 0 ] || [ $file_count -lt 1 ]
	        then
                date_end_processing=`date +"%Y-%m-%d %T"`
                nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 25 - Step 1: Cloud input S3 folder is already empty and does not need to be cleaned."
	    else
                gsutil -q -m rm $ParamAWSS3InputFolder/cr_*.csv
            cd_exit=$?
            date_end_processing=`date +"%Y-%m-%d %T"`
            nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
            if [ $cd_exit -ne 0 ]
                then
                    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                    generate_log "Procedure 25 - Step 1: GCP error. Please check if GCP is available or contact your administrator."
                    exit_sh 52; exit 52
            fi
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 25 - Step 1: Cloud input S3 folder to receive the new file to be processed was cleaned successfully."
        fi

	IFS=$'\n'
	for cd_company_rba in $(bq --headless --quiet query -n 10000 --use_legacy_sql=false "select distinct cd_company_rba from "$ParamBQDataSet"_rba.$ParamBQViewCustomerRobot" | head -n-1 | tail -n+4 | cut -d"|" -f2 | sed 's/ //g')
    do
		#Procedure 25 - Step 2: Create temp table with customer robot transaction.
		generate_log "Procedure 25 - Step 2 - $cd_company_rba: Create temp table with customer robot transaction."
			cd_interface="p025.s002"; ds_interface="Procedure 25: Extracts customers from SellOut by retail customer. | Step 2: Create temp table with customer robot transaction."; cd_start_by="bq"; ds_object_system=""; ds_path_input=""$ParamBQDataSet"_rba.$ParamBQViewCustomerRobot"; ds_path_output=""$ParamBQDataSet"_tmp."$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba""
			date_start_processing=`date +"%Y-%m-%d %T"`
					bq --headless --quiet query --replace --destination_table "$ParamBQDataSet"_tmp."$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba" --use_legacy_sql=false "SELECT SAFE_CAST( r_cnpj AS STRING ) r_cnpj, SAFE_CAST( nm_local_store_name AS STRING ) nm_local_store_name, SAFE_CAST( ds_retail AS STRING ) ds_retail, SAFE_CAST( ds_banner AS STRING ) ds_banner, SAFE_CAST( r_razao_social AS STRING ) r_razao_social, SAFE_CAST( r_endereco_logradouro AS STRING ) r_endereco_logradouro, SAFE_CAST( r_endereco_numero AS STRING ) r_endereco_numero, SAFE_CAST( r_endereco_complemento AS STRING ) r_endereco_complemento, SAFE_CAST( r_endereco_bairro AS STRING ) r_endereco_bairro, SAFE_CAST( r_endereco_cidade AS STRING ) r_endereco_cidade, SAFE_CAST( r_endereco_uf AS STRING ) r_endereco_uf, SAFE_CAST( ds_uf AS STRING ) ds_uf, SAFE_CAST( r_endereco_cep AS STRING ) r_endereco_cep, SAFE_CAST( r_endereco_pais AS STRING ) r_endereco_pais, SAFE_CAST( r_qsa_socio_nome_00 AS STRING ) r_qsa_socio_nome_00, SAFE_CAST( r_qsa_socio_nome_01 AS STRING ) r_qsa_socio_nome_01, SAFE_CAST( r_qsa_socio_nome_02 AS STRING ) r_qsa_socio_nome_02, SAFE_CAST( r_qsa_socio_nome_03 AS STRING ) r_qsa_socio_nome_03, SAFE_CAST( r_qsa_socio_nome_04 AS STRING ) r_qsa_socio_nome_04, SAFE_CAST( r_qsa_socio_nome_05 AS STRING ) r_qsa_socio_nome_05, SAFE_CAST( r_qsa_socio_nome_06 AS STRING ) r_qsa_socio_nome_06, SAFE_CAST( r_qsa_socio_nome_07 AS STRING ) r_qsa_socio_nome_07, SAFE_CAST( r_qsa_socio_nome_08 AS STRING ) r_qsa_socio_nome_08, SAFE_CAST( r_qsa_socio_nome_09 AS STRING ) r_qsa_socio_nome_09, SAFE_CAST( r_qsa_socio_nome_10 AS STRING ) r_qsa_socio_nome_10, SAFE_CAST( r_qsa_socio_nome_11 AS STRING ) r_qsa_socio_nome_11, SAFE_CAST( r_qsa_socio_nome_12 AS STRING ) r_qsa_socio_nome_12, SAFE_CAST( r_qsa_socio_nome_13 AS STRING ) r_qsa_socio_nome_13, SAFE_CAST( r_qsa_socio_nome_14 AS STRING ) r_qsa_socio_nome_14, SAFE_CAST( r_qsa_socio_nome_15 AS STRING ) r_qsa_socio_nome_15, SAFE_CAST( ds_region_store_01 AS STRING ) ds_region_store_01, SAFE_CAST( cd_dc_supplier AS STRING ) cd_dc_supplier, SAFE_CAST( nr_dc_supplier_registered_number AS STRING ) nr_dc_supplier_registered_number, SAFE_CAST( nm_dc_supplier_name AS STRING ) nm_dc_supplier_name, SAFE_CAST( cd_customer_unique_dtr AS STRING ) cd_customer_unique_dtr, SAFE_CAST( cd_customer_unique_cpg AS STRING ) cd_customer_unique_cpg, SAFE_CAST( cd_movement_channel AS STRING ) cd_movement_channel, SAFE_CAST( ds_movement_channel AS STRING ) ds_movement_channel, SAFE_CAST( nr_product_ean_cpg AS STRING ) nr_product_ean_cpg, SAFE_CAST( SUM(qt_sale_un) AS STRING ) qt_sale_un FROM "$ParamBQDataSet"_rba.$ParamBQViewCustomerRobot where cd_company_rba = '$cd_company_rba' GROUP BY r_cnpj, nm_local_store_name, ds_retail, ds_banner, r_razao_social, r_endereco_logradouro, r_endereco_numero, r_endereco_complemento, r_endereco_bairro, r_endereco_cidade, r_endereco_uf, ds_uf, r_endereco_cep, r_endereco_pais, r_qsa_socio_nome_00, r_qsa_socio_nome_01, r_qsa_socio_nome_02, r_qsa_socio_nome_03, r_qsa_socio_nome_04, r_qsa_socio_nome_05, r_qsa_socio_nome_06, r_qsa_socio_nome_07, r_qsa_socio_nome_08, r_qsa_socio_nome_09, r_qsa_socio_nome_10, r_qsa_socio_nome_11, r_qsa_socio_nome_12, r_qsa_socio_nome_13, r_qsa_socio_nome_14, r_qsa_socio_nome_15, ds_region_store_01, cd_dc_supplier, nr_dc_supplier_registered_number, nm_dc_supplier_name, cd_customer_unique_dtr, cd_customer_unique_cpg, cd_movement_channel, ds_movement_channel, nr_product_ean_cpg"
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``	
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 25 - Step 2 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 52; exit 52
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 25 - Step 2 - $cd_company_rba: Temp table with customer robot transaction created successfully."
		
		#Procedure 25 - Step 3: Run query to extract customers from transactions.
		generate_log "Procedure 25 - Step 3 - $cd_company_rba: Run query to extract customers from transactions."
			cd_interface="p025.s003"; ds_interface="Procedure 25: Extracts customers from SellOut by retail customer. | Step 3: Run query to extract customers from transactions."; cd_start_by="bq"; ds_object_system=""; ds_path_input=""$ParamBQDataSet"_tmp."$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba""; ds_path_output="$ParamCloudTempFolder/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"_$LOAD_CONTROL.txt.gz"
			date_start_processing=`date +"%Y-%m-%d %T"`
					bq --headless --quiet extract --destination_format CSV --compression GZIP --field_delimiter ';' --noprint_header ""$ParamBQDataSet"_tmp."$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"" $ParamCloudTempFolder/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"_$LOAD_CONTROL.txt.gz
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 25 - Step 3 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 52; exit 52
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 25 - Step 3 - $cd_company_rba: Query to extract customers from transactions ran successfully."
		
		#Procedure 25 - Step 4: Move customer transaction files from GCS to local folder.
		generate_log "Procedure 25 - Step 4 - $cd_company_rba: Move customer transaction files from GCS to local folder."
			cd_interface="p025.s004"; ds_interface="Procedure 25: Extracts customers from SellOut by retail customer. | Step 4: Move customer transaction files from GCS to local folder."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamCloudTempFolder/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"_$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamLocalTempFolder"
			date_start_processing=`date +"%Y-%m-%d %T"`
				gsutil -q -m mv $ParamCloudTempFolder/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"_*.txt.gz $ParamLocalTempFolder/
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 25 - Step 4 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 52; exit 52
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 25 - Step 4 - $cd_company_rba: Customer transaction files from GCS moved to local folder successfully."
			
		#Procedure 25 - Step 5: Add header and rename the extracted customer file.
		generate_log "Procedure 25 - Step 5 - $cd_company_rba: Add header and rename the extracted customer file."
			cd_interface="p025.s005"; ds_interface="Procedure 25: Extracts customers from SellOut by retail customer. | Step 5: Add header and rename the extracted customer file."; cd_start_by="gzip"; ds_object_system=""; ds_path_input="$ParamLocalParameterFolder/"$ParamBQTableTmpTRSCustomerRobot"-HEADER.txt"; ds_path_output=""$ParamLocalTempFolder"/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz"
			date_start_processing=`date +"%Y-%m-%d %T"`
				gzip -q -c $ParamLocalParameterFolder/"$ParamBQTableTmpTRSCustomerRobot"-HEADER.txt > $ParamLocalTempFolder/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 25 - Step 5 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 52; exit 52
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 25 - Step 5 - $cd_company_rba: Header added and the extracted customer file renamed successfully."
			
		#Procedure 25 - Step 6: Concatenate customer robot transaction files to final file.
		generate_log "Procedure 25 - Step 6 - $cd_company_rba: Concatenate customer robot transaction files to final file."
			cd_interface="p025.s006"; ds_interface="Procedure 25: Extracts customers from SellOut by retail customer. | Step 6: Concatenate customer robot transaction files to final file."; cd_start_by="cat"; ds_object_system=""; ds_path_input=""$ParamLocalTempFolder"/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"_$LOAD_CONTROL.txt.gz"; ds_path_output=""$ParamLocalTempFolder"/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz"
			date_start_processing=`date +"%Y-%m-%d %T"`
				cat $ParamLocalTempFolder/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"_*.txt.gz >> $ParamLocalTempFolder/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 25 - Step 6 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 52; exit 52
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 25 - Step 6 - $cd_company_rba: Customer robot transaction files concatenated to final file successfully."
			
		#Procedure 25 - Step 7: Remove customer transaction files from local folder.
		generate_log "Procedure 25 - Step 7 - $cd_company_rba: Remove customer transaction files from local folder."
			cd_interface="p025.s007"; ds_interface="Procedure 25: Extracts customers from SellOut by retail customer. | Step 7: Remove customer transaction files from local folder."; cd_start_by="rm"; ds_object_system=""; ds_path_input=""$ParamLocalTempFolder"/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"_$LOAD_CONTROL.txt.gz"; ds_path_output=""
			date_start_processing=`date +"%Y-%m-%d %T"`
				rm -f $ParamLocalTempFolder/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"_*.txt.gz
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 25 - Step 7 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 52; exit 52
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 25 - Step 7 - $cd_company_rba: Customer transaction files removed from local folder successfully."
			
		#Procedure 25 - Step 8: Generate uncompressed csv input file.
		generate_log "Procedure 25 - Step 8 - $cd_company_rba: Generate uncompressed csv input file."
			cd_interface="p025.s008"; ds_interface="Procedure 25: Extracts customers from SellOut by retail customer. | Step 8: Generate uncompressed csv input file."; cd_start_by="gunzip"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamLocalTempFolder/cr_"$cd_company_rba"_"$LOAD_CONTROL".csv"
			date_start_processing=`date +"%Y-%m-%d %T"`
				gunzip -q -c $ParamLocalTempFolder/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz > $ParamLocalTempFolder/cr_"$cd_company_rba"_"$LOAD_CONTROL".csv
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 25 - Step 8 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 52; exit 52
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 25 - Step 8 - $cd_company_rba: Uncompressed csv input file generated successfully."
			
		#Procedure 25 - Step 9: Move uncompressed csv input file to AWS S3.
		generate_log "Procedure 25 - Step 9 - $cd_company_rba: Move uncompressed csv input file to AWS S3."
			cd_interface="p025.s009"; ds_interface="Procedure 25: Extracts customers from SellOut by retail customer. | Step 9: Move uncompressed csv input file to AWS S3."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/cr_"$cd_company_rba"_"$LOAD_CONTROL".csv"; ds_path_output="$ParamAWSS3InputFolder/"
			date_start_processing=`date +"%Y-%m-%d %T"`
				gsutil -q -m mv $ParamLocalTempFolder/cr_"$cd_company_rba"_"$LOAD_CONTROL".csv $ParamAWSS3InputFolder/
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 25 - Step 9 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 52; exit 52
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 25 - Step 9 - $cd_company_rba: Uncompressed csv input file moved to AWS S3 successfully."

		#Procedure 25 - Step 10: Move final customer robot transaction file to GCS.
		generate_log "Procedure 25 - Step 10 - $cd_company_rba: Move final customer robot transaction file to GCS."
			cd_interface="p025.s010"; ds_interface="Procedure 25: Extracts customers from SellOut by retail customer. | Step 10: Move final customer robot transaction file to GCS."; cd_start_by="gsutil"; ds_object_system=""; ds_path_input="$ParamLocalTempFolder/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz"; ds_path_output="$ParamCloudOutputFolder/rba/$date_reference_d1/"
			date_start_processing=`date +"%Y-%m-%d %T"`
				gsutil -q -m mv $ParamLocalTempFolder/"$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"-$LOAD_CONTROL.txt.gz $ParamCloudOutputFolder/rba/$date_reference_d1/
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 25 - Step 10 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 52; exit 52
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 25 - Step 10 - $cd_company_rba: Final customer robot transaction file moved to GCS successfully."			

		#Procedure 25 - Step 11: Remove temp table with customer robot transaction.
		generate_log "Procedure 25 - Step 11 - $cd_company_rba: Remove temp table with customer robot transaction."
			cd_interface="p025.s011"; ds_interface="Procedure 25: Extracts customers from SellOut by retail customer. | Step 11: Remove temp table with customer robot transaction."; cd_start_by="bq"; ds_object_system=""; ds_path_input=""$ParamBQDataSet"_tmp."$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba""; ds_path_output=""
			date_start_processing=`date +"%Y-%m-%d %T"`
				bq --headless --quiet rm -f "$ParamBQDataSet"_tmp."$ParamBQTableTmpTRSCustomerRobot"_"$cd_company_rba"
			cd_exit=$?
			date_end_processing=`date +"%Y-%m-%d %T"`
			nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
			if [ $cd_exit -ne 0 ]
				then
					generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
					generate_log "Procedure 25 - Step 11 - $cd_company_rba: GCP error. Please check if GCP is available or contact your administrator."
					exit_sh 52; exit 52
			fi
			generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 25 - Step 11 - $cd_company_rba: Temp table with customer robot transaction removed successfully."
			
	done
generate_log "Procedure 25: Customers from SellOut by retail customer extracted successfully"

#Procedure 26: Run Cross Reference Robot API.
generate_log "Procedure 26: Run Cross Reference Robot API."

	#Check if there is Pharma to process
		nPharma=$(bq query -q --use_legacy_sql=false "SELECT count(*) FROM "$ParamBQDataSet"_rba.$ParamBQViewCustomerRobot where cd_movement_channel = '3'" | head -n-1 | tail -n+4 | cut -d"|" -f2 )
	
	#Switch to account with resizing permission  
		sudo gcloud config set account 722878179669-compute@developer.gserviceaccount.com

	#Adjusts the VM's capacity to 32vCPU
		if [ $nPharma -gt 0 ]
			then
				sudo gcloud compute instances set-machine-type prd-wdu-sba-clientrobot-new --machine-type e2-standard-32 --zone us-central1-a
				generate_log "Procedure 26: VM's capacity adjusted to 32vCPU."
		fi

	#Turn On the Customer Robot's VM
		sudo gcloud compute instances start "prd-wdu-sba-clientrobot-new" --zone="us-central1-a" --project="prd-wdu-sba-001-277701"

	#Switch to project service account
		sudo gcloud -q auth activate-service-account --key-file "$ParamLocalFolder/key/$ParamBQDataSet-integration@prd-wdu-sba-001-277701.key.json"

	#Wait 2 minutes to turn on VM
		sleep 120

	#Counts the number of files to send to API.
	nCustomersFiles=`gsutil -q -m ls $ParamAWSS3InputFolder/itg_*.csv | wc -l`
	nSellOutFiles=`gsutil -q -m ls $ParamAWSS3InputFolder/cr_*.csv | wc -l`
	nfiles=$(($nCustomersFiles + $nSellOutFiles))
	
	#Procedure 26 - Step 1: Authenticate to use the Customer Robot API.
	generate_log "Procedure 26 - Step 1: Authenticate to use the Customer Robot API."
        cd_interface="p026.s001"; ds_interface="Procedure 26: Run Cross Reference Robot API. | Step 1: Authenticate to use the Customer Robot API."; cd_start_by="curl"; ds_object_system=""; ds_path_input="/tmp/cookies"; ds_path_output=""
        date_start_processing=`date +"%Y-%m-%d %T"`
			bearer=`curl -c /tmp/cookies --request GET --url "$ParamCustomerRobotAPIURL/auth/login?email=$ParamCustomerRobotAPIUser&password=$ParamCustomerRobotAPIPassword" | cut -d"," -f2 | cut -d":" -f2 | cut -d"\"" -f2`
		cd_exit=$?
        date_end_processing=`date +"%Y-%m-%d %T"`
        nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
        if [ $cd_exit -ne 0 ] || [ "$bearer" == 'Login failed.' ]
            then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 26 - Step 1: Authentication error. Please check if API is available or contact your administrator."
                #exit_sh 52; exit 52
        fi
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 26 - Step 1: User authenticated successfully."

	#Procedure 26 - Step 2: Run the Customer Robot API.
	generate_log "Procedure 26 - Step 2: Run the Customer Robot API."
		cd_interface="p026.s002"; ds_interface="Procedure 26: Run Cross Reference Robot API. | Step 2: Run the Customer Robot API."; cd_start_by="curl"; ds_object_system=""; ds_path_input="/tmp/cookies"; ds_path_output=""
		date_start_processing=`date +"%Y-%m-%d %T"`
			api_output=`curl -b /tmp/cookies --request POST --url $ParamCustomerRobotAPIURL/api/load_robo --header "Authorization: Bearer $bearer" --header 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' --data-urlencode 'nfiles=$nfiles' | cut -d"," -f6 | cut -d":" -f2 | cut -d"\"" -f2`
		cd_exit=$?
		date_end_processing=`date +"%Y-%m-%d %T"`
		nr_load_control_interface=``; qt_read_records=``; qt_load_records=``; qt_rejected_records=``
		if [ $cd_exit -ne 0 ] || [ "$api_output" != 'Data has been received and is being processed!' ]
			then
				generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
				generate_log "Procedure 26 - Step 2: API error. Please check if API is available or contact your administrator."; 
				#exit_sh 52; exit 52
		fi
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	generate_log "Procedure 26 - Step 2: API ran successfully."
		
generate_log "Procedure 26: Cross Reference Robot API ran successfully for $nfiles file(s)."

#-------------------------------------------------------FIM - ROBO DE CLIENTES------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------- EXTRACTION FALCON ------------------------------------------------------------------------
#Procedure 27 - Step 1: Run extract files Falcon.
generate_log "Procedure 27 - Step 1: Run extract files Falcon."
cd_interface="p027.s001"; 
ds_interface="Procedure 27: Run extract files Falcon. | Step 1: Extract files Falcon Month."; 
cd_start_by=""; 
ds_object_system=""; 
ds_path_input="/prd-wdu-sba-001/prd-wdu-sba-kcc/script"; 
ds_path_output="/Inbound"
date_start_processing=`date +"%Y-%m-%d %T"`

#processamento mensal	
date_day=`date +"%d"`
if [ $date_day = 15 ]
    then
	cd /prd-wdu-sba-001/prd-wdu-sba-kcc/script/
        /prd-wdu-sba-001/prd-wdu-sba-kcc/script/Smart-ExtractionFalcon.sh M null null
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 27 - Step 1: Monthly files Processed";
        generate_log "Procedure 27 - Step 1: Extract files Falcon Month Finish"
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 27 - Step 1: Today is not a day processed monthly files";
        generate_log "Procedure 27 - Step 1: Extract files Falcon Month Finish"
fi

generate_log "Procedure 27 - Step 2: Run extract files Falcon."
cd_interface="p027.s002"; 
ds_interface="Procedure 27: Run extract files Falcon. | Step 2: Extract files Falcon daily."; 
cd_start_by=""; 
ds_object_system=""; 
ds_path_input="/prd-wdu-sba-001/prd-wdu-sba-kcc/script"; 
ds_path_output="/Inbound"
date_start_processing=`date +"%Y-%m-%d %T"`
	
    #processamento diario
    cd /prd-wdu-sba-001/prd-wdu-sba-kcc/script/
    /prd-wdu-sba-001/prd-wdu-sba-kcc/script/Smart-ExtractionFalcon.sh D null null

cd_exit=$?
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=``; 
qt_read_records=``; 
qt_load_records=``; 
qt_rejected_records=``

if [ $cd_exit -ne 0 ]
    then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 27 - Step 2: Extract error. Please check the script."; 
		#exit_sh 52; exit 52
fi
generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 27 - Step 2: Extract files Falcon daily Finish"
generate_log "Procedure 27: Run extract files Falcon successfully."

#-------------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------- GESTAO DE CATEGORIAS ------------------------------------------------------------------------------------------
#------------------------------------------------- FUNCOES GC ------------------------------------------------------------------------------------------------
#AVISOS:O CODIGO ESTA UM POUCO DIFERENTE DO RESTO DO ORQUESTRADOR.
#POR QUE FOI FEITO DESSA FORMA ? A UTILIZACAO DE FUNCOES PERMITE MAIOR LIBERTADE DE TESTES UNITARIOS
#DURANTE O DESENVOLVIMENTO E O DEPLOY
#POR QUE AS FUNCOES NAO FORAM 'ABERTAS' ? NAO VEJO NECESSIDADE
#POR QUE AS VARIAVEIS 'LOCAIS' DAS FUNCOES FAZEM REFERENCIA A PARAMETROS GLOBAIS DO SCRIPT ?
#DEIXEI DESSA FORMA PRA FACILITAR A LEITURA E DEVIDO A FALTA DE TEMPO PARA CONVERTER TODAS AS
#VARIAVEIS 'LOCAIS' EM PARAMETROS DAS FUNCOES. POREM, O CORRETO SERIA PASSAR COMO PARAMETRO (NA MINHA VISAO)
#AUTOR: GAWAN
#- LOCAIS -----------------------------------------------------------------------------------------------------
clear_csv_folder_gc () {
    rm -f $ParamLocalCSVFolderGC/*
}

clear_excel_gc_moviment () {
    rm -f \
    $ParamLocalExcelStoreFolderGC/* \
    $ParamLocalExcelProductFolderGC/* \
    $ParamLocalExceMovimentFolderGC/*
}

clear_excel_gc_product () {
    rm -f $ParamLocalExcelProductFolderGC/*
}

clear_excel_gc_store () {
    rm -f $ParamLocalExcelStoreFolderGC/*
}

zip_csv_gc () {
    #entra na pasta dos arquivos transformados em csv
    cd $ParamLocalCSVFolderGC
    
    #zip os arquivos transformados
    zip gc_transformados_$Day.zip $ParamLocalCSVFolderGC/*
}


mv_zip_csv_gc_to_processed () {

    #entra na pasta dos arquivos transformados em csv
    cd $ParamLocalCSVFolderGC
    
    #move arquivos zipados para processed do dia
    gsutil mv gc_transformados_$Day.zip $ParamCloudProcessedFolder/GC/$Day/
}


zip_excel_gc () {
    #entra na pasta dos arquivos transformados em csv
    cd $ParamLocalFolderGC
    
    #zip os arquivos transformados
    zip gc_originais_$Day.zip \
    $ParamLocalExcelStoreFolderGC/* \
    $ParamLocalExcelProductFolderGC/* \
    $ParamLocalExceMovimentFolderGC/*
    
}

mv_zip_excel_gc_to_processed () {

    #entra na pasta dos arquivos transformados em csv
    cd $ParamLocalFolderGC
    
    #move arquivos zipados para processed do dia
    gsutil mv gc_originais_$Day.zip $ParamCloudProcessedFolder/GC/$Day/
}

#-------------------------------- FUNCAO - PRODUTOS ------------------------------------------------------

#LIMPA ARQUIVOS DE GC PRODUTOS EM PROCESSING
clear_cloud_processeing_folder_product_gc () {
    gsutil rm -f $ParamCloudProcessingFolder/$ParamFileProductPrefixGC*
}

#MOVE ARQUIVOS DE GC PRODUTOS EM SOURCE/GC/excel_gc_produtos
mv_product_source_to_product_excel_folder_gc () {
    gsutil -m mv $ParamLocalCloudSourceProductFolderGC/* $ParamLocalExcelProductFolderGC
}

#TRANSFORMA EXCEL DE PRODUTOS EM CSV
etl_product_excel_to_csv_gc () {
    cd $ParamLocalScriptFolderGC
    
    source $ParamLocalScriptFolderGC/bin/activate
    
    python3.7 $ParamScriptETLGCProduct
    
    deactivate
}   

#COPIA ARQUIVOS CSV DE GC PRODUTOS PAARA PROCESSING
cp_product_csv_to_processing_gc () {
    
    #entra na pasta dos arquivos transformados em csv
    cd $ParamLocalCSVFolderGC
    #copia para processing
    gsutil -m cp $ParamLocalCSVFolderGC/$ParamFileProductPrefixGC* $ParamCloudProcessingFolder
} 
 

#SUBSSTITUI TABELA DIARIA DE GC PRODUTOS
bq_replace_day_product_gc () {
    bq query --replace --destination_table $ParamBQDataSet.$ParamBQTableDayProductGC \
    --use_legacy_sql=false "$(cat $ParamLocalUDFFolder/*.sql)"\
    "$(cat $ParamLocalLoadFolder/$ParamBQTableDayProductGC.sql)"
}

#APENAS TESTE
bq_rm_his_product_gc () {
    bq rm $ParamBQDataSet.$ParamBQTableHisProductGC;\
} 


#cria a tabela historica - teste
bq_mk_his_product_gc () {
    bq mk \
    --table \
    --description "Tabela historica - Produtos Gestao de Categoria - KCC" \
    --label organization:development \
    $ParamBQDataSet.$ParamBQTableHisProductGC \
    $ParamLocalLoadFolder/$ParamBQTableHisProductGC.json
}
 

#ATUALIZA TABELA HISTORICA DE GC PRODUTOS
bq_update_his_product_gc () {
    bq query --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/$ParamBQTableHisProductGC.sql)"
} 

#--------------------------------- MOVIMENTO ------------------------------------------------------

#LIMPA ARQUIVOS DE GC MOVIMENTO EM PROCESSING
clear_cloud_processeing_folder_movement_gc () {
    gsutil rm -f $ParamCloudProcessingFolder/$ParamFileMovementPrefixGC*
}

#MOVE ARQUIVOS DE GC MOVIMENTO PARA MV
mv_movent_source_to_movement_excel_folder_gc () {
    gsutil -m mv $ParamLocalCloudSourceMovimentFolderGC/* $ParamLocalExceMovimentFolderGC
}

#TRANSFORMA EM CSV ARQUIVOS DE GC MOVIMENTO
etl_movement_excel_to_csv_gc () {
    cd $ParamLocalScriptFolderGC
    
    source $ParamLocalScriptFolderGC/bin/activate
    
    python $ParamScriptETLGCMovement
    
    deactivate
}   



#COPIA ARQUIVOS DE MOVIMENTO PARA PROCESSING
cp_movement_csv_to_processing_gc () {
    
    #entra na pasta dos arquivos transformados em csv
    cd $ParamLocalCSVFolderGC
    #copia para processing
    gsutil -m cp $ParamLocalCSVFolderGC/$ParamFileMovementPrefixGC* $ParamCloudProcessingFolder
} 

#SUBSTITUI A TABELA DIARIA DE GC
bq_replace_day_movement_gc () {
    bq query --replace --destination_table $ParamBQDataSet.$ParamBQTableDayMovimentGC \
    --use_legacy_sql=false "$(cat $ParamLocalUDFFolder/*.sql)"\
    "$(cat $ParamLocalLoadFolder/$ParamBQTableDayMovimentGC.sql)"
}

#remove a tabela historica de gc - caso necessario - teste
bq_rm_his_gc () {
    bq rm $ParamBQDataSet.$ParamBQTableHisMovimentGC;\
} 

#cria a tabela historica - teste
bq_mk_his_gc () {
    bq mk \
    --table \
    --description "Tabela historica - Gestao de Categoria - KCC" \
    --label organization:development \
    $ParamBQDataSet.$ParamBQTableHisMovimentGC \
    $ParamLocalLoadFolder/$ParamBQTableHisMovimentGC.json
}

#COPIA TODA TABELA DAY DE GC PARA HISTORICA (OBS: NAO TEM CHAVE)
bq_cp_day_to_his_gc () {
    bq cp -a $ParamBQDataSet.$ParamBQTableDayMovimentGC $ParamBQDataSet.$ParamBQTableHisMovimentGC
}  

#--------------------------------- LOJAS ------------------------------------------------------
#LIMPA ARQUIVOS DE GC LOJAS EM PROCESSING
clear_cloud_processeing_folder_store_gc () {
    gsutil rm -f $ParamCloudProcessingFolder/$ParamFileStorePrefixGC*
}

#MOVE ARQUIVOS DE GC LOJAS PARA VM 
mv_store_source_to_store_excel_folder_gc () {
    gsutil -m mv $ParamLocalCloudSourceStoreFolderGC/* $ParamLocalExcelStoreFolderGC
}

#TRANSFORMA EM CSV ARQUIVOS DE GC LOJA
etl_store_excel_to_csv_gc () {
    cd $ParamLocalScriptFolderGC
    
    source $ParamLocalScriptFolderGC/bin/activate
    
    python $ParamScriptETLGCStore
    
    deactivate
} 

#COPIA ARQUIVOS DE GC LOJA PARA PROCESSING
cp_store_csv_to_processing_gc () {
    
    #entra na pasta dos arquivos transformados em csv
    cd $ParamLocalCSVFolderGC
    #copia para processing
    gsutil -m cp $ParamLocalCSVFolderGC/$ParamFileStorePrefixGC* $ParamCloudProcessingFolder
} 


#SUBSTITUI TABELA DIARIA GC LOJAS
bq_replace_day_store_gc () {
    bq query --replace --destination_table $ParamBQDataSet.$ParamBQTableDayStoreGC \
    --use_legacy_sql=false "$(cat $ParamLocalUDFFolder/*.sql)"\
    "$(cat $ParamLocalLoadFolder/$ParamBQTableDayStoreGC.sql)"
}

#deleta a tabela historica - teste
bq_rm_his_store_gc () {
    bq rm $ParamBQDataSet.$ParamBQTableHisStoreGC;\
} 


#cria a tabela historica - teste
bq_mk_his_store_gc () {
    bq mk \
    --table \
    --description "Tabela historica - Lojas Gestao de Categoria - KCC" \
    --label organization:development \
    $ParamBQDataSet.$ParamBQTableHisStoreGC \
    $ParamLocalLoadFolder/$ParamBQTableHisStoreGC.json
}
 

#ATUALIZA TABELA HISTORICA DE GC LOJAS
bq_update_his_store_gc () {
    bq query --use_legacy_sql=false "$(cat $ParamLocalLoadFolder/$ParamBQTableHisStoreGC.sql)"
}
   
#ROTINA DE LOJAS - GC
func_rotina_store_gc () {
    qtd_arquivos_gc=$(gsutil ls $ParamLocalCloudSourceStoretFolderGC | wc -l)
    if [ $qtd_arquivos_gc -gt 1 ]
        then
            clear_cloud_processeing_folder_store_gc
            mv_store_source_to_store_excel_folder_gc
            etl_store_excel_to_csv_gc
            cp_store_csv_to_processing_gc
            bq_replace_day_store_gc
            bq_update_his_store_gc
        else 
            echo -e "Sem arquivos para processar"
    fi
}

#ROTINA DE PRODUTO - GC
func_rotina_product_gc () {
    qtd_arquivos_gc=$(gsutil ls $ParamLocalCloudSourceProductFolderGC | wc -l)
    if [ $qtd_arquivos_gc -gt 1 ]
        then
            clear_cloud_processeing_folder_product_gc
            mv_product_source_to_product_excel_folder_gc
            etl_product_excel_to_csv_gc
            cp_product_csv_to_processing_gc
            bq_replace_day_product_gc
            bq_update_his_product_gc
        else 
            echo -e "Sem arquivos para processar"
    fi
}

#ROTINA DE MOVIMENTO - GC
func_rotina_moviment_gc () {
    qtd_arquivos_gc=$(gsutil ls $ParamLocalCloudSourceMovimenetFolderGC | wc -l)
    if [ $qtd_arquivos_gc -gt 1 ]
        then
            clear_cloud_processeing_folder_movement_gc
            mv_movent_source_to_movement_excel_folder_gc
            etl_movement_excel_to_csv_gc
            cp_movement_csv_to_processing_gc
            bq_replace_day_movement_gc
            bq_cp_day_to_his_gc
        else 
            echo -e "Sem arquivos para processar"
    fi
}


#----------------------------------- ORQUESTRACAO GC -------------------------------------

#Procedure 28 - Step 1: Clean local gc folders to receive the new file to be processed.
generate_log "Procedure 28 - Step 1: Clean local gc folders to receive the new file to be processed."
cd_interface="p028.s001"; 
ds_interface="Procedure 28: Collect GC files to be processed. | Step 1: Clean local gc folders to receive the new file to be processed."; 
cd_start_by="rm"; 
ds_object_system=""; 
ds_path_input="$ParamLocalFolderGC"; 
ds_path_output=""

date_start_processing=`date +"%Y-%m-%d %T"`
file_count=``

clear_csv_folder_gc
cd_exit=$?

clear_excel_gc_moviment
cd_exit=$((cd_exit+$?))

if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 11 - Step 1: Folder alredy empty"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 11 - Step 1: Folder clear successfully"
fi

#Procedure 28 - Step 2: Processes GC Store.
generate_log "Procedure 28 - Step 2: Processes GC Store."
cd_interface="p028.s002"; 
ds_interface="Procedure 28: Collect GC files to be processed. | Step 2: Processes GC Store."; 
cd_start_by="rm"; 
ds_object_system=""; 
ds_path_input=""; 
ds_path_output=""

date_start_processing=`date +"%Y-%m-%d %T"`

qtd_arquivos_gc=$(gsutil ls $ParamLocalCloudSourceStoreFolderGC | wc -l)
if [ $qtd_arquivos_gc -gt 1 ]
    then
        clear_cloud_processeing_folder_store_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 3: Processing has no files GC Store"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 3: Processing remove files GC Store successfully"
        fi
        
        mv_store_source_to_store_excel_folder_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 4: Source has no files GC Store"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 4: Source move files GC Store successfully"
        fi
        
        etl_store_excel_to_csv_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 5: Error in ETL process to GC Store files"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 5: ETL process GC Store files successfully"
        fi
        
        cp_store_csv_to_processing_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 6: Error to copy GC Store Files from GC local to Cloud Processing"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 6: Copy GC Store Files from GC local to Cloud Processing successfully"
        fi
        
        bq_replace_day_store_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 7: Error to replace daily GC Store table"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 7: Replace daily GC store table successfully"
        fi
        
        bq_update_his_store_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 8: Error to update history GC Store table"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 8: Update history GC Store table successfully"
        fi
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 28 - Step 2: No files to process"
fi

#------------------------------------- GC PRODUTOS -------------------------------------------------------------------
#Procedure 28 - Step 2: Processes GC Product.
generate_log "Procedure 28 - Step 9: Processes GC Product."
cd_interface="p028.s002"; 
ds_interface="Procedure 28: Collect GC files to be processed. | Step 2: Processes GC Product."; 
cd_start_by="rm"; 
ds_object_system=""; 
ds_path_input=""; 
ds_path_output=""

date_start_processing=`date +"%Y-%m-%d %T"`

qtd_arquivos_gc=$(gsutil ls $ParamLocalCloudSourceProductFolderGC | wc -l)
if [ $qtd_arquivos_gc -gt 1 ]
    then
        clear_cloud_processeing_folder_product_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 10: Processing has no files GC Product"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 10: Processing remove files GC Product successfully"
        fi
        
        mv_product_source_to_product_excel_folder_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 11: Source has no files GC Product"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 11: Source move files GC Product successfully"
        fi
        
        etl_product_excel_to_csv_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 12: Error in ETL process to GC Product files"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 12: ETL process GC Product files successfully"
        fi
        
        cp_product_csv_to_processing_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 13: Error to copy GC Product Files from GC local to Cloud Processing"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 13: Copy GC Product Files from GC local to Cloud Processing successfully"
        fi
        
        bq_replace_day_product_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 14: Error to replace daily GC Product table"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 14: Replace daily GC Product table successfully"
        fi
        
        bq_update_his_product_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 15: Error to update history GC Product table"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 15: Update history GC Product table successfully"
        fi
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 28 - Step 9: No files to process"
fi

#---------------------------------------------GC MOVIMENTO -------------------------------------------------------------
#Procedure 28 - Step 16: Processes GC Moviment.
generate_log "Procedure 28 - Step 16: Processes GC Moviment."
cd_interface="p028.s015"; 
ds_interface="Procedure 28: Collect GC files to be processed. | Step 16: Processes GC Moviment."; 
cd_start_by="rm"; 
ds_object_system=""; 
ds_path_input=""; 
ds_path_output=""

date_start_processing=`date +"%Y-%m-%d %T"`

qtd_arquivos_gc=$(gsutil ls $ParamLocalCloudSourceMovimentFolderGC | wc -l)
if [ $qtd_arquivos_gc -gt 1 ]
    then
        clear_cloud_processeing_folder_movement_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 17: Processing has no files GC Moviment"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 17: Processing remove files GC Moviment successfully"
        fi
        
        mv_movent_source_to_movement_excel_folder_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 18: Source has no files GC Moviment"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 18: Source move files GC Moviment successfully"
        fi
        
        etl_movement_excel_to_csv_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 19: Error in ETL process to GC Moviment files"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 19: ETL process GC Moviment files successfully"
        fi
        
        cp_movement_csv_to_processing_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 20: Error to copy GC Moviment Files from GC local to Cloud Processing"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 20: Copy GC Moviment Files from GC local to Cloud Processing successfully"
        fi
        
        bq_replace_day_movement_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 21: Error to replace daily GC Moviment table"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 21: Replace daily GC Moviment table successfully"
        fi
        
        bq_cp_day_to_his_gc
        cd_exit=$?
        if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 22: Error to copy history GC Moviment table"
        else
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 28 - Step 22: Copy history GC Moviment table successfully"
        fi
    else
        generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
        generate_log "Procedure 28 - Step 16: No files to process"
fi


#----------------------------------------------- BACKUP GC -------------------------------------------------------
#Procedure 28 - Step 23: Processes GC Moviment.
generate_log "Procedure 28 - Step 23: Backup GC Files."
cd_interface="p028.s015"; 
ds_interface="Procedure 28: Collect GC files to be processed. | Step 23: Backup GC Files."; 
cd_start_by="rm"; 
ds_object_system=""; 
ds_path_input=""; 
ds_path_output=""

date_start_processing=`date +"%Y-%m-%d %T"`

#ROTINA BACKUP - CSV
zip_csv_gc
cd_exit=$?
if [ $cd_exit -ne 0 ]
then
    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
    generate_log "Procedure 28 - Step 23: Error zip csv GC Files"
else
    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
    generate_log "Procedure 28 - Step 23: Zip csv GC Files successfully"
fi

ds_interface="Procedure 28: Collect GC files to be processed. | Step 24: Backup GC Files."; 
cd_start_by="rm"; 
ds_object_system=""; 
ds_path_input=""; 
ds_path_output=""

date_start_processing=`date +"%Y-%m-%d %T"`
mv_zip_csv_gc_to_processed
cd_exit=$?
if [ $cd_exit -ne 0 ]
then
    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
    generate_log "Procedure 28 - Step 24: Error Move zip csv GC files to GC Processed Folder"
else
    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
    generate_log "Procedure 28 - Step 24: Move zip csv GC files to GC Processed Folder successfully"
fi

ds_interface="Procedure 28: Collect GC files to be processed. | Step 25: Backup GC Files."; 
cd_start_by="rm"; 
ds_object_system=""; 
ds_path_input=""; 
ds_path_output=""

date_start_processing=`date +"%Y-%m-%d %T"`

#ROTINA BACKUP - EXCEL
zip_excel_gc
cd_exit=$?
if [ $cd_exit -ne 0 ]
then
    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
    generate_log "Procedure 28 - Step 25: Error zip excel GC Files"
else
    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
    generate_log "Procedure 28 - Step 25: Zip excel GC Files successfully"
fi

ds_interface="Procedure 28: Collect GC files to be processed. | Step 26: Backup GC Files."; 
cd_start_by="rm"; 
ds_object_system=""; 
ds_path_input=""; 
ds_path_output=""

date_start_processing=`date +"%Y-%m-%d %T"`
mv_zip_excel_gc_to_processed
cd_exit=$?
if [ $cd_exit -ne 0 ]
then
    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
    generate_log "Procedure 28 - Step 26: Error Move zip excel GC files to GC Processed Folder"
else
    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "KCC_PHARMA" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
    generate_log "Procedure 28 - Step 26: Move zip excel GC files to GC Processed Folder successfully"
fi


#------------------------------------------------------------------- JOB CONTRACTS, TOP STORE, PERFORMANCE AND SEND DATA ------------------------------------------------------------------------
#Procedure 29 - Step 01: Run job contracts.
generate_log "Procedure 29 - Step 01: Run Run job contracts."
cd_interface="p029.s001"; 
ds_interface="Procedure 29 - Step 01: Run Run job contracts."; 
cd_start_by=""; 
ds_object_system=""; 
ds_path_input="/prd-wdu-sba-001/prd-wdu-sba-kcc/script"; 
ds_path_output="/Inbound"
date_start_processing=`date +"%Y-%m-%d %T"`
	
#processamento diario de apuracao de contratos
/prd-wdu-sba-001/prd-wdu-sba-kcc/script/Smart-Contracts.sh

cd_exit=$?
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=``; 
qt_read_records=``; 
qt_load_records=``; 
qt_rejected_records=``

if [ $cd_exit -ne 0 ]
    then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 29 - Step 01: Extract error. Please check the script."; 
		#exit_sh 52; exit 52
fi
generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 29 - Step 01: Job contracts Finish"
generate_log "Procedure 29: Run job contracts successfully."

#------------------------------------------------------------------- FANATIKCOS FILES EXTRACTION ------------------------------------------------------------------------
#Procedure 30 - Job Fanatikcos Files Extraction.
generate_log "Procedure 30 - Job Fanatikcos Files Extraction."

#Data do sistema
dateproc=`date +"%Y_%m_%d"`
#Dia
date_day=`date +"%d"`
#dia da semana, onde 0 = domingo, 1 = segunda,..., 6 = sábado
date_week=`date +"%w"`
#pasta local output
LocalOutputFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamLocalOutputFolder' | cut -d"=" -f2 | head -1`
#pasta cloud output
CloudOutputFolder=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamCloudOutputFolder' | cut -d"=" -f2 | head -1`
CloudOutputFolder=$CloudOutputFolder/eai

#PARÂMETROS DE FTP Fanatikcos
#Usuário para acesso ao FTP
USER=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFTPUserFanatikcos' | cut -d"=" -f2 | head -1`
#Senha do usuário de acesso ao FTP
PASS=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFTPPasswordFanatikcos' | cut -d"=" -f2 | head -1`
#Host para acesso ao FTP
HOST=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFTPHostFanatikcos' | cut -d"=" -f2 | head -1`
#Pasta onde serao colocados os arquivos 
FILEPATH=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamFTPFilePathFanatikcos' | cut -d"=" -f2 | head -1`

#Procedure 30 - Step 01: Fanatikcos_6_months File.
generate_log "Procedure 30 - Step 01: Fanatikcos_6_months File"
cd_interface="p030.s001"; 
ds_interface="Procedure 30 - Step 01: Fanatikcos_6_months File"; 
cd_start_by=""; 
ds_object_system=""; 
ds_path_input="/prd-wdu-sba-001/prd-wdu-sba-kcc/script"; 
ds_path_output="/Inbound"
date_start_processing=`date +"%Y-%m-%d %T"`
	
########## Fanatikcos Target
if [ $date_day = 11 ]
then
    #Execucao procedure carga arquivo fanatikcos Meta
    bq --quiet query --use_legacy_sql=false  "call kcc.sp_itg_trs_kcc001_files_fanatikcos('T')"
    if [ $? -ne 0 ]
    then
        echo "Execution error procedure kcc.sp_itg_trs_kcc001_files_fanatikcos"; exit 2
    fi

    #Extracao Arquivo Fanatikcos Meta

    result=`bq --quiet query --format=csv --use_legacy_sql=false 'select size_bytes as size from kcc_tmp.__TABLES__ where table_id = "tb_tmp_eai_wdu001_fanatikcos"'| awk '{if(NR>1)print}'`
    if [ $result -lt 1000000000 ]
    then
        bq --quiet extract --destination_format CSV --field_delimiter ';' --print_header=true 'kcc_tmp.tb_tmp_eai_wdu001_fanatikcos' "$CloudOutputFolder"/Fanatikcos_6_months_"$dateproc".TXT
    else
        bq --quiet query --format=csv --use_legacy_sql=false 'SELECT * FROM kcc_tmp.tb_tmp_eai_wdu001_fanatikcos limit 1' | head -1 | sed 's/,/;/g' > Fanatikcos_6_months_"$dateproc".TXT
        gsutil mv Fanatikcos_6_months_"$dateproc".TXT  $CloudOutputFolder
        bq --quiet extract --destination_format CSV --field_delimiter ';' --print_header=false 'kcc_tmp.tb_tmp_eai_wdu001_fanatikcos' "$CloudOutputFolder"/Fanatikcos_6_months_"$dateproc"*.csv
        for object in $(gsutil ls $CloudOutputFolder/Fanatikcos_6_months_"$dateproc"*.csv)
        do
          gsutil compose $CloudOutputFolder/Fanatikcos_6_months_"$dateproc".TXT $object $CloudOutputFolder/Fanatikcos_6_months_"$dateproc".TXT
        done
        gsutil -m rm $CloudOutputFolder/Fanatikcos_6_months_"$dateproc"*.csv
    fi

    gsutil cp $CloudOutputFolder/Fanatikcos_6_months_"$dateproc".TXT $LocalOutputFolder

    #FTP
    lftp -e "open -u '$USER','$PASS' '$HOST'; set ftp:ssl-allow no; lcd '$LocalOutputFolder'; cd '$FILEPATH'; put Fanatikcos_6_months_"$dateproc".TXT; bye"

    rm $LocalOutputFolder/Fanatikcos_6_months_"$dateproc".TXT
fi

cd_exit=$?
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=``; 
qt_read_records=``; 
qt_load_records=``; 
qt_rejected_records=``

if [ $cd_exit -ne 0 ]
    then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 30 - Step 01: Extract Fanatikcos_6_months File error. Please check the script."; 
		#exit_sh 52; exit 52
fi
generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 30 - Step 01: Fanatikcos_6_months File Finish"

#Procedure 30 - Step 02: Fanatikcos_LastMonth File.
generate_log "Procedure 30 - Step 02: Fanatikcos_LastMonth File"
cd_interface="p030.s002"; 
ds_interface="Procedure 30 - Step 02: Fanatikcos_LastMonth File"; 
cd_start_by=""; 
ds_object_system=""; 
ds_path_input="/prd-wdu-sba-001/prd-wdu-sba-kcc/script"; 
ds_path_output="/Inbound"
date_start_processing=`date +"%Y-%m-%d %T"`

########## Fanatikcos Monthly
if [ $date_day = 10 ]
then
    #Execucao procedure carga arquivo fanatikcos Mensal
    bq --quiet query --use_legacy_sql=false  "call kcc.sp_itg_trs_kcc001_files_fanatikcos('M')"
    if [ $? -ne 0 ]
    then
        echo "Execution error procedure kcc.sp_itg_trs_kcc001_files_fanatikcos"; exit 2
    fi

    #Extracao Arquivo Fanatikcos Mensal
    result=`bq --quiet query --format=csv --use_legacy_sql=false 'select size_bytes as size from kcc_tmp.__TABLES__ where table_id = "tb_tmp_eai_wdu001_fanatikcos"'| awk '{if(NR>1)print}'`
    if [ $result -lt 1000000000 ]
    then
        bq --quiet extract --destination_format CSV --field_delimiter ';' --print_header=true 'kcc_tmp.tb_tmp_eai_wdu001_fanatikcos' "$CloudOutputFolder"/Fanatikcos_LastMonth_"$dateproc".TXT
    else
        bq --quiet query --format=csv --use_legacy_sql=false 'SELECT * FROM kcc_tmp.tb_tmp_eai_wdu001_fanatikcos limit 1' | head -1 | sed 's/,/;/g' > Fanatikcos_LastMonth_"$dateproc".TXT
        gsutil mv Fanatikcos_LastMonth_"$dateproc".TXT  $CloudOutputFolder
        bq --quiet extract --destination_format CSV --field_delimiter ';' --print_header=false 'kcc_tmp.tb_tmp_eai_wdu001_fanatikcos' "$CloudOutputFolder"/Fanatikcos_LastMonth_"$dateproc"*.csv
        for object in $(gsutil ls $CloudOutputFolder/Fanatikcos_LastMonth_"$dateproc"*.csv)
        do
          gsutil compose $CloudOutputFolder/Fanatikcos_LastMonth_"$dateproc".TXT $object $CloudOutputFolder/Fanatikcos_LastMonth_"$dateproc".TXT
        done
        gsutil -m rm $CloudOutputFolder/Fanatikcos_LastMonth_"$dateproc"*.csv
    fi

    gsutil cp $CloudOutputFolder/Fanatikcos_LastMonth_"$dateproc".TXT $LocalOutputFolder

    #FTP
    lftp -e "open -u '$USER','$PASS' '$HOST'; set ftp:ssl-allow no; lcd '$LocalOutputFolder'; cd '$FILEPATH'; put Fanatikcos_LastMonth_"$dateproc".TXT; bye"

    rm $LocalOutputFolder/Fanatikcos_LastMonth_"$dateproc".TXT
fi

cd_exit=$?
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=``; 
qt_read_records=``; 
qt_load_records=``; 
qt_rejected_records=``

if [ $cd_exit -ne 0 ]
    then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 30 - Step 02: Extract Fanatikcos_LastMonth File error. Please check the script."; 
		#exit_sh 52; exit 52
fi
generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 30 - Step 02: Fanatikcos_LastMonth File Finish"

#Procedure 30 - Step 03: Fanatikcos_Week File.
generate_log "Procedure 30 - Step 03: Fanatikcos_Week File"
cd_interface="p030.s003"; 
ds_interface="Procedure 30 - Step 03: Fanatikcos_Week File"; 
cd_start_by=""; 
ds_object_system=""; 
ds_path_input="/prd-wdu-sba-001/prd-wdu-sba-kcc/script"; 
ds_path_output="/Inbound"
date_start_processing=`date +"%Y-%m-%d %T"`

########## Fanatikcos Weekly
if [ $date_week = 1 ] || [ $date_week = 4 ]
then
    #Execucao procedure carga arquivo fanatikcos Semanal
    bq --quiet query --use_legacy_sql=false  "call kcc.sp_itg_trs_kcc001_files_fanatikcos('W')"
    if [ $? -ne 0 ]
    then
        echo "Execution error procedure kcc.sp_itg_trs_kcc001_files_fanatikcos"; exit 2
    fi

    #Extracao Arquivo Fanatikcos Semanal
    result=`bq --quiet query --format=csv --use_legacy_sql=false 'select size_bytes as size from kcc_tmp.__TABLES__ where table_id = "tb_tmp_eai_wdu001_fanatikcos"'| awk '{if(NR>1)print}'`
    if [ $result -lt 1000000000 ]
    then
        bq --quiet extract --destination_format CSV --field_delimiter ';' --print_header=true 'kcc_tmp.tb_tmp_eai_wdu001_fanatikcos' "$CloudOutputFolder"/Fanatikcos_Week_"$dateproc".TXT
    else
        bq --quiet query --format=csv --use_legacy_sql=false 'SELECT * FROM kcc_tmp.tb_tmp_eai_wdu001_fanatikcos limit 1' | head -1 | sed 's/,/;/g' > Fanatikcos_Week_"$dateproc".TXT
        gsutil mv Fanatikcos_Week_"$dateproc".TXT  $CloudOutputFolder
        bq --quiet extract --destination_format CSV --field_delimiter ';' --print_header=false 'kcc_tmp.tb_tmp_eai_wdu001_fanatikcos' "$CloudOutputFolder"/Fanatikcos_Week_"$dateproc"*.csv
        for object in $(gsutil ls $CloudOutputFolder/Fanatikcos_Week_"$dateproc"*.csv)
        do
          gsutil compose $CloudOutputFolder/Fanatikcos_Week_"$dateproc".TXT $object $CloudOutputFolder/Fanatikcos_Week_"$dateproc".TXT
        done
        gsutil -m rm $CloudOutputFolder/Fanatikcos_Week_"$dateproc"*.csv
    fi

    gsutil cp $CloudOutputFolder/Fanatikcos_Week_"$dateproc".TXT $LocalOutputFolder

    #FTP
    lftp -e "open -u '$USER','$PASS' '$HOST'; set ftp:ssl-allow no; lcd '$LocalOutputFolder'; cd '$FILEPATH'; put Fanatikcos_Week_"$dateproc".TXT; bye"

    rm $LocalOutputFolder/Fanatikcos_Week_"$dateproc".TXT
fi

cd_exit=$?
date_end_processing=`date +"%Y-%m-%d %T"`
nr_load_control_interface=``; 
qt_read_records=``; 
qt_load_records=``; 
qt_rejected_records=``

if [ $cd_exit -ne 0 ]
    then
		generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
		generate_log "Procedure 30 - Step 03: Extract Fanatikcos_Week File error. Please check the script."; 
		#exit_sh 52; exit 52
fi
generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
generate_log "Procedure 30 - Step 03: Fanatikcos_Week File Finish"

generate_log "Procedure 30: Job Fanatikcos Files Extraction successfully."

#PARAMETROS DE API - ZEN
#------------------------------------------------------------------------API ZEN--------------------------------------------------------------------------------------------------
#dia da semana, onde 0 = domingo, 1 = segunda,..., 6 = sábado
date_week=`date +"%w"`

ParamAPIZenTokenURL=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamAPIZenTokenURL=' | cut -d"=" -f2 | head -1`
ParamAPIZenGFileControleURL=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamAPIZenGFileControleURL=' | cut -d"=" -f2 | head -1`
ParamAPIZenGFileEstoqueURL=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamAPIZenGFileEstoqueURL=' | cut -d"=" -f2 | head -1`
ParamAPIZenUser=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamAPIZenUser=' | cut -d"=" -f2 | head -1`
ParamAPIZenPassword=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamAPIZenPassword=' | cut -d"=" -f2 | head -1`
ParamAPIZenReturnFilename1=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamAPIZenReturnFilename1=' | cut -d"=" -f2 | head -1`
ParamAPIZenReturnFilename2=`sed -n "/$ProjectName.$FileName/,//p" ../parameter/$ProjectName.par | grep '$ParamAPIZenReturnFilename2=' | cut -d"=" -f2 | head -1`

#Procedure 31: Call ZENATUR APIs be processed.
if [ $date_week = 1 ] 
then
    generate_log "Procedure 31: Call ZENATUR APIs be processed."
	    
    #Procedure 31 - Step 1: Authenticate to use the ZENATUR API.
    generate_log "Procedure 31 - Step 1: Authenticate to use the ZENATUR API."
    cd_interface="p0031.s001" 
    ds_interface="Procedure 31: Call ZENATUR APIs. | Step 1: Authenticate to use the ZENATUR API."; cd_start_by="curl"
    ds_object_system="" 
    ds_path_input="/tmp/cookies"
    ds_path_output=""
    date_start_processing=`date +"%Y-%m-%d %T"`
    apizentoken=`curl -d "senha=$ParamAPIZenPassword&login=$ParamAPIZenUser" -X POST $ParamAPIZenTokenURL | cut -d"," -f8 | cut -d":" -f2 | cut -d"\"" -f2`
    cd_exit=$?
    date_end_processing=`date +"%Y-%m-%d %T"`
    nr_load_control_interface=``
    qt_read_records=`` 
    qt_load_records=`` 
    qt_rejected_records=``

    if [ $cd_exit -ne 0 ] || [ "$bearer" == 'Login failed.' ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 31 - Step 1: Authentication error. Please check if API is available or contact your administrator."
            exit_sh 31; exit 31
    fi

    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
    generate_log "Procedure 31 - Step 1: User authenticated successfully."

    #Procedure 31 - Step 2: Run the ZENATUR Controle Regional API.
    generate_log "Procedure 31 - Step 2 - Call de ZENATUR Controle Regional API."
    cd_interface="p0031.s002"
    ds_interface="Procedure 31: Call ZENATUR APIs. | Step 2: Call de ZENATUR Controle Regional API."
    cd_start_by="curl"
    ds_object_system=""
    ds_path_input="/tmp/cookies"
    ds_path_output=""
    date_start_processing=`date +"%Y-%m-%d %T"`

    sudo curl -b /tmp/cookies --request GET --url $ParamAPIZenGFileControleURL --header "Authorization: $apizentoken" --header 'Content-Type: application/json' > $ParamLocalTempFolder/$ParamAPIZenReturnFilename1'_'$date_reference_d1.json

    cd_exit=$?
    date_end_processing=`date +"%Y-%m-%d %T"`
    nr_load_control_interface=``
    qt_read_records=`` 
    qt_load_records=``
    qt_rejected_records=``

    if [ $cd_exit -ne 0 ]
        then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 31 - Step 2: ZENATUR Controle Regional API error. Please check if API is available or contact your administrator."
            exit_sh 31; exit 31
    fi

    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
    generate_log "Procedure 31 - Step 2 - Call de ZENATUR Controle Regional API executed successfully."

    #Procedure 31 - Step 3: Run the ZENATUR Estoque Base API.
    generate_log "Procedure 31 - Step 3 - Call de ZENATUR Estoque Base API."
    cd_interface="p0031.s003"
    ds_interface="Procedure 31: Call ZENATUR APIs. | Step 3: Call de ZENATUR Estoque Base API."
    cd_start_by="curl"
    ds_object_system="" 
    ds_path_input="/tmp/cookies"
    ds_path_output=""
    date_start_processing=`date +"%Y-%m-%d %T"`

    sudo curl -b /tmp/cookies --request GET --url $ParamAPIZenGFileEstoqueURL --header "Authorization: $apizentoken" --header 'Content-Type: application/json' > $ParamLocalTempFolder/$ParamAPIZenReturnFilename2'_'$date_reference_d1.json

    cd_exit=$?
    date_end_processing=`date +"%Y-%m-%d %T"`
    nr_load_control_interface=``
    qt_read_records=`` 
    qt_load_records=`` 
    qt_rejected_records=``

    if [ $cd_exit -ne 0 ]
       then
            generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
            generate_log "Procedure 31 - Step 3: ZENATUR Estoque Base API error. Please check if API is available or contact your administrator."
            exit_sh 31; exit 31
    fi

    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
    generate_log "Procedure 31 - Step 3 - Call de ZENATUR Estoque Base API executed successfully."

    #Procedure 31 - Step 4: Clean cloud processing folder to receive the new files to be processed.
    generate_log "Procedure 31 - Step 4: Clean cloud processing folder to receive the new files to be processed."
    cd_interface="p031.s004"
    ds_interface="Procedure 31: Call ZENATUR APIs. | Step 4: Clean cloud processing folder to receive the new files to be processed."
    cd_start_by="gsutil" 
    ds_object_system="" 
    ds_path_input="$ParamCloudProcessingFolder/$ParamAPIZenReturnFilename1_* $ParamCloudProcessingFolder/$ParamAPIZenReturnFilename2_*" 
    ds_path_output=""
    date_start_processing=`date +"%Y-%m-%d %T"`
    file_count=`gsutil -q -m ls $ParamCloudProcessingFolder/$ParamAPIZenReturnFilename1'_'*.json $ParamCloudProcessingFolder/$ParamAPIZenReturnFilename2'_'*.json | wc -l`

    if [ $? -ne 0 ] || [ $file_count -lt 1 ]
       then
          date_end_processing=`date +"%Y-%m-%d %T"`
          nr_load_control_interface=`` 
          qt_read_records=`` 
          qt_load_records=`` 
          qt_rejected_records=``
          generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
          generate_log "Procedure 31 - Step 4: Cloud processing folder is already empty and does not need to be cleaned."
       else
          gsutil -q -m rm $ParamCloudProcessingFolder/$ParamAPIZenReturnFilename1'_'*.json 
          gsutil -q -m rm $ParamCloudProcessingFolder/$ParamAPIZenReturnFilename2'_'*.json
          cd_exit=$?
          date_end_processing=`date +"%Y-%m-%d %T"`
          nr_load_control_interface=``
          qt_read_records=`` 
          qt_load_records=`` 
          qt_rejected_records=``
          if [ $cd_exit -ne 0 ]
             then
                generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" /"$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
                generate_log "Procedure 31 - Step 4: Cloud processing folder to receive the new files to be processed were cleaned with error."
                exit_sh 31; exit 31
          fi
          generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
          generate_log "Procedure 31 - Step 4: Cloud processing folder to receive the new files to be processed were cleaned successfully."
     fi

    #Procedure 31 - Step 5: Move ZENATUR API files from local folder to cloud processing folder to be processed.
    generate_log "Procedure 31 - Step 5: Move ZENATUR API files from local folder to cloud processing folder to be processed."
    cd_interface="p031.s005"
    ds_interface="Procedure 31: Call ZENATUR APIs. | Step 5: Move ZENATUR API files from local folder to cloud processing folder to be processed."
    cd_start_by="gsutil" 
    ds_object_system="" 
    ds_path_input="$ParamCloudProcessingFolder/$ParamAPIZenReturnFilename1_* $ParamCloudProcessingFolder/$ParamAPIZenReturnFilename2_*" 
    ds_path_output=""
    date_start_processing=`date +"%Y-%m-%d %T"`
    gsutil -m mv $ParamLocalTempFolder/$ParamAPIZenReturnFilename1'_'$date_reference_d1.json $ParamCloudProcessingFolder/
    gsutil -m mv $ParamLocalTempFolder/$ParamAPIZenReturnFilename2'_'$date_reference_d1.json $ParamCloudProcessingFolder/
    cd_exit=$?
    date_end_processing=`date +"%Y-%m-%d %T"`
    nr_load_control_interface=``
    qt_read_records=`` 
    qt_load_records=`` 
    qt_rejected_records=``
    if [ $cd_exit -ne 0 ]
       then
          generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
          generate_log "Procedure 31 - Step 5: ZENATUR API files from local folder to cloud processing folder were moved with error."
          exit_sh 31; exit 31
    fi
    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
    generate_log "Procedure 31 - Step 5: ZENATUR API files from local folder to cloud processing folder were moved successfully."

    #Procedure 31 - Step 6: Execute procedure LOAD tables DAY and HIS ZENATUR API files.
    generate_log "Procedure 31 - Step 6: Execute procedure LOAD tables DAY and HIS ZENATUR API files."
    cd_interface="p031.s006"
    ds_interface="Procedure 31: Call ZENATUR APIs. | Step 6: Execute procedure LOAD tables DAY and HIS ZENATUR API files."
    cd_start_by="bq" 
    ds_object_system="call kcc.sp_day_trs_kcc001_zen_mpdv_controle_regional_filial(), call kcc.sp_day_trs_kcc001_zen_mpdv_estoque_bases(), call kcc.sp_his_trs_kcc001_zen_mpdv_controle_regional_filial(), call kcc.sp_his_trs_kcc001_zen_mpdv_estoque_bases()" 
    ds_path_input="" 
    ds_path_output=""
    date_start_processing=`date +"%Y-%m-%d %T"`
    bq --quiet query --use_legacy_sql=false  "call kcc.sp_day_trs_kcc001_zen_mpdv_controle_regional_filial()"
    bq --quiet query --use_legacy_sql=false  "call kcc.sp_day_trs_kcc001_zen_mpdv_estoque_bases()"
    bq --quiet query --use_legacy_sql=false  "call kcc.sp_his_trs_kcc001_zen_mpdv_controle_regional_filial()"
    bq --quiet query --use_legacy_sql=false  "call kcc.sp_his_trs_kcc001_zen_mpdv_estoque_bases()"
    cd_exit=$?
    date_end_processing=`date +"%Y-%m-%d %T"`
    nr_load_control_interface=``
    qt_read_records=`` 
    qt_load_records=`` 
    qt_rejected_records=``
					        
    if [ $cd_exit -ne 0 ]
       then
          generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_ERROR" "$DS_STATUS_ERROR" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
	  generate_log "Procedure 31 - Step 6: Execute procedure LOAD tables DAY and HIS ZENATUR API files with error."
          exit_sh 31; exit 31
    fi
    generate_lh "$Day" "$cd_interface" "$ds_interface" "$cd_start_by" "$ds_object_system" "$date_start_processing" "$date_end_processing" "$CD_STATUS_SUCCESS" "$DS_STATUS_SUCCESS" "$nr_load_control_interface" "$qt_read_records" "$qt_load_records" "$qt_rejected_records" "$ds_path_input" "$ds_path_output" "$DATETIME" "$COMPANY" "$LOAD_CONTROL" "$ACCOUNT" "$SYSTEM"
    generate_log "Procedure 31 - Step 6: Execute procedure LOAD tables DAY and HIS ZENATUR API files successfully."

    generate_log "Procedure 31: Call ZENATUR APIs be processed successfully."
fi

#--------------------------------------------------------------------------------------------------------------------------------------------------------------
#FINALIZATION:
#Finalize log file.c
generate_log "Smart-Workflow-Day: Daily SBA workflow process orchestrator finished successfully."
#Finalize shell script.
exit_sh 0; exit 0
exit 0

