import json


#  Controi  o dicionário 

d1 = { 'Cliente 1': { 
            'nome': 'Luiz',
            'idade': 25,
     },
     'Cliente 2': {
          'nome': 'Rose',
          'idade': 30,
     },
     }

# transforma o dic em um json

d1_json = json.dumps(d1, indent = True)

# y = json.dumps(d1)
# print(y)

#  Escreve o json em um arquivo json e salva ele.

with open('abc.json', 'w+') as file:
    file.write(d1_json)

# print(d1_json)

#  Lê o arquivo Json 
with open('abc.json', 'r') as f:
     dj = f.read()

# Converte o arquivo json em dic 

with open('abc.json', 'r') as f:
    d1_json = json.loads(d1_json)

#  lê o arquivo dic que foi convertido

for k, v in d1_json.items():
    print(k)
    for k1, v1 in v.items():
        print(k1, v1)

