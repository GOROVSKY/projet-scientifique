import flask
from flask import request, jsonify
import psycopg2,collections
import datetime, json


app = flask.Flask(__name__)
app.config["DEBUG"] = True

conn = psycopg2.connect(host="127.0.0.1",port="5432",dbname="Emergency", user="postgres", password="pierre")


@app.route('/', methods=['GET'])
def home():
    return '''<h1>PROJET SCIENTIFIQUE</h1>
<p>AHAHAH Rémi il pue</p>'''


# A route to return all of the available entries in our catalog.
@app.route('/api/sensor_data', methods=['GET', 'POST'])
def api_sensor_data():
    if request.method == 'GET':
        cur = conn.cursor()
        query = "SELECT id, code, latitude, longitude, row, sensor.column,value, date, type_id FROM sensor" 
        cur.execute(query)
        rows = cur.fetchall()
        objects_list = []
        for row in rows:
            d = collections.OrderedDict()
            d["id"] = int(row[0])
            d["code"] = row[1]
            d["latitude"] = int(row[2])
            d["longitude"] = int(row[3])
            d["row"] = int(row[4])
            d["column"] = int(row[5])
            d["intesity"] = int(row[6])
            d["date"] = row[7]
            d["type_id"] = row[8]
            objects_list.append(d)
        return jsonify(rows)
    elif request.method == 'POST':
        sensor=request.json #SENSORS
        count = 0
        #for sensor in sensors:
        print(sensor["id"])
        cur = conn.cursor()
        query = "update sensor set value = %s, date = %s where id = %s " 
        values = (sensor["value"], datetime.datetime.now(),sensor["id"])
        cur.execute(query, values)
        conn.commit()
        query = "insert into sensor_data_hst () values () " 
        values = (sensor["value"], datetime.datetime.now(),sensor["id"])
        cur.execute(query, values)
        conn.commit()
        count +=1
        print(count, "lignes mis à jour dans la table sensor")
        return sensor



@app.route('/api/sensors', methods=['GET'])
def api_sensor():
    cur = conn.cursor()
    query = "SELECT id, code, latitude, longitude, row, column, intensity, date FROM sensor" 
    cur.execute(query)
    rows = cur.fetchall()
    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["id"] = int(row[0])
        d["code"] = row[1]
        d["latitude"] = int(row[2])
        d["longitude"] = int(row[3])
        d["row"] = int(row[4])
        d["column"] = int(row[5])
        if row[6]:
            d["value"] = int(row[6])
        else :
            d["value"] = None
        d["date"] = row[7]
        objects_list.append(d)
    return jsonify(objects_list)

app.run()