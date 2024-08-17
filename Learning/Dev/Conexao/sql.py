import pyodbc

server = 'NET1694'
database = 'Boa'
username = 'sa'
password = '123456'
driver= '{ODBC Driver 17 for SQL Server}'
cnxn = pyodbc.connect('DRIVER='+driver+';SERVER='+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()

cursor.execute("SELECT TOP 20 * FROM [Boa].[dbo].[Cad_FornCadastro_Fornecedor]") 
row = cursor.fetchone() 
while row: 
    print (str(row[0]) + " " + str(row[1])+ " " + str(row[2]))
    row = cursor.fetchone()



"""
cursor.execute("SELECT @@version;") 
row = cursor.fetchone() 
while row: 
    print(row[0])
    row = cursor.fetchone()

"""


"""
import pyodbc as pyodbc
# Some other example server values are
# server = 'localhost\sqlexpress' # for a named instance
# server = 'myserver,port' # to specify an alternate port
server = 'NET1694' 
database = 'Boa' 
username = 'myusername' 
password = 'mypassword' 
cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()


import pyodbc

print("teste")


server = 'NET1694'
database = 'Boa'
username = 'sa'
password = '123456'
driver= '{ODBC Driver 17 for SQL Server}'
cnxn = pyodbc.connect('DRIVER='+driver+';SERVER='+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()

cursor.execute("SELECT TOP 20 [Coluna 0] FROM [Boa].[dbo].[Cadastro_Fornecedor]")
row = cursor.fetchone()
    while row:
    print (str(row[0]) + " " + str(row[1]))
    row = cursor.fetchone()

""" 