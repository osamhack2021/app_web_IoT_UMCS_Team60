<template>
  <v-container class="mt-6">
    <v-row>
      <v-col
        cols="12"
        xl="8"
        class="mx-auto"
      >
        <using-approval-data-table />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import UsingApprovalDataTable from "@/components/UsingApproval/DataTable";

export default {
  name: "UsingApprovalReport",
  components: {
    UsingApprovalDataTable,
  },
};
</script>
