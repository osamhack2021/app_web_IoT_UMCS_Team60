<template>
  <div>
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
      <v-col cols="8">
        <doom-monitoring-map />
      </v-col>

      <!-- People list -->
      <v-col
        cols="4"
        class="mt-5"
      >
        <doom-people-table />
      </v-col>
    </v-row>
  </div>
</template>

<script>
/* Note */
/* 화면 띄우는 Logic */
// 건물과 층까지의 data를 받아온다 → (건물이 1개라면) 각 층에 해당하는 건물 도면이 담긴 card를 띄운다
// → 각 층에 해당하는 icon element에 대한 data를 서버로부터 받아와서 띄운다
// → (클릭할 경우) beacon_id를 확인하여 해당 시설에 있는 사람들의 정보를 띄운다

import { mapState } from "vuex";

import DoomMonitoringMap from "@/components/Monitoring/DoomMonitoring/DoomMonitoringMap";
import DoomPeopleTable from "@/components/Monitoring/DoomMonitoring/DoomPeopleTable";

export default {
  name: "DoomMonitoring",
  components: {
    DoomMonitoringMap,
    DoomPeopleTable,
  },
  computed: {
    ...mapState("doom_monitoring", ["editMode"]),
  },
  created() {
    try {
      this.$socket.$subscribe("doomroom_get_in", () => this.getIn());
      this.$socket.$subscribe("doomfacility_get_in", () => this.getIn());
      this.$socket.$subscribe("doomroom_get_out", () => this.getOut());
      this.$socket.$subscribe("doomfacility_get_out", () => this.getOut());
    } catch (error) {
      window.location.reload();
    }
  },
  methods: {
    getIn() {
      window.location.reload();
    },
    getOut() {
      window.location.reload();
    },
  },
};
</script>
