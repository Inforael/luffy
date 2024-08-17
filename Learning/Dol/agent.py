import schedule 
import time
import os
import pandas as df

from io import BytesIO
from google.cloud import storage
from google.resumable_media.requests import upload

os.environ ['GOOGLE_APPLICATION_CREDENTIALS'] = 'dol-bkt.json'



storage_client = storage.Client()

bkt_name = 'new-dol'
bucket_name = 'new-dol'
bucket = storage_client.create_bucket(bkt_name,location='southamerica-east1')
data = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())

# --- Cmd primeira forma para up

def agent2():
    filename = "%s/%s" % ('dir',"hello2.py")
    bucket = storage_client.get_bucket('new-dol')
    blob = bucket.blob(filename)
    with open('hello2.py', 'rb') as f:
        blob.upload_from_file(f)
        print("up completo", data)  


schedule.every(60).seconds.do(agent2) 

while 1:
    schedule.run_pending()
    time.sleep(1) 