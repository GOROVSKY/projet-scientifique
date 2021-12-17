
import api from '@/api/api.js'

export default {
    name: 'CaserneModifier',

    props: {
        id: {}
    },

    data() {
        return {
            element: {}
        }
    },

    methods: {
        recupererElement() {
            api.recuperer("caserne", { id: this.id })
                .then(result => {
                    this.element = result.data;
                })
        },

        valider() {
            if (this.id) this.modifier();
            else this.ajouter();
        },

        ajouter() {
            api.inserer("caserne", this.element)
                .then(() => {
                    this.$emit("valider")
                })
        },

        modifier() {
            api.mettreAJour("caserne", this.element)
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