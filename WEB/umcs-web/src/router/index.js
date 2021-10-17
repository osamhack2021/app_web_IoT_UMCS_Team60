import Vue from "vue";
import VueRouter from "vue-router";
import io from "socket.io-client";
import VueSocketIO from "vue-socket.io-extended";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    redirect: "/authentication/login",
  },
  {
    path: "/test",
    component: () => import("@/views/Test"),
  },
  {
    path: "/main",
    name: "메인 화면",
    redirect: "/monitoring",
    component: () => import("@/layouts/adminPages/Index"),
    beforeEnter(to, from, next) {
      console.log(
        "cookie",
        window.$cookies.get("express.sid").replace("s:", "").split(".")[0]
      );
      // 실 배포시에는 option 제거할 것
      const socket = io.connect("https://militaryumcs.com/manager", {
        query:
          "session_id=" +
          window.$cookies
            .get("express.sid")
            .replace("s:", "")
            .split(".")[0],
      });
      Vue.use(VueSocketIO, socket);
      next();
    },
    children: [
      {
        path: "/monitoring",
        name: "실시간 모니터링",
        component: () => import("@/views/pages/Monitoring"),
      },
      {
        path: "/approval-moving",
        name: "외부시설 이동신청",
        component: () => import("@/views/pages/MovingApproval"),
      },
      {
        path: "/approval-using",
        name: "공용시설 이용신청",
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
