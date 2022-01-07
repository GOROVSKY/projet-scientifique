import api from '@/api/api.js'
import L from 'leaflet'
import moment from 'moment'

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
            pompiers: [],
            markersVehicules: [],
            markersCasernes: [],
            markersIncidents: [],
            interval: null,
            affichageCaserne: true,
            affichageVehicule: true,
            affichageIncident: true
        }
    },

    watch: {
        affichageCaserne: {
            handler() {
                this.afficherCasernes();
            }
        },

        affichageVehicule: {
            handler() {
                this.afficherVehicules();
            }
        },

        affichageIncident: {
            handler() {
                this.afficherIncidents();
            }
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

        recupererPompiers() {
            return api.recuperer("pompier")
                .then(result => {
                    this.pompiers = result.data;
                })
        },

        ajouterVehicules() {
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
                        iconUrl: require('@/assets/images/camion_pompier.png'),
                        iconSize: [50, 50],
                        iconAnchor: [10, 0],
                        popupAnchor: [1, -34],
                        shadowSize: [41, 41]
                    })
                }

                var marker = L.marker(latlng, options);
               
                var chaineInfo =  `<div style="font-size: 20px">${element.modele} <i>${element.num_immatriculation}</i></div><div>Longitude : <i>${element.longitude}</i></div><div>Latitude : <i>${element.latitude}</i></div><div>ID : ${element.id}</div>`
                chaineInfo += `<div>Caserne : ${element.caserne_nom}</div>`
                marker.bindPopup(chaineInfo)

                this.markersVehicules.push(marker);
                this.afficherVehicules();
            });
        },

        ajouterCasernes() {
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
                        iconUrl: require('@/assets/images/caserne.png'),
                        shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
                        iconSize: [40, 40],
                        iconAnchor: [20, 20],
                        popupAnchor: [1, -34],
                        shadowSize: [41, 41]
                    })
                }

                var marker = L.marker(latlng, options);

                var chaineInfo = `<span style="font-size: 20px">${element.nom}</span><div><i>${element.adresse}</i></div><div></i>${element.code_postal} ${element.ville}</i></div>`
                marker.bindPopup(chaineInfo)

                this.markersCasernes.push(marker);
                this.afficherCasernes();
            });
        },

        ajouterIncidents() {
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
                        iconUrl: require('@/assets/images/incident.png'),
                        // shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
                        iconSize: [40, 40],
                        iconAnchor: [20, 20],
                        popupAnchor: [1, -34],
                        shadowSize: [25, 25]
                    })
                }

                var marker = L.marker(latlng, options);

                var chaineInfo = `<div style="font-size: 20px">Date de début : ${moment(element.date_debut).format("HH[h] mm[min]")}</div><div>Type : ${element.type_incident_libelle}</div><div>Longitude : <i>${element.longitude}</i></div><div>Latitude : <i>${element.latitude}</i></div>`
                marker.bindPopup(chaineInfo)

                this.markersIncidents.push(marker);
                this.afficherIncidents();
            });
        },

        afficherCasernes() {
            this.markersCasernes.forEach(x => {
                if (this.affichageCaserne) {
                    this.carte.addLayer(x)
                } else {
                    this.carte.removeLayer(x)
                }
            })
        },

        afficherVehicules() {
            this.markersVehicules.forEach(x => {
                if (this.affichageVehicule) {
                    this.carte.addLayer(x)
                } else {
                    this.carte.removeLayer(x)
                }
            })
        },

        afficherIncidents() {
            this.markersIncidents.forEach(x => {
                if (this.affichageIncident) {
                    this.carte.addLayer(x)
                } else {
                    this.carte.removeLayer(x)
                }
            })
        }
    },

    mounted() {
        this.creerCarte();
        this.recupererCasernes().then(() => {
            this.ajouterCasernes();

            this.recupererVehicules().then(() => {
                this.ajouterVehicules();
            })

            this.recupererPompiers();
        })

        this.recupererIncidents().then(() => {
            this.ajouterIncidents();
        })

        this.interval = setInterval(() => {
            this.recupererVehicules().then(() => {
                this.ajouterVehicules();
            })
            this.recupererIncidents().then(() => {
                this.ajouterIncidents();
            })
            
            this.recupererPompiers();
        }, 2000);
    },

    beforeUnmount() {
        clearInterval(this.interval);
    }
}