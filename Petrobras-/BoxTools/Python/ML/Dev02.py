import pandas as pd
import os

carro = [7, 4, 3, 2, 8]
vendedor = ['davi', 'Rael' , 'Pedro', 'Manoel', 'Pri']

# os.system('clear')
dias = pd.date_range('20240101', '20240101', periods= len(vendedor))
dias = pd.date_range('20240101', '20240101', periods= 5)


df = pd.DataFrame({'Vendas' : carro , 'Data: ' : dias , 'Vendedor': vendedor})

print(df)

df02 = pd.DataFrame({'vendas' : carro })

print(df02)

print(len(vendedor))

