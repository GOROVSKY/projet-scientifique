
import api from '@/api/api.js'

export default {
    name: 'TypeProduitSelection',

    data() {
        return {
            liste: [],
            elementSelectionne: null
        }
    },

    methods: {
        recupererListe() {
            api.recuperer("typeProduit")
                .then(result => {
                    this.liste = result.data;
                })
        },

        choisir(element) {
            this.elementSelectionne = element;
            this.$emit("elementSelectionne")
        },
        

        annuler() {
            this.$emit("elementSelectionne")
        }

    },

    created() {
        this.recupererListe()
    }
}