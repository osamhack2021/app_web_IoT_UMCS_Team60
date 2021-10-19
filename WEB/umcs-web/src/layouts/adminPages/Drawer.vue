<template>
  <v-navigation-drawer
    v-model="drawer"
    app
    dark
  >
    <default-drawer-header />

    <v-divider />

    <v-list
      dense
      nav
    >
      <template v-for="item in items">
        <v-list-item
          v-if="isShowing(item.corona)"
          :key="item.title"
          link
          :to="item.to"
          active-class="primary"
          class="py-1"
        >
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title class="text-body-1 font-weight-regular">
              {{ item.title }}
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </template>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
import { mapState } from "vuex";
import DefaultDrawerHeader from "./DrawerHeader";

export default {
  name: "DefaultDrawer",
  components: {
    DefaultDrawerHeader,
  },
  computed: {
    ...mapState(["coronaSituation"]),
    ...mapState("drawer", ["items"]),
    drawer: {
      get() {
        return this.$store.getters["drawer/getDrawer"];
      },
      set(value) {
        return this.$store.dispatch("drawer/toggleDrawer", value);
      },
    },
  },
  methods: {
    isShowing(corona) {
      if (!corona) {
        return true;
      } else if (this.coronaSituation && corona) {
        return true;
      } else {
        return false;
      }
    }
  }
};
</script>

<style scoped>
</style>
