
import api from '@/api/api.js'

export default {
    name: 'TypeProduitSelection',

    props: {
        vehicule: {}
    },

    data() {
        return {
            liste: [],
            elementSelectionne: null
        }
    },

    computed: {
        listeVisible: function () {
            if (this.vehicule == null) return this.liste;

            var produits = this.vehicule.produits
            var listeFiltree = this.liste.filter(function (x) {
                return produits.filter(function (y) {
                    return y.id == x.id;
                }).length == 0
            });

            return listeFiltree;
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
        this.recupererListe();
    }
}