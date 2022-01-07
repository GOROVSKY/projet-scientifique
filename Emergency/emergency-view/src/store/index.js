import { createStore } from 'vuex'
import createPersistedState from "vuex-persistedstate";

export default createStore({
  state: {
    utilisateur: {}
  },
  mutations: {
    connecter(state, payload) {
      state.utilisateur.identifiant = payload.identifiant
    }
  },
  getters: {
    utilisateur: state => {
      return state.utilisateur
    }
  },
  actions: {
  },
  modules: {
  },
  
  plugins: [createPersistedState()]
})
