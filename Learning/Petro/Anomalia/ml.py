import pandas as pd
import site
from httpx import get 

"""
print(site.getsitepackages())

print(get("https://www.google.com/"))

print("Olá mundo")


"""
"""

df = pd.DataFrame([[1, 2], [3, 4]], columns = ['a','b'])
df2 = pd.DataFrame([[5, 6], [7, 8]], columns = ['a','b'])

df = df.append(df2)

# Drop rows with label 0
df = df.drop(0)

print(df)

"""

#importa a bibliotea pandas
import pandas as pd
#importa a biblioteca math para verificar se um campo float64 e null
import math
#biblioteca que executa comandos "shell"
import os
#biblioteca de execoes
import pandas.io.common
#biblioteca para add numero da linha no arquivo - funcao arange
import numpy as np
#biblioteca de data
from datetime import date
#biblioteca regex
import re


Print("Olá meu nome é Rita")