from typing import DefaultDict


user_ds =[15,23,43,56]
user_ml =[13,23,56,46]

assinaram = []
assinaram = user_ml.copy()
assinaram.extend(user_ds)


print(assinaram)
print(len(assinaram))

print(set(assinaram))

test = set( user_ds ) | set( user_ml )
print(test)

test = set( user_ds ) & set( user_ml )
print(test)

test = set( user_ds ) - set( user_ml )
print(test)

test = set( user_ds ) ^ set( user_ml )
print(test)

#-----------------------------------------

# Cmd Dicionário 

#https://docs.python.org/3/tutorial/datastructures.html#dictionaries

dic = {"israel": 1, "james" : 2 }

print(dic)
print(dic.get("xpto",0))

dic["pedro"] = 3

print(dic)

del dic["israel"]

print(dic)

for elemento in dic:
    print(elemento)

for elemento in dic.keys():
    print(elemento)

for elemento in dic.values():
    print(elemento)   

for elemento in dic.items():
    print(elemento)      

for chave,valor in dic.items():
    print(chave, "=", valor) 

print(["palavra {}".format(chave) for chave in dic.keys()])

from collections import defaultdict,Counter

dic = defaultdict(int)
print(dic["Gabriel"])

class Conta:
    def __init__(self):
        print("testando...")

conta = defaultdict(Conta)  
print(conta[15])      

texto = (" israel de Oliveira")
dic = Counter(texto.split())
print(dic)

#for caracter , prop in mais:
#    print("{} =>{:.2f}%".format(caracter,prop * 100))

#shift + alt+ a comenta várias linhas 
''' mais_comuns = proporcoes.most_common(10)
 for caractere, proporcao in mais_comuns:
    print("{} => {:.2f}%".format(caractere, proporcao * 100))
    https://pypi.org/project/validate-docbr/
     '''

