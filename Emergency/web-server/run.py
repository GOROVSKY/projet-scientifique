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

        cur = conn.cursor()

        try:
            query = "UPDATE capteur_donnees SET valeur = %s, date = %s WHERE id_capteur = %s AND id_type_capteur = %s"
            values = (sensor["value"], datetime.datetime.now(),
                      sensor["id"], sensor["type"])
            cur.execute(query, values)
            conn.commit()

            query = "INSERT INTO historique (id_capteur, id_type_capteur, valeur, date) VALUES (%s, %s, %s, %s) "
            values = (sensor["id"], sensor["type"],
                      sensor["value"], datetime.datetime.now())
            cur.execute(query, values)
            conn.commit()

        except Exception as e:
            print(e)
            conn.rollback()
            return "", 400

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


# ##### MODELE_TYPE_CAPTEUR #####
@app.route('/api/modeleTypeCapteur', methods=['PUT'])
def put_modele_type_capteur():

    element = request.json
    if element.get("id_modele_capteur") is None or element.get("id_type_capteur") is None:
        abort(422)

    requete = "INSERT INTO modele_type_capteur (id_modele_capteur, id_type_capteur) VALUES (%s, %s)"
    values = (element["id_modele_capteur"], element["id_type_capteur"])

    cur = conn.cursor()
    cur.execute(requete, values)
    conn.commit()

    return "", 201


@app.route('/api/modeleTypeCapteur/<id_modele_capteur>&<id_type_capteur>', methods=['DELETE'])
def delete_modele_type_capteur(id_modele_capteur, id_type_capteur):

    if id_modele_capteur is None or id_type_capteur is None:
        abort(422)

    requete = "DELETE FROM modele_type_capteur WHERE id_modele_capteur = %s AND id_type_capteur = %s"

    cur = conn.cursor()
    cur.execute(requete, (id_modele_capteur, id_type_capteur))
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

    qryModeleType = "SELECT id_modele_capteur, id_type_capteur, libelle FROM modele_type_capteur mtc JOIN type_capteur tc ON mtc.id_type_capteur = tc.id"
    if id is not None:
        qryModeleType += f" WHERE id_modele_capteur = {id}"
    cur.execute(qryModeleType)
    mtc = cur.fetchall()

    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["id"] = int(row["id"])
        d["libelle"] = row["libelle"]

        # Ajout des libellés des types de capteur
        d["types_capteur"] = []
        tmp = list(filter(lambda x: x[0] == row["id"], mtc))
        for i in tmp:
            dico = {'id': i[1], 'libelle': i[2]}
            d["types_capteur"].append(dico.copy())

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
    query = "SELECT c.id, c.id_modele, c.code, c.latitude, c.longitude, c.ligne, c.colonne, mc.libelle FROM capteur c "
    query += "LEFT JOIN modele_capteur mc ON c.id_modele = mc.id"

    if id is not None:
        query += f" WHERE c.id = {id}"

    cur.execute(query)
    rows = cur.fetchall()

    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["id"] = int(row["id"])
        d["modeleId"] = int(row["id_modele"])
        d["modeleLibelle"] = row["libelle"]
        d["code"] = row["code"]
        d["latitude"] = float(row["latitude"])
        d["longitude"] = float(row["longitude"])
        d["ligne"] = row["ligne"]
        d["colonne"] = row["colonne"]
        objects_list.append(d)
    return jsonify(objects_list)


