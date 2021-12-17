import { createRouter, createWebHistory } from 'vue-router'
import Index from '../views/index/index.vue'

const routes = [
  {
    path: '/',
    name: 'Index',
    component: Index
  },
  {
    path: '/caserne',
    name: 'Caserne',
    component: () => import('../views/caserne/caserne.index.vue')
  },
  {
    path: '/pompier',
    name: 'Pompier',
    component: () => import('../views/pompier/pompier.index.vue')
  },
  {
    path: '/vehicule',
    name: 'Vehicule',
    component: () => import('../views/vehicule/vehicule.index.vue')
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
