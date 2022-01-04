<template>
  <div class="modale">
    <div class="titre">
      Véhicule <span v-if="id">modification</span><span v-else>ajout</span>
    </div>
    <div class="contenu">
      <div>
        <label>Num immatriculation</label>
        <input v-model="element.num_immatriculation" class="form-control" />
      </div>
      <div>
        <label>Modèle</label>
        <input v-model="element.modele" class="form-control" />
      </div>
      <div>
        <label>Capacité personne</label>
        <input v-model="element.capacite_personne" type="number" class="form-control" />
      </div>
      <div>
        <label>Capacité produit</label>
        <input v-model="element.capacite_produit" class="form-control" />
      </div>
      <div>
        <label>Longitude</label>
        <input v-model="element.longitude" class="form-control" />
      </div>
      <div>
        <label>Latitude</label>
        <input v-model="element.latitude" class="form-control" />
      </div>
      <div>
        <label>Casernes</label>
        <select v-model="element.caserne_id">
          <option v-for="(element, index) in casernes" :key="index" :value="element.id">{{ element.nom }}</option>
        </select>
      </div>
    </div>
    <div class="pied">
      <button class="btn btn-success" @click="valider()">Valider</button>
      <button class="btn btn-danger ms-5" @click="annuler()">Annuler</button>
    </div>
  </div>
</template>

<script src="./vehicule.modifier.js">
</script>
