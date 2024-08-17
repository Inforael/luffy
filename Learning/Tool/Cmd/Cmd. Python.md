# Document Python - https://docs.python.org/pt-br/3/library/stdtypes.html#str.format

# Referência and Terminal -  https://www.w3schools.com/python/ref_string_join.asp

#  Python Live Coding - https://www.youtube.com/playlist?list=PLVt5okzyYGy8WO3xI_uiMJrp280gKH4z2

# FreeCodeCamp - https://www.youtube.com/playlist?list=PLVt5okzyYGy8L_B5X_x6EIFxZ7RUo-la2

# Music Work - https://www.youtube.com/playlist?list=PLVt5okzyYGy95XrKRyCQklSL1sYqq9IDg


# Cmd para ativar máquinas virtuais nos projetos

cria a máquina = clear


ativa = /Bko/Study-Projects/Workspace/Gallery/Golden-Gate/atelier/Scripts/activate 

sai do ambiente virtual = deactivatepip

# Cmd para atualizar o biblioteca Pip 

python -m pip install --upgrade pip 


# CMd cabeçalho padrão Python

-# !/usr/bin/env python
-# coding: utf-8

import pandas as pd
import math
import os
import pandas.io.common

# biblioteca para add numero da linha no arquivo - funcao arange
import numpy as np
from datetime import date
import re
from sys import argv

---------------------------------------------------------------------

# cmd para ativar máq virtual

source C:/Bko/Python/Estudo/MV/Scripts/activate

---------------------------------------------------------------------
Cmd para mostrar tudo que foi instalado

pip freeze

pip install sqlite
pip install pysqlite
pip install pysqlite3

----------------------------------------
-- Trabalhando com dicionário

cmd extend adiciona elementos na lista 

user_ds =[15,23,43,56]
assinaram = []
assinaram.extend(user_ds)
print(assinaram)

---------------------------------------
cmd copy() cópia valor da variável

user_ml =[13,23,56,46]
assinaram2= []
assinaram2 = user_ml.copy()

--------------------------------------
Cmd set cria um conjunto em uma lista
ele tira os números repetidos 

print(set(assinaram)) 
s>{43, 13, 46, 15, 23, 56} 

test = set( user_ds ) | set( user_ml ) 
| significa OU 
lembrado que só funciona com set(conjuntos)

& significa E 

test = set( user_ds ) & set( user_ml ) 

- retira os elementos que estão nos dois conjuntos

test = set( user_ds ) - set( user_ml )
print(test)

test = set( user_ds ) ^ set( user_ml )
print(test)

Cmd add adiciona elementos ao conjunto

frozenset não deixa adicionar elemento ao conjunto

--------------------------------------------
cmd split()

Quebra o texto que está em branco

---------------------------------------------

Cmd Dicionário

https://docs.python.org/3/tutorial/datastructures.html#dictionaries

dic = {"israel": 1, "james" : 2 }

print(dic)
print(dic.get("xpto",0))

Cmd get para trazer valores dentro do dicionário

cmd para add nova chave valor no dicionário
Obs:.. veja que para add e feito usando uma lista

dic["pedro"] = 3

print(dic)

cmd para remover nova chave valor no dicionário

del dic["israel"]

varrendo os dicionários 

for elemento in dic.keys():
    print(elemento)

for elemento in dic.values():
    print(elemento)   

for elemento in dic.items():
    print(elemento)    

for chave,valor in dic.items():
    print(chave, "=", valor) 

print(["palavra {}".format(chave) for chave in dic.keys()])        

cmd defaultdict 

-----------------------------------------------------------
https://pypi.org/project/validate-docbr/

Para usar valores padrões no dicionário

from collections import defaultdict
dic = defaultdict(int)
print(dic["Gabriel"])


--------------------------------------------------
cmd para fazer comentário no python


# Cmd

para abrir terminal vccode = ctrl + ; 

cmd para fazer comentario grande """  = shift + alt + A 

https://cloud.google.com/run/docs/quickstarts/build-and-deploy?gclid=Cj0KCQjw2NyFBhDoARIsAMtHtZ7KKWYrLZ6T_IjFIkeuljQNw972iZmnu4aeIhazrfr5W0w-DwZQtNAaAhruEALw_wcB&gclsrc=aw.ds#python
https://github.com/GoogleCloudPlatform

-------------------------------------
Cmd python app engine

https://cloud.google.com/appengine/docs/standard/python?hl=pt_BR&_ga=2.204801171.-244489462.1619611829&_gac=1.191754456.1622732727.Cj0KCQjw2NyFBhDoARIsAMtHtZ7KKWYrLZ6T_IjFIkeuljQNw972iZmnu4aeIhazrfr5W0w-DwZQtNAaAhruEALw_wcB

https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/appengine/standard

https://cloud.google.com/compute/docs/shutdownscript

---------------------------------------

from sys import argv

scores =[12,34,6]

avg = sum(scores) / len(scores)
print(avg)
print(f" valores: {avg}" )
print(sum(scores))
print(len(scores)) 


# cmd passando argumento no sem uma chama de função

if len(argv) == 2:
    print(f"Hello", {})


https://docs.python.org/pt-br/3/library/stdtypes.html#str.format
https://docs.python.org/3/library/stdtypes.html?highlight=str%20format#str.format
 str.format(*args, **kwargs)
print("The sum of 1 + 2 is {0}".format(1+2))


# Cmd para listar o diretório da pasta 

print(os.listdir("C:\Bko\Python\Estudo\MV\Caixa de Ferramenta\Learning"))

# Cmd para conectar Banco Postgresql

https://www.devart.com/odbc/postgresql/docs/python.htm









