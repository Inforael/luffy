
import pandas as pd
import spacy 
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import plotly.express as px
from spacy.lang.pt.examples import sentences
from spacy import displacy

nlp = spacy.load("pt_core_news_sm")


for s in sentences:
    print(s, '\n')


# Criando o objeto spacy
nlp = spacy.load("pt_core_news_sm")
doc = nlp(sentences[0])
print(doc.text)


for token in doc:
    print(token.text)


for token in doc:
    print(token.text, token.lemma_)


for ent in doc.ents:
    print(ent.text, ent.label_)


for token in doc:
    print(token.text, token.pos_)


for token in doc:
    print(token.text, "-->", token.dep_)




displacy.render(doc)

