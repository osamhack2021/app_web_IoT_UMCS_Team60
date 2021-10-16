<template>
  <v-app>
    <default-bar />
    <default-drawer />
    <default-view />
  </v-app>
</template>

<script>
import { mapState, mapGetters, mapMutations, mapActions } from "vuex";
import DefaultBar from "./AppBar";
import DefaultDrawer from "./Drawer";
import DefaultView from "./View";

export default {
  name: "AdminpageIndex",
  components: {
    DefaultBar,
    DefaultDrawer,
    DefaultView,
  },
  created() {
    // 모든 page에서 공통적으로 사용할 data들을 initializing한다
    this.FETCH_CORONA_SITUATION();
    this.FETCH_ADMIN_LIST();
    this.FETCH_USER_LIST();
    this.FETCH_DOOM_LIST();
    this.FETCH_FACILITY_LIST();
  },
  methods: {
    ...mapActions([
      "FETCH_CORONA_SITUATION",
      "FETCH_ADMIN_LIST",
      "FETCH_USER_LIST",
      "FETCH_DOOM_LIST",
      "FETCH_FACILITY_LIST",
    ]),
  },
};
</script>
