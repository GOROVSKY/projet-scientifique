import api from '@/api/api.js'

import VehiculeModifier from './vehicule.modifier.vue';

export default {
    name: 'VehiculeIndex',

    components: {
        VehiculeModifier
    },

    data() {
        return {
            liste: [
                {
                    numImmatriculation: "ZE-568-ZD",
                    modele: "Tesla",
                    capacitePersonne: 5,
                    capaciteProduit: 10,
                    produits: [
                        { libelle: "Eau"}
                    ],
                    longitude: 56.325659,
                    latitude: 56.325659,
                    caserneNom: 'Caserne de Lyon',
                }
            ],
            afficherModale: false,
            elementSelectionne: null
        }
    },

    methods: {
        recupererListe() {
            // api.recuperer("vehicule")
            //     .then(result => {
            //         this.liste = result.data;
            //     })
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