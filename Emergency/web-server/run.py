import flask
from flask import request, jsonify, abort
from flask_cors import CORS
import psycopg2
import psycopg2.extras
import collections
import datetime


app = flask.Flask(__name__)
app.config["DEBUG"] = True
app.config['CORS_HEADERS'] = 'Content-Type'

cors = CORS(app, resources={r"/*": {"origins": "*"}})

conn = psycopg2.connect(
    host="127.0.0.1",
    port="5432",
    dbname="Emergency",
    user="postgres",
    password="pierre")

@app.before_request
def oauth_verify(*args, **kwargs):
    """Ensure the oauth authorization header is set"""
    if request.method in ['OPTIONS', ]:
        return

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
        sensor = request.json
        count = 0
        print(sensor["id"])
        cur = conn.cursor()
        query = "update capteur_donne set valeur = %s, date = %s where id_capteur = %s and id_type_capteur = %s"
        values = (sensor["valeur"], datetime.datetime.now(),
                  sensor["id_capteur"], sensor["id_type_capteur"])
        cur.execute(query, values)
        conn.commit()
        query = "insert into historique (id_capteur,id_type_capteur,valeur,date) values (%s,%s,%s) "
        values = (sensor["value"], datetime.datetime.now(), sensor["id"])
        cur.execute(query, values)
        conn.commit()
        count += 1
        print(count, "lignes mis à jour dans la table sensor")
        return sensor




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
    caserne = request.json
    requete = "update caserne set"
    for key in caserne:
        if key == "nom" & caserne[key] != None:
            requete += "nom =" + caserne[key]
        if key == "adresse" & caserne[key] != None:
            requete += "adresse =" + caserne[key]
        if key == "code_postal" & caserne[key] != None:
            requete += "code_postal =" + caserne[key]
        if key == "ville" & caserne[key] != None:
            requete += "ville =" + caserne[key]
        if key == "tel" & caserne[key] != None:
            requete += "tel =" + caserne[key]
        if key == "longitude" & caserne[key] != None:
            requete += "longitude =" + str(caserne[key])
        if key == "latitude" & caserne[key] != None:
            requete += "latitude =" + str(caserne[key])
    requete += "where id = %s"
    cur = conn.cursor()
    values = (caserne["id"])
    cur.execute(requete, values)
    conn.commit()


@app.route('/api/caserne', methods=['PUT'])
def api_caserne_put():
    caserne = request.json
    print(caserne)
    if "nom" in caserne & "adresse" in caserne & "code_postal" in caserne & "ville" in caserne & "tel" in caserne & "longitude" in caserne & "latitude" in caserne:
        requete = "insert into caserne (nom,adresse,code_postal,ville,tel,longitude,latitude) values (%s, %s,%s, %s, %s, %s,%s) "
        values = (caserne["nom"], caserne["adresse"], caserne["code_postal"],
                  caserne["ville"], caserne["tel"], caserne["longitude"], caserne["latitude"])
        cur = conn.cursor()
        cur.execute(requete, values)
        conn.commit()
    else:
        return {400, }
    return {201, }



##### TYPE_CAPTEUR #####
@app.route('/api/typeCapteur', methods=['GET'])
@app.route('/api/typeCapteur/<id>', methods=['GET'])
def get_type_capteur(id = None):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    query = "SELECT id, libelle FROM type_capteur"

    if id is not None:
        query += f" WHERE id = {id}"

    cur.execute(query)
    rows = cur.fetchall()

    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["id"] = int(row["id"])
        d["libelle"] = row["libelle"]
        objects_list.append(d)
    return jsonify(objects_list)

@app.route('/api/typeCapteur', methods=['POST'])
def post_type_capteur():

    element = request.json
    if element.get("id") is None:
        abort(422)

    
    requete = "UPDATE type_capteur SET libelle = %s WHERE id = %s"
    values = (element["libelle"], element["id"])

    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()

    return "", 201

@app.route('/api/typeCapteur', methods=['PUT'])
def put_type_capteur():

    element = request.json
    if element.get("libelle") is None:
        abort(422)

    
    requete = "INSERT INTO type_capteur (libelle) VALUES (%s)"
    values = (element["libelle"],)

    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()

    return "", 201

