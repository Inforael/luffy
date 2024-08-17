 
 arq = open('Estudo/SELLOUT.txt', 'r')
 saudacao = arq.read()
 arq.close()

 for i in arq:
     pinrt(arq)

"""
https://cadernoscicomp.com.br/tutorial/introducao-a-programacao-em-python-3/manipulando-arquivos/
Lendo arquivos de textos
Vamos ver como abrir arquivos de texto para ler os dados neles.

Primeiro no diretório que você vem usando para seguir esse tutorial crie um arquivo um outro diretório 
chamado data dentro desse diretório crie o arquivo de texto saudacao.txt:

Olá Mundo!
Eu adoro programar em Python.
Usando o método read()
Para abrir um arquivo somente para leitura em um programa Python usamos a função open()
tendo como argumento o nome e o caminho até arquivo,
 o caminho pode ser absoluto ou relativo, e como opcional um segundo argumento o caractere “r”.

No terminal abra o interpretador Python dentro do diretória pai do diretório data recém criado
 e depois tente abrir o arquivo saudacao.txt para leitura conforme mostrado abaixo, 
 de estiver no Windows lembre-se de usar \ ao invés de /:

>>> arq = open('data/saudacao.txt', 'r')
>>> saudacao = arq.read()
>>> arq.close()
>>> saudacao
'Olá Mundo!\nEu adoro programar em Python\n'
>>> 
No interpretador nos abrimos o arquivo saudacao.txt passando o caminho relativo como argumento da função open(), lemos o seu conteúdo com o método read() que coloca todo o conteúdo do arquivo em uma string única, depois disso nós fechamos o arquivo uma vez que já temos os dados dele para trabalhar. Repare que cada frase da string tem no final um caractere de nova linha “\n”. Que tal usarmos o método split() para strings e criarmos uma lista de strings:

>>> arq = open('data/saudacao.txt', 'r')
>>> saudacao = arq.read()
>>> arq.close()
>>> saudacao
'Olá Mundo!\nEu adoro programar em Python\n'
>>> lista_saudacao = saudacao.split('\n')
>>> lista_saudacao
['Olá Mundo!', 'Eu adoro programar em Python', '']
>>> 
No exemplo acima olhando para o último elemento da lista podemos ver claramente que o método read() criou uma nova linha em branco quando leu o arquivo.

Usando readline()
Podemos também ler uma linha por vez com o método readline():

>>> arq = open('data/saudacao.txt', 'r')
>>> linha = arq.readline()
>>> linha
'Olá Mundo!\n'
>>> linha = arq.readline()
>>> linha
'Eu adoro programar em Python\n'
>>> arq.close()
>>>
Usando readlines()
Uma outra forma de lermos arquivos é com o método readlines() esse método retorna uma lista contendo as linhas do arquivo como itens:

>>> arq = open('data/saudacao.txt')
>>> saudacao = arq.readlines()
>>> saudacao
['Olá Mundo!\n', 'Eu adoro programar em Python\n']
>>> arq.close()
>>> 
No exemplo acima abrimos o arquivo para leitura sem passar o argumento ‘r’ pois para abrir arquivos no modo somente leitura tanto faz usar o segundo argumento, no caso de abrirmos arquivos para escrita o segundo argumento é obrigatório como veremos na próxima seção.

Escrevendo em arquivos de textos
Uma das melhores formas de preservar seus dados depois que o programa é encerrado e colocando eles em um arquivo. Para escrevermos no arquivo precisamos abrir ele como open() é obrigatoriamente passar um segundo argumento que pode ser o caractere ‘w’ ou ‘a’ sendo que:

w – cria um novo arquivo para escrita, se o arquivo já existir ele irá apagar o arquivo existente por isso tome cuidado.
a – abre um arquivo se ele existir e começa a adicionar novo texto no final do arquivo, se o arquivo não existir ele cria o arquivo.
Usando write
Para escrever os dados usamos a função write() que leva como argumento a string que desejamos gravar no nosso arquivo:

>>> arq = open('data/filmes.txt', 'w')
>>> arq.write('Tubarão')
7
>>> arq.write('O Podereso Chefão')
17
>>> arq.close()
>>> 
No exemplo acima criamos um arquivo filmes.txt e escrevemos nele dois filmes, repare que o método write nós retorna o número de caracteres que foram escritos no arquivo. Feche o interpretador, não sem antes fechar o arquivo, abra o arquivo filmes.txt com um editor de textos e veja o que está gravado nele, provavelmente ele estará da forma mostrada abaixo:

TubarãoO Podereso Chefão
A opção with
Uma coisa fundamental e lembrarmos de fechar o arquivo se não ao sairmos do interpretador ou do programa em execução iremos perder todas as escritas feitas no arquivo. Para não corrermos esse risco podemos usar o comando with sua sintaxe é:

with open(arquivo, ‘w’) as arq:
suite
o comando with fecha o arquivo automaticamente assim que saímos de sua suite.

Vamos agora abrir novamente o arquivo filmes.txt e reinserir nossos filmes com a quebra de linha, lembre-se ao usarmos o argumeto ‘w’ ele sempre irá apagar o arquivo existente para que comecemos a escrever a partir do zero:

>>> with open('data/filmes.txt', 'w') as arq:
...     arq.write('Tubarão\n')
...     arq.write('O Poderoso Chefão')
... 
8
17
>>>
Abra novamente o arquivo filmes.txt e veja se ele se encontra como abaixo:

Tubarão
O Poderoso Chefão
O arquivo filmes.txt foi criado e contem dois filmes, vamos agora abrir novamente o arquivo para inserir mais alguns filmes.

Para inserir novos filmes no arquivo filmes.txt devemos abrir ele para escrita só que desta vez usando como segundo argumento do método open() o caractere ‘a’ uma vez que queremos inserir novos títulos sem apagar os já existentes:

>>> with open('data/filmes.txt', 'a') as arq:
...     arq.write('\nAliens, O Resgate\n')
...     arq.write('De Volta Para O Futuro')
... 
18
22
>>> 
Que tal criarmos um programa para criar e administrar uma lista de nossos filmes favoritos, o programa filmes.py abaixo faz isso:

Este programa é um pouco mais complexo dos que fizemos até agora:

logo no começo buscamos saber qual é o sistema operacional usando sys.platform, para usarmos a função de limpeza de tela de acordo com ele,
criamos uma função lambda para limpar a tela usando a função os.system() que executa o comando passada como argumento no terminal. Se o sistema operacional não for nem Linux, nem Windows, criamos uma função lambda que não faz nada para não quebrar o programa,
usamos também o comando sys.exit() com o argumento zero informando que o programa encerrou sem problemas, sem esse comando o programa ficaria em um loop constante,
as demais instruções já são conhecidas recomendo que análise o código, veja se consegue melhorá-lo.
#!/usr/bin/env python3
"""Programa para administrar uma lista com os filmes favoritos"""
import os
import sys

# Pega qual é o SO
so = sys.platform
so_clear = ''

# Defini o argumento para limpeza de tela de acordo com o SO
if (so == 'linux'):
    so_clear = 'clear'
elif (so[:3] == 'win'):
    so_clear = 'cls'

# Função lambda para limpeza de tela
if so_clear:
    limpar = lambda l: os.system(l)
else:
    limpar = lambda l: l

def main():
    """Inicializa o programa"""

    limpar(so_clear)
    print('Programa para administrar sua lista de filmes favoritos')
    print()

    while True:
        print()
        print('Escolha uma das opções abaixo\n')
        print('1 - Ver a lista')
        print('2 - Adicionar filmes na lista')
        print('3 - Excluir filmes da lista')
        print('0 - Sair\n')

        opcao = input('Entre com o número da opcao: ')
        print()

        if (opcao == '1'):
            ver()
        elif (opcao == '2'):
            adicionar()
        elif (opcao == '0'):
            sys.exit(0)
        else:
            print('Opcao inválida')
def existe():
    """Verifica se o arquivo filmes.txt existe"""
    if os.path.isfile('data/filmes.txt'):
        return 'data/filmes.txt'
    else:
        return ''

def ver():
    """Mostra na tela do terminal 20 itens por vez da lista de filmes"""

    arq = existe()
    if not arq:
        input("O arquivo filmes.txt ainda não foi "
              "criado, tecle enter para continuar")
        return

    limpar(so_clear)
    print("Lista de Filmes:")
    print("(tecle enter para continuar)\n")
    with open(arq, 'r') as arquivo:
        filmes = arquivo.readlines()
        x = 0

        for filme in filmes:
            # Aqui declaramos end como um carcter vazio pois os
            # itens no arquivo já possuem um caracter de nova linha
            print(filme, end='')
            if x > 20:
                x = 0
                input()
            x += 1

def adicionar():
    """Adiciona filmes ao arquivo"""
    filmes = []
    opcao = 'a'
    arq = existe()

    if not arq:
        opcao = 'w'

    limpar(so_clear)
    print("Entre com os filmes digite 0 para sair")
    while True:
        filme = input()
        if filme != '0':
            filmes.append(filme)
        else:
            break

    with open(arq, opcao) as arquivo:
        for filme in filmes:
            # insere um caracter de nova linha até o penultimo item
            arquivo.write("{0}{1}".format(filme, '\n'))

        return

main())


"""