import {
  fetchAdminInfo,
  fetchAdminDuty_month,
  addDuty,
  deleteDuty,
} from "@/api/index.js";

const state = {
  selectedDate: "",
  events: [],
  //
  selectedEvent: {},
  selectedElement: undefined,
  selectedOpen: false,

  // Form data for Create Admin on duty
  formData: {
    admin: "",
    date: new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
      .toISOString()
      .substr(0, 10),
    doom: 0,
  },
  displayMenu: false,
};
const getters = {
  getSelectedDate(state) {
    return state.selectedDate;
  },
  getSelectedOpen(state) {
    return state.selectedOpen;
  },
  getFormAdmin(state) {
    return state.formData.admin;
  },
  getFormDate(state) {
    return state.formData.date;
  },
  getDisplayMenu(state) {
    return state.displayMenu;
  },
  getFormDoom(state) {
    return state.formData.doom;
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
  setFormAdmin(state, value) {
    state.formData.admin = value;
  },
  setFormDate(state, value) {
    state.formData.date = value;
  },
  setDisplayMenu(state, value) {
    state.displayMenu = value;
  },
  setFormDoom(state, value) {
    state.formData.doom = value;
  },
  pushEvent(state, obj) {
    state.events.push(obj);
  },
  deleteEvent(state, id) {
    for (let i = 0; i < state.events.length; i++) {
      if (state.events[i].id === id) {
        state.events.splice(i, 1);
        break;
      }
    }
  },
};
const actions = {
  async FETCH_ADMIN_INFO({ commit, state }) {
    try {
      const response = await fetchAdminDuty_month(state.selectedDate);
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
  },
  async ADD_EVENT({ commit, state }) {
    try {
      const response = await addDuty(state.formData);
      const obj = {};
      const adminInfo = await fetchAdminInfo(state.formData.admin);

      obj.id = -1;  // id는 서버에서 받아와야 하므로 명시적으로(-1) 임시 초기화해줌
      obj.tag = state.formData.admin;
      obj.name = `${adminInfo.data.data.rank} ${adminInfo.data.data.name}`;
      obj.color = "cyan",
      obj.start = new Date(state.formData.date);
      commit("pushEvent", obj);
      return response;
    } catch (error) {
      console.log(error);
    } finally {
      // form 초기화
      state.formData.admin = "";
      state.formData.date = new Date(
        Date.now() - new Date().getTimezoneOffset() * 60000
      )
        .toISOString()
        .substr(0, 10);
      state.formData.doom = 0;
    }
  },
  async DELETE_EVENT({ commit }, id) {
    try {
      const response = await deleteDuty(id);
      commit("deleteEvent", id);
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
