
import api from '@/api/api.js'

export default {
    name: 'CapteurTypeSelection',

    data() {
        return {
            liste: [],
            elementSelectionne: null
        }
    },

    methods: {
        recupererListe() {
            api.recuperer("typeCapteur")
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