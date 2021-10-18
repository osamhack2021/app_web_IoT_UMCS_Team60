<template>
  <v-container class="mt-5">
    <v-snackbar
      v-model="editMode"
      color="#ff5252"
      :timeout="-1"
      class="mb-8"
    >
      <v-alert
        type="error"
        prominent
        dense
        class="pa-0 mx-4 my-0"
      >
        <v-row align="center">
          <v-col class="grow font-weight-medium">
            Room Icon의 편집(위치 이동)은 한번에 하나만 가능합니다
          </v-col>
        </v-row>
      </v-alert>
    </v-snackbar>

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
  </v-container>
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "MonitoringPage",
  computed: {
    ...mapState("monitoring", ["editMode"]),
  },
};
</script>
