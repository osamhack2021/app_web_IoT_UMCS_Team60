import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import axios from "axios";
import vuetify from "./plugins/vuetify";
import VueDraggableResizable from "vue-draggable-resizable";
import "vue-draggable-resizable/dist/VueDraggableResizable.css";
import io from "socket.io-client";

import io  from 'socket.io-client'
import VueSocketIO from 'vue-socket.io-extended'
const socket = io('https://militaryumcs.com/manager', { transports : ['websocket'] });

Vue.prototype.$socket = socket;
Vue.config.productionTip = false;

new Vue({
  router,
  store,
  axios,
  vuetify,
  VueDraggableResizable,
  render: (h) => h(App),
}).$mount("#app");
