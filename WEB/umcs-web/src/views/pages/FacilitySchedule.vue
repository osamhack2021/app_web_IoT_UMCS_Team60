<template>
  <v-container class="mt-6">
    <v-row>
      <v-col
        cols="12"
        xl="8"
        class="mx-auto"
      >
        <v-row>
          <!-- Facility List Info -->
          <v-col cols="5">
            <facility-list />
          </v-col>

          <!-- Facility Time Table -->
          <v-col cols="7">
            <schedule-table />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import FacilityList from "@/components/FacilitySchedule/FacilityList";
import ScheduleTable from "@/components/FacilitySchedule/ScheduleTable";

export default {
  name: "FacilitySchedule",
  components: {
    FacilityList,
    ScheduleTable,
  },
};
</script>
