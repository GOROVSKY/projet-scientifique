import api from '@/api/api.js'

export default {
    name:  'IncidentCreer',
    data() {
        return {
            incident: {
                longitude: 4.872431,
                latitude: 45.766682,
            },
            typesIncident: []
        }
    },

    methods: {
        recupererTypesIncident() {
            api.recuperer("typeIncident")
                .then(result => {
                    this.typesIncident = result.data;
                    this.incident.id_type_incident = this.typesIncident[0]?.id
                })
        },


        ajouter() {
            api.inserer("incident", this.incident)
                .then(() => {
                    this.$router.push('/')
                })
        },
    },

    created() {
        this.recupererTypesIncident();
    }
}