import api from '@/api/api.js'

import VehiculeModifier from './vehicule.modifier.vue';
import TypeProduitSelection from '@/views/typeProduit/typeProduit.selection.vue';

export default {
    name: 'VehiculeIndex',

    components: {
        VehiculeModifier,
        TypeProduitSelection
    },

    data() {
        return {
            liste: [],
            afficherModale: false,
            afficherProduit: false,
            elementSelectionne: null
        }
    },

    methods: {
        recupererListe() {
            api.recuperer("vehicule")
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
            api.supprimer("vehicule", { id: element.id })
                .then(() => {
                    this.recupererListe();
                })
        },

        supprimerProduit(vehicule, produit) {
            api.supprimerIds("vehiculeTypeProduit", { id1: vehicule.id, id2: produit.id })
                .then(() => {
                    this.recupererListe();
                })
        },

        ajouterProduit(vehicule) {
            this.elementSelectionne = vehicule;
            this.afficherProduit = true;
        },

        fermerModale() {
            this.afficherModale = false;
            this.elementSelectionne = null;
            this.recupererListe();
        },

        async fermerModaleProduit() {
            var produit = this.$refs.typeProduitSelection.elementSelectionne;
            if (produit != null) {
                await api.inserer("vehiculeTypeProduit", { id_vehicule: this.elementSelectionne.id, id_type_produit: produit.id})
            }

            this.afficherProduit = false;
            this.elementSelectionne = null;

            this.recupererListe();
        }
    },

    created() {
        this.recupererListe()
    }
}