import {
  fetchUserInfo,
  fetchUsingReport,
  fetchUsingReport_Id,
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
    { text: "이용할 곳", value: "locationToUse" },
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
  updateUsingReport(state, data) {
    state.tableDatas = data;
  },
  pushUsingReport(state, obj) {
    state.tableDatas.push(obj);
  },
  deleteUsingReport(state, id) {
    for (let i = 0; i < state.tableDatas.length; i++) {
      if (state.tableDatas[i].id == id) {
        state.tableDatas.splice(i, 1);
        break;
      }
    }
  },
};

const actions = {
  async FETCH_USING_REPORT({ commit }) {
    commit("setLoading", true);
    try {
      const response = await fetchUsingReport();
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
          if (currentLocation.data.code == 1) {
            obj.currentLocation = currentLocation.data.data.name;
          } else {
            obj.currentLocation = "알 수 없음";
          }
          obj.locationToUse = elem.facility_name;
          obj.details = elem.description || "내용이 없습니다.";
          data.push(obj);
        });
      } else {
        console.log("There is not Using report!");
      }
      commit("updateUsingReport", data);
      commit("setLoading", false);
      return data;
    } catch (error) {
      console.log(error);
    }
  },
  async ADD_USING_REPORT({ commit }, data) {
    try {
      const obj = {};
      const currentLocation = await fetchCurrentLocation_Tag(data.user_tag);
      const userInfo = await fetchUserInfo(data.user_tag);
      const locationToUse = await fetchUsingReport_Id(data.id);
      const reportedDate = new Date(data.request_time);

      obj.id = data.id;
      obj.tag = data.user_tag;
      obj.name = `${userInfo.data.data.rank} ${userInfo.data.data.name}`;
      obj.reportedTime = reportedDate.toLocaleString();
      if (currentLocation.data.code == 1) {
        obj.currentLocation = currentLocation.data.data.name;
      } else {
        obj.currentLocation = "알 수 없음";
      }
      obj.locationToUse = locationToUse.data.data.facility_name;
      obj.details = data.description || "내용이 없습니다.";

      commit("pushUsingReport", obj);
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
