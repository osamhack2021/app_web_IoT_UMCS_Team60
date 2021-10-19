<template>
  <v-app-bar
    app
    color="primary darken-1"
    dark
  >
    <v-app-bar-nav-icon @click="drawer = !drawer" />
    <div class="d-flex align-center">
      <p class="text-h5 white--text font-weight-medium mb-0 ml-3">
        {{ $route.name }}
      </p>
    </div>

    <v-spacer />

    <v-badge
      :content="getCountMovingReport"
      :value="getCountMovingReport"
      color="error"
      overlap
    >
      <v-btn
        color="secondary"
        to="/approval-moving"
      >
        이동 신청
      </v-btn>
    </v-badge>

    <v-badge
      v-if="coronaSituation"
      :content="getCountUsingReport"
      :value="getCountUsingReport"
      color="error"
      overlap
      class="mx-6"
    >
      <v-btn
        color="secondary"
        to="/approval-using"
      >
        이용 신청
      </v-btn>
    </v-badge>

    <v-btn
      color="secondary"
      @click="logout"
    >
      <span class="mr-2">LogOut</span>
      <v-icon>mdi-open-in-new</v-icon>
    </v-btn>
  </v-app-bar>
</template>

<script>
import { mapState, mapGetters } from "vuex";
import { logoutAdmin } from "@/api/index.js";

export default {
  name: "DefaultBar",
  data() {
    return {
      toggleSwitch: false,
    };
  },
  computed: {
    ...mapState(["coronaSituation"]),
    ...mapGetters("moving_approval", ["getCountMovingReport"]),
    ...mapGetters("using_approval", ["getCountUsingReport"]),
    drawer: {
      get() {
        return this.$store.getters["drawer/getDrawer"];
      },
      set(value) {
        return this.$store.dispatch("drawer/toggleDrawer", value);
      },
    },
  },
  mounted() {
    console.log("getCountMovingReport: ", this.getCountMovingReport);
  },
  methods: {
    async logout() {
      try {
        await logoutAdmin();
        this.$router.push("/authentication/login");
      } catch (error) {
        console.log(error);
      }
    },
  },
};
</script>

<style scoped>
</style>
