<template>
  <div class="modale">
    <h1>Type de produit sélection</h1>
    <div class="content-scroll">
      <div class="d-flex flex-wrap">
        <div
          v-for="(element, index) in listeVisible"
          :key="index"
          class="cursor-pointer m-3 p-3 border"
          @click="choisir(element)"
        >
          <b>{{ element.libelle }}</b>
        </div>
      </div>
    </div>
    <div class="pied">
      <button class="btn btn-danger" @click="annuler()">Annuler</button>
    </div>
  </div>
</template>

<script src="./typeProduit.selection.js">
</script>
