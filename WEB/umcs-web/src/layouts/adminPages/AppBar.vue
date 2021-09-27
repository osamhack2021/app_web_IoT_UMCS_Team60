<template>
  <v-app-bar
    app
    color="primary darken-1"
    dark
  >
    <v-app-bar-nav-icon @click="drawer = !drawer" />
    <div class="d-flex align-center">
      <p class="text-h5-kr white--text font-weight-medium mb-0 ml-3">
        {{ $route.name }}
      </p>
    </div>

    <v-spacer />

    <v-btn
      class="mr-5"
      icon
    >
      <v-badge
        color="secondary"
        overlap
        content="5"
      >
        <v-icon>mdi-bell</v-icon>
      </v-badge>
    </v-btn>

    <v-btn color="secondary">
      <span class="mr-2">LogOut</span>
      <v-icon>mdi-open-in-new</v-icon>
    </v-btn>
  </v-app-bar>
</template>

<script>
export default {
  name: "DefaultBar",
  data() {
    return {
      toggleSwitch: false,
    }
  },
  computed: {
    drawer: {
      get() {
        return this.$store.getters['drawer/getDrawer'];
      },
      set(value) {
        return this.$store.dispatch('drawer/toggleDrawer', value);
      }
    }
  }
};
</script>

<style scoped>
</style>
