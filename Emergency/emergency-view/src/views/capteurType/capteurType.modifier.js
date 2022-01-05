
import api from '@/api/api.js'

export default {
    name: 'CapteurTypeModifier',

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
            api.recuperer("typeCapteur", { id: this.id })
                .then(result => {
                    this.element = result.data;
                })
        },

        recupererTypes() {
            api.recuperer("typeCapteur")
                .then(result => {
                    this.modeles = result.data;
                })
        },

        valider() {
            if (this.id) this.modifier();
            else this.ajouter();
        },

        ajouter() {
            api.inserer("typeCapteur", this.element)
                .then(() => {
                    this.$emit("valider")
                })
        },

        modifier() {
            api.mettreAJour("typeCapteur", this.element)
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