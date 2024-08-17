from datetime import datetime
from locale import setlocale, LC_ALL
from calendar import mdays

# https://docs.python.org/3/library/datetime.html#module-datetime
# https://docs.python.org/2/library/datetime.html

setlocale(LC_ALL, '')
setlocale(LC_ALL, 'pt_BR.utf-8')

dt = datetime.now()
mes_atual = int(dt.strftime('%m'))
ultimo_dia_mes = mdays[mes_atual]

# sábado, 13 de julho de 2019
formatacao1 = dt.strftime('%A, %d de %B de %Y')
# 13/07/2019 11:21:20
formatacao2 = dt.strftime('%d/%m/%Y %H:%M:%S')

print(formatacao1, formatacao2)
print(mes_atual, mdays[mes_atual])

"""
Último dia do mês em ano bissexto

from calendar import monthrange
 
# Retorna uma tupla contendo o número do dia na semana (0-6)
# e último dia de fevereiro de 2020
print(monthrange(2020, 2))
 
# Saída - (5, 29)
# O 5 significa que é um sábado
# O 29 significa que este é o último dia do mês

from calendar import monthrange
dia_semana, ultimo_dia = monthrange(2020, 2)
print(ultimo_dia)  # Saída: 29 (último dia de fevereiro de 2020)


from datetime import datetime
from calendar import monthrange
 
ultimos_dias_de_meses_do_ano_atual = [
    monthrange(datetime.now().year, mes)[1] for mes in range(1, 13)
]
print(ultimos_dias_de_meses_do_ano_atual)
# Saída: [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
# Observação: meu ano atual é 2020 neste momento



"""
