<template>
  <div class="content-scroll">
    <PompierModifier
      v-if="afficherModale"
      :id="elementSelectionne?.id"
      @valider="fermerModale()"
    />
    <div class="content-header">
      <h1>Pompiers</h1>
      <div class="m-2">
        <button class="btn btn-success" @click="ajouter()">+ Ajouter</button>
      </div>
    </div>
    <div class="content-body">
      <table class="table-bordered table-hover table-stripped">
        <thead>
          <tr>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Age</th>
            <th>Tel</th>
            <th>Energie</th>
            <th>Année d'expérience</th>
            <th>Caserne</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(element, index) in liste"
            :key="index"
            class="show-overlay"
          >
            <td>
              {{ element.nom }}
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
            <td>{{ element.prenom }}</td>
            <td>{{ element.age }}</td>
            <td>{{ element.tel }}</td>
            <td>{{ element.energie }}</td>
            <td>{{ element.annees_experience }}</td>
            <td>{{ element.caserne_nom }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script src="./pompier.index.js">
</script>
