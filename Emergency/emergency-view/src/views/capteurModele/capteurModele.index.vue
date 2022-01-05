<template>
  <div class="content-scroll">
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
    <div class="content-header">
      <h1>Modèles 
        <button class="btn btn-success" @click="ajouter()">+ Ajouter</button></h1>
      <table class="table table-bordered">
        <thead>
          <tr class="d-flex">
            <th style="flex-basis: 50%">Libellé</th>
            <th style="flex-basis: 50%">Types</th>
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
            <td style="flex-basis: 50%">
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
            <td style="flex-basis: 50%">
              <ul style="margin: unset">
                <li v-for="(type, index) in element.types_capteur" :key="index">
                  {{ type.libelle }}
                  <span
                    class="fa fa-times txt-danger cursor-pointer"
                    @click="supprimerType(element, type)"
                  ></span>
                </li>
              </ul>
              <div class="overlay">
                <button
                  class="btn btn-sm btn-success"
                  @click="ajouterType(element)"
                >
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
