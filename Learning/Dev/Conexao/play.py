
import random


print("*****************")
print(" Programa de jogo")
print("*****************")

print("Qual nível de dificuldade você deseja ?")
print("(1) Fácil (2) Médio (3) Difícil")
nivel = int(input("Digite o nível escolhido"))

if(nivel == 1):
    total_tentativas = 3
elif (nivel == 2):
    total_tentativas = 4
else:
    total_tentativas = 5

rodada = 1

for rodada in range(1,total_tentativas):
    numero_secreto = random.randrange(1,101) 
    print("Tentativa {} de {}".format(rodada,n))
    chute_str = input("Digite o número emtre 1 e 100")
    print("você digitou", chute_str )
    chute = int(chute_str)

    if(chute < 1 or chute > 100):
        print("você deve digitar um valor entre 1 e 100")
        continue

    acertou = chute == numero_secreto
    maior   = chute > numero_secreto
    menor   = chute < numero_secreto

    if(acertou):
        print("você acertou!")
        break
    else:
        if(maior):
            print("você errou! O seu chute foi maior do que o número secreto")
            print("O número secreto é:",numero_secreto)
        elif(menor):
            print("você errou! O seu chute foi menor do que o número secreto")
            print("O número secreto é:",numero_secreto)
    total_tentativas = total_tentativas + 1 
    rodada  = rodada +1     

print("Fim do jogo")
    

    

