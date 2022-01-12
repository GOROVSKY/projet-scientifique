<template>
  <div class="content-scroll">
    <div class="content-header">
      <h1>Historique des incidents</h1>
      <div class="d-flex justify-content-center">
        <div class="me-4">
          Du
          <input type="date" v-model="filtreDateDebut" />
        </div>
        <div class="me-4">
          Au
          <input type="date" v-model="filtreDateFin" />
        </div>
      </div>
    </div>
    <div class="content-body">
      <div class="mt-4 d-flex flex-wrap">
        <div
          v-for="(element, index) in liste"
          :key="index"
          style="flex-basis: 25%"
        >
          <div class="card m-3">
            <div class="card-header">
              <div>
                Début : {{ moment(element.date_debut).format("DD/MM/YYYY") }} à
                {{ moment(element.date_debut).format("HH[h]mm") }}
              </div>
              <div>
                Fin {{ moment(element.date_fin).format("DD/MM/YYYY") }} à
                {{ moment(element.date_fin).format("HH[h]mm") }}
              </div>
              <div>Type : {{ element.type_incident_libelle }}</div>
              <div>Criticité {{ element.criticite }}</div>
            </div>
            <div class="mt-3">
              Véhicules <span class="fa fa-ambulance"></span>
              <ul>
                <li v-for="(vehicule, index) in element.vehicules" :key="index">
                  {{ vehicule.modele }}
                  <i>{{ vehicule.num_immatriculation }}</i>
                </li>
              </ul>
            </div>
            <hr />
            <div>
              Pompiers <span class="fa fa-user-nurse"></span>
              <ul>
                <li v-for="(pompier, index) in element.pompiers" :key="index">
                  {{ pompier.nom }} {{ pompier.prenom }}
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="content-footer">
      {{ liste.length }} incident<span v-if="liste.length > 1">s</span>
    </div>
  </div>
</template>

<script src="./historique.index.js">
</script>
