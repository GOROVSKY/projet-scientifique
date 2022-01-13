<template>
  <div
    class="d-flex justify-content-between align-items-center ps-3 pe-3 header"
  >
    <div class="text-start">
      <div
        class="cursor-pointer"
        style="font-size: 1.5rem"
        @click="$router.push('/')"
      >
        <b>Emergency</b>
      </div>
      <b>{{ heureActuelle }}</b>
    </div>
    <div id="teleport-header"></div>
    <div
      class="cursor-pointer d-flex align-items-center dropdown-parent"
      @click="$router.push('/connexion')"
    >
      <span class="fa fa-user-circle fa-2x" @click="connexion()"></span>
      <div v-if="$store.getters.utilisateur.identifiant" class="ms-2">
        {{ $store.getters.utilisateur.identifiant }}
        <div class="dropdown">
          <div @click="deconnecter()">
            Déconnexion <span class="fa fa-sign-out-alt"></span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script src="./header.js">
</script>

<style scoped>
.dropdown-parent {
  position: relative;
}
.dropdown {
  position: absolute;
  padding: 10px;
  background-color: rgb(36, 38, 44);
  right: 0;
  width: max-content;
  display: none;
  -webkit-box-shadow: 0px 0px 29px 5px rgba(0, 0, 0, 0.31);
  box-shadow: 0px 0px 29px 5px rgba(0, 0, 0, 0.31);
}
.dropdown-parent:hover .dropdown {
  display: block;
}
</style>