@app.route('/api/capteur', methods=['POST'])
def post_capteur():

    element = request.json
    if element.get("id") is None:
        abort(422)

    requete = "UPDATE capteur SET code = %s, latitude = %s, longitude = %s, id_modele = %s WHERE id = %s"
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

    requete = "INSERT INTO capteur (code, latitude, longitude, id_model) VALUES (%s, %s, %s, %s)"
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
    query = "SELECT v.id, v.modele, v.num_immatriculation, v.capacite_personne, v.capacite_produit, v.longitude, v.latitude, v.id_caserne, c.nom FROM vehicule v "
    query += "LEFT JOIN caserne c ON v.id_caserne = c.id "

    qryTypeProduit = "SELECT * FROM type_produit"

    qryVehciuleTypeProduit = "SELECT * FROM vehicule_type_produit "

    if id is not None:
        query += "WHERE v.id = %s "
        qryVehciuleTypeProduit += "WHERE id_vehicule = %s"

    query += "ORDER BY v.num_immatriculation"
    cur.execute(query, (id,))
    rows = cur.fetchall()

    cur.execute(qryTypeProduit)
    types_produits = cur.fetchall()

    cur.execute(qryVehciuleTypeProduit, (id,))
    vehicules_produits = cur.fetchall()

    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["id"] = int(row["id"])
        d["modele"] = row["modele"]
        d["num_immatriculation"] = row["num_immatriculation"]
        d["capacite_personne"] = int(row["capacite_personne"])
        d["capacite_produit"] = int(row["capacite_produit"])
        d["longitude"] = float(row["longitude"])
        d["latitude"] = float(row["latitude"])
        d["id_caserne"] = row["id_caserne"]
        d["caserne_nom"] = row["nom"]
        d["produits"] = []

        # Produits fournis par le véhicule
        vehicule_produits = (
            x for x in vehicules_produits if x["id_vehicule"] == d["id"])

        # Produits
        for x in vehicule_produits:
            produit = next(
                y for y in types_produits if y["id"] == x["id_type_produit"])
            p = collections.OrderedDict()
            p["id"] = int(produit["id"])
            p["libelle"] = produit["libelle"]
            d["produits"].append(p)

        objects_list.append(d)
    return jsonify(objects_list)


def update_entity(queries, id):
    cur = conn.cursor()

    for x in queries:
        qry = x["query"] + " WHERE id = %s"  # pour identifier l'entité
        values = (x["value"], id)
        cur.execute(qry, values)

    conn.commit()
    cur.close()


@app.route('/api/vehicule', methods=['POST'])
def post_vehicule():
    # Erreur si pas d'id
    element = request.json
    if element.get("id") is None:
        abort(422)

    # Modifications
    queries = []
    qry = {}
    if element.get("latitude") is not None:
        qry['query'] = "UPDATE vehicule SET latitude = %s"
        qry['value'] = element.get("latitude")
        queries.append(qry.copy())
    if element.get("longitude") is not None:
        qry['query'] = "UPDATE vehicule SET longitude = %s"
        qry['value'] = element.get("longitude")
        queries.append(qry.copy())
    if element.get("modele") is not None:
        qry['query'] = "UPDATE vehicule SET modele = %s"
        qry['value'] = element.get("modele")
        queries.append(qry.copy())
    if element.get("num_immatriculation") is not None:
        qry['query'] = "UPDATE vehicule SET num_immatriculation = %s"
        qry['value'] = element.get("num_immatriculation")
        queries.append(qry.copy())
    if element.get("capacite_personne") is not None:
        qry['query'] = "UPDATE vehicule SET capacite_personne = %s"
        qry['value'] = element.get("capacite_personne")
        queries.append(qry.copy())
    if element.get("capacite_produit") is not None:
        qry['query'] = "UPDATE vehicule SET capacite_produit = %s"
        qry['value'] = element.get("capacite_produit")
        queries.append(qry.copy())
    if element.get("id_caserne") is not None:
        qry['query'] = "UPDATE vehicule SET id_caserne = %s"
        qry['value'] = element.get("id_caserne")
        queries.append(qry.copy())

    # Enregistrement
    update_entity(queries, element.get("id"))

    return "", 201


@app.route('/api/vehicule', methods=['PUT'])
def put_vehicule():

    element = request.json
    if element.get("id_caserne") is None:
        abort(422)

    requete = "INSERT INTO vehicule (modele, num_immatriculation, capacite_personne, capacite_produit, longitude, latitude, id_caserne) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    values = (element.get("modele"), element.get("num_immatriculation"), element.get("capacite_personne"),
              element.get("capacite_produit"), element.get("longitude"), element.get("latitude"), element.get("id_caserne"))

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


