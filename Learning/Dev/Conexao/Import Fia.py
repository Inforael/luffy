#!/usr/bin/env python
# coding: utf-8

#importa a bibliotea pandas
import pandas as pd
#importa a biblioteca math para verificar se um campo float64 e null
import math
#biblioteca que executa comandos "shell"
import os
#biblioteca de execoes
import pandas.io.common
#biblioteca para add numero da linha no arquivo - funcao arange
import numpy as np
#biblioteca de data
from datetime import date
#biblioteca regex
import re

#caminho dos arquivos 
FROM_PATH_SOURCE=r"/prd-wdu-sba-001/prd-wdu-sba-kcc/fia/ftp_fia"

#caminho para pasta onde os arquivos convertidos serao armazenados
TO_PATH_CSV=r"/prd-wdu-sba-001/prd-wdu-sba-kcc/fia/csv_fia"

#lista com o nome de todos os arquivos capturados (despreza o arquivo da dec sul)
source_file_list = \
[''.join([FROM_PATH_SOURCE,'/',f]) for f in os.listdir(FROM_PATH_SOURCE) \
if re.match(r'sellout|kimberly', f,  re.IGNORECASE)]

#caminho do arquivo de log dos arquivos vazios
path_log_empty_files=''.join([r"/prd-wdu-sba-001/prd-wdu-sba-kcc/log/ARQUIVOS_COPIADOS_FTP_VAZIOS_",date.today().strftime("%Y%m%d"),".txt"])

#cria um arquivo de log
LOG_EMPTY_FILES = open(path_log_empty_files,mode="w", newline='\n')

#caminho do arquivo de log que sera lido na tabela externa de controle
path_log_external_crlt_file=''.join([r"/prd-wdu-sba-001/prd-wdu-sba-kcc/log/CTRL_FILE_LOG_SELLTHROUGH_",date.today().strftime("%Y%m%d"),".txt"])

#cria arquivo de log que sera lido na tabela externa de controle
CTRL_FILE_LOG = open(path_log_external_crlt_file, mode="w", newline='\n')

#dicionario com o tamanho dos arquivos
length_array_file_dict = {}
empty_file_count=0

"""
Descricao da utilizacao do for:
    Esse FOR percorre a lista de arquivos verificando seu tamanho de layout 
    baseado na quantidade de posições da segunda linha.
    Caso o tamanho jA tenha sido mapeado o nome do arquivo e adicionado a chave no dicionario
    correspondente ao tamanho encontrado.
    Caso o tamanho nao tenha sido mapeado, a chave correspondente ao tamanho e criada
    e o nome do arquivo e adicionado pela primeira vez.
    
    As excecoes sao feitas para capturar erros de arquivos nulos (sem nenhuma linha),
    arquivos apenas com a linha de cabecalho e arquivos que por algum erro de encoding
    nao foi possivel mapear seu tamanho.
    
lista de variaves:
    -source_file_list: lista com caminho full dos arquivos copiados do ftp;
    -short_name_file: nome do arquivo;
    -bytes_size: tamanho do arquivo;
    -read_csv_open: csv carregado;
    -length_array: quantidade de posições na segunda linha do arquivos. Pula-se a linha de cabeçalho;
    -length_array_file_dict: dicionaio que ira agrupar nosso arquivos pelo tamanho do layout;
    -erro: mensagem de erro que ira para nossa log interna;
    -erro_ctrl_file: mensagme de erro que ira para log da tabela externa de controle de arquivos;
    -empty_file_count: contador de arquivos vazios.
"""


for source_file in source_file_list:
    try:
        short_name_file= source_file.split('/')[-1]
        bytes_size = os.path.getsize(source_file)
        read_csv_open=pd.read_csv(source_file, encoding='ISO-8859-1',sep='\n',skiprows=1,names=["coluna unica"])
        trim = lambda x: x.rstrip() if isinstance(x, str) else x
        read_csv_open = read_csv_open.applymap(trim)
        length_array = max(read_csv_open.iloc[:,0].astype(str).apply(len))
        if length_array in length_array_file_dict:
            length_array_file_dict[length_array].append(source_file)
        else:
            length_array_file_dict[length_array]=[source_file]
    except (ValueError) as exception:
        erro=str("Arquivo Rejeitado nº {}: {} tamanho: {:,.0f} erro: {}".format(empty_file_count,short_name_file,bytes_size/float(1<<10),type(exception).__name__))
        LOG_EMPTY_FILES.write(erro+'\n')
        erro_ctrl_file=str("||||||||||||||{}||||||||".format(short_name_file))
        CTRL_FILE_LOG.write(erro_ctrl_file+'\n')
        empty_file_count+=1
        continue
    except (pandas.errors.ParserError):
        bytes_size = os.path.getsize(source_file)
        read_csv_open=pd.read_csv(source_file, engine='python',encoding='ISO-8859-1',sep='\n',skiprows=1,names=["coluna unica"])
        length_array=len(str.rstrip(read_csv_open["coluna unica"][0:1].array[0]))
        if length_array in length_array_file_dict:
            length_array_file_dict[length_array].append(source_file)
        else:
            length_array_file_dict[length_array]=[source_file]
            erro="Arquivo Rejeitado nº {}: {} tamanho: {:,.0f} erro: {}".format(empty_file_count,short_name_file,length_array/float(1<<10),type(exception).__name__)            
            LOG_EMPTY_FILES.write(erro+'\n')
            erro_ctrl_file=str("||||||||||||||{}||||||||".format(short_name_file))
            CTRL_FILE_LOG.write(erro_ctrl_file+'\n')
        empty_file_count+=1

        

