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


##### TYPE_CAPTEUR #####
@app.route('/api/typeCapteur', methods=['GET'])
@app.route('/api/typeCapteur/<id>', methods=['GET'])
def get_type_capteur(id=None):
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
def get_modele_capteur(id=None):
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
def get_capteur(id=None):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    query = "SELECT c.id, c.id_modele_capteur, c.code, c.latitude, c.longitude, c.ligne, c.colonne, mc.libelle FROM capteur c "
    query += "LEFT JOIN modele_capteur mc ON c.id_modele_capteur = mc.id"

    if id is not None:
        query += f" WHERE c.id = {id}"

    cur.execute(query)
    rows = cur.fetchall()

    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["id"] = int(row["id"])
        d["modeleId"] = int(row["id_modele_capteur"])
        d["modeleLibelle"] = row["libelle"]
        d["code"] = row["code"]
        d["latitude"] = int(row["latitude"])
        d["longitude"] = int(row["longitude"])
        d["ligne"] = row["ligne"]
        d["colonne"] = row["colonne"]
        objects_list.append(d)
    return jsonify(objects_list)


@app.route('/api/capteur', methods=['POST'])
def post_capteur():

    element = request.json
    if element.get("id") is None:
        abort(422)

    requete = "UPDATE capteur SET code = %s, latitude = %s, longitude = %s, id_modele_capteur = %s WHERE id = %s"
    values = (element["code"], element["latitude"],
              element["longitude"], element["modeleId"], element["id"])

    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()

    return "", 201


@app.route('/api/capteur', methods=['PUT'])
def put_capteur():

    element = request.json
    if element.get("code") is None or element.get("latitude") is None or element.get("longitude") is None or element.get("modeleId") is None:
        abort(422)

    requete = "INSERT INTO capteur (code, latitude, longitude, id_modele_capteur) VALUES (%s, %s, %s, %s)"
    values = (element["code"], element["latitude"],
              element["longitude"], element["modeleId"])

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


##### VEHICULE #####
@app.route('/api/vehicule', methods=['GET'])
@app.route('/api/vehicule/<id>', methods=['GET'])
def get_vehicule(id=None):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    query = "SELECT v.id, v.modele, v.num_immatriculation, v.capacite_personne, v.capacite_produit, v.type_produit, v.longitude, v.latitude, v.id_caserne, c.nom FROM vehicule v "
    query += "LEFT JOIN caserne c ON v.id_caserne = c.id"

    if id is not None:
        query += f" WHERE v.id = {id}"

    cur.execute(query)
    rows = cur.fetchall()

    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["id"] = int(row["id"])
        d["modele"] = row["modele"]
        d["num_immatriculation"] = row["num_immatriculation"]
        d["capacite_personne"] = int(row["capacite_personne"])
        d["capacite_produit"] = int(row["capacite_produit"])
        d["type_produit"] = row["type_produit"]
        d["longitude"] = row["longitude"]
        d["latitude"] = row["latitude"]
        d["caserne_id"] = row["id_caserne"]
        d["caserne_nom"] = row["nom"]
        objects_list.append(d)
    return jsonify(objects_list)


@app.route('/api/vehicule', methods=['POST'])
def post_vehicule():

    element = request.json
    if element.get("id") is None:
        abort(422)

    requete = "UPDATE vehicule SET modele = %s, num_immatriculation = %s, capacite_personne = %s, capacite_produit = %s, longitude = %s, latitude = %s, id_caserne = %s WHERE id = %s"
    values = (element["modele"], element["num_immatriculation"], element["capacite_personne"],
              element["capacite_produit"], element["longitude"], element["latitude"], element["caserne_id"], element["id"])

    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()

    return "", 201


@app.route('/api/vehicule', methods=['PUT'])
def put_vehicule():

    element = request.json
    if element.get("caserne_id") is None:
        abort(422)

    requete = "INSERT INTO vehicule (modele, num_immatriculation, capacite_personne, capacite_produit, longitude, latitude, id_caserne) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    values = (element.get("modele"), element.get("num_immatriculation"), element.get("capacite_personne"),
              element.get("capacite_produit"), element.get("longitude"), element.get("latitude"), element.get("caserne_id"))

    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()

    return "", 201


@app.route('/api/vehicule/<id>', methods=['DELETE'])
def delete_vehicule(id):

    if id is None:
        abort(422)

    requete = "DELETE FROM vehicule WHERE id = %s"

    cur = conn.cursor()
    cur.execute(requete, (id,))
    conn.commit()

    return "", 200


