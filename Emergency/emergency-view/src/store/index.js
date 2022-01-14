import { createStore } from 'vuex'
import createPersistedState from "vuex-persistedstate";

export default createStore({
  state: {
    utilisateur: {},
    token: localStorage.getItem('user-token') || '',
    status: '',
  },
  mutations: {
    connecter(state, payload) {
      state.utilisateur.identifiant = payload.identifiant
    },
    deconnecter(state) {
      state.utilisateur = {}
    }
  },
  getters: {
    utilisateur: state => {
      return state.utilisateur
    },
    estAuthentifie: state => !!state.token,
    authStatus: state => state.status,
  },
  actions: {
  },
  modules: {
  },

  plugins: [createPersistedState()]
})
