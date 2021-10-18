import { loadingCycle } from "@/utils/loading.js";
import {
  createRoomPicker,
  editRoomPicker,
  deleteRoomPicker,
  fetchCurrentLocation_BeaconId,
} from "@/api/index.js";

const state = {
  editMode: false,
  editedX: 0,
  editedY: 0,

  // focused Picker
  focusPickerId: 0,

  /* Data Table */
  tableHeaders: [
    { text: "관등성명", value: "name" },
    { text: "출입시각", value: "enterTime" },
  ],
  tableDatas: [],

  // focused Room
  focusRoom: "",
  // Search
  searchInput: "",
  // Loading
  loading: false,
};

const getters = {
  getEditText(state) {
    if (state.editMode) return "저장";
    else return "편집";
  },
  getEditedX(state) {
    return state.editedX;
  },
  getEditedY(state) {
    return state.editedY;
  },
  getSearchInput(state) {
    return state.searchInput;
  },
  getLoading(state) {
    return state.loading;
  },
};

const mutations = {
  changeEditMode(state) {
    state.editMode = !state.editMode;
  },
  setEditedX(state, value) {
    state.editedX = value;
  },
  setEditedY(state, value) {
    state.editedY = value;
  },
  setFocusPickerId(state, value) {
    state.focusPickerId = value;
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
  setLoading(state, value) {
    state.loading = value;
  },
};

const actions = {
  async FETCH_CURRENT_LOCATION_BEACON({ commit, state }, beaconId) {
    let count = 0;
    commit("setLoading", true);
    try {
      const response = await fetchCurrentLocation_BeaconId(beaconId);
      count += parseInt(response.data.total);
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
        count = 0;
        console.log("There isn't any person");
      }
      commit("setPeopleList", data);
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
  async CREATE_ROOM_PICKER({ commit }, payload) {
    try {
      const response = await createRoomPicker(payload);
      window.location.reload();
      return response;
    } catch (error) {
      console.log(error);
    }
  },
  async EDIT_ROOM_PICKER({ state }) {
    try {
      const payload = {
        id: state.focusPickerId,
        x: state.editedX,
        y: state.editedY,
      };
      const response = await editRoomPicker(payload);
      return response;
    } catch (error) {
      console.log(error);
    }
  },
  async DELETE_ROOM_PICKER({ state }) {
    try {
      console.log("api called!!");
      const response = await deleteRoomPicker(state.focusPickerId);
      window.location.reload();
      return response;
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
