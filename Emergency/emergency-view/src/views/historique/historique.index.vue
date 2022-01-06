<template>
  <div>
    <h1>Historique des incidents</h1>
    <div class="mt-4 d-flex flex-wrap">
      <div v-for="(element, index) in liste" :key="index" class="m-3 card">
        <div class="card-header">
          Le {{ moment(element.date_fin).format("DD/MM/YYYY") }} à
          {{ moment(element.date_fin).format("HH[h]mm") }}
          <div>
            Type : {{element.type_incident_libelle }}
          </div>
        </div>
        <div class="mt-3">
          Véhicules
          <ul>
            <li v-for="(vehicule, index) in element.vehicules" :key="index">
              {{ vehicule.modele }} <i>{{ vehicule.num_immatriculation }}</i>
            </li>
          </ul>
        </div>
        <hr>
        <div>
          Pompiers
          <ul>
            <li v-for="(pompier, index) in element.pompiers" :key="index">
              {{ pompier.nom }} {{ pompier.prenom }}
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script src="./historique.index.js">
</script>
