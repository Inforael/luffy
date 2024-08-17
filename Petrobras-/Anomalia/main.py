distribuidor =  ['CBN', 'IKEDA', 'REAL', 'PEIXOTO', 'E A FRIEDRICH', 'ZAMBONI']

cliente = ['Rodolfo','Victor','Gabriel']

Atendente = ['israel','Fabio','lady']

print(distribuidor,cliente,Atendente)


var=[]

while True:
  msg = int(input('Digite 1 para iniciar ou 2 para sair'))
  print(msg)
  if (msg ==1 ):
    for x in range(0,4):
      var.append(int(input('Digite um valor:')))
    print(var)
  else:
    print('Esperamos você da próxima vez :)')
    break