import ftplib
from datetime import datetime
import pathlib

ftp = ftplib.FTP("painelindiretokc.com.br")
ftp.login("ftpmaster", "FTPm@st3r!2018")

today = datetime.now()
now = str(today.strftime("%b-%d-%Y-%H-%M-%S"))

file_name = "Output"+now+".csv"
text_file = open(pathlib.Path(__file__).parent.absolute()/file_name, "w", encoding="utf8")

def add_log(pListText):  
    now = str(datetime.now())
    with open(pathlib.Path(__file__).parent.absolute()/'PROCESS_LOGS.csv', 'a', encoding="utf8") as LogFile:
        LogFile.write('\n' + now + ';' + str(pListText))
        LogFile.close

def move_aquivos(pastaInicial, diretorio, destino, arquivo): 
    origem = pastaInicial+'/'+ diretorio+'/'+arquivo
    destino = pastaInicial+'/'+ diretorio +'/' + destino + '/'+arquivo
    try:
        ftp.rename(origem, destino)
        add_log(arquivo +"; transferido para "+ destino)
        print(arquivo,' transferido para ', destino) 
    except Exception as e: 
        add_log(origem+'; Não transferido')
        print(origem,' Não transferido') 

def seleciona_arquivos(pastaInicial, bucar_arquivo, list_ignore, pasta_SELLOUT, pasta_ESTOQUE):
    text_file.write("Status;Cliente;Aquivo/Pasta"+"\n" )
    try: 
        ftp.cwd(pastaInicial) 
        root_diretorios = ftp.nlst()
        
        for diretorio in root_diretorios:
            ftp.cwd(pastaInicial+"/"+diretorio+'/')
            arquivos = ftp.nlst()
            
            for arquivo in arquivos:
                if not [s for s in list_ignore if s.lower() in diretorio+'/'+arquivo.lower()]:
                    if bucar_arquivo.lower() in arquivo.lower() and '.' in arquivo.lower():
                        move_aquivos(pastaInicial, diretorio, pasta_SELLOUT, arquivo)
                        text_file.write("Arquivo de Sellout;"+ diretorio + ";"+arquivo+ "\n" )
                    
                    elif '.' in arquivo.lower(): 
                        move_aquivos(pastaInicial, diretorio, pasta_ESTOQUE, arquivo)
                        text_file.write("Arquivo de Estoque;"+diretorio +";"+ arquivo + "\n" )   
                    else:
                        text_file.write("Diretorio;"+diretorio +";"+ arquivo + "\n" )
                else: 
                    text_file.write("Arquivo Ignorado;"+diretorio +";"+ arquivo + "\n" )
    except Exception as e: 
        add_log('ERRO: {0}'.format(e))

pastaInicial = "/allusers" 
arquivo_sellout = "sellout"
list_ignore = ["DIKIMBERL","DATA","FORN","LOCAL","PROD","EXCELENCIA",".d","layout"] 
pasta_SELLOUT = "SELLOUT"
pasta_ESTOQUE = "ESTOQUE"

seleciona_arquivos( pastaInicial, 
                    arquivo_sellout, 
                    list_ignore, 
                    pasta_SELLOUT, 
                    pasta_ESTOQUE
                    )

ftp.close()
text_file.close()