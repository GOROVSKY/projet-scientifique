<template>
  <div class="d-flex flex-column">
    <div class="d-flex justify-content-center align-items-center" style="height: 60px">
      <div class="me-4">
        <label for="input-caserne">Casernes <span class="fa fa-clinic-medical text-primary"></span></label>
        <input class="ms-2" type="checkbox" name="input-caserne" v-model="affichageCaserne">
      </div>
      <div class="me-4">
        <label for="input-caserne">Véhicules <span class="fa fa-ambulance text-success"></span></label>
        <input class="ms-2" type="checkbox" name="input-caserne" v-model="affichageVehicule">
      </div>
      <div>
        <label for="input-caserne">Incidents <span class="fa fa-exclamation-circle text-danger"></span></label>
        <input class="ms-2" type="checkbox" name="input-caserne" v-model="affichageIncident">
      </div>
    </div>
    <div id="map" style="width: 100%; height: 100%; z-index: 0; flex-grow: 1"></div>
  </div>
</template>

<script src="./index.js">
</script>
