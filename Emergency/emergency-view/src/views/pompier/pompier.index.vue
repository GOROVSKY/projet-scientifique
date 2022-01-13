<template>
  <div class="content-scroll">
    <PompierModifier
      v-if="afficherModale"
      :id="elementSelectionne?.id"
      @valider="fermerModale()"
    />
    <teleport to="#teleport-header">
      <h1>
        Pompiers
        <button class="btn btn-success" @click="ajouter()">+ Ajouter</button>
      </h1>
    </teleport>
    <div class="content-header">
      <table class="table table-bordered">
        <thead>
          <tr class="d-flex">
            <th style="flex-basis: calc(100% / 7)">Nom</th>
            <th style="flex-basis: calc(100% / 7)">Prénom</th>
            <th style="flex-basis: calc(100% / 7)">Age</th>
            <th style="flex-basis: calc(100% / 7)">Tel</th>
            <th style="flex-basis: calc(100% / 7)">Energie</th>
            <th style="flex-basis: calc(100% / 7)">Année d'expérience</th>
            <th style="flex-basis: calc(100% / 7)">Caserne</th>
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
            <td style="flex-basis: calc(100% / 7)">{{ element.prenom }}</td>
            <td style="flex-basis: calc(100% / 7)">{{ element.age }}</td>
            <td style="flex-basis: calc(100% / 7)">{{ element.tel }}</td>
            <td style="flex-basis: calc(100% / 7)">{{ element.energie }}</td>
            <td style="flex-basis: calc(100% / 7)">
              {{ element.annees_experience }}
            </td>
            <td style="flex-basis: calc(100% / 7)">
              {{ element.caserne_nom }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="content-footer">
      <div style="font-size: 1.2rem">
        <b>{{ liste.length }} pompier<span v-if="liste.length > 1">s</span></b>
      </div>
    </div>
  </div>
</template>

<script src="./pompier.index.js">
</script>
