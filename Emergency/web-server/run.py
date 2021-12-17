import flask
from flask import request, jsonify
from flask_cors import CORS,cross_origin
import psycopg2,collections
import datetime, json


app = flask.Flask(__name__)
app.config["DEBUG"] = True

CORS(app, resources={r"/*": {"origins": "*"}})
app.config['CORS_HEADERS'] = 'application/json'


conn = psycopg2.connect(host="127.0.0.1",port="5432",dbname="Emergency", user="postgres", password="pierre")


@app.route('/', methods=['GET'])
def home():
    return '''<h1>PROJET SCIENTIFIQUE</h1>
<p>AHAHAH Rémi il pue</p>'''


# A route to return all of the available entries in our catalog.
@app.route('/api/historique', methods=['GET', 'POST'])
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
        sensor=request.json 
        count = 0
        print(sensor["id"])
        cur = conn.cursor()
        query = "update capteur_donne set valeur = %s, date = %s where id_capteur = %s and id_type_capteur = %s" 
        values = (sensor["valeur"], datetime.datetime.now(),sensor["id_capteur"],sensor["id_type_capteur"])
        cur.execute(query, values)
        conn.commit()
        query = "insert into historique (id_capteur,id_type_capteur,valeur,date) values (%s,%s,%s) " 
        values = (sensor["value"], datetime.datetime.now(),sensor["id"])
        cur.execute(query, values)
        conn.commit()
        count +=1
        print(count, "lignes mis à jour dans la table sensor")
        return sensor



@app.route('/api/capteur', methods=['GET'])
def api_sensor():
    cur = conn.cursor()
    query = "SELECT id, id_modele_capteur, code, latitude, longitude, ligne, colonne FROM capteur" 
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
        d["ligne"] = int(row[5])
        d["colonne"] = int(row[6])
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
            requete += "longitude =" + str(caserne[key])
        if key=="latitude" & caserne[key]!=None:
            requete += "latitude =" + str(caserne[key])
    requete += "where id = %s"
    cur = conn.cursor()
    values = (caserne["id"])
    cur.execute(requete, values)
    conn.commit()

@app.route('/api/caserne', methods=['PUT'])
def api_caserne_put():
    caserne=request.json
    print(caserne)
    if "nom" in caserne & "adresse" in caserne & "code_postal" in caserne & "ville" in caserne & "tel" in caserne & "longitude" in caserne & "latitude" in caserne:
        requete = "insert into caserne (nom,adresse,code_postal,ville,tel,longitude,latitude) values (%s, %s,%s, %s, %s, %s,%s) " 
        values = (caserne["nom"],caserne["adresse"],caserne["code_postal"],caserne["ville"],caserne["tel"],caserne["longitude"],caserne["latitude"])
        cur = conn.cursor()
        cur.execute(requete, values)
        conn.commit()
    else :
        return {400,}
    return {201,}
