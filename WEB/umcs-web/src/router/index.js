import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    redirect: "/authentication/login"
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
        name: "시설 이동/이용 신청",
        component: () => import("@/views/ApprovalReport"),
        children: [
          {
            path: "/",
            redirect: "moving"
          },
          {
            path: "moving",
            name: "이동 신청",
            component: () => import("@/views/Approval/MovingApproval"),
          },
          {
            path: "using",
            name: "이용 신청",
            component: () => import("@/views/Approval/UsingApproval"),
          }
        ]
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
        path: "/manage-army",
        name: "부대 관리",
        component: () => import("@/views/ManageArmy"),
      },
      {
        path: "/manage-admin",
        name: "날짜별 관리자 조회",
        component: () => import("@/views/ManageAdmin"),
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
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
