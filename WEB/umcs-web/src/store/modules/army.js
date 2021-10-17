const state = {
  // Search
  searchInput: "",

  // Selects
  selectedDoomId: 0,

  tableHeaders: [
    { text: "군번", value: "tag" },
    { text: "계급", value: "rank" },
    { text: "이름", value: "name" },
  ],
  // tableDatas: [],
};
const getters = {
  getSearchInput(state) {
    return state.searchInput;
  },
  getFormDoom(state) {
    return state.selectedDoomId;
  },
};
const mutations = {
  updateSearchInput(state, value) {
    state.searchInput = value;
  },
  setFormDoom(state, value) {
    state.selectedDoomId = value;
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
