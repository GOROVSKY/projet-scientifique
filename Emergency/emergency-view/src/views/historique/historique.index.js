import moment from 'moment'
import api from '@/api/api.js'

export default {
    name: 'HistoriqueIndex',

    components: {
    },

    data() {
        return {
            liste: [],
            moment: moment,
            filtreDateDebut: null,
            filtreDateFin: null,
            filtreCriticite: null
        }
    },

    watch: {
        filtreDateDebut: {
            handler() {
                if (this.filtreDateDebut == "") {
                    this.filtreDateDebut = null;
                }

                this.recupererListe();
            }
        },
        
        filtreDateFin: {
            handler() {
                if (this.filtreDateFin == "") {
                    this.filtreDateFin = null;
                }

                this.recupererListe();
            }
        },
        
        filtreCriticite: {
            handler() {
                this.recupererListe();
            }
        }
    },

    methods: {
        recupererListe() {
            api.recuperer(`incident/historique?dateDebut=${this.filtreDateDebut}&dateFin=${this.filtreDateFin}&criticite=${this.filtreCriticite}`)
                .then(result => {
                    this.liste = result.data;
                })
        },

        reinitialiserFiltre() {
            this.filtreDateDebut = null;
            this.filtreDateFin = null;
            this.filtreCriticite = null;
        }
    },

    created() {
        this.recupererListe()
    }
}