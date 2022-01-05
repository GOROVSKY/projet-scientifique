<template>
  <div class="content-scroll">
    <VehiculeModifier
      v-if="afficherModale"
      :id="elementSelectionne?.id"
      @valider="fermerModale()"
    />
    <div class="content-header">
      <h1>
        Véhicules
        <button class="btn btn-success" @click="ajouter()">+ Ajouter</button>
      </h1>
      <table class="table table-bordered">
        <thead>
          <tr class="d-flex">
            <th style="flex-basis: calc(100% / 7)">Num immatriculation</th>
            <th style="flex-basis: calc(100% / 7)">Modèle</th>
            <th style="flex-basis: calc(100% / 7)">Capacité de personnes</th>
            <th style="flex-basis: calc(100% / 7)">Capacité de produit</th>
            <th style="flex-basis: calc(100% / 7)">Caserne</th>
            <th style="flex-basis: calc(100% / 7)">Longitude</th>
            <th style="flex-basis: calc(100% / 7)">Latitude</th>
          </tr>
        </thead>
      </table>
    </div>
    <div class="content-body">
      <table class="table table-bordered table-hover table-striped">
        <tbody>
          <tr
            v-for="(element, index) in liste"
            :key="index"
            class="d-flex show-overlay"
          >
            <td style="flex-basis: calc(100% / 7)">
              {{ element.num_immatriculation }}
              <div class="overlay">
                <button class="btn btn-sm btn-edit" @click="modifier(element)">
                  <span class="fa fa-edit"></span>
                </button>
                <button
                  class="btn btn-sm btn-danger ms-1 me-1"
                  @click="supprimer(element)"
                >
                  <span class="fa fa-trash"></span>
                </button>
              </div>
            </td>
            <td style="flex-basis: calc(100% / 7)">{{ element.modele }}</td>
            <td style="flex-basis: calc(100% / 7)">
              {{ element.capacite_personne }}
            </td>
            <td style="flex-basis: calc(100% / 7)">
              {{ element.capacite_produit }}
            </td>
            <td style="flex-basis: calc(100% / 7)">
              {{ element.caserne_nom }}
            </td>
            <td style="flex-basis: calc(100% / 7)">{{ element.longitude }}</td>
            <td style="flex-basis: calc(100% / 7)">{{ element.latitude }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script src="./vehicule.index.js">
</script>
