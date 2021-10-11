import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import axios from "axios";
import vuetify from "./plugins/vuetify";
import VueDraggableResizable from "vue-draggable-resizable";
import "vue-draggable-resizable/dist/VueDraggableResizable.css";
import io from "socket.io-client";

const socket = io("/manager");

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
