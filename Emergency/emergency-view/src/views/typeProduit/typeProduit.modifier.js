
import api from '@/api/api.js'

export default {
    name: 'TypeProduitModifier',

    props: {
        id: {}
    },

    data() {
        return {
            element: {},
            modeles: []
        }
    },

    methods: {
        recupererElement() {
            api.recuperer("typeProduit", { id: this.id })
                .then(result => {
                    this.element = result.data;
                })
        },

        valider() {
            if (this.id) this.modifier();
            else this.ajouter();
        },

        ajouter() {
            api.inserer("typeProduit", this.element)
                .then(() => {
                    this.$emit("valider")
                })
        },

        modifier() {
            api.mettreAJour("typeProduit", this.element)
                .then(() => {
                    this.$emit("valider")
                })
        },

        annuler() {
            this.$emit("valider")
        }
    },

    created() {
        if (this.id) {
            this.recupererElement();
        }
    }
}