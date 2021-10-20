<template>
  <v-row>
    <v-col
      cols="5"
      class="mt-5"
    >
      <outside-monitoring-table />
    </v-col>

    <!-- People list -->
    <v-col
      cols="7"
      class="mt-5"
    >
      <outside-people-table />
    </v-col>
  </v-row>
</template>

<script>
import OutsideMonitoringTable from "@/components/Monitoring/OutsideMonitoring/OutsideMonitoringTable";
import OutsidePeopleTable from "@/components/Monitoring/OutsideMonitoring/OutsidePeopleTable";

export default {
  name: "OutsideMonitoring",
  components: {
    OutsideMonitoringTable,
    OutsidePeopleTable,
  },
  created() {
    try {
      this.$socket.$subscribe("outside_facility_get_in", (data) =>
        this.getIn()
      );
      this.$socket.$subscribe("outside_facility_get_out", (data) =>
        this.getOut()
      );
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
