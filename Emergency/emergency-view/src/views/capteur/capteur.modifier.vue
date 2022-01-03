<template>
  <div class="modale">
    <div class="titre">Capteur ajout/modif</div>
    <form class="contenu">
      <div>
        <label>Code</label>
        <input v-model="element.code" class="form-control" required />
      </div>
      <div>
        <label>Latitude</label>
        <input v-model="element.latitude" class="form-control" required />
      </div>
      <div>
        <label>Longitude</label>
        <input v-model="element.longitude" class="form-control" required />
      </div>
      <div>
        <label>Modèle</label>
        <select v-model="element.modeleId">
          <option v-for="(element, index) in modeles" :key="index" :value="element.id">{{ element.libelle }}</option>
        </select>
      </div>
    </form>
    <div class="pied">
      <button class="btn btn-success" type="submit" @click="valider()">Valider</button>
      <button class="btn btn-danger ms-5" @click="annuler()">Annuler</button>
    </div>
  </div>
</template>

<script src="./capteur.modifier.js">
</script>
