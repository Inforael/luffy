import re

arq = 'How to replace multiple string in Python 02/12/2020 20:38'
# print(arq.upper())
# print(arq.upper().replace('','_'))
# arq2= arq.upper().replace('','_')
# print(arq2)
# print(arq2.replace('_','').replace('/','-').replace(':',''))

# change = ' '
# for char in change:
#     print(char)
#     print(arq.replace(char,'_'))

# print(len(arq))
# for char in arq:
#     print(arq.replace(char,'*'))

arq = re.sub('[ ]','_',arq).replace(':','-')
print(arq)


   



