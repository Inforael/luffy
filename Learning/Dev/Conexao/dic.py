

import copy
# Comentário
#--Cmd Dic
#Para a declaração de dic é necessário seguir algumas regras
#Faça a declaração do dic sellout, colocar igual = seguido da chave {}
#o primeiro atributo que se refere a coluna precisa de duas aspas "",  "data"
#a atribuição para dic na coluna não se usa =  e sim : ex: "data" : "19/08/2019",

"""
sellout = {
             "data" : "19/08/2019",
             "distribuidor" : "alvo",
             "pdvid": "121314"
             }

print('Carga de hoje:')
print(sellout['data'])
print(sellout['distribuidor'])
print(sellout['pdvid'])

indirect_data = { 
                  "dataid": "1",
                  "clusterid": "97819",
                  "skuid": "123",
                  "pdvid": ['12523','30861','167800']


}

print(indirect_data ['pdvid'])

"""

"""-----------------------------------------------------------------------------------------------

Dicionários também podem ser criados dinamicamente como no exemplo baixo. """

"""
dic = {}
dic['name'] = "joao"
dic['age']  = "39"


print (dic)


d = {'a': 'apple', 'b': 'berry', 'c': 'cherry'}

for key in d:
    print (key + " " + d[key])
    print (d[key])  


dic02 = {}

dic02['nome'] = 'kim'
dic02['idade'] = '40'
dic02['cargo'] = 'vendedor'
dic02['distribuidor'] = 'RB'

for x in dic02:
    print(dic02)
    print(dic02['nome'])

webster = {
    "Aardvark" : "A star of a popular children's cartoon show.",
    "Baa" : "The sound a goat makes.",
    "Carpet": "Goes on the floor.",
    "Dab": "A small amount."
}

for word in webster:
    print( webster[word])
    
my_dict = {
    "1": "a",
    "2": "b",
    "3": "c"
}

my_dict.items()  # dict_items([('1', 'a'), ('3', 'c'), ('2', 'b')])
my_dict.keys()   # dict_keys(['1', '3', '2'])
my_dict.values() # dict_values(['a', 'c', 'b'])

print(my_dict.items())
print(my_dict.keys())
print(my_dict.values())
print(my_dict.values())



Kcc_dic = {
             'data':'21/08/2019',
             'distribuidor': 'triufante',
             'cidade':'São Paulo',
             'Quantidade': 200
}

#print(Kcc_dic)
#print(Kcc_dic.keys())     Kcc_dic ([('data'),('distribuidor'),('triufante')])
#print(Kcc_dic.items())    Kcc_dic ([('data',21/08/2019'),('distribuidor', triufante'),('cidade','São Paulo'),('Quantidade','200')])
#print(Kcc_dic.values())   Kcc_dic (['21/08/2019','triufante','São Paulo'])

print(Kcc_dic)
print(Kcc_dic.keys()) 
print(Kcc_dic.items()) 
print(Kcc_dic.values()) 

#-----------------------------------------------------------------------------------------------------
"""

clientes = {
            'cliente1': {'nome': 'Luiz', 'sobrenome':'Otávio','idade': 37},
            'cliente2': {'nome': 'joão','sobrenome': 'teixera','idade':23},
            'cliente3': {'nome': 'pedro','sobrenome': 'Oliveria','idade':10},

           }       

for cli_k, cli_v in clientes.items():
   # print(f'Exibindo {cli_v}')
    for dados_k, dados_v in cli_v.items():
        print(f'\t{dados_k} = {dados_v}')



"""       

Exibindo {'nome': 'Luiz', 'sobrenome': 'Otávio', 'idade': 37}
        nome = Luiz
        sobrenome = Otávio
        idade = 37
Exibindo {'nome': 'joão', 'sobrenome': 'teixera', 'idade': 23}
        nome = joão
        sobrenome = teixera
        idade = 23
Exibindo {'nome': 'pedro', 'sobrenome': 'Oliveria', 'idade': 10}
        nome = pedro
        sobrenome = Oliveria
        idade = 10

        """

""" ---------------------------------------------------------------------------------------------------------"""

dir(print)


