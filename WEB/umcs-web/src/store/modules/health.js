const state = {
  // Date Picker
  picker: "",

  // Search
  searchInput: "",

  // Data Table
  tableHeaders: [
    { text: "군번", value: "tag" },
    { text: "계급", value: "rank" },
    { text: "이름", value: "name" },
    { text: "체온", value: "temperature" },
    { text: "보고 시간", value: "createdTime" },
    { text: "특이사항", value: "details", sortable: false },
  ],
  tableDatas: [
    {
      tag: "12-3456",
      rank: "병장",
      name: "김기석",
      temperature: "36.0",
      details: "10.05 속쓰림으로 야간진료 받음",
      createdTime: "16:15",
    },
    {
      tag: "22222",
      rank: "상병",
      name: "bbb",
      temperature: "36.1",
      details: "2",
      createdTime: "2",
    },
    {
      tag: "33333",
      rank: "상병",
      name: "ccc",
      temperature: "36.2",
      details: "3",
      createdTime: "3",
    },
    {
      tag: "44444",
      rank: "일병",
      name: "ddd",
      temperature: "36.3",
      details: "4",
      createdTime: "4",
    },
    {
      tag: "55555",
      rank: "일병",
      name: "eee",
      temperature: "36.4",
      details: "5",
      createdTime: "5",
    },
    {
      tag: "66666",
      rank: "이병",
      name: "fff",
      temperature: "36.5",
      details: "6",
      createdTime: "5",
    },
  ],
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
  initTableDatas(state, datas) {
    // actions에서 api로 호출한 값을 가져옴
    state.tableDatas = datas;
  }
};
const actions = {};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
