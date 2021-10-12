import Vue from "vue";
import VueRouter from "vue-router";

import io  from 'socket.io-client'
import VueSocketIO from 'vue-socket.io-extended'
const socket = io('http://127.0.0.1:3010/manager', { transports : ['websocket'] });

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    redirect: "/authentication/login"
  },
  {
    path:"/test",
    component: () => import("@/views/Test"),
    beforeEnter(to, from, next) {      
      Vue.use(VueSocketIO, socket);
      next();
    }
  },
  {
    path: "/main",
    name: "메인 화면",
    component: () => import("@/layouts/adminPages/Index"),
    children: [
      {
        path: "/monitoring",
        name: "실시간 모니터링",
        component: () => import("@/views/pages/Monitoring"),
      },
      {
        path: "/approval-moving",
        name: "이동 신청",
        component: () => import("@/views/pages/MovingApproval"),
      },
      {
        path: "/approval-using",
        name: "시설 이용 신청",
        component: () => import("@/views/pages/UsingApproval"),
      },
      {
        path: "/health",
        name: "건강상태 조회",
        component: () => import("@/views/pages/HealthCare"),
      },
      {
        path: "/schedule",
        name: "공용시설 시간표",
        component: () => import("@/views/pages/FacilitySchedule"),
      },
      {
        path: "/manage-army",
        name: "부대 관리",
        component: () => import("@/views/pages/ManageArmy"),
      },
      {
        path: "/manage-admin",
        name: "날짜별 근무자 관리",
        component: () => import("@/views/pages/ManageAdmin"),
      },
      {
        path: "/user/:id",
        name: "용사 상세정보",
        component: () => import("@/views/UserProfile"),
      },
    ],
  },
  {
    path: "/authentication",
    component: () => import("@/layouts/authentication/Index"),
    children: [
      {
        path: "login",
        name: "Login",
        component: () => import("@/views/authentication/Login"),
      },
    ],
  },
];

const router = new VueRouter({
  routes,
});

export default router;
