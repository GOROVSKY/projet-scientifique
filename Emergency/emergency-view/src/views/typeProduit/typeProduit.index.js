
import api from '@/api/api.js'
import TypeProduitModifier from './typeProduit.modifier.vue';

export default {
    name: 'TypeProduitIndex',

    components: {
        TypeProduitModifier
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
            api.recuperer("typeProduit")
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
            api.supprimer("typeProduit", { id: element.id })
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