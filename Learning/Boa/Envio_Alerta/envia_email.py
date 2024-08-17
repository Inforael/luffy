# -*- coding: utf-8 -*-

import smtplib
from  email.message import EmailMessage
from  datetime import date
from email.mime.text import MIMEText

def send_email(emissor, senha_emissor, recebedor, assunto_email_log, conteudo):
	
	email_content = conteudo
	try:

		msg            = MIMEText(email_content.encode("utf-8"), 'html','utf-8')
		msg['Subject'] = assunto_email_log
		password       = senha_emissor
		msg['From']    = emissor
		msg['To']      = ', '.join(recebedor)
		#msg['Cc']      = ""
		msg.add_header('Content-Type', 'text/html')
		#msg.set_payload(email_content)

		s = smtplib.SMTP_SSL('smtp.gmail.com', 465)
		# Login Credentials for sending the mail
		s.login(msg['From'], password)
		s.sendmail(msg['From'],recebedor, msg.as_string())
		s.close()
		
		print ("successfully sent email to %s:" % (msg['To']))
	
	except Exception as e:
		print('Process send_email ERROR!\n{0}'.format(e))