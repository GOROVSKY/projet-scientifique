<template>
  <div>
    <CaserneModifier
      v-if="afficherModale"
      :id="elementSelectionne?.id"
      @valider="fermerModale()"
    />
    <h1>Casernes</h1>
    <div class="m-2">
      <button class="btn btn-success" @click="ajouter()">+ Ajouter</button>
    </div>
    <div class="content-scroll">
      <table class="table-bordered table-hover table-stripped">
        <thead>
          <tr>
            <th>Nom</th>
            <th>Adresse</th>
            <th>Code postal</th>
            <th>Ville</th>
            <th>Longitude</th>
            <th>Latitude</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(element, index) in liste" :key="index" class="show-overlay">
            <td>{{ element.nom }}
              <div class="overlay">
                <button class="btn btn-sm btn-edit" @click="modifier(element)">
                  <span class="fa fa-edit"></span>
                </button>
                <button class="btn btn-sm btn-danger ms-1 me-1" @click="supprimer(element)">
                  <span class="fa fa-trash"></span>
                </button>
              </div>
            </td>
            <td>{{ element.adresse }}</td>
            <td>{{ element.codePostal }}</td>
            <td>{{ element.ville }}</td>
            <td>{{ element.longitude }}</td>
            <td>{{ element.latitude }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script src="./caserne.index.js">
</script>
