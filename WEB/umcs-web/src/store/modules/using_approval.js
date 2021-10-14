import {
  fetchUserInfo,
  fetchUsingReport,
  fetchCurrentLocation_Tag,
} from "@/api/index.js";

const state = {
  // Search
  searchInput: "",

  // Selected
  selectedItems: [],

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
  tableDatas: [
    {
      tag: "11111",
      name: "병장 aaa",
      reportedTime: "16:15",
      currentLocation: "5생활관",
      locationToUse: "화장실",
      details: "양치할게요",
    },
    {
      tag: "22222",
      name: "상병 bbb",
      reportedTime: "20:10",
      currentLocation: "2생활관",
      locationToUse: "화장살",
      details: "급합니다",
    },
    {
      tag: "44444",
      name: "일병 ddd",
      reportedTime: "03:00",
      currentLocation: "식당",
      locationToUse: "샤워실",
      details: "점호 끝나고 씻어도 될까요?",
    },
    {
      tag: "55555",
      name: "일병 eee",
      reportedTime: "5",
      currentLocation: "3생활관",
      locationToUse: "세탁실",
      details: "빨래 잠깐 하겠습니다.",
    },
  ],
};

const getters = {
  getSearchInput(state) {
    return state.searchInput;
  },
  getSelectedItems(state) {
    return state.selectedItems;
  },
};

const mutations = {
  updateSearchInput(state, value) {
    state.searchInput = value;
  },
  updateSelectedItems(state, value) {
    state.selectedItems = value;
  },
  updateMovingReport(state, data) {
    console.log("moving report", data);
  },
};

const actions = {
  async FETCH_USING_REPORT({ commit }) {
    try {
      const response = await fetchUsingReport();
      const resData = response.data.data;
      const data = [];
      if (resData) {
        resData.forEach(async (elem) => {
          const obj = {};
          const userInfo = await fetchUserInfo(elem.user_tag);
          const currentLocation = await fetchCurrentLocation_Tag(elem.user_tag);

          obj.tag = elem.user_tag;
          obj.name = `${userInfo.rank} ${userInfo.name}`;
          obj.reportedTime = elem.request_time;
          // obj.currentLocation = currentLocation.
          obj.locationToUse = elem.
          // obj.details = ;
            data.push(obj);
        });
      } else {
        console.log("There is not Using report!");
      }
      commit("updateMovingReport", response);
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
