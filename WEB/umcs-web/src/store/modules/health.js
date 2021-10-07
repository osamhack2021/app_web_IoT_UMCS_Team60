import { fetchHealthReport } from "@/api/index.js";

const state = {
  // Date Picker
  picker: "",

  // Search
  searchInput: "",

  // Data Table
  tableHeaders: [
    { text: "군번", value: "tag", width: "25%" },
    { text: "관등성명", value: "name", width: "20%" },
    { text: "체온", value: "temperature", width: "15%" },
    { text: "보고 시간", value: "reported_time", width: "25%" },
    { text: "특이사항", value: "data-table-expand", width: "15%" },
  ],
  tableDatas: [],
};
const getters = {
  getPicker(state) {
    return state.picker;
  },
  getSearchInput(state) {
    return state.searchInput;
  },
};
const mutations = {
  setPickedDate(state, date) {
    state.picker = date;
  },
  updateSearchInput(state, value) {
    state.searchInput = value;
  },
  updateTableDatas(state, datas) {
    // actions에서 api로 호출한 값을 가져옴
    state.tableDatas = datas;
  },
};
const actions = {
  async FETCH_HEALTH_REPORT({ commit }, date) {
    try {
      const response = await fetchHealthReport(date);
      const data = response.data.data;
      const datas = [];
      if (data) {
        data.forEach((obj) => {
          const objElem = {};
          const reported_date = new Date(obj.reported_time);

          objElem.tag = obj.user_tag;
          objElem.temperature = `${obj.temperature}℃`;
          objElem.name = `${obj.rank} ${obj.name}`;
          objElem.reported_time = `${reported_date.toLocaleTimeString()}`;
          objElem.details = obj.details;
          datas.push(objElem);
        });
        commit("updateTableDatas", datas);
      } else {
        console.log("data is empty!");
      }
      // return Promise
      return datas;
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
