import { loadingCycle } from "@/utils/loading.js";
import {
  fetchRoomInfo,
  fetchRoomList_doomId,
  createSchedule,
  fetchTimeTable,
  deleteSchedule,
} from "@/api/index.js";

const state = {
  // 호실 목록 저장
  roomList: [],

  formSelectedDoomRoom: 0,

  selectedDoomId: 0,
  selectedFacilityId: 0,
  selectedFacilityName: "공용 시설",

  /* Data Table */
  // Loading
  loading: false,

  tableHeaders: [
    { text: "호실/생활관", value: "room" },
    { text: "시작 시각", value: "startTime" },
    { text: "종료 시각", value: "endTime" },
    { text: "삭제", value: "actions", sortable: false },
  ],
  tableDatas: [],
};

const getters = {
  getFormSelectedDoomRoom(state) {
    return state.formSelectedDoomRoom;
  },
  getLoading(state) {
    return state.loading;
  },
};

const mutations = {
  setRoomList(state, data) {
    state.roomList = data;
  },
  setFormSelectedDoomRoom(state, value) {
    state.formSelectedDoomRoom = value;
  },
  // Facility List
  setSelectedDoomId(state, value) {
    state.selectedDoomId = value;
  },
  setSelectedFacilityId(state, value) {
    state.selectedFacilityId = value;
  },
  setSelectedFacilityName(state, value) {
    state.selectedFacilityName = value;
  },

  setLoading(state, value) {
    state.loading = value;
  },

  // Time Table
  updateTimeTable(state, data) {
    state.tableDatas = data;
  },
  addNewSchedule(state, data) {
    state.tableDatas.push(data);
  },
  deleteTableSchedule(state, id) {
    for (let i = 0; i < state.tableDatas.length; i++) {
      if (state.tableDatas[i].id === id) {
        state.tableDatas.splice(i, 1);
        break;
      }
    }
  },
};

const actions = {
  async FETCH_ROOM_LIST({ commit, state }) {
    try {
      const response = await fetchRoomList_doomId(state.selectedDoomId);
      const resData = response.data.data;
      commit("setRoomList", resData);
      return resData;
    } catch (error) {
      console.log(error);
    }
  },
  async FETCH_TIME_TABLE({ commit }, idData) {
    let count = 0;
    commit("setLoading", true);
    try {
      const response = await fetchTimeTable(idData);
      count += parseInt(response.data.total);
      const resData = response.data.data;
      const data = [];
      if (resData) {
        resData.forEach(async (elem) => {
          const obj = {};
          const roomInfo = await fetchRoomInfo(elem.room_id);
          const startTime = new Date(elem.start_time);
          const endTime = new Date(elem.end_time);
          // UTC time으로 Date 객체를 생성하면 현지 시각으로 자동 변환됨
          // 한국시간, UTC time은 9시간 차이나므로 자동 변환을 막는 code
          startTime.setHours(startTime.getHours() - 9);
          endTime.setHours(endTime.getHours() - 9);
          const option = { hour: "2-digit", minute: "2-digit", hour12: false };

          obj.id = elem.id;
          obj.room = roomInfo.data.data.name;
          obj.startTime = startTime.toLocaleTimeString([], option);
          obj.endTime = endTime.toLocaleTimeString([], option);
          data.push(obj);
        });
      } else {
        count = 0;
        console.log("이용 시간표 정보가 없습니다!");
      }
      commit("updateTimeTable", data);
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
  async CREATE_SCHEDULE({ commit, state }, data) {
    try {
      const requestPayload = {
        room_id: state.formSelectedDoomRoom,
        facility_id: state.selectedFacilityId,
        start_time: data.startTime,
        end_time: data.endTime,
      };
      const response = await createSchedule(requestPayload);
      const resData = response.data.data;

      const obj = {};
      const roomInfo = await fetchRoomInfo(resData.room_id);
      const startTime = new Date(resData.start_time);
      const endTime = new Date(resData.end_time);
      const option = { hour: "2-digit", minute: "2-digit", hour12: false };

      obj.id = resData.room_id;
      obj.room = roomInfo.data.data.name;
      obj.startTime = startTime.toLocaleTimeString([], option);
      obj.endTime = endTime.toLocaleTimeString([], option);

      commit("addNewSchedule", obj);
      return resData;
    } catch (error) {
      console.log(error);
    }
  },
  async DELETE_SCHEDULE({ commit }, id) {
    try {
      commit("deleteTableSchedule", id);
      const response = await deleteSchedule(id);
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