##### CASERNE #####
@app.route('/api/caserne', methods=['GET'])
@app.route('/api/caserne/<id>', methods=['GET'])
def get_caserne(id=None):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    query = "SELECT * FROM caserne"

    if id is not None:
        query += f" WHERE id = {id}"

    cur.execute(query)
    rows = cur.fetchall()

    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["id"] = int(row["id"])
        d["nom"] = row["nom"]
        d["adresse"] = row["adresse"]
        d["code_postal"] = row["code_postal"]
        d["ville"] = row["ville"]
        d["tel"] = row["tel"]
        d["longitude"] = row["longitude"]
        d["latitude"] = row["latitude"]
        objects_list.append(d)
    return jsonify(objects_list)


@app.route('/api/caserne', methods=['POST'])
def post_caserne():

    element = request.json
    if element.get("id") is None:
        abort(422)

    requete = "UPDATE caserne SET nom = %s, adresse = %s, code_postal = %s, ville = %s, tel = %s, longitude = %s, latitude = %s WHERE id = %s"
    values = (element["nom"], element["adresse"], element["code_postal"], element["ville"],
              element["tel"], element["longitude"], element["latitude"], element["id"])

    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()

    return "", 201


@app.route('/api/caserne', methods=['PUT'])
def put_caserne():

    element = request.json
    if element.get("nom") is None:
        abort(422)

    requete = "INSERT INTO caserne (nom, adresse, code_postal, ville, tel, longitude, latitude) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    values = (element.get("nom"), element.get("adresse"), element.get("code_postal"), element.get("ville"),
              element.get("tel"), element.get("longitude"), element.get("latitude"))

    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()

    return "", 201


@app.route('/api/caserne/<id>', methods=['DELETE'])
def delete_caserne(id):

    if id is None:
        abort(422)

    requete = "DELETE FROM caserne WHERE id = %s"

    cur = conn.cursor()
    cur.execute(requete, (id,))
    conn.commit()

    return "", 200

##### POMPIER #####
@app.route('/api/pompier', methods=['GET'])
@app.route('/api/pompier/<id>', methods=['GET'])
def get_pompier(id=None):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    query = "SELECT p.id, p.nom, p.prenom, p.age, p.tel, p.annees_experience, p.energie, p.id_caserne, c.nom AS caserne_nom FROM pompier p "
    query += "LEFT JOIN caserne c ON p.id_caserne = c.id"

    if id is not None:
        query += f" WHERE p.id = {id}"

    cur.execute(query)
    rows = cur.fetchall()

    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["id"] = int(row["id"])
        d["nom"] = row["nom"]
        d["prenom"] = row["prenom"]
        d["age"] = int(row["age"])
        d["tel"] = row["tel"]
        d["annees_experience"] = row["annees_experience"]
        d["energie"] = row["energie"]
        d["caserne_id"] = row["id_caserne"]
        d["caserne_nom"] = row["caserne_nom"]
        objects_list.append(d)
    return jsonify(objects_list)


@app.route('/api/pompier', methods=['POST'])
def post_pompier():

    element = request.json
    if element.get("id") is None:
        abort(422)

    requete = "UPDATE pompier SET nom = %s, prenom = %s, age = %s, tel = %s, annees_experience = %s, energie = %s, id_caserne = %s WHERE id = %s"
    values = (element["nom"], element["prenom"], element["age"],
              element["tel"], element["annees_experience"], element["energie"], element["caserne_id"], element["id"])

    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()

    return "", 201


@app.route('/api/pompier', methods=['PUT'])
def put_pompier():

    element = request.json
    if element.get("caserne_id") is None:
        abort(422)

    requete = "INSERT INTO pompier (nom, prenom, age, tel, annees_experience, energie, id_caserne) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    values = (element.get("nom"), element.get("prenom"), element.get("age"),
              element.get("tel"), element.get("annees_experience"), element.get("energie"), element.get("caserne_id"))

    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()

    return "", 201


@app.route('/api/pompier/<id>', methods=['DELETE'])
def delete_pompier(id):

    if id is None:
        abort(422)

    requete = "DELETE FROM pompier WHERE id = %s"

    cur = conn.cursor()
    cur.execute(requete, (id,))
    conn.commit()

    return "", 200