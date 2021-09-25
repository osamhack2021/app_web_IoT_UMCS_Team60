<template>
  <v-app-bar
    app
    color="primary darken-2"
    dark
  >
    <v-app-bar-nav-icon @click="drawer = !drawer" />
    <div class="d-flex align-center">
      <p class="text-h5 white--text font-weight-medium mb-0 ml-3">
        {{ $route.name }}
      </p>
    </div>

    <v-spacer />

    <!-- <v-btn class="d-flex align-center justify-center mr-5">
      <p class="text-h6 white--text font-weight-medium mr-3 my-0">
        격리
      </p>
      <v-switch
        v-model="toggleSwitch"
        inset
        color="info"
        class="my-0"
      />
    </v-btn> -->
    <v-btn>
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
        return this.$store.getters['app/getDrawer'];
      },
      set(value) {
        return this.$store.dispatch('app/toggleDrawer', value);
      }
    }
  }
};
</script>

<style scoped>
</style>