@app.route('/api/typeCapteur/<id>', methods=['DELETE'])
def delete_type_capteur(id):
    
    if id is None:
        abort(422)

    requete = "DELETE FROM type_capteur WHERE id = %s"

    cur = conn.cursor()
    cur.execute(requete, (id,))
    conn.commit()

    return "", 200


##### MODELE_CAPTEUR #####
@app.route('/api/modeleCapteur', methods=['GET'])
@app.route('/api/modeleCapteur/<id>', methods=['GET'])
def get_modele_capteur(id = None):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    query = "SELECT id, libelle FROM modele_capteur"

    if id is not None:
        query += f" WHERE id = {id}"

    cur.execute(query)
    rows = cur.fetchall()

    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["id"] = int(row["id"])
        d["libelle"] = row["libelle"]
        objects_list.append(d)
    return jsonify(objects_list)

@app.route('/api/modeleCapteur', methods=['POST'])
def post_modele_capteur():

    element = request.json
    if element.get("id") is None:
        abort(422)

    
    requete = "UPDATE modele_capteur SET libelle = %s WHERE id = %s"
    values = (element["libelle"], element["id"])

    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()

    return "", 201

@app.route('/api/modeleCapteur', methods=['PUT'])
def put_modele_capteur():

    element = request.json
    if element.get("libelle") is None:
        abort(422)

    
    requete = "INSERT INTO modele_capteur (libelle) VALUES (%s)"
    values = (element["libelle"],)

    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()

    return "", 201

@app.route('/api/modeleCapteur/<id>', methods=['DELETE'])
def delete_modele_capteur(id):
    
    if id is None:
        abort(422)

    requete = "DELETE FROM modele_capteur WHERE id = %s"

    cur = conn.cursor()
    cur.execute(requete, (id,))
    conn.commit()

    return "", 200



##### CAPTEUR #####
@app.route('/api/capteur', methods=['GET'])
@app.route('/api/capteur/<id>', methods=['GET'])
def get_capteur(id = None):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    query = "SELECT c.id, c.id_modele_capteur, c.code, c.latitude, c.longitude, c.ligne, c.colonne, mc.libelle FROM capteur c "
    query += "LEFT JOIN modele_capteur mc ON c.id_modele_capteur = mc.id"

    if id is not None:
        query += f" WHERE id = {id}"

    cur.execute(query)
    rows = cur.fetchall()

    objects_list = []
    for row in rows:
        print(row["id"])
        d = collections.OrderedDict()
        d["id"] = int(row["id"])
        d["modeleId"] = int(row["id_modele_capteur"])
        d["modeleLibelle"] = row["libelle"]
        d["code"] = row["code"]
        d["latitude"] = int(row["latitude"])
        d["longitude"] = int(row["longitude"])
        # d["ligne"] = int(row["ligne"])
        # d["colonne"] = int(row["colonne"])
        objects_list.append(d)
    return jsonify(objects_list)

@app.route('/api/capteur', methods=['POST'])
def post_capteur():

    element = request.json
    if element.get("id") is None:
        abort(422)

    requete = "UPDATE capteur SET code = %s, latitude = %s, longitude = %s, id_modele_capteur = %s WHERE id = %s"
    values = (element["code"], element["latitude"], element["longitude"], element["modeleId"], element["id"])

    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()

    return "", 201

@app.route('/api/capteur', methods=['PUT'])
def put_capteur():

    element = request.json
    if element.get("code") is None or element.get("latitude") is None or element.get("longitude") is None or element.get("modeleId") is None :
        abort(422)
    
    requete = "INSERT INTO capteur (code, latitude, longitude, id_modele_capteur) VALUES (%s, %s, %s, %s)"
    values = (element["code"], element["latitude"], element["longitude"], element["modeleId"])

    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()

    return "", 201

@app.route('/api/capteur/<id>', methods=['DELETE'])
def delete_capteur(id):
    
    if id is None:
        abort(422)

    requete = "DELETE FROM capteur WHERE id = %s"

    cur = conn.cursor()
    cur.execute(requete, (id,))
    conn.commit()

    return "", 200