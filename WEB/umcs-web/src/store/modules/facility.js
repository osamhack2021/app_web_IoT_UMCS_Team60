const state = {
  // Facility List
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

  // Data Table
  facilityTimeTable: {
    headers: [
      { text: "호실/생활관", value: "room" },
      { text: "시작 시각", value: "start" },
      { text: "종료 시각", value: "end" },
      { text: "수정/삭제", value: "actions", sortable: false },
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
  editedIndex: -1,
  editedItem: {
    room: "",
    start: "",
    end: "",
  },
  defaultItem: {
    room: "",
    start: "",
    end: "",
  },
};

const getters = {
  // Facility List
  getFacilityList(state) {
    return state.facilityList;
  },
  getFocusingItem(state) {
    return state.focus;
  },

  // Time Table
  getTimeTable(state) {
    return state.facilityTimeTable;
  },
  // CRUD
};

const mutations = {
  // Facility List
  updateFocusingItem(state, value) {
    state.focus = value;
  },

  // Time Table
  // CRUD
  setDefault(state) {
    // state.editedItem = Object.assign({}, state.defaultItem);
    state.editedItem = state.defaultItem;
    state.editedIndex = -1;
  },
  setEditedIndex(state, item) {
    state.editedIndex = state.facilityTimeTable.datas.indexOf(item);
  },
  setEditedItem(state, item) {
    // state.editedItem = Object.assign({}, item);
    state.editedItem = item;
  },
  pushNewItem(state) {
    state.facilityTimeTable.datas.push(state.editedItem);
  },
  editOneItem(state) {
    // Object.assign(state.facilityTimeTable.datas[state.editedIndex], state.editedItem);
    state.facilityTimeTable.datas[state.editedIndex] = state.editedItem;
  },
  deleteOneItem(state) {
    state.facilityTimeTable.datas.splice(state.editedIndex, 1);
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
