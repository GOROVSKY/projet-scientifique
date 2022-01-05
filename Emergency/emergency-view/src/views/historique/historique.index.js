import moment from 'moment'
import api from '@/api/api.js'

export default {
    name: 'HistoriqueIndex',

    components: {
    },

    data() {
        return {
            liste: [],
            moment: moment
        }
    },

    methods: {
        recupererListe() {
            api.recuperer("incident/historique")
                .then(result => {
                    this.liste = result.data;
                })
        },
    },

    created() {
        this.recupererListe()
    }
}