##### TYPE_PRODUIT #####
@app.route('/api/typeProduit', methods=['GET'])
@app.route('/api/typeProduit/<id>', methods=['GET'])
def get_type_produit(id=None):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    query = "SELECT id, libelle FROM type_produit"

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


@app.route('/api/typeProduit', methods=['POST'])
def post_type_produit():
    # Erreur si pas d'id
    element = request.json
    if element.get("id") is None:
        abort(422)

    # Modifications
    queries = []
    qry = {}
    if element.get("libelle") is not None:
        qry['query'] = "UPDATE type_produit SET libelle = %s"
        qry['value'] = element.get("libelle")
        queries.append(qry.copy())

    # Enregistrement
    update_entity(queries, element.get("id"))

    return "", 201


@app.route('/api/typeProduit', methods=['PUT'])
def put_type_produit():

    element = request.json
    if element.get("libelle") is None:
        abort(422)
    try:
        requete = "INSERT INTO type_produit (libelle) VALUES (%s)"
        values = (element.get("libelle"),)

        cur = conn.cursor()
        cur.execute(requete, values)
        conn.commit()
    except Exception as e:
        print(e)
        conn.rollback()
        return "", 400
    return "", 201


@app.route('/api/typeProduit/<id>', methods=['DELETE'])
def delete_type_produit(id):

    if id is None:
        abort(422)

    requete = "DELETE FROM type_produit WHERE id = %s"

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


##### INCIDENT #####

@app.route('/api/incident', methods=['GET'])
@app.route('/api/incident/<id>', methods=['GET'])
def get_incident(id=None):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    query = "SELECT * FROM incident "
    query += "JOIN type_incident ti ON incident.id_type_incident = ti.id "
    query += "WHERE date_fin IS NULL "

    if id is not None:
        query += f"AND id = {id}"

    cur.execute(query)
    rows = cur.fetchall()

    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["id"] = int(row["id"])
        d["date_debut"] = row["date_debut"]
        d["date_fin"] = row["date_fin"]
        d["criticite"] = int(row["criticite"])
        d["longitude"] = row["longitude"]
        d["latitude"] = float(row["latitude"])
        d["type_incident_libelle"] = row["libelle"]
        objects_list.append(d)
    return jsonify(objects_list)


