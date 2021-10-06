import Vue from "vue";
import Vuex from "vuex";
import modules from './modules'

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    // true: 코로나 격리, false: 평시
    coronaStatus: false,
    // Data Table에서 한 페이지당 표시할 item 개수
    ITEMS_PER_PAGE: 10,
    // pagination에서 최대 표시할 페이지 개수
    TOTAL_VISIBLE: 7,
  },
  modules
});
