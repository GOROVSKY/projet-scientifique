<template>
  <div class="content-scroll">
    <CaserneModifier
      v-if="afficherModale"
      :id="elementSelectionne?.id"
      @valider="fermerModale()"
    />
    <teleport to="#teleport-header">
      <h1>
        Casernes
        <button class="btn btn-success" @click="ajouter()">+ Ajouter</button>
      </h1>
    </teleport>
    <div class="content-header">
      <table class="table table-bordered">
        <thead>
          <tr class="d-flex">
            <th style="flex-basis: 16%">Nom</th>
            <th style="flex-basis: 15%">Adresse</th>
            <th style="flex-basis: 12%">Code postal</th>
            <th style="flex-basis: 15%">Ville</th>
            <th style="flex-basis: 12%">Tel</th>
            <th style="flex-basis: 15%">Longitude</th>
            <th style="flex-basis: 15%">Latitude</th>
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
            <td style="flex-basis: 16%">
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
            <td style="flex-basis: 15%">{{ element.adresse }}</td>
            <td style="flex-basis: 12%">{{ element.code_postal }}</td>
            <td style="flex-basis: 15%">{{ element.ville }}</td>
            <td style="flex-basis: 12%">{{ element.tel }}</td>
            <td style="flex-basis: 15%">{{ element.longitude }}</td>
            <td style="flex-basis: 15%">{{ element.latitude }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="content-footer">
      <div style="font-size: 1.2rem">
        <b>{{ liste.length }} caserne<span v-if="liste.length > 1">s</span></b>
      </div>
    </div>
  </div>
</template>

<script src="./caserne.index.js">
</script>
