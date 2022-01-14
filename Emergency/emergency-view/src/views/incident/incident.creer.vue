<template>
  <div>
    <teleport to="#teleport-header">
      <h1>Nouvel incident</h1>
    </teleport>
    <div class="mt-5 d-flex justify-content-between ps-5 pe-5">
      <div class="d-flex flex-column">
        <label for="longitude">Longitude</label>
        <input
          v-model="incident.longitude"
          name="longitude"
          class="form-control"
          type="number"
        />
      </div>
      <div class="d-flex flex-column">
        <label for="latitude">Latitude</label>
        <input
          v-model="incident.latitude"
          name="latitude"
          class="form-control"
          type="number"
        />
      </div>
      <div class="d-flex flex-column">
        <div>Type d'incident</div>
        <select v-model="incident.id_type_incident">
          <option
            v-for="(element, index) in typesIncident"
            :key="index"
            :value="element.id"
          >
            {{ element.libelle }}
          </option>
        </select>
      </div>
      <div>
          <button class="btn btn-success" @click="ajouter()">Créer un incident</button>
      </div>
    </div>
  </div>
</template>

<script src="./incident.creer.js">
</script>
