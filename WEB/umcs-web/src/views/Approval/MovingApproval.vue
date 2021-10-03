<template>
  <data-table
    :datas="getMovingDatas"
    :need-select="true"
  />
</template>

<script>
import { mapGetters } from 'vuex'
import DataTable from '@/components/DataTable'

export default {
  name: "MovingApprovalReport",
  components: {
    DataTable,
  },
  computed: {
    ...mapGetters('approval', [
      "getMovingDatas",
    ]),
  }
};
</script>
