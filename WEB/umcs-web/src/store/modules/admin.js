const state = {
  dialog: false,
  events: [
    {
      name: "김중위",
      start: new Date('2021-09-27T00:00:00'),
      end: new Date('2021-09-27T08:30:00'),
      color: "orange",
      details: "말년 중위 김중위",
      timed: true,
    },
    {
      name: "김하사",
      start: '2021-09-15T15:00:00',
      end: new Date('2021-09-15T22:00:00'),
      color: "orange",
      details: "",
      timed: true,
    },
    {
      name: "송중사",
      start: '2021-09-28T13:30:00',
      end: '2021-09-28T18:45:00',
      color: "orange",
      details: "",
      timed: true,
    }
  ],
  selectedEvent: {},
  selectedElement: null,
  selectedOpen: false,
  colors: [
    "orange",
  ],
}
const getters = {
  getDialog(state) {
    return state.dialog;
  },
  getEvents(state) {
    return state.events;
  },
  getEventColor(state, event) {
    return event.color;
  }
}
const mutations = {
  setDialog(state, value) {
    state.dialog = value;
  },
  showEvent(state, { nativeEvent, event }) {
    const open = () => {
      state.selectedEvent = event;
      state.selectedElement = nativeEvent.target;
      requestAnimationFrame(() => requestAnimationFrame(() => state.selectedOpen = true));
    }
    if (state.selectedOpen) {
      state.selectedOpen = false;
      requestAnimationFrame(() => requestAnimationFrame(() => open()));
    } else {
      open();
    }

    nativeEvent.stopPropagation();
  }
}
const actions = {

}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
}