"""
Funcao responsavel por converter arquivo com layouts de 909 posicoes.

lista de argumentos:
    -file_list: lista com arquivos de tamanho 909
    -to_path:
        caminho full onde o csv será gravado.
        utiliza o caminho declarado no inicio do arquivo.
"""
def fia_csv_909(file_list,to_path):
    
    for flat_file in file_list:
        #nome das colunas
        col_names = [ "Indicador_de_Registro","Codigo_SAP_do_Distribuidor_faturamento","Codigo_SAP_do_Distribuidor_entrega",
                 "Codigo_do_cliente", "Nome_do_cliente", "CNPJ_do_cliente_indireto_pessoa_juridica", 
                 "CPF_do_cliente_indireto_pessoa_fisica", "Endereco", "CEP", "Estado", "Bairro", "Municipio", "Telefone", 
                 "Pais", "Contato", "Tipo_de_Negocio", "Zona_estabelecida_pelo_Distribuidor", "Representante_do_Distribuidor",
                 "Nome_do_Representante", "Codigo_do_produto_atacado", "Codigo_EAN13", "Codigo_SAP_Produto_KCC", 
                 "Venda_em_quantidade", "Valor_da_venda", "Preco_unitario_da_venda", "Tipo_de_moeda", "Data_de_faturamento",
                 "Data_de_entrega", "Tipo_de_documento", "Codigo_do_documento", "Unidade_de_medida_de_quantidade",
                 "Numerador_de_conversao_das_quantidades_para_unidade", "Denominador_de_conversor_das_quantidades_para_unidade",
                 "Unidade_de_medida_do_preco", "Numerador_de_conversao_do_preco_para_unidade",
                 "Denominador_de_conversor_do_preco_para_unidade", "Data_de_fim_do_periodo_reportado",
                 "Data_de_transmissao_da_informacao", "Numero_de_transmissao", "CPF_Representante_vendas_Atacado",
                 "Chave_de_Acesso_NFE"]
    
        #posições das colunas para o arquivo de 910 posições
        col_specs=[(0,1),(1,9),(9,17),(17,32),(32,112),(112,132),(132,192),(192,272),(272,280),(280,283),(283,323),(323,363),
                 (363,393),(393,396),(396,466),(466,470),(470,510),(510,520),(520,600),(600,635),(635,648),(648,683),(683,688),
                 (688,703),(703,718),(718,721),(721,731),(731,741),(741,742),(742,777),(777,780),(780,795),(795,810),(810,813),
                 (813,828),(828,843),(843,853),(853,863),(863,898),(898,909)]
    
        #colunas que devem ser carregadas como string
        d_type={"Codigo_SAP_do_Distribuidor_faturamento":str,
                "Codigo_SAP_do_Distribuidor_entrega":str,
                "Codigo_do_cliente":str,
                "CEP":str,
                "Telefone":str,
                "Tipo_de_Negocio":str,
                "Representante_do_Distribuidor":str,
                "Codigo_do_produto_atacado":str,
                "Codigo_EAN13":str,
                "Codigo_SAP_Produto_KCC":str,
                "Codigo_do_documento":str,
                "CNPJ_do_cliente_indireto_pessoa_juridica":str,
                "CPF_do_cliente_indireto_pessoa_fisica":str,
                "CPF_Representante_vendas_Atacado":str}
        
        #carregar o arquivo
        try:
            FIA = pd.read_fwf(flat_file, colspecs=col_specs, skiprows=1, names=col_names, index_col=None, dtype=d_type, encoding='ISO-8859-1')
        except UnicodeDecodeError:
            return type(exception).__name__
            
        
        #transforma em um dataframe
        FIA_df = pd.DataFrame(FIA)
    
        #substitui nulos por vazio para ser identificado com null no bigquery
        FIA_df = FIA_df.fillna('')
        
        #captura o nome do arquivo
        file_name= flat_file.split('/')[-1]
        
        #insere na posicao 0 do dataframe uma coluna com o nome do arquivo em todas linhas
        FIA_df.insert(0,column="Arquivo",value=file_name, allow_duplicates=True)
        
        #insere na posicao 0 do dataframe uma coluna com o numero da linha do registros no proprio arquivo
        FIA_df.insert(loc=0, column='num_linha', value=np.arange(2,len(FIA_df)+2,1))
        
        #substuiu sellout (case insentive) por SELLTHROUGH_FINAL
        file_name= re.sub("sellout", "SELLTHROUGH_FINAL",file_name, flags=re.IGNORECASE)
        
        #exporta o csv sem index, com head e separado pipe |
        FIA_df.to_csv(to_path+"/"+file_name, index = False, header=True, sep="|")


