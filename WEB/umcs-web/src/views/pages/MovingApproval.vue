<template>
  <v-container class="mt-6">
    <v-row>
      <v-col
        cols="12"
        xl="8"
        class="mx-auto"
      >
        <moving-approval-data-table />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import MovingApprovalDataTable from "@/components/MovingApproval/DataTable";

export default {
  name: "MovingApprovalReport",
  components: {
    MovingApprovalDataTable,
  },
};
</script>
