import Vue from "vue";
import Vuex from "vuex";
import modules from "./modules";

import { fetchUsers, fetchFacilityList } from "@/api/index.js";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    // true: 코로나 격리, false: 평시
    coronaStatus: false,
    // Data Table에서 한 페이지당 표시할 item 개수
    ITEMS_PER_PAGE: 10,
    // pagination에서 최대 표시할 페이지 개수
    TOTAL_VISIBLE: 7,

    // 관리중인 용사들의 목록
    userList: [],

    // 관리하는 장소들의 목록
    facilityList: [],
  },

  mutations: {
    setUserList(state, data) {
      state.userList = data;
    },
    setFacilityList(state, data) {
      state.facilityList = data;
    }
  },

  actions: {
    async FETCH_USER_LIST({ commit }) {
      try {
        const response = await fetchUsers();
        const resData = response.data.data;
        commit("setUserList", resData);
        return resData;
      } catch (error) {
        console.log(error);
      }
    },
    async FETCH_FACILITY_LIST({ commit }) {
      try {
        const response = await fetchFacilityList();
        const resData = response.data.data;
        commit("setFacilityList", resData);
        return resData;
      } catch (error) {
        console.log(error);
      }
    }
  },

  modules,
});
