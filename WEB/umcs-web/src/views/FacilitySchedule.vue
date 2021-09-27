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
      <v-col cols="7">
        <v-card
          class="mx-auto mb-5"
        >
          <v-card-title class="text-h6-kr">
            {{ this.$store.getters['facility/getFocusingItem'] }}
          </v-card-title>
        </v-card>
        <data-table
          :datas="getFacilityTimeTable"
          :need-search="search"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex"
import DataTable from "@/components/DataTable";
import FacilityList from '@/components/List/List';

export default {
  name: "FacilitySchedule",
  components: {
    DataTable,
    FacilityList,
  },
  data: () => ({
    search: false,
  }),
  computed: {
    ...mapGetters('facility', [
      'getFacilityList',
      'getFacilityTimeTable',
    ])
  },
};
</script>

<style scoped>
</style>
