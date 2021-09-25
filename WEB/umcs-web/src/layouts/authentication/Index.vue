<template>
  <v-app>
    <authentication-bar />
    <authentication-view />
  </v-app>
</template>

<script>
import AuthenticationView from './View'
import AuthenticationBar from './AppBar'

export default {
  name: 'AuthenticationLayout',
  components: {
    AuthenticationView,
    AuthenticationBar,
  }
}
</script>

<style scoped></style>
