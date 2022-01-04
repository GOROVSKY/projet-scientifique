<template>
  <div class="modale">
    <div class="titre">Caserne ajout/modif</div>
    <form class="contenu">
      <div>
        <label>Nom</label>
        <input v-model="element.nom" class="form-control" required />
      </div>
      <div>
        <label>Adresse</label>
        <input v-model="element.adresse" class="form-control" required />
      </div>
      <div>
        <label>Code postal</label>
        <input v-model="element.code_postal" class="form-control" required />
      </div>
      <div>
        <label>Ville</label>
        <input v-model="element.ville" class="form-control" required />
      </div>
      <div>
        <label>Tel</label>
        <input v-model="element.tel" type="tel" class="form-control" pattern="[0-9]{10}" required />
      </div>
      <div>
        <label>Longitude</label>
        <input v-model="element.longitude" class="form-control" required />
      </div>
      <div>
        <label>Latitude</label>
        <input v-model="element.latitude" class="form-control" required />
      </div>
    </form>
    <div class="pied">
      <button class="btn btn-success" type="submit" @click="valider()">Valider</button>
      <button class="btn btn-danger ms-5" @click="annuler()">Annuler</button>
    </div>
  </div>
</template>

<script src="./caserne.modifier.js">
</script>
