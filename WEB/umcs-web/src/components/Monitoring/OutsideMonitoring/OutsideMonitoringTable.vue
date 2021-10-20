<template>
  <v-card>
    <v-card-title>
      영외 시설 모니터링
    </v-card-title>
    <v-data-table
      :headers="monitoringHeaders"
      :items="outsideFacilityList"
      hide-default-footer
      :items-per-page="outsideFacilityList.length+5"
      class="elavation-1"
      @click:row="rowClick"
    />
  </v-card>
</template>

<script>
import { mapState, mapMutations, mapActions } from "vuex";

export default {
  name: "OutsideMonitoringTable",
  computed: {
    ...mapState(["outsideFacilityList"]),
    ...mapState("outside_monitoring", ["monitoringHeaders"]),
  },
  methods: {
    ...mapMutations("outside_monitoring", ["setFocusRoom"]),
    ...mapActions("outside_monitoring", ["FETCH_CURRENT_LOCATION_BEACON"]),
    rowClick(row) {
      this.setFocusRoom(row.name);
      this.FETCH_CURRENT_LOCATION_BEACON(row.beacon_id);
    },
  },
};
</script>