"""
Funcao responsavel por converter arquivo com layouts de 910 posicoes.

lista de argumentos:
    -file_list: lista com arquivos de tamanho 910
    -to_path:
        caminho full onde o csv será gravado.
        utiliza o caminho declarado no inicio do arquivo.
"""
def fia_csv_910(file_list,to_path):
    for flat_file in file_list:
    
        #nome das colunas
        col_names = [ "Indicador_de_Registro","Codigo_SAP_do_Distribuidor_faturamento","Codigo_SAP_do_Distribuidor_entrega",
                 "Codigo_do_cliente", "Nome_do_cliente", "CNPJ_do_cliente_indireto_pessoa_juridica", 
                 "CPF_do_cliente_indireto_pessoa_fisica", "Endereco", "CEP", "Estado", "Bairro", "Municipio", "Telefone", 
                 "Pais", "Contato", "Tipo_de_Negocio", "Zona_estabelecida_pelo_Distribuidor", "Representante_do_Distribuidor",
                 "Nome_do_Representante", "Codigo_do_produto_atacado", "Codigo_EAN13", "Codigo_SAP_Produto_KCC", 
                 "Venda_em_quantidade", "Valor_da_venda", "Preco_unitario_da_venda", "Tipo_de_moeda", "Data_de_faturamento",
                 "Data_de_entrega", "Tipo_de_documento", "Codigo_do_documento", "Unidade_de_medida_de_quantidade",
                 "Numerador_de_conversao_das_quantidades_para_unidade", "Denominador_de_conversor_das_quantidades_para_unidade",
                 "Unidade_de_medida_do_preco", "Numerador_de_conversao_do_preco_para_unidade",
                 "Denominador_de_conversor_do_preco_para_unidade", "Data_de_fim_do_periodo_reportado",
                 "Data_de_transmissao_da_informacao", "Numero_de_transmissao", "CPF_Representante_vendas_Atacado",
                 "Chave_de_Acesso_NFE"]
    
        #posições das colunas para o arquivo de 910 posições
        col_specs=[(0,1) ,(1,9) ,(9,17) ,(17,32) ,(32,112) ,(112,132) ,(132,192) ,(192,272) ,(272,280) ,(280,283) ,(283,323),
                 (323,363) ,(363,393) ,(393,396) ,(396,466) ,(466,470) ,(470,510) ,(510,520) ,(520,600) ,(600,635) ,(635,649),
                 (649,684) ,(684,689) ,(689,704) ,(704,719) ,(719,722) ,(722,732) ,(732,742) ,(742,743) ,(743,778) ,(778,781),
                 (781,796) ,(796,811) ,(811,814) ,(814,829) ,(829,844) ,(844,854) ,(854,864) ,(864,899) ,(899,910)]
    
        #colunas que devem ser carregadas como string
        d_type={"Codigo_SAP_do_Distribuidor_faturamento":str,
                "Codigo_SAP_do_Distribuidor_entrega":str,
                "Codigo_do_cliente":str,
                "CEP":str,
                "Telefone":str,
                "Tipo_de_Negocio":str,
                "Representante_do_Distribuidor":str,
                "Codigo_do_produto_atacado":str,
                "Codigo_EAN13":str,
                "Codigo_SAP_Produto_KCC":str,
                "Codigo_do_documento":str,
                "CNPJ_do_cliente_indireto_pessoa_juridica":str,
                "CPF_do_cliente_indireto_pessoa_fisica":str,
                "CPF_Representante_vendas_Atacado":str}
        
        #carregar o arquivo
        try:
            FIA = pd.read_fwf(flat_file, colspecs=col_specs, skiprows=1, names=col_names, index_col=None, dtype=d_type, encoding='ISO-8859-1')
        except UnicodeDecodeError:
            return type(exception).__name__            
        
        #transforma em um dataframe
        FIA_df = pd.DataFrame(FIA)
    
        #substitui nulos por vazio para ser identificado com null no bigquery
        FIA_df = FIA_df.fillna('')
        
        #captura o nome do arquivo
        file_name= flat_file.split('/')[-1]
        
        #insere na posicao 0 do dataframe uma coluna com o nome do arquivo em todas linhas
        FIA_df.insert(0,column="Arquivo",value=file_name, allow_duplicates=True)
        
        #insere na posicao 0 do dataframe uma coluna com o numero da linha do registros no proprio arquivo
        FIA_df.insert(loc=0, column='num_linha', value=np.arange(2,len(FIA_df)+2,1))
        
        #substuiu sellout (case insentive) por SELLTHROUGH_FINAL
        file_name= re.sub("sellout", "SELLTHROUGH_FINAL",file_name, flags=re.IGNORECASE)
        
        #exporta o csv sem index, com head e separado pipe |
        FIA_df.to_csv(to_path+"/"+file_name, index = False, header=True, sep="|")


