<template>
  <div class="content-scroll">
    <CapteurModifier
      v-if="afficherModale"
      :id="elementSelectionne?.id"
      @valider="fermerModale()"
    />
    <div class="content-header">
      <h1>Capteurs</h1>
      <div class="m-2">
        <button class="btn btn-success" @click="ajouter()">+ Ajouter</button>
      </div>

      <table class="table table-bordered table-hover">
        <thead>
          <tr class="d-flex">
            <th style="flex-basis: 25%">Code</th>
            <th style="flex-basis: 25%">Latitude</th>
            <th style="flex-basis: 25%">Longitude</th>
            <th style="flex-basis: 25%">Modèle</th>
          </tr>
        </thead>
      </table>
    </div>
    <div class="content-body">
      <table class="table table-bordered table-hover table-striped table-sm">
        <tbody>
          <tr
            v-for="(element, index) in liste"
            :key="index"
            class="d-flex show-overlay"
          >
            <td style="flex-basis: 25%">
              {{ element.code }}
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
            <td style="flex-basis: 25%">{{ element.latitude }}</td>
            <td style="flex-basis: 25%">{{ element.longitude }}</td>
            <td style="flex-basis: 25%">
              {{ element.modeleLibelle }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="content-footer">
      <h4>{{ liste.length }} capteurs</h4>
    </div>
  </div>
</template>

<script src="./capteur.index.js">
</script>
