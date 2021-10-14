import {
  fetchMovingReport,
  fetchCurrentLocation_Tag,
} from "@/api/index.js";

const state = {
  // Search
  searchInput: "",

  // Selected
  selectedItems: [],

  // Loading
  loading: true,

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
};

const actions = {
  async FETCH_MOVING_REPORT({ commit }) {
    commit("setLoading", true);
    try {
      const response = await fetchMovingReport();
      const resData = response.data.data;
      const data = [];
      if (resData) {
        resData.forEach(async (elem) => {
          const obj = {};
          const currentLocation = await fetchCurrentLocation_Tag(elem.user_tag);
          const reportedDate = new Date(elem.request_time);

          obj.id = elem.id;
          obj.tag = elem.user_tag;
          obj.name = `${elem.user_rank} ${elem.user_name}`;
          obj.reportedTime = reportedDate.toLocaleString();
          if (currentLocation.data.code == 1) {
            obj.currentLocation = currentLocation.data.data.name;
          } else {
            obj.currentLocation = "알 수 없음";
          }
          obj.locationToGo = elem.outside_name;
          obj.details = elem.description || "내용이 없습니다.";
          data.push(obj);
        });
      } else {
        console.log("There is not Moving report!");
      }
      commit("updateMovingReport", data);
      commit("setLoading", false);
      return data;
    } catch (error) {
      console.log(error);
    }
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
