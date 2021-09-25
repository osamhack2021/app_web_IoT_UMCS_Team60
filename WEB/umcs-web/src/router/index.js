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
    name: "Main",
    component: () => import("@/layouts/adminPages/Index"),
    children: [
      {
        path: "/monitoring",
        name: "Monitoring",
        component: () => import("@/views/Monitoring"),
      },
      {
        path: "/approval",
        name: "Move Approval",
        component: () => import("@/views/MoveApproval"),
      },
      {
        path: "/health",
        name: "Health Care",
        component: () => import("@/views/HealthCare"),
      },
      {
        path: "/schedule",
        name: "Facility Schedule",
        component: () => import("@/views/FacilitySchedule"),
      },
      {
        path: "/manage",
        name: "Account Manage",
        component: () => import("@/views/AccountManage"),
      },
      {
        path: "/worker",
        name: "Worker",
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
