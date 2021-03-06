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
            capteurs: [],
            markersVehicules: [],
            markersCasernes: [],
            markersIncidents: [],
            markersCapteurs: [],
            interval: null,
            affichageCaserne: true,
            affichageVehicule: true,
            affichageIncident: true,
            affichageCapteur: true,
            moment: moment
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
        },

        affichageCapteur: {
            handler() {
                this.afficherCapteurs();
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

        recupererCapteurs() {
            return api.recuperer("capteur")
                .then(result => {
                    this.capteurs = result.data;
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
                        iconAnchor: [19, 19],
                        popupAnchor: [1, -34],
                        shadowSize: [41, 41]
                    })
                }

                var marker = L.marker(latlng, options);

                var chaineInfo = `<div style="font-size: 20px">${element.modele} <i>${element.num_immatriculation}</i></div><div>Longitude : <i>${element.longitude}</i></div><div>Latitude : <i>${element.latitude}</i></div><div>ID : ${element.id}</div>`
                chaineInfo += `<div>Caserne : ${element.caserne_nom}</div>`
                chaineInfo += `<div class="mt-2">Produits</div>`
                chaineInfo += `<ul>`
                element.produits.forEach(x => {
                    chaineInfo += `<li>${x.libelle}</li>`
                })
                chaineInfo += `</ul>`
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

                var chaineInfo = `<div style="font-size: 20px">Date de d??but : ${moment(element.date_debut).format("HH[h] mm[min]")}</div><div>Type : ${element.type_incident_libelle}</div><div>Longitude : <i>${element.longitude}</i></div><div>Latitude : <i>${element.latitude}</i></div>`
                marker.bindPopup(chaineInfo)

                this.markersIncidents.push(marker);
                this.afficherIncidents();
            });
        },

        ajouterCapteurs() {
            //On supprime tous les markers
            this.markersCapteurs.forEach(x => {
                this.carte.removeLayer(x);
            })

            this.markersCapteurs = [];

            //On ajoute les markers
            this.capteurs.forEach(element => {
                var latlng = L.latLng(element.latitude, element.longitude);
                var options = {
                    draggable: false,
                    icon: new L.Icon({
                        iconUrl: require('@/assets/images/capteur.png'),
                        // shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
                        iconSize: [25, 25],
                        iconAnchor: [20, 20],
                        popupAnchor: [1, -34],
                        shadowSize: [25, 25]
                    })
                }

                var marker = L.marker(latlng, options);

                // // Mise ?? jour des coordonn??es BD du capteur
                // marker.on('dragend', function (event) {
                //     var marker = event.target;
                //     var position = marker.getLatLng();

                //     element.latitude = position.lat;
                //     element.longitude = position.lng;
                //     api.mettreAJour("capteur", element)
                //         .then(() => {
                //         })
                // });


                var chaineInfo = `<div style="font-size: 20px">Code : ${element.code}</div><div>Mod??le : ${element.modeleLibelle}</div><div>Longitude : <i>${element.longitude}</i></div><div>Latitude : <i>${element.latitude}</i></div>`
                marker.bindPopup(chaineInfo)

                this.markersCapteurs.push(marker);
                this.afficherCapteurs();
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
        },

        afficherCapteurs() {
            this.markersCapteurs.forEach(x => {
                if (this.affichageCapteur) {
                    this.carte.addLayer(x)
                } else {
                    this.carte.removeLayer(x)
                }
            })
        },

        zoomCarte(element) {
            this.carte.setView([element.latitude, element.longitude])
        }
    },

    mounted() {
        this.creerCarte();

        // R??cup??ration et affichage des ressources 
        this.recupererCapteurs().then(() => {
            this.ajouterCapteurs();
        })


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

        // Boucle infinie pour r??cup??rer la position des v??hicules et des incidents en temps r??el
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