const state = {
  selectedItems: [],
  movingDatas: {
    headers: [
      { text: "군번", value: "tag" },
      { text: "계급", value: "rank" },
      { text: "이름", value: "name" },
      { text: "보고 시간", value: "createdTime"},
      { text: "현재 위치", value: "currentLocation" },
      { text: "이동할 곳", value: "gotoLocation" },
      { text: "목적", value: "details", sortable: false },
      { text: "", value: "accept", sortable: false },
      { text: "", value: "reject", sortable: false },
    ],
    datas: [
      {
        tag: "11111",
        rank: "병장",
        name: "aaa",
        createdTime: "16:15",
        currentLocation: "5생활관",
        gotoLocation: "식당",
        details: "밥 먹으러 갑니다",
      },
      {
        tag: "22222",
        rank: "상병",
        name: "bbb",
        createdTime: "20:10",
        currentLocation: "2생활관",
        gotoLocation: "풋살장",
        details: "한국의 호날두",
      },
      {
        tag: "44444",
        rank: "일병",
        name: "ddd",
        createdTime: "03:00",
        currentLocation: "식당",
        gotoLocation: "교회",
        details: "종교 활동",
      },
      {
        tag: "55555",
        rank: "일병",
        name: "eee",
        createdTime: "5",
        currentLocation: "3생활관",
        gotoLocation: "위병소",
        details: "택배 가지러 갔다오겠습니다",
      },
    ],
  },
  usingDatas: {
    headers: [
      { text: "군번", value: "tag" },
      { text: "계급", value: "rank" },
      { text: "이름", value: "name" },
      { text: "보고 시간", value: "createdTime"},
      { text: "현재 위치", value: "currentLocation" },
      { text: "이용할 시설", value: "facility" },
      { text: "목적", value: "details", sortable: false },
      { text: "", value: "accept", sortable: false },
      { text: "", value: "reject", sortable: false },
    ],
    datas: [
      {
        tag: "11111",
        rank: "병장",
        name: "aaa",
        createdTime: "16:15",
        currentLocation: "1생활관",
        facility: "화장실",
        details: "양치",
      },
      {
        tag: "22222",
        rank: "상병",
        name: "bbb",
        createdTime: "2",
        currentLocation: "2생활관",
        facility: "화장실",
        details: "소변",
      },
      {
        tag: "44444",
        rank: "일병",
        name: "ddd",
        createdTime: "4",
        currentLocation: "3생활관",
        facility: "샤워실",
        details: "샤워하고 싶습니다",
      },
      {
        tag: "55555",
        rank: "일병",
        name: "eee",
        createdTime: "5",
        currentLocation: "4생활관",
        facility: "화장실",
        details: "세수",
      },
    ],
  },
}
const getters = {
  getMovingDatas(state) {
    return state.movingDatas;
  },
  getUsingDatas(state) {
    return state.usingDatas;
  },
}
const mutations = {
  updateSelectedItems(state, selected) {
    console.log("Implementing...");
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
