import os
import shutil

caminho_original = r'C:\Bko\Python\Estudo\Study Python\Ferramentas\Mover arquivos\Arquivos_ser_ movidos'
caminho_novo = r'C:\Bko\Python\Estudo\Study Python\Ferramentas\Mover arquivos\arquivos_movidos'

# try:
#     os.mkdir('arquivos_movidos')
# except FileNotFoundError as e:
#     print(f'Pasta {caminho_novo} já existe.')


#  cmd para mover arquivos

# for root, dirs, files in os.walk(caminho_original):
#     for file in files:
#         old_file_path = os.path.join(root, file)
#         new_file_path = os.path.join(caminho_novo, file)

#         shutil.move(old_file_path, new_file_path)
#         print(f'Arquivo {file} movido com sucesso!')


#Cmd para copiar arquivos

for root, dirs, files in os.walk(caminho_original):
    for file in files:
        old_file_path = os.path.join(root, file)
        new_file_path = os.path.join(caminho_novo, file)

        shutil.copy(old_file_path, new_file_path)
        print(f'Arquivo {file} copy com sucesso!')       


# comando para excluir

# for root, dirs, files in os.walk(caminho_novo):
#     for file in files:
#         old_file_path = os.path.join(root, file)
#         new_file_path = os.path.join(caminho_novo, file)

#         if '.JPG' in file:
#             os.remove(new_file_path)
#             print(f'Arquivo {file} Excluido com sucesso!')

            

    