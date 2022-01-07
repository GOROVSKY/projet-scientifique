<template>
  <div class="content-scroll">
    <VehiculeModifier
      v-if="afficherModale"
      :id="elementSelectionne?.id"
      @valider="fermerModale()"
    />
    <TypeProduitSelection
      v-if="afficherProduit"
      @elementSelectionne="fermerModaleProduit()"
      ref="typeProduitSelection"
    />
    <div class="content-header">
      <h1>
        Véhicules
        <button class="btn btn-success" @click="ajouter()">+ Ajouter</button>
      </h1>
      <table class="table table-bordered">
        <thead>
          <tr class="d-flex">
            <th style="flex-basis: calc(100% / 8)">Num immatriculation</th>
            <th style="flex-basis: calc(100% / 8)">Modèle</th>
            <th style="flex-basis: calc(100% / 8)">Capacité de personnes</th>
            <th style="flex-basis: calc(100% / 8)">Capacité de produit</th>
            <th style="flex-basis: calc(100% / 8)">Type de produits</th>
            <th style="flex-basis: calc(100% / 8)">Caserne</th>
            <th style="flex-basis: calc(100% / 8)">Longitude</th>
            <th style="flex-basis: calc(100% / 8)">Latitude</th>
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
            <td style="flex-basis: calc(100% / 8)">
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
            <td style="flex-basis: calc(100% / 8)">{{ element.modele }}</td>
            <td style="flex-basis: calc(100% / 8)">
              {{ element.capacite_personne }}
            </td>
            <td style="flex-basis: calc(100% / 8)">
              {{ element.capacite_produit }}
            </td>
            <td style="flex-basis: calc(100% / 8)">
              <span v-if="element.produits.length == 0"><i>Aucun</i></span>
              <ul v-else>
                <li v-for="(produit, index) in element.produits" :key="index">
                  {{ produit.libelle }}
                  <span
                    class="fa fa-times cursor-pointer"
                    @click="supprimerProduit(element, produit)"
                  ></span>
                </li>
              </ul>
              <div class="overlay">
                <button class="btn btn-sm btn-success" 
                    @click="ajouterProduit(element)">
                  <span
                    class="fa fa-plus"
                  ></span>
                </button>
              </div>
            </td>
            <td style="flex-basis: calc(100% / 8)">
              {{ element.caserne_nom }}
            </td>
            <td style="flex-basis: calc(100% / 8)">{{ element.longitude }}</td>
            <td style="flex-basis: calc(100% / 8)">{{ element.latitude }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script src="./vehicule.index.js">
</script>
