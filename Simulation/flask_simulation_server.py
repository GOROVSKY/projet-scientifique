import flask
from flask import request, jsonify
import psycopg2,collections
import psycopg2.extras
import datetime, json


app = flask.Flask(__name__)
app.config["DEBUG"] = True

conn = psycopg2.connect(host="127.0.0.1",port="5432",dbname="Simulation", user="postgres", password="postgres")


@app.route('/', methods=['GET'])
def home():
    return '''<h1>PROJET SCIENTIFIQUE</h1>
<p>AHAHAH Rémi il pue</p>'''


# A route to return all of the available entries in our catalog.
@app.route('/api/sensor', methods=['POST'])
def api_sensor():
    if request.method == 'POST':
        sensor=request.json
        count = 0
        print(sensor["id"])
        cur = conn.cursor()
        query = "update sensor set value = %s, date = %s where id = %s "
        values = (sensor["value"], datetime.datetime.now(),sensor["id"])
        cur.execute(query, values)
        conn.commit()
        count +=1
        print(count, "lignes mis à jour dans la table sensor")
        return sensor

# A route to return all of the available entries in our catalog.
@app.route('/api/sensors', methods=['GET', 'POST'])
def api_sensors():
    if request.method == 'GET':
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor);
        query = "SELECT id, code, latitude, longitude, row, sensor.column, value, date, type_id FROM sensor"
        cur.execute(query)
        rows = cur.fetchall()
        objects_list = []
        for row in rows:
            d = collections.OrderedDict()
            d["id"] = int(row['id'])
            d["code"] = row['code']
            d["latitude"] = int(row['latitude'])
            d["longitude"] = int(row['longitude'])
            #d["row"] = int(row['row'])
            #d["column"] = int(row['column'])
            if row[6]:
                d["value"] = int(row['value'])
            else :
                d["value"] = 0
            d["date"] = row['date']
            d["type_id"] = int(row['type_id'])
            objects_list.append(d)
        return jsonify(objects_list)
    elif request.method == 'POST':
        sensors=request.json
        count = 0
        for sensor in sensors:
            print(sensor["id"])
            cur = conn.cursor()
            query = "update sensor set value = %s, date = %s where id = %s "
            values = (sensor["value"], datetime.datetime.now(),sensor["id"])
            cur.execute(query, values)
            conn.commit()
            count +=1
        print(count, "lignes mis à jour dans la table sensor")
        return sensors

app.run(host='0.0.0.0')
