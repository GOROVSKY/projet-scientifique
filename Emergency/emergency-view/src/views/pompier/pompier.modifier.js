import api from '@/api/api.js'

export default {
    name: 'PompierModifier',

    props: {
        id: {}
    },

    data() {
        return {
            element: {},
            casernes: []
        }
    },

    methods: {
        recupererElement() {
            api.recuperer("pompier", { id: this.id })
                .then(result => {
                    this.element = result.data;
                })
        },

        recupererCasernes() {
            api.recuperer("caserne")
                .then(result => {
                    this.casernes = result.data;
                })
        },

        valider() {
            if (this.id) this.modifier();
            else this.ajouter();
        },

        ajouter() {
            api.inserer("pompier", this.element)
                .then(() => {
                    this.$emit("valider")
                })
        },

        modifier() {
            api.mettreAJour("pompier", this.element)
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