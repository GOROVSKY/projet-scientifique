<template>
  <div class="d-flex">
    <teleport to="#teleport-header">
      <div
        class="d-flex justify-content-center align-items-center"
        style="height: 60px"
      >
        <div class="me-4">
          <label for="input-caserne"
            >Casernes <span class="fa fa-clinic-medical text-primary"></span
          ></label>
          <input
            class="ms-2"
            type="checkbox"
            name="input-caserne"
            v-model="affichageCaserne"
          />
        </div>
        <div class="me-4">
          <label for="input-vehicule"
            >Véhicules <span class="fa fa-ambulance text-success"></span
          ></label>
          <input
            class="ms-2"
            type="checkbox"
            name="input-vehicule"
            v-model="affichageVehicule"
          />
        </div>
        <div class="me-4">
          <label for="input-incident"
            >Incidents <span class="fa fa-exclamation-circle text-danger"></span
          ></label>
          <input
            class="ms-2"
            type="checkbox"
            name="input-incident"
            v-model="affichageIncident"
          />
        </div>
        <div>
          <label for="input-capteur"
            >Capteurs <span class="fa fa-video text-secondary"></span
          ></label>
          <input
            class="ms-2"
            type="checkbox"
            name="input-capteur"
            v-model="affichageCapteur"
          />
        </div>
      </div>
    </teleport>
    <div style="flex-basis: 20%" class="content-scroll recap p-3">
      <div class="content-header">
        <div><b>Situation</b></div>
        <div class="mt-3">
          <div v-if="incidents.length > 0" class="text-danger">
            <b>{{ incidents.length }}</b>
            <span class="fa fa-exclamation-circle"></span>
          </div>
          <div v-else>
            <i>Aucun incident</i>
          </div>
        </div>
        <hr size="2"/>
      </div>
      <div class="content-body">
        <div>{{ vehicules.length }} <span class="fa fa-ambulance"></span> <input
            class="ms-2"
            type="checkbox"
            name="input-vehicule"
            v-model="affichageVehicule"
          /></div>
        <hr />
        <div>
          {{ casernes.length }} <span class="fa fa-clinic-medical"></span> 
          <input
            class="ms-2"
            type="checkbox"
            name="input-caserne"
            v-model="affichageCaserne"
          />
        </div>
        <hr/>
        <div>{{ pompiers.length }} <span class="fa fa-user-nurse"></span></div>
        <hr/>
        <div>{{ capteurs.length }} <span class="fa fa-video"></span> 
          <input
            class="ms-2"
            type="checkbox"
            name="input-capteur"
            v-model="affichageCapteur"
          /></div>
      </div>
    </div>
    <div
      id="map"
      style="width: 100%; height: 100%; z-index: 0; flex-grow: 1"
    ></div>
  </div>
</template>

<script src="./index.js">
</script>
