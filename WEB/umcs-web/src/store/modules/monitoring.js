import { fetchCurrentLocation_BeaconId } from "@/api/index.js";

const state = {
  editMode: false,
  focusRoom: "",

  /* Data Table */
  tableHeaders: [
    { text: "관등성명", value: "name" },
    { text: "출입시각", value: "enterTime" },
  ],
  tableDatas: [],

  // Search
  searchInput: "",
};

const getters = {
  getEditText(state) {
    if (state.editMode) return "저장";
    else return "편집";
  },
  getSearchInput(state) {
    return state.searchInput;
  },
};

const mutations = {
  changeEditMode(state) {
    state.editMode = !state.editMode;
  },
  setFocusRoom(state, value) {
    state.focusRoom = value;
  },
  setPeopleList(state, data) {
    state.tableDatas = data;
  },
  updateSearchInput(state, value) {
    state.searchInput = value;
  },
};

const actions = {
  async FETCH_CURRENT_LOCATION_BEACON({ commit }, beaconId) {
    try {
      const response = await fetchCurrentLocation_BeaconId(beaconId);
      const resData = response.data.data;
      const data = [];
      if (resData) {
        resData.forEach((elem) => {
          const obj = {};
          const enterTime = new Date(elem.in_time);
          // UTC time으로 Date 객체를 생성하면 현지 시각으로 자동 변환됨
          // 한국시간, UTC time은 9시간 차이나므로 자동 변환을 막는 code
          enterTime.setHours(enterTime.getHours() - 9);

          obj.tag = elem.user_tag;
          obj.name = `${elem.user_rank} ${elem.user_name}`;
          obj.enterTime = enterTime.toLocaleString();
          data.push(obj);
        });
      } else {
        console.log("There isn't any person");
      }
      commit("setPeopleList", data);
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
