<template>
  <div class="menu">
    <router-link to="/">
      <span class="fa fa-globe-europe fa-2x"></span>
      <span class="info">Emergency</span>
    </router-link>
    <hr />
    <router-link to="/caserne"
      ><span class="fa fa-clinic-medical fa-2x"></span
    ></router-link>
    <router-link to="/vehicule" class="mt-3"
      ><span class="fa fa-ambulance fa-2x"></span
    ></router-link>
    <router-link to="/typeProduit" class="mt-3"
      ><span class="fa fa-fire-extinguisher fa-2x"></span
    ></router-link>
    <router-link to="/pompier" class="mt-3"
      ><span class="fa fa-user-nurse fa-2x"></span
    ></router-link>
    <hr />
    <router-link to="/capteur"
      ><span class="fa fa-video fa-2x"></span
    ></router-link>
    <router-link to="/capteurModele" class="mt-3"
      ><span class="fa fa-microchip fa-2x"></span
    ></router-link>
    <router-link to="/capteurType" class="mt-3"
      ><span class="fa fa-cloud-sun-rain fa-2x"></span
    ></router-link>
    <hr />
    <router-link to="/historique" class="mt-auto"
      ><span class="fa fa-history fa-2x"></span
    ></router-link>
  </div>
</template>

<script src="./menu.js">
</script>

<style scoped>
a {
  position: relative;
  z-index: 1000;
}
.info {
  display: none;
  position: absolute;
  color: white;
  background-color: rgb(73, 51, 51);
  border-radius: 3px;
  z-index: 1001;
  top: 5px;
  font-size: 0.8rem;
  padding: 2px 8px;
  left: 40px;
}
a:hover .info {
  display: block;
}
</style>
