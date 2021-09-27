const state = {
  focus: "공용 시설",
  facilityList: [
    {
      title: "1층",
      items: [
        { title: "1층 화장실" },
        { title: "1층 샤워실" },
        { title: "체단실" },
      ],
    },
    {
      title: "2층",
      items: [
        { title: "2층 화장실" },
        { title: "2층 샤워실" },
        { title: "노래방" },
      ],
    },
  ],
  facilityTimeTable: {
    headers: [
      { text: "호실/생활관", value: "room" },
      { text: "시작 시각", value: "start" },
      { text: "종료 시각", value: "end" },
    ],
    datas: [
      {
        room: "1호실",
        start: "09:20",
        end: "09:40",
      },
      {
        room: "2호실",
        start: "10:00",
        end: "10:20",
      },
      {
        room: "3호실",
        start: "10:40",
        end: "11:00",
      },
    ],
  },
};
const getters = {
  getFacilityList(state) {
    return state.facilityList;
  },
  getFacilityTimeTable(state) {
    return state.facilityTimeTable;
  },
  getFocusingItem(state) {
    return state.focus;
  }
};
const mutations = {
  updateFocusingItem(state, value) {
    state.focus = value;
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
