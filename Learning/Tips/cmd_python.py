# --------------------------14-02-2021-----------------------------
# Work List

"""
mylist = ['banana', 'cherry', 'apple']
print(mylist)
print()

# Como apago uma lista interia ?
# Observação para criar uma lista vazia usa ()
# print(list())

# Como apago uma lista interia ?

mylist = list()
print(mylist)
print()

mylist03 = ['banana', 'cherry', 'apple', 'morando', 'macã']
print(mylist03)
item = mylist03.clear()
print(mylist03)
# Como cópiar uma lista interia 
mylist02 = [5, True, 'apple', 'apple']

item = mylist02
print(item)
print()

# Como imprimir um único elemento de uma lista

itens = mylist02
print(itens[1])
print()

# Como localizar o elemento de uma lista

print(mylist02.count('apple'))
print()

# Como localizar o index de uma lista

print(mylist02.index('apple'))
print()

# Como adicionar elemento em uma lista

mylist02.append('lemon')
print(mylist02)
print()

# Como remover elemento do final da lista 

mylist02.pop()
print(mylist02)
print()

# Como remover elemento do final da lista e salvar em uma variavel 

item = mylist02.pop()
print(item)
print()

# Como remover um especifico elemento de uma lista 

mylist02.remove('apple')
print(mylist02)


# Como adicionar elemento em uma lista em uma posição deterninada

mylist02.insert(0,'blueberry')
print(mylist02)

# Como ordenar os elementos de uma lista 

num = [2, 1, 4, 3, 5, 7, 8, 10, 9, 6]
print(num)
num.sort()
print(num)

# List: ordered, mutable, allows duplicate elements

#index 0  1  2  3  4  5  6  7   8  9
num = [2, 1, 4, 3, 5, 7, 8, 10, 9, 6]

a = num[:5] # começa no index zero e vai até o index definido
print(a) # saída [2, 1, 4, 3, 5]

a = num[1:] # começa no index 1 e vai até o index final
print(a) # saída [1, 4, 3, 5, 7, 8, 10, 9, 6]

a = num[1:5]
print(a) # saída [1, 4, 3, 5]

a = num[1:7] # último index não imprimi na nova lista 
print(a) # saída [1, 4, 3, 5, 7, 8]

a = num[::2] # com dois pontos a mais defini a quantidade de slice deve pular 
print(a) # saída = [2, 4, 5, 8, 9]

a = num[::-1] # o sinal de menos mais index -1 faz com que os valores seja lido ao 
#contratio  
print(a) # saída = [6, 9, 10, 8, 7, 5, 3, 4, 1, 2]

list_org = ['banana', 'cherry', 'apple', 'morando', 'macã']
list_copy = list_org
list_copy.append('lemon')
print()
print(list_org)
print(list_copy)
print()

# Ao copiar uma lista para outra lista o endereço de memória vai junto 
# por isso ao inserir um novo elemento na nova lista automaticamento o elemento e salvo
# na lista original para evitar isso deve se add alguns argumentos na lista a ser compiada
 


list_org = ['banana', 'cherry', 'apple', 'morando', 'macã']
list_copy = list_org.copy() # list_copy = list(list_org) or list_copy = list_org [:]
list_copy.append('morango')
print()
print(list_org)
print(list_copy)
print()

# list compre

num = [2, 1, 4, 3, 5, 7, 8, 10, 9, 6]

b = [i * i for i in num]
print(num)
print(b)





"""
# --------------------------15-02-2021-----------------------------
# Work Dicionário

dic = {'nome':'israel', 'idade':38, 'cidade': 'sao paulo'}

print(dic.get('nome'))
print(dic.get('cargo','não informado'))



# Como fazer um dicionário comp
dial_codes = [(86, 'China'), (91, 'India'), (1, 'United States'), (55, 'Brasil')]
print(dial_codes)

cidade_code = {cidade : code for code, cidade in dial_codes}
print(cidade_code)

# [(86, 'China'), (91, 'India'), (1, 'United States'), (55, 'Brasil')]
# {'China': 86, 'India': 91, 'United States': 1, 'Brasil': 55}

cidade_code = {code : cidade for code, cidade in dial_codes}
print(cidade_code)

Cid_cod = {code : cidade.upper() for code, cidade in cidade_code.items() if code < 66}
print(Cid_cod)


print()
# Como imprir o valor de um dic ?
#vc faz a busca pelo valor com um indíce

d1 = {'chave1' : ' Valor da chave'}
print(d1['chave1'])


# Como faço para adicionar uma nova chave ?

d1 = {'chave': 'Valor da chave'}
d1['nova_chave'] = 'valor da nova chave'
print(d1)
#{'chave': 'Valor da chave', 'nova_chave': 'valor da nova chave'}

# Como faço para acessar o valor no  dic
# para imprimir o valor da chave não se utiliza os indicies como na lista 
# ou tuplas e sim o nome da chave

print()
print(d1['nova_chave'])
print()

# Os valores de chaves pode ser do tipo 

d2 = {
       'str': 'valor',
        123: 'Outro valor',
        (1,2,3,4) : 'tupla',

     }

print(d2)     

"""

# --------------------------15-02-2021-----------------------------
# Study book Fluent Python

# colors = ['black','white','red']
# sizes = ['S','M','l']
# # camisa = [(color,size) for in range()]
# # print(camisa)

# # x = 0 
# # for x in range(1 ,10):
    
# #     for color in color:
# #         print(color)


# for color in colors:
#     for size in sizes:
#         print(color,size)
        
# x = 0 
# y = 0
# z = 0 
# qtd = 2

# print()
# for x in range(0,qtd):
#     for y in range(0,qtd):
#         for z in range(0,qtd):
#             print(x,y,z)

# # ---------------------------------------------------------
# print()
# for x in range(5):
#     print(x)

# # ---------------------------------------------------------

# print()
# for x in range(2,6,2):
#     print(x)

# new = []

# # print(dir(new))


# # print()
# # print(dir(Carro))  


# # class Carro():
# #     c='red'
# # p1 = Carro.c
# # print(p1)
# new.append('israel')
# new.append('james')
# new.append('Maico')

# for x in new:
#     print('Olá ' + x + ' Vamos jogar Xadrez ? ')


# dic = {'nome' :'israel', 'idade': 38}

# for chave,valor in dic.items():
#     print(chave,":",valor)

# --------------------------17-02-2021-----------------------------
range(5)
print(range(10))

num = list(range(10))
print(num)
print(len(num))

# range(0, 10)
# [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

# print(dir(list))

new = num.reverse()
print(new)

# help(num.reverse())

"""





















