from sqlalchemy import  create_engine
import pandas as pd

server = 'NET1694'
database = 'Boa'
DRIVER = 'SQL Server Native Client 11.0'
username = 'sa'
password = '123456'

database_connection = f'mssql://{username}:{password}@{server}/{database}?driver={DRIVER}'


engine = create_engine(database_connection)

connection = engine.connect()

data = pd.read_sql_query("SELECT TOP 20 * FROM [Boa].[dbo].[CadastroProdutos]",connection)

print(data)

