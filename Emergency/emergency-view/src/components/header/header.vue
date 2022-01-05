<template>
  <div class="d-flex justify-content-between align-items-center ps-2 pe-2 header">
    <div id="nav">
      <router-link to="/">Index</router-link> |
      <router-link to="/caserne">Casernes</router-link> |
      <router-link to="/pompier">Pompiers</router-link> |
      <router-link to="/vehicule"
        ><span class="fa fa-ambulance"></span> Véhicules</router-link
      >
      | <router-link to="/capteur">Capteurs</router-link> |
      <router-link to="/capteurModele">Modèles</router-link> |
      <router-link to="/capteurType">Types</router-link>
    </div>
    <div class="cursor-pointer">
      <span class="fa fa-user-circle fa-2x" @click="connexion()"></span>
    </div>
  </div>
</template>

<script src="./header.js">
</script>
