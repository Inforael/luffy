from string import Template
from datetime import datetime
from email.mime.multipart import MIMEMultipart 
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
import smtplib


# meu_email = 'rael.x@hotmail.com'
# minha_senha = 'R@el198237'


meu_email = 'inforael@gmail.com'
minha_senha = 'S@ldanha123'


with open('template.html', 'r') as html:
    template = Template(html.read())
    data_atual = datetime.now().strftime('%d/%m/%y')
    corpo_msg = template.substitute(nome='Israel Teixeira', data=data_atual)


msg = MIMEMultipart()
msg['from'] = 'Israel de Oliveira Teixeira'
msg['to'] = 'israel.teixeira@netpartners.com.br'
msg['subject'] = 'Segue e-mail de test'

corpo = MIMEText(corpo_msg, 'html')
msg.attach(corpo)


with open('Relatório.jpg', 'rb') as img:
    img = MIMEImage(img.read())
    msg.attach(img)

# with smtplib.SMTP(host='smtp.gmail.com', port=587) as smtp:
# with smtplib.SMTP(host='Smtp.live.com', port=587) as smtp:
# https://www.serversmtp.com/pt-pt/servidores-smtp/  
# https://humberto.io/pt-br/blog/enviando-e-recebendo-emails-com-python/  

with smtplib.SMTP(host='smtp.gmail.com', port=587) as smtp:
    smtp.ehlo()
    smtp.starttls()
    smtp.login(meu_email, minha_senha)
    smtp.send_message(msg)
    print('E-mail enviado com sucess')









   