"""
Funcao responsavel por converter arquivo com layouts de 923 posicoes.

lista de argumentos:
    -file_list: lista com arquivos de tamanho 923
    -to_path:
        caminho full onde o csv será gravado.
        utiliza o caminho declarado no inicio do arquivo.
"""
def fia_csv_923(file_list,to_path):   
    for flat_file in file_list:
        
        #nome das colunas
        col_names = [ "Indicador_de_Registro","Codigo_SAP_do_Distribuidor_faturamento","Codigo_SAP_do_Distribuidor_entrega",
                 "Codigo_do_cliente", "Nome_do_cliente", "CNPJ_do_cliente_indireto_pessoa_juridica", 
                 "CPF_do_cliente_indireto_pessoa_fisica", "Endereco", "CEP", "Estado", "Bairro", "Municipio", "Telefone", 
                 "Pais", "Contato", "Tipo_de_Negocio", "Zona_estabelecida_pelo_Distribuidor", "Representante_do_Distribuidor",
                 "Nome_do_Representante", "Codigo_do_produto_atacado", "Codigo_EAN13", "Codigo_SAP_Produto_KCC", 
                 "Venda_em_quantidade", "Valor_da_venda", "Preco_unitario_da_venda", "Tipo_de_moeda", "Data_de_faturamento",
                 "Data_de_entrega", "Tipo_de_documento", "Codigo_do_documento", "Unidade_de_medida_de_quantidade",
                 "Numerador_de_conversao_das_quantidades_para_unidade", "Denominador_de_conversor_das_quantidades_para_unidade",
                 "Unidade_de_medida_do_preco", "Numerador_de_conversao_do_preco_para_unidade",
                 "Denominador_de_conversor_do_preco_para_unidade", "Data_de_fim_do_periodo_reportado",
                 "Data_de_transmissao_da_informacao", "Numero_de_transmissao", "CPF_Representante_vendas_Atacado",
                 "Chave_de_Acesso_NFE"]
    
        #posições das colunas para o arquivo de 910 posições
        col_specs=[(0,1),     (1,9),     (9,17),    (17,32),   (32,112),  (112,132), (132,192), (192,272), (272,280), (280,283),
                 (283,323), (323,363), (363,393), (393,396), (396,466), (466,470), (470,510), (510,520), (520,600), (600,635),
                 (635,649), (649,684), (684,689), (689,704), (704,719), (719,722), (722,732), (732,742), (742,743), (743,778),
                 (778,781), (781,796), (796,811), (811,814), (814,829), (829,844), (844,854), (854,864), (864,899), (899,910),
                 (910,923)]
    
        #colunas que devem ser carregadas como string
        d_type={"Codigo_SAP_do_Distribuidor_faturamento":str,
                "Codigo_SAP_do_Distribuidor_entrega":str,
                "Codigo_do_cliente":str,
                "CEP":str,
                "Telefone":str,
                "Tipo_de_Negocio":str,
                "Representante_do_Distribuidor":str,
                "Codigo_do_produto_atacado":str,
                "Codigo_EAN13":str,
                "Codigo_SAP_Produto_KCC":str,
                "Codigo_do_documento":str,
                "CNPJ_do_cliente_indireto_pessoa_juridica":str,
                "CPF_do_cliente_indireto_pessoa_fisica":str,
                "CPF_Representante_vendas_Atacado":str}
        
        #carregar o arquivo
        try:
            FIA = pd.read_fwf(flat_file, colspecs=col_specs, skiprows=1, names=col_names, index_col=None, dtype=d_type, encoding='ISO-8859-1')
        except UnicodeDecodeError:
            return type(exception).__name__

        #transforma em um dataframe
        FIA_df = pd.DataFrame(FIA)
    
        #substitui nulos por vazio para ser identificado com null no bigquery
        FIA_df = FIA_df.fillna('')
        
        #captura o nome do arquivo
        file_name= flat_file.split('/')[-1]
        
        #insere na posicao 0 do dataframe uma coluna com o nome do arquivo em todas linhas
        FIA_df.insert(0,column="Arquivo",value=file_name, allow_duplicates=True)
        
        #insere na posicao 0 do dataframe uma coluna com o numero da linha do registros no proprio arquivo
        FIA_df.insert(loc=0, column='num_linha', value=np.arange(2,len(FIA_df)+2,1))
        
        #substuiu sellout (case insentive) por SELLTHROUGH_FINAL
        file_name= re.sub("sellout", "SELLTHROUGH_FINAL",file_name, flags=re.IGNORECASE)
        
        #exporta o csv sem index, com head e separado pipe |
        FIA_df.to_csv(to_path+"/"+file_name, index = False, header=True, sep="|")

