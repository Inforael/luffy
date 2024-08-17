

"""
Code to communicate with Power BI REST API.
(c) Pablo Santos, 2020

"""
from email_log import gera_html
from email_log import envia_email
from datetime import timedelta
from datetime import datetime
from datetime import date
import requests
import config
import time
import json

try:
	def get_access_token(application_id, application_secret, user_id, user_password):
		data = {
			'grant_type': 'password',
			'scope': 'openid',
			'resource': config.RESOURCE,
			'client_id': application_id,
			'client_secret': application_secret,
			'username': user_id,
			'password': user_password
		}
		token = requests.post(config.MICROSOFT_TOKEN, data=data)
		assert token.status_code == 200, "Fail to retrieve token: {}".format(token.text)
		return token.json()['access_token']

	def make_headers(application_id, application_secret, user_id, user_password):
		return {
			'Content-Type': 'application/json; charset=utf-8',
			'Authorization': "Bearer {}".format(get_access_token(application_id, application_secret, user_id, user_password))
		}

	def refreshes(application_id, application_secret, user_id, user_password, group_id, datasets):
		endpoint = "https://api.powerbi.com/v1.0/myorg/groups/{}/datasets/{}/refreshes".format(group_id, datasets)
		headers = make_headers(application_id, application_secret, user_id, user_password)
		res = requests.post(endpoint, headers=headers, json={"accessLevel": "View"})
		return res

	def get_status(application_id, application_secret, user_id, user_password, group_id):
		endpoint = endpoint = "https://api.powerbi.com/v1.0/myorg/datasets/{}/refreshes?$top=1".format(group_id)
		headers = make_headers(application_id, application_secret, user_id, user_password)
		return requests.get(endpoint, headers=headers).json()

	def normalize_data(data_status):	
		normalize = (19 - len(data_status))
		data_status = data_status.replace("T", " ")
		data_status = data_status[:normalize]
		data_status = datetime.strptime(data_status, '%Y-%m-%d %H:%M:%S')
		data_status = data_status - timedelta(hours=3)
		return data_status

	loop = True
	list_status = []

	def return_dict(): 
		SendEmail = [] 
		SendEmail.append(False)
		dict_texto = '{}'
		email_dados = json.loads(dict_texto)
	
		for datasets in config.DATASETS_LIST:
			
			DATASET = datasets[0]	
			email_dados.update({DATASET:{}})
	
			json_status = get_status(config.APPLICATION_ID, 
									 config.APPLICATION_SECRET, 
									 config.USER_ID, 
									 config.USER_PASSWORD, 
									 datasets[1])
			time.sleep(5)
			try:
				date_str_start = normalize_data(json_status["value"][0]['startTime'])
			except KeyError:
				date_str_start = date.today() - timedelta(days=1) 
	
			print(date_str_start) 
			if date_str_start.strftime('%Y-%m-%d') == date.today().strftime('%Y-%m-%d'):
				SendEmail.append(True)
				try:
					if json_status["value"][0]['status'] == 'Failed':
						email_dados[DATASET].update({"Status": json_status["value"][0]['status']}) 
						email_dados[DATASET].update({"StartTime": date_str_start})
						erro_json = json.loads(json_status["value"][0]['serviceExceptionJson'])
						email_dados[DATASET].update({"Exception": erro_json['errorDescription']})
	
						#refreshes(config.APPLICATION_ID, config.APPLICATION_SECRET, config.USER_ID, config.USER_PASSWORD, config.GROUP_ID, datasets)
	
					elif json_status["value"][0]['status'] == 'Unknown':
						email_dados[DATASET].update({"Status": json_status["value"][0]['status']})
						email_dados[DATASET].update({"StartTime": date_str_start})
						email_dados[DATASET].update({"Exception": "in progress"})
					
					else:
						email_dados[DATASET].update({"Status": json_status["value"][0]['status']})
						email_dados[DATASET].update({"StartTime": date_str_start})
						email_dados[DATASET].update({"EndTime": normalize_data(json_status["value"][0]['endTime'])})
				
				except:
					email_dados[DATASET].update({"Status": 'Failed'})
					email_dados[DATASET].update({"StartTime":"is not found!"})
					email_dados[DATASET].update({"EndTime":"is not found!"})
			
			else:
				try:
					email_dados[DATASET].update({"Status": 'Failed'})
					email_dados[DATASET].update({"StartTime": date_str_start})
					email_dados[DATASET].update({"EndTime": normalize_data(json_status["value"][0]['endTime'])})
				except KeyError:
					email_dados[DATASET].update({"Status": 'Failed'})
					email_dados[DATASET].update({"StartTime":"is not found!"})
					email_dados[DATASET].update({"EndTime":"is not found!"})
	
				SendEmail.append(False)
	
		return email_dados, SendEmail

	loop = True
	while loop:
		email_dados, SendEmail = return_dict()
		
		if True in SendEmail:
			email_texto = gera_html.gera_html_log(email_dados,'STATUS POWER BI')
			envia_email.send_email(config.EMISSOR, config.PASS_EMISSOR, config.RECEBEDOR, config.ASSUNTO_EMAIL, email_texto)
			
			if not 'Failed' in str(email_dados) and not 'Unknown' in str(email_dados):
				loop = False
		
		time.sleep(1800) #30min

except Exception as e:
	file_log = open("log.txt","w") 
	file_log.write(str(e))
	file_log.close() 