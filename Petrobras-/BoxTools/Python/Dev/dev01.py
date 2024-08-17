nome = input('Digite seu nome: ')
idade = input('Digiete sua idade: ')

# if nome and idade:
#     print(f' Seu nome é: {nome}')
#     print(f' Seu nome invertido é {0:-1}')
#     print(f' Sua idade é: {idade}')


# if nome and idade:
#     print(f' Seu nome é: {nome}')
#     print(f' Seu nome invertido é {nome[:-1]}')
#     print(f' Sua idade é: {idade}')    

if nome and idade:
    print(f' Seu nome é: {nome}')
    print(f' Seu nome invertido é: {nome[::-1]}')
    print(f' Sua idade é: {idade}')

    if ' ' in nome:
        print('seu nome contém espaço')
    else:
        print('Seu nome não contém espaço')
        print(f' Seu nome tem {len(nome)}, letras')
        print(f' A primeira letra do seu nome é: {nome[0]}')
        print(f' A ultima letra do seu nome é: {nome[-1]}')

else:
    print('Você não digitou nada')
