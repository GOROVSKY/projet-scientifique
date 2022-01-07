<template>
  <div class="modale">
    <div class="titre">Type de produit : <span v-if="id">modif</span><span v-else>ajout</span></div>
    <form class="contenu">
      <div>
        <label>Libellé</label>
        <input v-model="element.libelle" class="form-control" required />
      </div>
    </form>
    <div class="pied">
      <button class="btn btn-success" type="submit" @click="valider()">Valider</button>
      <button class="btn btn-danger ms-5" @click="annuler()">Annuler</button>
    </div>
  </div>
</template>

<script src="./typeProduit.modifier.js">
</script>
