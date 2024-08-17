import pandas as pd
import numpy as np

# dt = pd.date_range('20240101', periods=6)
# df = pd.DataFrame(np.random.randn(6,5),index=dt, columns=['Var_A','Var_B','Var_C','Var_D','Var_E'])

# print(df ,'\n')
# print ( 100 * '*','\n')
# print(df.T)

# print(df.shape)

dias = pd.date_range(start ='20240101',periods=12)

print(dias ,'\n')

pessoas = ['Angelina','Davi','Isabella']
print(pessoas, '\n')

print(np.random.choice(pessoas))

nome = []
gasto = []

for i in range(12):
    nome.append(np.random.choice(pessoas))
    gasto.append(np.round(np.random.rand()*100,2))

print(nome)    
print(gasto)  

df = pd.DataFrame({'Dias':dias,'Nome':nome , 'Gasto': gasto})

# print('\n', df)

# print(df)

print(df.pivot(index='Dias',columns='Nome',values='Gasto'))

