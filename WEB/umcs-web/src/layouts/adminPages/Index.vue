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
    DefaultView
  },
  created() {
    this.FETCH_USER_LIST();
    this.FETCH_FACILITY_LIST();
  },
  methods: {
    ...mapActions(["FETCH_USER_LIST", "FETCH_FACILITY_LIST"]),
  },
};
</script>
