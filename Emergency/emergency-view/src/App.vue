<template>
  <Header />
  <div class="d-flex h-100" style="overflow: hidden">
    <Menu v-if="route != 'connexion'" />
    <router-view id="main-router-view" />
  </div>
</template>

<script src="./App.js"></script>

<style src="@/assets/styles/main.css"></style>
<style src="@/assets/styles/modale.css"></style>

