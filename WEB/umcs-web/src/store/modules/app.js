const state = {
  drawer: false,
  items: [
    { title: '실시간 모니터링', icon: 'mdi-monitor-eye', to: '/monitoring' },
    { title: '이동 결재', icon: 'mdi-clipboard-check-outline', to: '/approval' },
    { title: '체온 및 건강상태', icon: 'mdi-hospital-box-outline', to: '/health' },
    { title: '공용시설 시간표', icon: 'mdi-clock-outline', to: '/schedule'},
    { title: '계정 관리', icon: 'mdi-account-multiple-plus-outline', to: '/manage' },
    { title: '당직근무자', icon: 'mdi-calendar-month-outline', to: '/worker'},
  ],
}
const getters = {
  getDrawer(state) {
    return state.drawer;
  }
}
const mutations = {
  setDrawer(state, value) {
    state.drawer = value;
  }
}
const actions = {
  toggleDrawer ({ commit }, value) {
    commit("setDrawer", value);
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
}
