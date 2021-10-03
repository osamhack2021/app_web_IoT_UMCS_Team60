const state = {
  healthDatas: {
    headers: [
      { text: "군번", value: "number" },
      { text: "계급", value: "rank" },
      { text: "이름", value: "name" },
      { text: "체온", value: "temperature" },
      { text: "보고 시간", value: "createdTime"},
      { text: "특이사항", value: "details", sortable: false },
    ],
    datas: [
      {
        number: "11111",
        rank: "병장",
        name: "aaa",
        temperature: "36.0℃",
        details: "1",
        createdTime: "16:15",
      },
      {
        number: "22222",
        rank: "상병",
        name: "bbb",
        temperature: "36.1℃",
        details: "2",
        createdTime: "2"
      },
      {
        number: "33333",
        rank: "상병",
        name: "ccc",
        temperature: "36.2℃",
        details: "3",
        createdTime: "3"
      },
      {
        number: "44444",
        rank: "일병",
        name: "ddd",
        temperature: "36.3℃",
        details: "4",
        createdTime: "4"
      },
      {
        number: "55555",
        rank: "일병",
        name: "eee",
        temperature: "36.4℃",
        details: "5",
        createdTime: "5"
      },
      {
        number: "66666",
        rank: "이병",
        name: "fff",
        temperature: "36.5℃",
        details: "6",
        createdTime: "5"
      },
    ],
  },
}
const getters = {
  getHealthDatas(state) {
    return state.healthDatas;
  }
}
const mutations = {
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
