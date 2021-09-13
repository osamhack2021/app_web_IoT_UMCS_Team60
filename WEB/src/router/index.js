import { createRouter, createWebHistory } from 'vue-router';
import LocationState from '../views/LocationState.vue';

const routes = [
  {
    path: '/',
    redirect: '/location-state',
  },
  {
    path: '/location-state',
    name: 'location-state',
    component: LocationState,
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;