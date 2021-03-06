import moment from 'moment'
export default {
    name: 'Header',


    data() {
        return {
            heureActuelle: moment(new Date()).format("HH[:]mm[:]ss"),
            interval: null
        }
    },

    methods: {
        connexion() {
            
        },

        deconnecter() {
            this.$store.commit('deconnecter');
            this.$router.push('/connexion')
        }
    },

    created() {
        this.interval = setInterval(() => {
            this.heureActuelle = moment(new Date()).format("HH[:]mm[:]ss")
        }, 1000)
    },

    beforeUnmount() {
        clearInterval(this.interval)
    }
}