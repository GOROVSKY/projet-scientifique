<template>
  <div class="content-scroll">
    <TypeProduitModifier
      v-if="afficherModale"
      :id="elementSelectionne?.id"
      @valider="fermerModale()"
    />
    <teleport to="#teleport-header">
      <h1>
        Types de produit
        <button class="btn btn-success" @click="ajouter()">
          <span class="fa fa-plus"></span> Ajouter
        </button>
      </h1>
    </teleport>
    <div class="content-header">
      <table class="table table-bordered">
        <thead>
          <tr class="d-flex">
            <th style="flex-basis: 50%">Id</th>
            <th style="flex-basis: 50%">Libellé</th>
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
              {{ element.id }}
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
            <td style="flex-basis: 50%">{{ element.libelle }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="content-footer">
      <div style="font-size: 1.2rem">
        <b
          >{{ liste.length }} type<span v-if="liste.length > 1">s</span> de
          produit</b
        >
      </div>
    </div>
  </div>
</template>

<script src="./typeProduit.index.js">
</script>
