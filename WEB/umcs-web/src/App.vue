<template>
  <v-app>
    <v-app-bar
      app
      color="primary darken-2"
      dark
    >
      <div class="d-flex align-center">
        <router-link to="#">
          <p class="umcs-logo white--text font-weight-bold mb-0 ml-3">
            UMCS
          </p>
        </router-link>
      </div>

      <v-spacer />

      <v-btn
        href="https://github.com/osamhack2021/app_web_IoT_UMCS_Team60"
        target="_blank"
        text
      >
        <span class="mr-2">Team60 GitHub</span>
        <v-icon>mdi-open-in-new</v-icon>
      </v-btn>
    </v-app-bar>

    <v-main>
      <router-view />
    </v-main>
  </v-app>
</template>

<script>
export default {
  name: "App",

  data: () => ({
    //
  }),
};
</script>

<style scoped>
a {
  color: #FFF;
  text-decoration: none;
  outline: none;
}
.umcs-logo {
  font-size: 2.6rem;
}
</style>
