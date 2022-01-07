export default {
    name: 'ConnexionIndex',

    data() {
        return {
            identifiant: null,
            motDePasse: null
        }
    },

    methods: {
        connecter() {
            this.$store.commit('connecter', {identifiant: this.identifiant, motDePasse: this.motDePasse})
            this.$router.push('/')
        }
    }
}