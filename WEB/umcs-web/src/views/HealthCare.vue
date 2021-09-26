<template>
  <v-container>
    <v-row class="fill-height">
      <!-- Calendar -->
      <v-col cols="6">
        <calendar />
      </v-col>
      <!-- Health Table -->
      <v-col cols="6">
        <data-table :datas="healthTableDatas" :need-search="search">
        </data-table>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
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
    healthTableDatas: {
      headers: [
        { text: "군번", value: "number" },
        { text: "계급", value: "rank" },
        { text: "이름", value: "name" },
        { text: "체온", value: "temperature" },
        { text: "특이사항", value: "status" },
      ],
      datas: [
        {
          number: "11111",
          rank: "병장",
          name: "aaa",
          temperature: "36.0℃",
          status: "1",
        },
        {
          number: "22222",
          rank: "상병",
          name: "bbb",
          temperature: "36.1℃",
          status: "2",
        },
        {
          number: "33333",
          rank: "상병",
          name: "ccc",
          temperature: "36.2℃",
          status: "3",
        },
        {
          number: "44444",
          rank: "일병",
          name: "ddd",
          temperature: "36.3℃",
          status: "4",
        },
        {
          number: "55555",
          rank: "일병",
          name: "eee",
          temperature: "36.4℃",
          status: "5",
        },
        {
          number: "66666",
          rank: "이병",
          name: "fff",
          temperature: "36.5℃",
          status: "6",
        },
      ],
    },
  }),
};
</script>

<style scoped>
</style>
