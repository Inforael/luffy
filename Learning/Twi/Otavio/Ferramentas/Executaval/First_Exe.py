
#pyinstaller --onefile --noconsole --windowed .\First_Exe.py


import os
import shutil

caminho_original = r'C:\Bko\Python\Estudo\Study Python\Ferramentas\Mover arquivos\Arquivos_ser_ movidos'
caminho_novo = r'C:\Bko\Python\Estudo\Study Python\Ferramentas\Mover arquivos\arquivos_movidos'


for root, dirs, files in os.walk(caminho_original):
    for file in files:
        old_file_path = os.path.join(root, file)
        
        new_file_path = os.path.join(caminho_novo, file)

        shutil.copy(old_file_path, new_file_path)
        print(f'Arquivo {file} copy com sucesso!')       


