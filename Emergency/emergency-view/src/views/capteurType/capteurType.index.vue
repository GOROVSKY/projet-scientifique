<template>
  <div class="content-scroll">
    <CapteurTypeModifier
      v-if="afficherModale"
      :id="elementSelectionne?.id"
      @valider="fermerModale()"
    />
    <div class="content-header">
      <h1>Types</h1>
      <div class="m-2">
        <button class="btn btn-success" @click="ajouter()">
          <span class="fa fa-plus"></span> Ajouter
        </button>
      </div>
    </div>
    <div class="content-body">
      <table class="table-bordered table-hover table-stripped">
        <thead>
          <tr>
            <th>Libellé</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(element, index) in liste"
            :key="index"
            class="show-overlay"
          >
            <td>
              {{ element.libelle }}
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
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script src="./capteurType.index.js">
</script>
