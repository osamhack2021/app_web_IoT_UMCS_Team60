const state = {
  // Search
  searchInput: "",

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
};
const mutations = {
  updateSearchInput(state, value) {
    state.searchInput = value;
  },
};
const actions = {};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
