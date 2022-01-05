import axios from "axios";


export default {
     API_URL: "http://127.0.0.1:5000/api",

     // appeler(methods, params) {

     // },

     recuperer(methode, params = {}) {
          var url = `${this.API_URL}/${methode}`
          if (params["id"] != null ) {
               url += `/${params["id"]}`
          }

          return axios.get(url)
               .then(result => {
                    if (params["id"] != null) {
                         result.data = result.data[0]
                    }
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
          var url = `${this.API_URL}/${methode}/${params["id"]}`
          return axios.delete(url, params)
               .then(result => {
                    return result
               })
     },

     supprimerIds(methode, params) {
          var url = `${this.API_URL}/${methode}/${params["id1"]}&${params["id2"]}`
          return axios.delete(url, params)
               .then(result => {
                    return result
               })
     },
}