import api from '@/api/api.js'

import PompierModifier from './pompier.modifier.vue';

export default {
    name: 'PompierIndex',

    components: {
        PompierModifier
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
            api.recuperer("pompier")
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
            api.supprimer("pompier", { id: element.id })
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