"""
Funcao responsavel por converter arquivo com layouts de 950 posicoes.

lista de argumentos:
    -file_list: lista com arquivos de tamanho 950
    -to_path:
        caminho full onde o csv será gravado.
        utiliza o caminho declarado no inicio do arquivo.
"""
def fia_csv_950(file_list,to_path):  
    for flat_file in file_list:

        #nome das colunas
        col_names = [ "Indicador_de_Registro","Codigo_SAP_do_Distribuidor_faturamento","Codigo_SAP_do_Distribuidor_entrega",
                 "Codigo_do_cliente", "Nome_do_cliente", "CNPJ_do_cliente_indireto_pessoa_juridica", 
                 "CPF_do_cliente_indireto_pessoa_fisica", "Endereco", "CEP", "Estado", "Bairro", "Municipio", "Telefone", 
                 "Pais", "Contato", "Tipo_de_Negocio", "Zona_estabelecida_pelo_Distribuidor", "Representante_do_Distribuidor",
                 "Nome_do_Representante", "Codigo_do_produto_atacado", "Codigo_EAN13", "Codigo_SAP_Produto_KCC", 
                 "Venda_em_quantidade", "Valor_da_venda", "Preco_unitario_da_venda", "Tipo_de_moeda", "Data_de_faturamento",
                 "Data_de_entrega", "Tipo_de_documento", "Codigo_do_documento", "Unidade_de_medida_de_quantidade",
                 "Numerador_de_conversao_das_quantidades_para_unidade", "Denominador_de_conversor_das_quantidades_para_unidade",
                 "Unidade_de_medida_do_preco", "Numerador_de_conversao_do_preco_para_unidade",
                 "Denominador_de_conversor_do_preco_para_unidade", "Data_de_fim_do_periodo_reportado",
                 "Data_de_transmissao_da_informacao", "Numero_de_transmissao", "CPF_Representante_vendas_Atacado",
                 "Chave_de_Acesso_NFE"]
    
        #posições das colunas para o arquivo de 910 posições
        col_specs=[ (0,1),    (1,9),    (9,17),   (17,32),  (32,112), (112,132),(132,192),(192,272),(272,280),(280,283),(283,323)
                 ,(323,363),(363,393),(393,396),(396,466),(466,470),(470,510),(510,520),(520,600),(600,635),(635,649),(649,684)
                 ,(684,689),(689,702),(702,715),(715,718),(723,733),(733,743),(743,744),(744,774),(774,777),(777,792),(792,807)
                 ,(807,810),(810,825),(825,840),(840,850),(850,860),(860,895),(895,906),(906,950)]
    
        #colunas que devem ser carregadas como string
        d_type={"Codigo_SAP_do_Distribuidor_faturamento":str,
                "Codigo_SAP_do_Distribuidor_entrega":str,
                "Codigo_do_cliente":str,
                "CEP":str,
                "Telefone":str,
                "Tipo_de_Negocio":str,
                "Representante_do_Distribuidor":str,
                "Codigo_do_produto_atacado":str,
                "Codigo_EAN13":str,
                "Codigo_SAP_Produto_KCC":str,
                "Codigo_do_documento":str,
                "CNPJ_do_cliente_indireto_pessoa_juridica":str,
                "CPF_do_cliente_indireto_pessoa_fisica":str,
                "CPF_Representante_vendas_Atacado":str}
        
        #carregar o arquivo
        try:
            FIA = pd.read_fwf(flat_file, colspecs=col_specs, skiprows=1, names=col_names, index_col=None, dtype=d_type, encoding='ISO-8859-1')
        except UnicodeDecodeError:
            return type(exception).__name__

        #transforma em um dataframe
        FIA_df = pd.DataFrame(FIA)
    
        #substitui nulos por vazio para ser identificado com null no bigquery
        FIA_df = FIA_df.fillna('')
        
        #captura o nome do arquivo
        file_name= flat_file.split('/')[-1]
        
        #insere na posicao 0 do dataframe uma coluna com o nome do arquivo em todas linhas
        FIA_df.insert(0,column="Arquivo",value=file_name, allow_duplicates=True)
        
        #insere na posicao 0 do dataframe uma coluna com o numero da linha do registros no proprio arquivo
        FIA_df.insert(loc=0, column='num_linha', value=np.arange(2,len(FIA_df)+2,1))
        
        #substuiu sellout (case insentive) por SELLTHROUGH_FINAL
        file_name= re.sub("sellout", "SELLTHROUGH_FINAL",file_name, flags=re.IGNORECASE)
        
        #exporta o csv sem index, com head e separado pipe |
        FIA_df.to_csv(to_path+"/"+file_name, index = False, header=True, sep="|")

