import api from '@/api/api.js'
import L from 'leaflet'

export default {
    name: 'Index',

    data() {
        return {
            latitude: 45.761086,
            longitude: 4.858308,
            carte: null,
            vehicules: [],
            incidents: [],
            casernes: [],
            markersVehicules: [],
            markersCasernes: [],
            markersIncidents: [],
            direction: 0.0004
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

        recupererVehicules() {
            return api.recuperer("vehicule")
                .then(result => {
                    this.vehicules = result.data;

                })
        },

        recupererCasernes() {
            return api.recuperer("caserne")
                .then(result => {
                    this.casernes = result.data;

                })
        },

        recupererIncidents() {
            return api.recuperer("incident")
                .then(result => {
                    this.incidents = result.data;
                })
        },

        afficherVehicules() {
            //On supprime toutes les bornes
            this.markersVehicules.forEach(x => {
                this.carte.removeLayer(x);
            })

            this.markersVehicules = [];

            //On ajoute les bornes
            this.vehicules.forEach(element => {
                var latlng = L.latLng(element.latitude, element.longitude);
                var options = {
                    draggable: false,
                    icon: new L.Icon({
                        iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png',
                        shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
                        iconSize: [25, 41],
                        iconAnchor: [12, 41],
                        popupAnchor: [1, -34],
                        shadowSize: [41, 41]
                    })
                }

                var marker = L.marker(latlng, options);
               
                var chaineInfo =  `<div style="font-size: 20px">${element.modele} <i>${element.num_immatriculation}</i></div><div>Longitude : <i>${element.longitude}</i></div><div>Latitude : <i>${element.latitude}</i></div>`
                marker.bindPopup(chaineInfo)

                this.markersVehicules.push(marker);
                this.carte.addLayer(marker);
            });
        },

        afficherCasernes() {
            //On supprime tous les markers
            this.markersCasernes.forEach(x => {
                this.carte.removeLayer(x);
            })

            this.markersCasernes = [];

            //On ajoute les markers
            this.casernes.forEach(element => {
                var latlng = L.latLng(element.latitude, element.longitude);
                var options = {
                    draggable: false,
                    icon: new L.Icon({
                        iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-blue.png',
                        shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
                        iconSize: [25, 41],
                        iconAnchor: [12, 41],
                        popupAnchor: [1, -34],
                        shadowSize: [41, 41]
                    })
                }

                var marker = L.marker(latlng, options);

                var chaineInfo = `<span style="font-size: 20px">${element.nom}</span><div><i>${element.adresse}</i></div><div></i>${element.code_postal} ${element.ville}</i></div>`
                marker.bindPopup(chaineInfo)

                this.markersCasernes.push(marker);
                this.carte.addLayer(marker);
            });
        },

        afficherIncidents() {
            //On supprime tous les markers
            this.markersIncidents.forEach(x => {
                this.carte.removeLayer(x);
            })

            this.markersIncidents = [];

            //On ajoute les markers
            this.incidents.forEach(element => {
                var latlng = L.latLng(element.latitude, element.longitude);
                var options = {
                    draggable: false,
                    icon: new L.Icon({
                        iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png',
                        shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
                        iconSize: [25, 41],
                        iconAnchor: [12, 41],
                        popupAnchor: [1, -34],
                        shadowSize: [41, 41]
                    })
                }

                var marker = L.marker(latlng, options);

                var chaineInfo = `<div style="font-size: 20px">Date de début : ${element.date_debut}</div><div>Longitude : <i>${element.longitude}</i></div><div>Latitude : <i>${element.latitude}</i></div>`
                marker.bindPopup(chaineInfo)

                this.markersIncidents.push(marker);
                this.carte.addLayer(marker);
            });
        },

        deplacerVehicule() {
            var latitude = this.vehicules[0]?.latitude;
            if (latitude >= 45.8 || latitude <= 45.7) this.direction *= -1;

            latitude += this.direction;

            return api.mettreAJour("vehicule", { id: this.vehicules[0]?.id, latitude: latitude })
                .then(() => { })
        },
    },

    mounted() {
        this.creerCarte();
        this.recupererCasernes().then(() => {
            this.afficherCasernes();
        })

        this.recupererVehicules().then(() => {
            this.afficherVehicules();
            this.deplacerVehicule();
        })

        this.recupererIncidents().then(() => {
            this.afficherIncidents();
        })

        setInterval(() => {
            this.recupererVehicules().then(() => {
                this.afficherVehicules();
                this.deplacerVehicule();
            })
            this.recupererIncidents().then(() => {
                this.afficherIncidents();
            })
        }, 3000);
    }
}