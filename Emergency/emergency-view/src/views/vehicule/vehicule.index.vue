<template>
  <div>
    <VehiculeModifier
      v-if="afficherModale"
      :id="elementSelectionne?.id"
      @valider="fermerModale()"
    />
    <h1>Véhicules</h1>
    <div class="m-2">
      <button class="btn btn-success" @click="ajouter()">+ Ajouter</button>
    </div>
    <div class="content-scroll">
      <table class="table-bordered table-hover table-stripped">
        <thead>
          <tr>
            <th>Num immatriculation</th>
            <th>Modèle</th>
            <th>Capacité de personnes</th>
            <th>Capacité de produit</th>
            <th>Caserne</th>
            <th>Longitude</th>
            <th>Latitude</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(element, index) in liste" :key="index" class="show-overlay">
            <td>{{ element.num_immatriculation }}
              <div class="overlay">
                <button class="btn btn-sm btn-edit" @click="modifier(element)">
                  <span class="fa fa-edit"></span>
                </button>
                <button class="btn btn-sm btn-danger ms-1 me-1" @click="supprimer(element)">
                  <span class="fa fa-trash"></span>
                </button>
              </div>
            </td>
            <td>{{ element.modele }}</td>
            <td>{{ element.capacite_personne }}</td>
            <td>{{ element.capacite_produit }}</td>
            <td>{{ element.caserne_nom }}</td>
            <td>{{ element.longitude }}</td>
            <td>{{ element.latitude }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script src="./vehicule.index.js">
</script>
