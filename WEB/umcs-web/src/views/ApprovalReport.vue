<template>
  <v-container>
    <router-link to="/approval/moving">
      moving
    </router-link> |
    <router-link to="/approval/using">
      using
    </router-link>
    <router-view />
  </v-container>
</template>

<script>
export default {
  name: "ApprovalReport",
};
</script>
