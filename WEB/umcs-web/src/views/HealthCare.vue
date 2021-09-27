<template>
  <v-container>
    <v-row class="fill-height">
      <!-- Calendar -->
      <v-col cols="6">
        <calendar />
      </v-col>
      <!-- Health Table -->
      <v-col cols="6">
        <data-table
          :datas="getHealthDatas"
          :need-search="search"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex';
import Calendar from "@/components/Calendar";
import DataTable from "@/components/DataTable";

export default {
  components: {
    Calendar,
    DataTable,
  },
  data: () => ({
    search: true,
    // Data Table
  }),
  computed: {
    ...mapGetters('health', [
      'getHealthDatas',
    ])
  },
};
</script>

<style scoped>
</style>
