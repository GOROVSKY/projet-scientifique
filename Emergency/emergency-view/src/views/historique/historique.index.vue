<template>
  <div><h1>Historique des incidents</h1>
  <div class="mt-4 d-flex flex-wrap">
      <div v-for="(element, index) in liste" :key="index" class="m-3 p-3 border">
          Le {{moment(element.date_fin).format("DD/MM/YYYY")}} à {{moment(element.date_fin).format("HH[h]mm")}}
      </div> 
  </div>
  
  </div>
</template>

<script src="./historique.index.js">
</script>
