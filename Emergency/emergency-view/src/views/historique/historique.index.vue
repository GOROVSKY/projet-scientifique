<template>
  <div class="content-scroll">
    <teleport to="#teleport-header"
      ><h1>Historique des incidents</h1>
    </teleport>
    <div class="content-header">
      <div class="d-flex justify-content-center bandeau-filtre">
        <div class="me-4">
          Du
          <input type="date" v-model="filtreDateDebut" />
        </div>
        <div class="me-4">
          Au
          <input type="date" v-model="filtreDateFin" />
        </div>
        <div class="me-4">
          Criticité
          <input type="number" min="0" max="10" v-model="filtreCriticite" />
        </div>
        <div class="me-4">
          <button class="btn btn-sm btn-secondary" @click="reinitialiserFiltre()"><span class="fa fa-redo-alt"></span></button>
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
      <div style="font-size: 1.2rem">
        <b>{{ liste.length }} incident<span v-if="liste.length > 1">s</span></b>
      </div>
    </div>
  </div>
</template>

<script src="./historique.index.js">
</script>
