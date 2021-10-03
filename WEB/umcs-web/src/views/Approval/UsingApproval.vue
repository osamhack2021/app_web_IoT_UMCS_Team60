<template>
  <data-table
    :datas="getUsingDatas"
    :need-select="true"
  />
</template>

<script>
import { mapGetters } from 'vuex'
import DataTable from '@/components/DataTable'

export default {
  name: "UsingApprovalReport",
  components: {
    DataTable,
  },
  computed: {
    ...mapGetters('approval', [
      "getUsingDatas",
    ]),
  }
};
</script>
