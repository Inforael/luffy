
#!/usr/bin/python2.7 --> #!/usr/bin/python
#!/usr/bin/env python
# coding: utf-8
# coding: utf-8


import pandas as pd
import math
import os
import pandas.io.common
import numpy as np
from datetime import date
import re

#caminho dos arquivos 
# FROM_PATH_SOURCE=r"/prd-wdu-sba-001/prd-wdu-sba-kcc/fia/ftp_fia"

# NEW_FROM_PATH_SOURCE = "C:\Bko\Python\Estudo\MV\Caixa de Ferramenta\Learning"

#caminho para pasta onde os arquivos convertidos serao armazenados
# TO_PATH_CSV=r"/prd-wdu-sba-001/prd-wdu-sba-kcc/fia/csv_fia"

# print(os.listdir(NEW_FROM_PATH_SOURCE))
# print([''.join([FROM_PATH_SOURCE,'/',f]))

# [''.join([FROM_PATH_SOURCE,'/',f]) for f in os.listdir(FROM_PATH_SOURCE) \
# if re.match(r'sellout|kimberly', f,  re.IGNORECASE)]

# myTuple = [str(os.listdir(NEW_FROM_PATH_SOURCE)), "Vicky"]
# out: C:\Bko\Python\Estudo\MV\Caixa de Ferramenta\LearningVicky
# x = ''.join(myTuple) 
# print(x)

# https://www.youtube.com/watch?v=lOeIDvyRUQs

# isso é um test no monitor 
from time import  sleep 
print("This is my file to demonstrate best practices.")

def process_data(data):
    print("Beginning data processing...")
    modified_data = data + "that has been modified"
    sleep(3)
    print("Data from the web")


"""
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

afajkfkajndjasdfnioadhfondal\d
fdsfsdfsdf


"""