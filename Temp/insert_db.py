import psycopg2
import datetime
from random import randrange
conn = psycopg2.connect(host="127.0.0.1",port="5432",dbname="Simulation", user="postgres", password="postgres")
cur = conn.cursor()

# query = "INSERT INTO \"sensor_data\" values (%s,%s,%s)"
# for id in range (60):
#     values = (id+1,0,datetime.datetime.now())
#     cur.execute(query,values)
# conn.commit()
# cur.close()
# conn.close()

query = "INSERT INTO \"sensor\" (id,type_id,value) values (%s,%s,%s)"
id=1
for row in range(7):
    for col in range(10):
        values = (id,1,randrange(5))
        cur.execute(query,values)
        id+=1
conn.commit()
cur.close()
conn.close()
