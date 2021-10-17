<template>
  <v-app-bar
    app
    color="primary darken-1"
    dark
  >
    <div class="d-flex align-center">
      <p class="text-h4-en white--text font-weight-medium mb-0 ml-3">
        UMCS - {{ $route.name }}
      </p>
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
</template>

<script>
export default {
  name: "AuthenticationBar",
};
</script>

<style scoped>
</style>
