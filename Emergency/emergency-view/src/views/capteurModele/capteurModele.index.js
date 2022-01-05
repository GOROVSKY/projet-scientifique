
import api from '@/api/api.js'
import CapteurModeleModifier from './capteurModele.modifier.vue';
import CapteurTypeSelection from '@/views/capteurType/capteurType.selection.vue';

export default {
    name: 'CapteurModeleIndex',

    components: {
        CapteurModeleModifier,
        CapteurTypeSelection
    },

    data() {
        return {
            liste: [],
            afficherModale: false,
            afficherSelection: false,
            elementSelectionne: null
        }
    },

    methods: {
        recupererListe() {
            api.recuperer("modeleCapteur")
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
            api.supprimer("modeleCapteur", { id: element.id })
                .then(() => {
                    this.recupererListe();
                })
        },

        fermerModale() {
            this.afficherModale = false;
            this.elementSelectionne = null;
            this.recupererListe();
        },

        ajouterType(element) {
            this.elementSelectionne = element;
            this.afficherSelection = true;
        },

        async fermerModaleSelection() {
            var type = this.$refs.capteurTypeSelection.elementSelectionne;
            if (type != null) {
                await api.inserer("modeleTypeCapteur", { id_modele_capteur: this.elementSelectionne.id, id_type_capteur: type.id})
            }

            this.afficherSelection = false;
            this.elementSelectionne = null;
            this.recupererListe();
        },

        supprimerType(element, type) {
            api.supprimerIds("modeleTypeCapteur", { id1: element.id, id2: type.id}).then(() => {
                this.recupererListe();
            })
        }
    },

    created() {
        this.recupererListe()
    }
}