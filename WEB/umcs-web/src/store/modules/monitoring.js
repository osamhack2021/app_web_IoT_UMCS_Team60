const state = {
  editMode: false,
  focusRoom: "",

  // Data Table
  tableHeaders: [
    { text: "군번", value: "tag" },
    { text: "관등성명", value: "name" },
  ],
  peopleList: [
    {
      tag: "20-70000001",
      name: "상병 엄복걸",
    },
    {
      tag: "20-70000002",
      name: "병장 손박타",
    },
    {
      tag: "20-70000003",
      name: "상병 유분조",
    },
    {
      tag: "20-70000004",
      name: "일병 진환이",
    },
  ],

  // 관리할 장소(room) data
  roomList: [
    {
      doomId: "1",
      doomName: "1생활관",
      items: [
        {
          name: "1층",
          floor: 1,
          items: [
            {
              id: 1,
              beaconId: "aa:aa:aa:aa:aa:aa",
              doom_id: 1,
              floor: 1,
              name: "101호",
              current_count: 2,
            },
            {
              beaconId: "bb:bb:bb:bb:bb:bb",
              name: "102호",
            },
            {
              beaconId: "cc:cc:cc:cc:cc:cc",
              name: "화장실",
            },
            {
              beaconId: "dd:dd:dd:dd:dd:dd",
              name: "샤워실",
            },
          ],
        },
        {
          name: "2층",
          floor: 2,
          items: [
            {
              beaconId: "ee:ee:ee:ee:ee:ee",
              name: "201호",
            },
            {
              beaconId: "ff:ff:ff:ff:ff:ff",
              name: "202호",
            },
            {
              beaconId: "gg:gg:gg:gg:gg:gg",
              name: "화장실",
            },
          ],
        },
      ],
    },
  ],

  // Room Picker
  roomPickers: [
    {
      floor: 1,
      items: [
        {
          x: 320,
          y: 60,
          size: "normal",
          name: "화장실",
          current_count: 1,
          // 해당 방에 대한 인원 현황을 불러오기 위한 beacon_id
          beaconId: "34:14:B5:41:A2:7E",
        },
        {
          x: 100,
          y: 82,
          size: "normal",
          name: "102호",
          current_count: 4,
          // 해당 방에 대한 인원 현황을 불러오기 위한 beacon_id
          beaconId: "aa:aa:aa:aa:aa:aa",
        },
      ],
    },
    {
      floor: 2,
      items: [
        {
          x: 297,
          y: 60,
          size: "normal",
          name: "화장실",
          current_count: 2,
          // 해당 방에 대한 인원 현황을 불러오기 위한 beacon_id
          beaconId: "bb:bb:bb:bb:bb:bb",
        },
        {
          x: 666,
          y: 8,
          size: "normal",
          name: "PX",
          current_count: 5,
          // 해당 방에 대한 인원 현황을 불러오기 위한 beacon_id
          beaconId: "aa:aa:aa:aa:aa:aa",
        },
      ],
    },
  ],
};
const getters = {
  getEditText(state) {
    if (state.editMode) return "저장";
    else return "편집";
  },
};
const mutations = {
  changeEditMode(state) {
    state.editMode = !state.editMode;
  },
  setFocusRoom(state, value) {
    state.focusRoom = value;
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
