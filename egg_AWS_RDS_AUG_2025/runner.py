
import psycopg2
import os
import sys

db_host = os.getenv('DB_HOST') 
db_port = os.getenv('DB_PORT') 
db_name = os.getenv('DB_NAME')
db_user = os.getenv('DB_USER') 
db_pass = os.getenv('DB_PASS') 

db = psycopg2.connect(
    host=db_host,
    port=db_port,
    user=db_user,
    password=db_pass,
    dbname=db_name
)

cursor = db.cursor()
cursor.execute("SELECT version();")
db_version = cursor.fetchone()
print(f"Connected to database: {db_version[0]}")
cursor.close()

print('Ready.')