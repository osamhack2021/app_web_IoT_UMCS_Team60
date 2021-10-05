<template>
  <v-container>
    <data-table
      :datas="getMovingDatas"
      :need-select="true"
    />
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";
import DataTable from "@/components/DataTable";

export default {
  name: "MovingApprovalReport",
  components: {
    DataTable,
  },
  computed: {
    ...mapGetters("approval", ["getMovingDatas"]),
  },
};
</script>
