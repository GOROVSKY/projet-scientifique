<template>
  <div class="modale">
    <div class="titre">
      Pompier <span v-if="id">modification</span><span v-else>ajout</span>
    </div>
    <div class="contenu">
      <div>
        <label>Nom</label>
        <input v-model="element.nom" class="form-control" />
      </div>
      <div>
        <label>Prénom</label>
        <input v-model="element.prenom" class="form-control" />
      </div>
      <div>
        <label>Age</label>
        <input v-model="element.age" type="number" class="form-control" />
      </div>
      <div>
        <label>Téléphone</label>
        <input v-model="element.tel" type="tel" pattern="[0-9]{10}" class="form-control" />
      </div>
      <div>
        <label>Energie</label>
        <input v-model="element.energie" type="number" class="form-control" />
      </div>
      <div>
        <label>Annee d'expérience</label>
        <input v-model="element.annees_experience" type="number" class="form-control" />
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

<script src="./pompier.modifier.js">
</script>
