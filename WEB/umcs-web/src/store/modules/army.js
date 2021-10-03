const state = {
  accountDatas: {
    headers: [
      { text: "군번", value: "number" },
      { text: "계급", value: "rank" },
      { text: "이름", value: "name" },
    ],
    datas: [
      {
        number: "11111",
        rank: "병장",
        name: "aaa",
      },
      {
        number: "22222",
        rank: "상병",
        name: "bbb",
      },
      {
        number: "44444",
        rank: "일병",
        name: "ddd",
      },
      {
        number: "55555",
        rank: "일병",
        name: "eee",
      },
    ],
  },
}
const getters = {
  getAccountDatas(state) {
    return state.accountDatas;
  },
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