"""
Funcao responsavel por converter arquivo com layouts de 953 posicoes.

lista de argumentos:
    -file_list: lista com arquivos de tamanho 953
    -to_path:
        caminho full onde o csv será gravado.
        utiliza o caminho declarado no inicio do arquivo.
"""
def fia_csv_953(file_list,to_path):
    for flat_file in file_list:

        #nome das colunas
        col_names = [ "Indicador_de_Registro","Codigo_SAP_do_Distribuidor_faturamento","Codigo_SAP_do_Distribuidor_entrega",
                 "Codigo_do_cliente", "Nome_do_cliente", "CNPJ_do_cliente_indireto_pessoa_juridica", 
                 "CPF_do_cliente_indireto_pessoa_fisica", "Endereco", "CEP", "Estado", "Bairro", "Municipio", "Telefone", 
                 "Pais", "Contato", "Tipo_de_Negocio", "Zona_estabelecida_pelo_Distribuidor", "Representante_do_Distribuidor",
                 "Nome_do_Representante", "Codigo_do_produto_atacado", "Codigo_EAN13", "Codigo_SAP_Produto_KCC", 
                 "Venda_em_quantidade", "Valor_da_venda", "Preco_unitario_da_venda", "Tipo_de_moeda", "Data_de_faturamento",
                 "Data_de_entrega", "Tipo_de_documento", "Codigo_do_documento", "Unidade_de_medida_de_quantidade",
                 "Numerador_de_conversao_das_quantidades_para_unidade", "Denominador_de_conversor_das_quantidades_para_unidade",
                 "Unidade_de_medida_do_preco", "Numerador_de_conversao_do_preco_para_unidade",
                 "Denominador_de_conversor_do_preco_para_unidade", "Data_de_fim_do_periodo_reportado",
                 "Data_de_transmissao_da_informacao", "Numero_de_transmissao", "CPF_Representante_vendas_Atacado",
                 "Chave_de_Acesso_NFE"]
    
        #posições das colunas para o arquivo de 910 posições
        col_specs=[(0,1),    (1,9),    (9,17),   (17,32),  (32,112), (112,132),(132,192),(192,272),(272,280),(280,283),(283,323),
                 (323,363),(363,393),(393,396),(396,466),(466,470),(470,510),(510,520),(520,600),(600,635),(635,648),(648,683),
                 (683,688),(688,703),(715,718),(718,721),(721,731),(731,741),(741,742),(742,777),(777,780),(780,795),(795,810),
                 (810,813),(813,828),(828,843),(843,853),(853,863),(863,898),(898,909),(909,953)]
    
        #colunas que devem ser carregadas como string
        d_type={"Codigo_SAP_do_Distribuidor_faturamento":str,
                "Codigo_SAP_do_Distribuidor_entrega":str,
                "Codigo_do_cliente":str,
                "CEP":str,
                "Telefone":str,
                "Tipo_de_Negocio":str,
                "Representante_do_Distribuidor":str,
                "Codigo_do_produto_atacado":str,
                "Codigo_EAN13":str,
                "Codigo_SAP_Produto_KCC":str,
                "Codigo_do_documento":str,
                "CNPJ_do_cliente_indireto_pessoa_juridica":str,
                "CPF_do_cliente_indireto_pessoa_fisica":str,
                "CPF_Representante_vendas_Atacado":str}
        
        #carregar o arquivo
        try:
            FIA = pd.read_fwf(flat_file, colspecs=col_specs, skiprows=1, names=col_names, index_col=None, dtype=d_type, encoding='ISO-8859-1')
        except UnicodeDecodeError:
            return type(exception).__name__

        #transforma em um dataframe
        FIA_df = pd.DataFrame(FIA)
    
        #substitui nulos por vazio para ser identificado com null no bigquery
        FIA_df = FIA_df.fillna('')
        
        #captura o nome do arquivo
        file_name= flat_file.split('/')[-1]
        
        #insere na posicao 0 do dataframe uma coluna com o nome do arquivo em todas linhas
        FIA_df.insert(0,column="Arquivo",value=file_name, allow_duplicates=True)
        
        #insere na posicao 0 do dataframe uma coluna com o numero da linha do registros no proprio arquivo
        FIA_df.insert(loc=0, column='num_linha', value=np.arange(2,len(FIA_df)+2,1))
        
        #substuiu sellout (case insentive) por SELLTHROUGH_FINAL
        file_name= re.sub("sellout", "SELLTHROUGH_FINAL",file_name, flags=re.IGNORECASE)
        
        #exporta o csv sem index, com head e separado pipe |
        FIA_df.to_csv(to_path+"/"+file_name, index = False, header=True, sep="|")

