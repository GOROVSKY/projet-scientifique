
import api from '@/api/api.js'
import CapteurTypeModifier from './capteurType.modifier.vue';

export default {
    name: 'CapteurTypeIndex',

    components: {
        CapteurTypeModifier
    },

    data() {
        return {
            liste: [],
            afficherModale: false,
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

        ajouter() {
            this.afficherModale = true;
        },

        modifier(element) {
            this.elementSelectionne = element;
            this.afficherModale = true;
        },

        supprimer(element) {
            api.supprimer("typeCapteur", { id: element.id })
                .then(() => {
                    this.recupererListe();
                })
        },

        fermerModale() {
            this.afficherModale = false;
            this.elementSelectionne = null;
            this.recupererListe();
        }
    },

    created() {
        this.recupererListe()
    }
}