@app.route('/api/incident/historique/<id>', methods=['GET'])
@app.route('/api/incident/historique', methods=['GET'])
def get_incident_historique(id=None):
    dateDebut = request.args.get('dateDebut', default=None)
    dateFin = request.args.get('dateFin', default=None)

    dateDebut =dateDebut if dateDebut != 'null' else None
    dateFin = dateFin if dateFin != 'null' else None

    # Requêtes
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    query = "SELECT i.id, i.date_debut, i.date_fin, i.criticite, i.longitude, i.latitude, i.id_type_incident, ti.id as type_incident_id, ti.libelle as type_libelle FROM incident i "
    query += "JOIN type_incident ti ON i.id_type_incident = ti.id "

    qryVehicule = "SELECT * FROM vehicule "
    qryVehiculeIncident = "SELECT * FROM vehicule_incident "

    qryPompier = "SELECT * FROM pompier "
    qryPompierIncident = "SELECT * FROM pompier_incident "

    # Filtres
    if dateDebut is None and dateFin is None:
        query += f"WHERE date_fin IS NOT NULL "
    elif dateDebut is not None and dateFin is not None:
        query += f"WHERE date_debut >= '{dateDebut}' AND date_fin <= '{dateFin}' "
    elif dateDebut is not None:
        query += f"WHERE date_debut >= '{dateDebut}' "
    elif dateFin is not None:
        query += f"WHERE date_Fin <= '{dateFin}' "

    if id is not None:
        query += f"AND i.id = {id}"
        qryVehiculeIncident += f"WHERE id_incident = {id}"
        qryPompierIncident += f"WHERE id_incident = {id}"

    # Executions
    try:
        cur.execute(query)
        rows = cur.fetchall()

        cur.execute(qryVehiculeIncident)
        vehicules_incidents = cur.fetchall()

        cur.execute(qryVehicule)
        vehicules = cur.fetchall()

        cur.execute(qryPompierIncident)
        pompiers_incidents = cur.fetchall()

        cur.execute(qryPompier)
        pompiers = cur.fetchall()
    except Exception as e:
        print(e)
        return "", 400

    # Liste en sortie
    objects_list = []
    for row in rows:
        d = collections.OrderedDict()
        d["id"] = int(row["id"])
        d["date_debut"] = row["date_debut"]
        d["date_fin"] = row["date_fin"]
        d["criticite"] = int(row["criticite"])
        d["id_type_incident"] = row["id_type_incident"]
        d["type_incident_libelle"] = row["type_libelle"]
        d["vehicules"] = []
        d["pompiers"] = []

        if row.get("longitude") is not None :
            d["longitude"] = float(row["longitude"])
        if row.get("latitude") is not None :
            d["latitude"] = float(row["latitude"])

        vehicules_incident = (
            x for x in vehicules_incidents if x["id_incident"] == d["id"])
        pompiers_incident = (
            x for x in pompiers_incidents if x["id_incident"] == d["id"])

        # Véhicules
        for x in vehicules_incident:
            vehicule = next(
                y for y in vehicules if y["id"] == x["id_vehicule"])
            v = collections.OrderedDict()
            v["id"] = int(vehicule["id"])
            v["modele"] = vehicule["modele"]
            v["num_immatriculation"] = vehicule["num_immatriculation"]
            v["capacite_personne"] = int(vehicule["capacite_personne"])
            v["capacite_produit"] = int(vehicule["capacite_produit"])
            v["longitude"] = float(vehicule["longitude"])
            v["latitude"] = float(vehicule["latitude"])
            v["id_caserne"] = vehicule["id_caserne"]

            d["vehicules"].append(v)

        # Pompiers
        for x in pompiers_incident:
            pompier = next(
                y for y in pompiers if y["id"] == x["id_pompier"])
            p = collections.OrderedDict()
            p["id"] = int(pompier["id"])
            p["nom"] = pompier["nom"]
            p["prenom"] = pompier["prenom"]
            p["age"] = int(pompier["age"])
            p["tel"] = pompier["tel"]
            p["annees_experience"] = pompier["annees_experience"]
            p["energie"] = pompier["energie"]

            d["pompiers"].append(p)

        objects_list.append(d)
    return jsonify(objects_list)



##### VEHICULE_TYPE_PRODUIT #####
@app.route('/api/vehiculeTypeProduit', methods=['PUT'])
def put_vehicule_type_produit():

    element = request.json
    if element.get("id_vehicule") is None and element.get("id_type_produit") is None :
        abort(422)

    # On teste si l'association existe déjà
    qryTmp = "SELECT * FROM vehicule_type_produit WHERE id_vehicule = %s AND id_type_produit = %s"
    cur = conn.cursor()
    cur.execute(qryTmp, (element.get("id_vehicule"), element.get("id_type_produit")))
    tmp = cur.fetchone()
    if tmp is not None :
        return "", 400

    requete = "INSERT INTO vehicule_type_produit (id_vehicule, id_type_produit) VALUES (%s, %s)"
    values = (element.get("id_vehicule"), element.get("id_type_produit"))
    cur.execute(requete, values)
    conn.commit()

    return "", 201


@app.route('/api/vehiculeTypeProduit/<id_vehicule>&<id_produit>', methods=['DELETE'])
def delete_vehicule_type_produit(id_vehicule=None, id_produit=None):

    if id_vehicule is None and id_produit is None:
        abort(422)

    requete = "DELETE FROM vehicule_type_produit WHERE id_vehicule = %s AND id_type_produit = %s"

    cur = conn.cursor()
    cur.execute(requete, (id_vehicule, id_produit))
    conn.commit()

    return "", 200
