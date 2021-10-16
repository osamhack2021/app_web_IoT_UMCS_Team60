import { loadingCycle } from "@/utils/loading.js";
import { fetchRoomInfo, createTimeTable, fetchTimeTable } from "@/api/index.js";

const state = {
  /* Data Table */
  // Loading
  loading: false,

  selectedFacility: "공용 시설",

  tableHeaders: [
    { text: "호실/생활관", value: "room" },
    { text: "시작 시각", value: "startTime" },
    { text: "종료 시각", value: "endTime" },
    { text: "수정 / 삭제", value: "actions", sortable: false },
  ],
  tableDatas: [],
};

const getters = {
  getLoading(state) {
    return state.loading;
  },
};

const mutations = {
  // Facility List
  setSelectedFacility(state, value) {
    state.selectedFacility = value;
  },

  setLoading(state, value) {
    state.loading = value;
  },

  // Time Table
  updateTimeTable(state, data) {
    state.tableDatas = data;
  },
};

const actions = {
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
          const option = { hour: "2-digit", minute: "2-digit", hour12: false };

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
      console.log("count", count);
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
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
