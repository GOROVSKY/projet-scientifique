
import L from 'leaflet'

export default {
    name: 'Index',

    data() {
        return {
            latitude: 45.761086,
            longitude: 4.858308,
            carte: null,
        }
    },

    methods: {
        creerCarte() {
            this.carte = L.map('map')
                .setView([this.latitude, this.longitude], 13);

            L.tileLayer('https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png', {
                minZoom: 1,
                maxZoom: 20,
            }).addTo(this.carte);


            // this.carte.on('click', (e) => {
            //     this.placerBorneUtilisateur(e)
            // });
        },
    },

    mounted() {
        this.creerCarte();
    }
}