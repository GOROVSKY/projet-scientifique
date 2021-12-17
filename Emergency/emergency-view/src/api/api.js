import axios from "axios";


export default {
     API_URL: "http://172.20.10.2:5000/api/",

     // appeler(methods, params) {

     // },

     recuperer(methode, params) {
          return axios.get(`${this.API_URL}/${methode}`, params)
             .then(result => {
                 return result
          })
     },

     inserer(methode, params) {
          return axios.put(`${this.API_URL}/${methode}`, params)
             .then(result => {
                 return result
          })
     },
     
     mettreAJour(methode, params) {
          return axios.post(`${this.API_URL}/${methode}`, params)
             .then(result => {
                 return result
          })
     },

     supprimer(methode, params) {
          return axios.delete(`${this.API_URL}/${methode}`, params)
             .then(result => {
                 return result
          })
     }
}