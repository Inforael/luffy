# entrada = input('Digite um número : \n\n')

# print('\n'f'O valor digitado foi: {entrada} ')

# if entrada.isdecimal():
#     entrada_int = int(entrada)
#     par_impar = entrada_int % 2 == 0
#     par_impar_texto = 'impar'

#     if par_impar:
#         par_impar_texto = 'par'

#     print(f'O número {entrada_int} é {par_impar_texto}')
# else:
#     print('Você não digitou um número inteiro')       

################################################################33

entrada = input('Digite a hora: ''\n')

try:
    hora = int(entrada)
    if hora >=0 and hora <= 12:
        print('Bom dia !')
    if hora >=13 and hora <= 17:
       print('Bom tarde !')
    if hora >=18 and hora <= 23:
        print('Bom noite !') 
    else:
        print( 'Não conheço essa hora')    

except:

    print('Por favor digitar uma hora valida: ''\n')

    


