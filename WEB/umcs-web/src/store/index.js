import Vue from "vue";
import Vuex from "vuex";
import modules from "./modules";

import {
  fetchCurrentSituation,
  fetchAdmins,
  fetchUsers,
  fetchDoomList,
  fetchFacilityList,
} from "@/api/index.js";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    // true: 코로나 격리, false: 평시
    coronaSituation: undefined,
    // Data Table에서 한 페이지당 표시할 item 개수
    ITEMS_PER_PAGE: 10,
    // pagination에서 최대 표시할 페이지 개수
    TOTAL_VISIBLE: 7,

    // 관리자 목록
    adminList: [],

    // 관리중인 용사들의 목록
    userList: [],

    // 관리 단위(건물, 생활관 등)의 목록
    doomList: [],

    // 관리하는 장소들의 목록
    facilityList: [],
  },

  mutations: {
    setCoronaSituation(state, value) {
      state.coronaSituation = value;
    },
    setAdminList(state, data) {
      state.adminList = data;
    },
    setUserList(state, data) {
      state.userList = data;
    },
    setDoomList(state, data) {
      state.doomList = data;
    },
    setFacilityList(state, data) {
      state.facilityList = data;
    },
  },

  actions: {
    async FETCH_CORONA_SITUATION({ commit }) {
      try {
        const response = await fetchCurrentSituation();
        const resData = response.data.data;
        commit("setCoronaSituation", Boolean(resData.isCohort));
        return resData;
      } catch (error) {
        console.log(error);
      }
    },
    async FETCH_ADMIN_LIST({ commit }) {
      try {
        const response = await fetchAdmins();
        const resData = response.data.data;
        const data = [];
        if (resData) {
          resData.forEach((elem) => {
            const obj = elem;
            obj.identity = `${elem.rank} ${elem.name}`;
            data.push(obj);
          });
        } else {
          console.log("데이터가 없습니다.", response);
        }
        commit("setAdminList", data);
        return data;
      } catch (error) {
        console.log(error);
      }
    },
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
    async FETCH_DOOM_LIST({ commit }) {
      try {
        const response = await fetchDoomList();
        const resData = response.data.data;
        commit("setDoomList", resData);
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
    },
  },

  modules,
});
