const state = {
  drawer: false,
  items: [
    { title: '실시간 모니터링', icon: 'mdi-monitor-eye', to: '/monitoring' },
    { title: '외부시설 이동신청', icon: 'mdi-clipboard-check-outline', to: '/approval-moving' },
    { title: '공용시설 이용신청', icon: 'mdi-clipboard-check-outline', to: '/approval-using'},
    { title: '건강상태 조회', icon: 'mdi-hospital-box-outline', to: '/health' },
    { title: '공용시설 시간표', icon: 'mdi-clock-outline', to: '/schedule'},
    { title: '부대 관리', icon: 'mdi-account-group-outline', to: '/manage-army' },
    { title: '날짜별 근무자 관리', icon: 'mdi-calendar-month-outline', to: '/manage-admin' },
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
