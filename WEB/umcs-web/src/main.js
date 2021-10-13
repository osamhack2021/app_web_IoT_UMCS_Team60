
import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import axios from "axios";
import vuetify from "./plugins/vuetify";
import VueDraggableResizable from "vue-draggable-resizable";
import "vue-draggable-resizable/dist/VueDraggableResizable.css";

import io  from 'socket.io-client'
import VueSocketIO from 'vue-socket.io-extended'
import VueCookies from "vue-cookies";
Vue.use(VueCookies);
// 실 배포때는 option 제거할 것
const socket = io.connect('https://militaryumcs.com/manager', { query: 'session_id=' + window.$cookies.get('express.sid')?.replace('s:','').split('.')[0] });

Vue.use(VueSocketIO, socket);
Vue.config.productionTip = false;

new Vue({
  router,
  store,
  axios,
  vuetify,
  VueDraggableResizable,
  render: (h) => h(App),
}).$mount("#app");