"""
Funcao responsavel por converter arquivo com layouts de 954 posicoes.

lista de argumentos:
    -file_list: lista com arquivos de tamanho 954
    -to_path:
        caminho full onde o csv será gravado.
        utiliza o caminho declarado no inicio do arquivo.
"""
def fia_csv_954(file_list,to_path):   
    for flat_file in file_list:

        #nome das colunas
        col_names = [ "Indicador_de_Registro","Codigo_SAP_do_Distribuidor_faturamento","Codigo_SAP_do_Distribuidor_entrega",
                 "Codigo_do_cliente", "Nome_do_cliente", "CNPJ_do_cliente_indireto_pessoa_juridica", 
                 "CPF_do_cliente_indireto_pessoa_fisica", "Endereco", "CEP", "Estado", "Bairro", "Municipio", "Telefone", 
                 "Pais", "Contato", "Tipo_de_Negocio", "Zona_estabelecida_pelo_Distribuidor", "Representante_do_Distribuidor",
                 "Nome_do_Representante", "Codigo_do_produto_atacado", "Codigo_EAN13", "Codigo_SAP_Produto_KCC", 
                 "Venda_em_quantidade", "Valor_da_venda", "Preco_unitario_da_venda", "Tipo_de_moeda", "Data_de_faturamento",
                 "Data_de_entrega", "Tipo_de_documento", "Codigo_do_documento", "Unidade_de_medida_de_quantidade",
                 "Numerador_de_conversao_das_quantidades_para_unidade", "Denominador_de_conversor_das_quantidades_para_unidade",
                 "Unidade_de_medida_do_preco", "Numerador_de_conversao_do_preco_para_unidade",
                 "Denominador_de_conversor_do_preco_para_unidade", "Data_de_fim_do_periodo_reportado",
                 "Data_de_transmissao_da_informacao", "Numero_de_transmissao", "CPF_Representante_vendas_Atacado",
                 "Chave_de_Acesso_NFE"]
    
        #posições das colunas para o arquivo de 910 posições
        col_specs=[(0,1),    (1,9),    (9,17),   (17,32),  (32,112), (112,132),(132,192),(192,272),(272,280),(280,283),(283,323),
                 (323,363),(363,393),(393,396),(396,466),(466,470),(470,510),(510,520),(520,600),(600,635),(635,649),(649,684),
                 (684,689),(689,704),(704,719),(719,722),(722,732),(732,742),(742,743),(743,778),(778,781),(781,796),(796,811),
                 (811,814),(814,829),(829,844),(844,854),(854,864),(864,899),(899,910),(910,954)]
    
        #colunas que devem ser carregadas como string
        d_type={"Codigo_SAP_do_Distribuidor_faturamento":str,
                "Codigo_SAP_do_Distribuidor_entrega":str,
                "Codigo_do_cliente":str,
                "CEP":str,
                "Telefone":str,
                "Tipo_de_Negocio":str,
                "Representante_do_Distribuidor":str,
                "Codigo_do_produto_atacado":str,
                "Codigo_EAN13":str,
                "Codigo_SAP_Produto_KCC":str,
                "Codigo_do_documento":str,
                "CNPJ_do_cliente_indireto_pessoa_juridica":str,
                "CPF_do_cliente_indireto_pessoa_fisica":str,
                "CPF_Representante_vendas_Atacado":str}
        
        #carregar o arquivo
        try:
            FIA = pd.read_fwf(flat_file, colspecs=col_specs, skiprows=1, names=col_names, index_col=None, dtype=d_type, encoding='ISO-8859-1')
        except UnicodeDecodeError:
            return type(exception).__name__

        #transforma em um dataframe
        FIA_df = pd.DataFrame(FIA)
    
        #substitui nulos por vazio para ser identificado com null no bigquery
        FIA_df = FIA_df.fillna('')
        
        #captura o nome do arquivo
        file_name= flat_file.split('/')[-1]
        
        #insere na posicao 0 do dataframe uma coluna com o nome do arquivo em todas linhas
        FIA_df.insert(0,column="Arquivo",value=file_name, allow_duplicates=True)
        
        #insere na posicao 0 do dataframe uma coluna com o numero da linha do registros no proprio arquivo
        FIA_df.insert(loc=0, column='num_linha', value=np.arange(2,len(FIA_df)+2,1))
        
        #substuiu sellout (case insentive) por SELLTHROUGH_FINAL
        file_name= re.sub("sellout", "SELLTHROUGH_FINAL",file_name, flags=re.IGNORECASE)
        
        #exporta o csv sem index, com head e separado pipe |
        FIA_df.to_csv(to_path+"/"+file_name, index = False, header=True, sep="|")


"""
Funcao responsavel por converter arquivo com layouts de 974 posicoes.

lista de argumentos:
    -file_list: lista com arquivos de tamanho 974
    -to_path:
        caminho full onde o csv será gravado.
        utiliza o caminho declarado no inicio do arquivo.
"""
def fia_csv_974(file_list,to_path):
    for flat_file in file_list:

        #nome das colunas
        col_names = [ "Indicador_de_Registro","Codigo_SAP_do_Distribuidor_faturamento","Codigo_SAP_do_Distribuidor_entrega",
                 "Codigo_do_cliente", "Nome_do_cliente", "CNPJ_do_cliente_indireto_pessoa_juridica", 
                 "CPF_do_cliente_indireto_pessoa_fisica", "Endereco", "CEP", "Estado", "Bairro", "Municipio", "Telefone", 
                 "Pais", "Contato", "Tipo_de_Negocio", "Zona_estabelecida_pelo_Distribuidor", "Representante_do_Distribuidor",
                 "Nome_do_Representante", "Codigo_do_produto_atacado", "Codigo_EAN13", "Codigo_SAP_Produto_KCC", 
                 "Venda_em_quantidade", "Valor_da_venda", "Preco_unitario_da_venda", "Tipo_de_moeda", "Data_de_faturamento",
                 "Data_de_entrega", "Tipo_de_documento", "Codigo_do_documento", "Unidade_de_medida_de_quantidade",
                 "Numerador_de_conversao_das_quantidades_para_unidade", "Denominador_de_conversor_das_quantidades_para_unidade",
                 "Unidade_de_medida_do_preco", "Numerador_de_conversao_do_preco_para_unidade",
                 "Denominador_de_conversor_do_preco_para_unidade", "Data_de_fim_do_periodo_reportado",
                 "Data_de_transmissao_da_informacao", "Numero_de_transmissao", "CPF_Representante_vendas_Atacado",
                 "Chave_de_Acesso_NFE"]
    
        #posições das colunas para o arquivo de 910 posições
        col_specs=[(0,1),    (1,9),    (9,17),   (17,32), (32,112),  (112,132),(132,192),(192,272),(272,280),(280,283),(283,323),
                 (323,363),(363,393),(393,396),(396,466),(466,470),(470,510),(510,520),(520,600),(600,635),(635,649),(649,684),
                 (684,689),(689,704),(704,719),(719,722),(722,732),(732,742),(742,743),(743,778),(778,781),(781,796),(796,811),
                 (811,814),(814,829),(829,844),(844,854),(854,864),(864,899),(899,910),(910,954)]
    
        #colunas que devem ser carregadas como string
        d_type={"Codigo_SAP_do_Distribuidor_faturamento":str,
                "Codigo_SAP_do_Distribuidor_entrega":str,
                "Codigo_do_cliente":str,
                "CEP":str,
                "Telefone":str,
                "Tipo_de_Negocio":str,
                "Representante_do_Distribuidor":str,
                "Codigo_do_produto_atacado":str,
                "Codigo_EAN13":str,
                "Codigo_SAP_Produto_KCC":str,
                "Codigo_do_documento":str,
                "CNPJ_do_cliente_indireto_pessoa_juridica":str,
                "CPF_do_cliente_indireto_pessoa_fisica":str,
                "CPF_Representante_vendas_Atacado":str}
        
        #carregar o arquivo
        try:
            FIA = pd.read_fwf(flat_file, colspecs=col_specs, skiprows=1, names=col_names, index_col=None, dtype=d_type, encoding='ISO-8859-1')
        except UnicodeDecodeError:
            return type(exception).__name__

        #transforma em um dataframe
        FIA_df = pd.DataFrame(FIA)
    
        #substitui nulos por vazio para ser identificado com null no bigquery
        FIA_df = FIA_df.fillna('')
        
        #captura o nome do arquivo
        file_name= flat_file.split('/')[-1]
        
        #insere na posicao 0 do dataframe uma coluna com o nome do arquivo em todas linhas
        FIA_df.insert(0,column="Arquivo",value=file_name, allow_duplicates=True)
        
        #insere na posicao 0 do dataframe uma coluna com o numero da linha do registros no proprio arquivo
        FIA_df.insert(loc=0, column='num_linha', value=np.arange(2,len(FIA_df)+2,1))
        
        #substuiu sellout (case insentive) por SELLTHROUGH_FINAL
        file_name= re.sub("sellout", "SELLTHROUGH_FINAL",file_name, flags=re.IGNORECASE)
        
        #exporta o csv sem index, com head e separado pipe |
        FIA_df.to_csv(to_path+"/"+file_name, index = False, header=True, sep="|")


