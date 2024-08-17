import os
import io
import pandas as df


from io import BytesIO
from google.cloud import storage
from google.resumable_media.requests import upload

os.environ ['GOOGLE_APPLICATION_CREDENTIALS'] = 'dol-bkt.json'

storage_client = storage.Client()

bkt_name = 'new-dol'
bucket_name = 'new-dol'
bucket = storage_client.create_bucket(bkt_name,location='southamerica-east1')

# --- Cmd primeira forma para up

filename = "%s/%s" % ('dir',"hello2.py")

bucket = storage_client.get_bucket('new-dol')

blob = bucket.blob(filename)

with open('hello2.py', 'rb') as f:
    blob.upload_from_file(f)
print("up completo")  

# ---------------------------------------------------------------

# --- Cmd Segunda forma para up

# bucket = storage_client.create_bucket(bkt_name,location='southamerica-east1')

# def carga(blob_name, file_path, bucket_name):
#     try:
#         bucket = storage_client.get_bucket(bucket_name)
#         blob = bucket.blob(blob_name)
#         blob.upload_from_filename(file_path)
#         return True
#     except Exception as e:
#         print(e)
#         return False

# file_path = r'C:\\Bko\\Python\Estudo\\MV\\Dol'
# carga('hello', os.path.join(file_path,'hello.py'),'new-dol')



""" def download(blob_name, file_path, bucket_name):
    try:
        bucket = storage_client.get_bucket(bucket_name)
        blob = bucket.blob(blob_name)
        with open(file_path,'wb') as f:
            storage_client.download_blob_to_file(blob, f)
        return True
    except Exception as e:
        print(e)
        return False """

# file_path = r'C:\Users\israel.teixeira\Documents'
# download('hello', os.getcwd(),'new-dol')

  











