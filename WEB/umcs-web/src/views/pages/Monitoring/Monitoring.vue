<template>
  <v-container class="mt-5">
    <v-row>
      <v-col
        cols="12"
        xl="8"
        class="mx-auto"
      >
        <v-row>
          <v-col cols="6">
            <v-btn
              to="/monitoring/doom"
              tile
              block
            >
              영내
            </v-btn>
          </v-col>

          <v-col cols="6">
            <v-btn
              to="/monitoring/outside"
              tile
              block
            >
              영외
            </v-btn>
          </v-col>
        </v-row>

        <router-view />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: "MonitoringPage",
};
</script>
