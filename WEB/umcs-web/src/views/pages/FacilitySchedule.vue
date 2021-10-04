<template>
  <v-container>
    <v-row>
      <!-- Facility List Info -->
      <v-col cols="5">
        <v-card
          class="mx-auto"
          tile
        >
          <facility-list
            :items="getFacilityList"
          />
        </v-card>
      </v-col>
      <!-- Facility Time Table -->
      <!-- <v-col cols="7">
        <v-card
          class="mx-auto mb-5"
        >
          <v-card-title class="text-h6">
            {{ getFocusingItem }}
          </v-card-title>
        </v-card>
        <data-table
          :datas="facilityTimeTable"
          store-name="facility"
          :need-c-r-u-d="true"
        />
      </v-col> -->
      <v-col cols="7">
        <v-card
          class="mx-auto mb-5"
        >
          <v-card-title class="text-h6">
            {{ getFocusingItem }}
          </v-card-title>
        </v-card>
        <temp-facility-schedule />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapState, mapGetters } from "vuex"
// import DataTable from "@/components/DataTable";
import FacilityList from '@/components/List/List';
import TempFacilitySchedule from "@/views/tempFacilitySchedule";

export default {
  name: "FacilitySchedule",
  components: {
    // DataTable,
    FacilityList,
    TempFacilitySchedule,
  },
  computed: {
    ...mapState('facility', [
      "facilityTimeTable"
    ]),
    ...mapGetters('facility', [
      'getFacilityList',
      'getFocusingItem',
      'getTimeTable',
    ])
  },
};
</script>

<style scoped>
</style>
