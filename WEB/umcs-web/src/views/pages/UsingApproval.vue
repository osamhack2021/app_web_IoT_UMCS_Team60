<template>
  <v-container>
    <data-table
      :datas="getUsingDatas"
      :need-select="true"
    />
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";
import DataTable from "@/components/DataTable";

export default {
  name: "UsingApprovalReport",
  components: {
    DataTable,
  },
  computed: {
    ...mapGetters("approval", ["getUsingDatas"]),
  },
};
</script>
