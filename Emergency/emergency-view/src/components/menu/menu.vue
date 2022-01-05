<template>
  <div class="menu">
    <router-link to="/"
      ><span class="fa fa-globe-europe fa-2x"></span
    ></router-link>

    <hr />
    <router-link to="/caserne"
      ><span class="fa fa-clinic-medical fa-2x"></span
    ></router-link>
    <router-link to="/vehicule" class="mt-3"
      ><span class="fa fa-ambulance fa-2x"></span
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
    <hr>
    <router-link to="/historique" class="mt-auto"
      ><span class="fa fa-history fa-2x"></span
    ></router-link>
    
  </div>
</template>

<script src="./menu.js">
</script>
