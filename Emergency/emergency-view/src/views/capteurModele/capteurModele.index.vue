<template>
  <div>
    <CapteurModeleModifier
      v-if="afficherModale"
      :id="elementSelectionne?.id"
      @valider="fermerModale()"
    />
    <CapteurTypeSelection
      v-if="afficherSelection"
      @elementSelectionne="fermerModaleSelection()"
      ref="capteurTypeSelection"
    />
    <h1>Modèles</h1>
    <div class="m-2">
      <button class="btn btn-success" @click="ajouter()">+ Ajouter</button>
    </div>
    <div class="content-scroll">
      <table class="table-bordered table-hover table-stripped">
        <thead>
          <tr>
            <th>Libellé</th>
            <th>Types</th>
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
            <td>
              <ul>
                <li v-for="(type, index) in element.types_capteur" :key="index">
                  {{ type.libelle }} <span class="fa fa-times txt-danger cursor-pointer" @click="supprimerType(element, type)"></span>
                </li>
              </ul>
              <div class="overlay">
                <button class="btn btn-sm btn-success" @click="ajouterType(element)">
                  <span class="fa fa-plus"></span>
                </button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script src="./capteurModele.index.js">
</script>