"""
O bloco FOR abaixo tem a forcao de mapear o dicionario e chamar a funcao correspondente a chave/tamanho do arquivo,
passando como parametro para funcao a lista de todos os arquivos correspondente ao tamanho.

O ultimo else registra possiveis arquivos que podem ser captados e nao tem layout mapeado.

Existe 7 funcoes e 11 layouts diferentes. Porem, alguns layouts "encaixam" em outros layouts.
A diferenca no tamanho da do layout e apenas na ultima "coluna".
"""
for legth_array in length_array_file_dict:
    if legth_array in [909]:
        fia_csv_909(length_array_file_dict[legth_array],TO_PATH_CSV)
    elif legth_array in [899,910,940]:                  
        fia_csv_910(length_array_file_dict[legth_array],TO_PATH_CSV)
    elif legth_array == 923:                            
        fia_csv_923(length_array_file_dict[legth_array],TO_PATH_CSV)
    elif legth_array == 950:                            
        fia_csv_950(length_array_file_dict[legth_array],TO_PATH_CSV)
    elif legth_array in [953]:                          
        fia_csv_953(length_array_file_dict[legth_array],TO_PATH_CSV)
    elif legth_array in [954,2451,854]:                 
        fia_csv_954(length_array_file_dict[legth_array],TO_PATH_CSV)
    elif legth_array == 974:                            
        fia_csv_974(length_array_file_dict[legth_array],TO_PATH_CSV)
    else:
        erro=str("Arquivo sem tamanho mapeado {} - Tamanho: {}".format((length_array_file_dict[legth_array][0]).split("/")[-1],legth_array))        
        LOG_EMPTY_FILES.write(erro+'\n')
        erro_ctrl_file=str("||||||||||||||{}||||||||".format((length_array_file_dict[legth_array][0]).split("/")[-1]))
        CTRL_FILE_LOG.write(erro_ctrl_file+'\n')
        
#lista gerada com o caminho absoluto de todos arquivos transformados em csv
csv_file_path_list =[''.join([TO_PATH_CSV,'/',csv_file]) for csv_file in os.listdir(TO_PATH_CSV)]

#fecha o arquivo de log
LOG_EMPTY_FILES.close()

#fecha o arquivo de log tabela de controle
CTRL_FILE_LOG.close()

"""
retira caracteres nulos 'invisiveis' que possivelmente podem gerar erro ao carregar na day.
lista de variaveis:
    -csv: arquivo csv da lista de arquivo transformados;
    -open_csv_read: arquivo csv aberto em modo leitura;
    -open_csv_read_lines: todas as linhas do arquivo carregadas em memoria;
    -open_csv_write: arquivo csv aberto em modo escrita;
    -line: linha do arquivo carregado em memoria.
"""
for csv in csv_file_path_list:
    
    #abre o arquivo csv em modo leitura
    open_csv_read = open(csv)
    
    #le todas as linhas do arquivo aberto
    open_csv_read_lines = open_csv_read.readlines()
    
    #fecha o arquivo
    open_csv_read.close()
    
    #substitui o csv por um arquivo vazio com o mesmo nome
    open_csv_write = open(csv,"w")
    
    #itera sobre as linhas em memoria do csv substituido
    for line in open_csv_read_lines:
    
        #caso exista uma ou mais sequencias de \x00 sera apagado.
        open_csv_write.write(line.replace('\x00', ''))
        
    #fecha o arquivo substituido
    open_csv_write.close()
