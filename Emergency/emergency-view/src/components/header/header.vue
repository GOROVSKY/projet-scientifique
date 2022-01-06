<template>
  <div
    class="d-flex justify-content-between align-items-center ps-3 pe-3 header"
  >
    <div class="text-start">
      <div class="cursor-pointer" style="font-size: 1.5rem" @click="$router.push('/')">
        <b>Emergency</b>
      </div>
      <b>{{ heureActuelle }}</b>
    </div>
    <div id="teleport-header"></div>
    <div class="cursor-pointer">
      <span class="fa fa-user-circle fa-2x" @click="connexion()"></span>
    </div>
  </div>
</template>

<script src="./header.js">
</script>
