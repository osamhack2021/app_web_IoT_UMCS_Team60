import Vue from "vue";
import Vuex from "vuex";
import modules from './modules'

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    // true: 코로나 격리, false: 평시
    coronaStatus: false,
  },
  modules
});
