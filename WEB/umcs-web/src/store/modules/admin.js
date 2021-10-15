import { fetchAdminInfo, fetchAdminInfo_month } from "@/api/index.js";

const state = {
  selectedDate: "",
  events: [],
  //
  selectedEvent: {},
  selectedElement: undefined,
  selectedOpen: false,
};
const getters = {
  getSelectedDate(state) {
    return state.selectedDate;
  },
  getSelectedOpen(state) {
    return state.selectedOpen;
  },
};
const mutations = {
  setSelectedDate(state, value) {
    state.selectedDate = value;
  },
  setSelectedOpen(state, value) {
    state.selectedOpen = value;
  },
  updateEvents(state, data) {
    state.events = data;
  },
  showEvent(state, { nativeEvent, event }) {
    const open = () => {
      state.selectedEvent = event;
      state.selectedElement = nativeEvent.target;
      requestAnimationFrame(() =>
        requestAnimationFrame(() => (state.selectedOpen = true))
      );
    };
    if (this.selectedOpen) {
      this.selectedOpen = false;
      requestAnimationFrame(() => requestAnimationFrame(() => open()));
    } else {
      open();
    }
    nativeEvent.stopPropagation();
  },
};
const actions = {
  async FETCH_ADMIN_INFO({ commit, state }) {
    try {
      const response = await fetchAdminInfo_month(state.selectedDate);
      const resData = response.data.data;
      const data = [];
      if (resData) {
        resData.forEach(async (elem) => {
          const obj = {};
          const adminInfo = await fetchAdminInfo(elem.manager_tags);

          obj.id = elem.id;
          obj.tag = elem.manager_tags;
          obj.name = `${adminInfo.data.data.rank} ${adminInfo.data.data.name}`;
          obj.color = "cyan";
          obj.start = new Date(elem.responsible_date);
          data.push(obj);
        });
      } else {
        console.log("이번 달 관리자 정보가 없습니다!");
      }
      commit("updateEvents", data);
      return data;
    } catch (error) {
      console.log(error);
    }
  }
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
