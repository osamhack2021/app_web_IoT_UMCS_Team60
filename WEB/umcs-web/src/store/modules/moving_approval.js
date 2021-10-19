import { loadingCycle } from "@/utils/loading.js";
import {
  fetchUserInfo,
  fetchMovingReport,
  fetchMovingReport_Id,
  fetchCurrentLocation_Tag,
} from "@/api/index.js";

const state = {
  // Search
  searchInput: "",

  // Selected
  selectedItems: [],

  // Loading
  loading: false,

  // Data Table
  tableHeaders: [
    { text: "군번", value: "tag" },
    { text: "관등성명", value: "name" },
    { text: "보고 시간", value: "reportedTime" },
    { text: "현재 위치", value: "currentLocation" },
    { text: "이동할 곳", value: "locationToGo" },
    { text: "승인", value: "accept", sortable: false },
    { text: "거절", value: "reject", sortable: false },
    { text: "목적", value: "data-table-expand" },
  ],
  tableDatas: [],
};

const getters = {
  getSearchInput(state) {
    return state.searchInput;
  },
  getSelectedItems(state) {
    return state.selectedItems;
  },
  getLoading(state) {
    return state.loading;
  },
  getCountMovingReport(state) {
    return state.tableDatas.length;
  },
};

const mutations = {
  updateSearchInput(state, value) {
    state.searchInput = value;
  },
  updateSelectedItems(state, value) {
    state.selectedItems = value;
  },
  setLoading(state, value) {
    state.loading = value;
  },
  updateMovingReport(state, data) {
    state.tableDatas = data;
  },
  pushMovingReport(state, obj) {
    state.tableDatas.push(obj);
  },
  deleteMovingReport(state, id) {
    for (let i=0; i < state.tableDatas.length; i++) {
      if (state.tableDatas[i].id === id) {
        state.tableDatas.splice(i, 1);
        break;
      }
    }
  }
};

const actions = {
  async FETCH_MOVING_REPORT({ commit, state }) {
    let count = 0;
    commit("setLoading", true);
    try {
      const response = await fetchMovingReport();
      count += parseInt(response.data.total);
      const resData = response.data.data;
      const data = [];
      if (resData) {
        resData.forEach(async (elem) => {
          const obj = {};
          const currentLocation = await fetchCurrentLocation_Tag(elem.user_tag);
          const reportedDate = new Date(elem.request_time);
          // UTC time으로 Date 객체를 생성하면 현지 시각으로 자동 변환됨
          // 한국시간, UTC time은 9시간 차이나므로 자동 변환을 막는 code
          reportedDate.setHours(reportedDate.getHours() - 9);

          obj.id = elem.id;
          obj.tag = elem.user_tag;
          obj.name = `${elem.user_rank} ${elem.user_name}`;
          obj.reportedTime = reportedDate.toLocaleString();
          if (currentLocation.data.code === 1) {
            obj.currentLocation = currentLocation.data.data[0].name;
          } else {
            obj.currentLocation = "알 수 없음";
          }
          obj.locationToGo = elem.outside_name;
          obj.details = elem.description || "내용이 없습니다.";
          data.push(obj);
        });
      } else {
        count = 0;
        console.log("There is not Moving report!");
      }
      commit("updateMovingReport", data);
      let timer = setInterval(() => {
        if (state.tableDatas.length === count) {
          commit("setLoading", false);
          clearInterval(timer);
        }
      }, loadingCycle);
      return data;
    } catch (error) {
      console.log(error);
    }
  },
  async ADD_MOVING_REPORT({ commit }, data) {
    try {
      const obj = {};
      const currentLocation = await fetchCurrentLocation_Tag(data.user_tag);
      const userInfo = await fetchUserInfo(data.user_tag);
      const locationToGo = await fetchMovingReport_Id(data.id);
      const reportedDate = new Date(data.request_time);

      obj.id = data.id;
      obj.tag = data.user_tag;
      obj.name = `${userInfo.data.data.rank} ${userInfo.data.data.name}`;
      obj.reportedTime = reportedDate.toLocaleString();
      if (currentLocation.data.code === 1) {
        obj.currentLocation = currentLocation.data.data[0].name;
      } else {
        obj.currentLocation = "알 수 없음";
      }
      obj.locationToGo = locationToGo.data.data.outside_name;
      obj.details = data.description || "내용이 없습니다.";

      commit("pushMovingReport", obj);
      return data;
    } catch (error) {
      console.log(error);
    }
  }
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
