<template>
  <div>
    <CapteurModifier
      v-if="afficherModale"
      :id="elementSelectionne?.id"
      @valider="fermerModale()"
    />
    <h1>Capteurs</h1>
    <div class="m-2">
      <button class="btn btn-success" @click="ajouter()">+ Ajouter</button>
    </div>
    <div class="content-scroll">
      <table class="table-bordered table-hover table-stripped">
        <thead>
          <tr>
            <th>Code</th>
            <th>Latitude</th>
            <th>Longitude</th>
            <th>Modèle</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(element, index) in liste"
            :key="index"
            class="show-overlay"
          >
            <td>
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
            <td>{{ element.latitude }}</td>
            <td>{{ element.longitude }}</td>
            <td>
              {{ element.modeleLibelle }}
              <div>
                <ul>
                  <li v-for="(type, index) in element.modeleTypes" :key="index">
                    {{ type.libelle }}
                  </li>
                </ul>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script src="./capteur.index.js">
</script>
