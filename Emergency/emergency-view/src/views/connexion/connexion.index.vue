<template>
  <div
    class="d-flex h-100 align-items-center justify-content-center flex-column"
  >
    <h1>Connexion</h1>
    <div class="mt-3">
      <form class="text-start">
        <div class="d-flex flex-column">
          <label for="identifiant">Identifiant</label>
          <input v-model="identifiant" name="identifiant" required />
        </div>
        <div class="d-flex flex-column mt-2">
          <label for="motDePasse">Mot de passe</label>
          <input v-model="motDePasse" name="motDePasse" required/>
        </div>
        <button type="submit" class="btn btn-primary mt-3 w-100" @click.prevent="connecter()">Se connecter</button>
      </form>
    </div>
  </div>
</template>

<script src="./connexion.index.js">
</script>
