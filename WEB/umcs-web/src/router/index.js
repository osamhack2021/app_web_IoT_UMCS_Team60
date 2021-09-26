import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    redirect: "/login"
  },
  {
    path: "/main",
    name: "메인 화면",
    component: () => import("@/layouts/adminPages/Index"),
    children: [
      {
        path: "/monitoring",
        name: "실시간 모니터링",
        component: () => import("@/views/Monitoring"),
      },
      {
        path: "/approval",
        name: "이동 결재",
        component: () => import("@/views/MoveApproval"),
      },
      {
        path: "/health",
        name: "건강상태 조회",
        component: () => import("@/views/HealthCare"),
      },
      {
        path: "/schedule",
        name: "공용시설 시간표",
        component: () => import("@/views/FacilitySchedule"),
      },
      {
        path: "/manage",
        name: "부대 관리",
        component: () => import("@/views/AccountManage"),
      },
      {
        path: "/worker",
        name: "당직근무자 관리",
        component: () => import("@/views/Worker"),
      },
    ],
  },
  {
    path: "/authentication",
    component: () => import("@/layouts/authentication/Index"),
    children: [
      {
        path: "/login",
        name: "Login",
        component: () => import("@/views/authentication/Login"),
      },
    ],
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
