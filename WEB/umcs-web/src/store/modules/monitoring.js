const state = {
  // display할 floor 구분
  floorList: [
    {
      doomId: "1",
      doomName: "통신대대",
      items: [
        {
          name: "1층",
          floor: 1,
        },
        {
          name: "2층",
          floor: 2,
        },
      ],
    },
  ],

  // Room Picker
  roomPicker: {
    x: 325,
    y: 50,
    size: "normal",
    name: "화장실",
    // 해당 방에 대한 인원 현황을 불러오기 위한 beacon_id
    beaconId: "aa:aa:aa:aa",
  },
  // Room Picker Create 할 때 시설 선택
  roomList: [
    {
      doomId: "1",
      doomName: "통신대대",
      items: [
        {
          name: "1층",
          items: [
            {
              beaconId: "aa:aa:aa:aa:aa:aa",
              name: "101호",
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
};
const getters = {};
const mutations = {};
const actions = {};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
