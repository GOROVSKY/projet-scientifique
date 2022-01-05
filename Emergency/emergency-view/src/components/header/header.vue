<template>
  <div class="d-flex justify-content-between align-items-center ps-3 pe-3 header">
    <h3 class="cursor-pointer" @click="$router.push('/')"><b>Emergency</b></h3>
    <div id="teleport-header">
    </div>
    <div class="cursor-pointer">
      <span class="fa fa-user-circle fa-2x" @click="connexion()"></span>
    </div>
  </div>
</template>

<script src="./header.js">
</script>
