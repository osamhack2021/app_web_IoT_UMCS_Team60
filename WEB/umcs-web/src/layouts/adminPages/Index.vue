<template>
  <v-app>
    <default-bar />
    <default-drawer />
    <default-view />
    <v-snackbars
      :objects.sync="objects"
      :time-out="4000"
      multi-line
      bottom
      right
    />
  </v-app>
</template>

<script>
import { mapState, mapActions } from "vuex";
import DefaultBar from "./AppBar";
import DefaultDrawer from "./Drawer";
import DefaultView from "./View";
import VSnackbars from "v-snackbars";

export default {
  name: "AdminpageIndex",
  components: {
    DefaultBar,
    DefaultDrawer,
    DefaultView,
    "v-snackbars": VSnackbars,
  },
  data: () => ({
    objects: [],
  }),
  computed: {
    ...mapState(["coronaSituation"]),
  },
  created() {
    // 모든 page에서 공통적으로 사용할 data들을 initializing한다
    this.FETCH_CORONA_SITUATION();
    this.FETCH_ADMIN_LIST();
    this.FETCH_USER_LIST();
    this.FETCH_DOOM_LIST();
    this.FETCH_FACILITY_LIST();
    this.FETCH_OUTSIDE_FACILITY_LIST();
    this.FETCH_MOVING_REPORT();
    this.FETCH_USING_REPORT();

    try {
      this.$socket.$subscribe("move_request", (data) => {
        this.objects.push({
          message: "외부시설 이동신청이 도착했습니다",
          color: "primary",
        });
        this.ADD_MOVING_REPORT(data);
      });
      this.$socket.$subscribe("facility_request", (data) => {
        if (this.coronaSituation) {
          this.objects.push({
            message: "공공시설 이용신청이 도착했습니다",
            color: "primary",
          });
          this.ADD_USING_REPORT(data);
        }
      });
      this.$socket.$subscribe("doomroom_contact", (data) => {
        if (this.coronaSituation) {
          this.objects.push({
            message: `${data.doom_name} ${data.name}에서 타 호실원끼리 접촉이 발생했습니다`,
            color: "red darken-2",
          });
        }
      });
      this.$socket.$subscribe("doomfacility_contact", (data) => {
        if (this.coronaSituation) {
          this.objects.push({
            message: `${data.doom_name} ${data.name}에서 타 호실원끼리 접촉이 발생했습니다`,
            color: "red darken-2",
          });
        }
      });
    } catch (error) {
      window.location.reload();
    }
  },
  methods: {
    ...mapActions([
      "FETCH_CORONA_SITUATION",
      "FETCH_ADMIN_LIST",
      "FETCH_USER_LIST",
      "FETCH_DOOM_LIST",
      "FETCH_FACILITY_LIST",
      "FETCH_OUTSIDE_FACILITY_LIST",
    ]),
    ...mapActions("moving_approval", [
      "FETCH_MOVING_REPORT",
      "ADD_MOVING_REPORT",
    ]),
    ...mapActions("using_approval", ["FETCH_USING_REPORT", "ADD_USING_REPORT"]),
  },
};
</script>
