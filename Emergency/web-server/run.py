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



@app.route('/api/capteur', methods=['GET'])
def api_sensor():
    cur = conn.cursor()
    query = "SELECT id, id_modele_capteur, code, latitude, longitude, ligne, colonne, intensity, date FROM capteur" 
    cur.execute(query)
    rows = cur.fetchall()
    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["id"] = int(row[0])
        d["id_modele_capteur"] = int(row[1])
        d["code"] = row[2]
        d["latitude"] = int(row[3])
        d["longitude"] = int(row[4])
        d["row"] = int(row[5])
        d["column"] = int(row[6])
        if row[7]:
            d["value"] = int(row[7])
        else :
            d["value"] = None
        d["date"] = row[8]
        objects_list.append(d)
    return jsonify(objects_list)

@app.route('/api/caserne', methods=['GET'])
def api_caserne_get():
    cur = conn.cursor()
    query = "SELECT id, nom, adresse, code_postal, ville, tel, longitude, latitude FROM caserne" 
    cur.execute(query)
    rows = cur.fetchall()
    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["id"] = int(row[0])
        d["nom"] = row[1]
        d["adresse"] = row[2]
        d["code_postal"] = row[3]
        d["ville"] = row[4]
        d["tel"] = row[5]
        d["longitude"] = row[6]
        d["latitude"] = row[7]
        objects_list.append(d)
    return jsonify(objects_list)

@app.route('/api/caserne', methods=['POST'])
def api_caserne_post():
    caserne=request.json
    requete = "update caserne set"
    for key in caserne:
        if key=="nom" & caserne[key]!=None:
            requete += "nom =" + caserne[key]
        if key=="adresse" & caserne[key]!=None:
            requete += "adresse =" + caserne[key]
        if key=="code_postal" & caserne[key]!=None:
            requete += "code_postal =" + caserne[key]
        if key=="ville" & caserne[key]!=None:
            requete += "ville =" + caserne[key]
        if key=="tel" & caserne[key]!=None:
            requete += "tel =" + caserne[key]
        if key=="longitude" & caserne[key]!=None:
            requete += "longitude =" + caserne[key]
        if key=="latitude" & caserne[key]!=None:
            requete += "latitude =" + caserne[key]
    requete += "where id = %s"
    cur = conn.cursor()
    values = (caserne["id"])
    cur.execute(requete, values)
    conn.commit()

@app.route('/api/caserne', methods=['PUT'])
def api_caserne_put():
    caserne=request.json
    caserne[id]
    requete = "insert into caserne (nom,adresse,code_postal,ville,tel,longitude,latitude) values (%s, %s,%s, %s, %s, %s,%s) " 
    values = (caserne["nom"],caserne["adresse"],caserne["code_postal"],caserne["ville"],caserne["tel"],caserne["longitude"],caserne["latitude"])
    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()
    cur = conn.cursor()
    values = (caserne["id"])
    cur.execute(requete, values)
app.run()