
import api from '@/api/api.js'

export default {
    name: 'CapteurModifier',

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
            api.recuperer("capteur", { id: this.id })
                .then(result => {
                    this.element = result.data;
                })
        },

        recupererModeles() {
            return api.recuperer("modeleCapteur")
                .then(result => {
                    this.modeles = result.data;
                    if (!this.id) this.element.modeleId = this.modeles[0]?.id
                })
        },

        valider() {
            if (this.id) this.modifier();
            else this.ajouter();
        },

        ajouter() {
            api.inserer("capteur", this.element)
                .then(() => {
                    this.$emit("valider")
                })
        },

        modifier() {
            api.mettreAJour("capteur", this.element)
                .then(() => {
                    this.$emit("valider")
                })
        },

        annuler() {
            this.$emit("valider")
        }
    },

    created() {
        this.recupererModeles().then(() => {
            if (this.id) {
                this.recupererElement();
            }
        })
    }
}