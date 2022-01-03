
import api from '@/api/api.js'
import CapteurModeleModifier from './capteurModele.modifier.vue';

export default {
    name: 'CapteurModeleIndex',

    components: {
        CapteurModeleModifier
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
            api.recuperer("modeleCapteur")
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
            api.supprimer("modeleCapteur", { id: element.id })
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